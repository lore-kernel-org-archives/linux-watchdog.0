Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36000 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbbFZSYz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Jun 2015 14:24:55 -0400
Received: by qgal13 with SMTP id l13so38005307qga.3
        for <linux-watchdog@vger.kernel.org>; Fri, 26 Jun 2015 11:24:54 -0700 (PDT)
From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, linux@roeck-us.net, ezequiel@vanguardiasur.com.ar,
	Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: [PATCH 1/2] watchdog: NXP LPC18XX Windowed Watchdog Timer Driver
Date: Fri, 26 Jun 2015 15:24:31 -0300
Message-Id: <1435343072-8753-2-git-send-email-ariel@vanguardiasur.com.ar>
In-Reply-To: <1435343072-8753-1-git-send-email-ariel@vanguardiasur.com.ar>
References: <1435343072-8753-1-git-send-email-ariel@vanguardiasur.com.ar>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This commit adds support for the watchdog timer found in NXP LPC SoCs
family, which includes LPC18xx/LPC43xx. Other SoCs in that family may
share the same watchdog hardware.

Watchdog driver registers a restart handler that will restart the system
by performing an incorrect feed after ensuring the watchdog is enabled in
reset mode.

As watchdog cannot be disabled in hardware, driver's stop routine will
regularly send a keepalive ping using a timer.

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
---
 drivers/watchdog/Kconfig       |  11 ++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/lpc18xx_wdt.c | 340 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 352 insertions(+)
 create mode 100644 drivers/watchdog/lpc18xx_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 742fbbc..31100c2 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -547,6 +547,17 @@ config DIGICOLOR_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called digicolor_wdt.
 
+config LPC18XX_WATCHDOG
+	tristate "LCP18XX Watchdog"
+	depends on ARCH_LPC18XX
+	select WATCHDOG_CORE
+	help
+	  Say Y here if to include support for the watchdog timer
+	  in NXP LPC SoCs family, which includes LPC18xx/LPC43xx
+	  processors.
+	  To compile this driver as a module, choose M here: the
+	  module will be called lpc18xx_wdt.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 59ea9a1..1b0ef48 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
 obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
 obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
 obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
+obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
new file mode 100644
index 0000000..80d68eb
--- /dev/null
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -0,0 +1,340 @@
+/*
+ * NXP LPC18xx Windowed Watchdog Timer (WWDT)
+ *
+ * Copyright (c) 2015 Ariel D'Alessandro <ariel@vanguardiasur.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Notes
+ * -----
+ * The Watchdog consists of a fixed divide-by-4 clock pre-scaler and a 24-bit counter
+ * which decrements on every clock cycle.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/watchdog.h>
+
+/* Registers */
+#define LPC_WDT_MOD			0x00
+#define LPC_WDT_MOD_WDEN		BIT(0)
+#define LPC_WDT_MOD_WDRESET		BIT(1)
+#define LPC_WDT_MOD_WDTOF_MASK		0x04
+
+#define LPC_WDT_TC			0x04
+#define LPC_WDT_TC_MIN			0xff
+#define LPC_WDT_TC_MAX			0xffffff
+
+#define LPC_WDT_FEED			0x08
+#define LPC_WDT_FEED_MAGIC1		0xaa
+#define LPC_WDT_FEED_MAGIC2		0x55
+
+#define LPC_WDT_TV			0x0c
+
+/* Clock pre-scaler */
+#define LPC_WDT_CLK_DIV			4
+
+/* Timeout values in seconds */
+#define LPC_WDT_DEF_TIMEOUT		1
+
+static int heartbeat;
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds "
+	"(default=" __MODULE_STRING(LPC_WDT_DEF_TIMEOUT) ")");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
+	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct lpc_wdt_dev {
+	struct watchdog_device wdt_dev;
+	struct clk *wdt_clk;
+	struct clk *sys_clk;
+	void __iomem *base;
+	struct timer_list timer;
+	struct notifier_block restart_handler;
+};
+
+static int lpc_wdt_feed(struct watchdog_device *wdt_dev)
+{
+	unsigned long flags;
+	struct lpc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	raw_local_irq_save(flags);
+	writel(LPC_WDT_FEED_MAGIC1, wdt->base + LPC_WDT_FEED);
+	writel(LPC_WDT_FEED_MAGIC2, wdt->base + LPC_WDT_FEED);
+	raw_local_irq_restore(flags);
+
+	return 0;
+}
+
+static void lpc_wdt_timer_feed(unsigned long data)
+{
+	unsigned long flags;
+	struct watchdog_device *wdt_dev = (struct watchdog_device *) data;
+	struct lpc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	/*
+	 * An abort condition will occur if an interrupt happens during the feed
+	 * sequence.
+	 */
+	raw_local_irq_save(flags);
+	writel(LPC_WDT_FEED_MAGIC1, wdt->base + LPC_WDT_FEED);
+	writel(LPC_WDT_FEED_MAGIC2, wdt->base + LPC_WDT_FEED);
+	raw_local_irq_restore(flags);
+
+	/* Use safe value (1/2 of real timeout) */
+	mod_timer(&wdt->timer, jiffies + msecs_to_jiffies((wdt_dev->timeout *
+							   MSEC_PER_SEC) / 2));
+}
+
+/*
+ * Since LPC18xx Watchdog cannot be disabled in hardware, we must keep feeding
+ * it with a timer until userspace watchdog software takes over.
+ */
+static int lpc_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	lpc_wdt_timer_feed((unsigned long) wdt_dev);
+
+	return 0;
+}
+
+static void __lpc_wdt_set_timeout(struct lpc_wdt_dev *wdt)
+{
+	unsigned long clk_rate = clk_get_rate(wdt->wdt_clk);
+	unsigned int val;
+
+	val = DIV_ROUND_UP(wdt->wdt_dev.timeout * clk_rate, LPC_WDT_CLK_DIV);
+	writel(val, wdt->base + LPC_WDT_TC);
+}
+
+static int lpc_wdt_set_timeout(struct watchdog_device *wdt_dev,
+			       unsigned int new_timeout)
+{
+	struct lpc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	wdt->wdt_dev.timeout = new_timeout;
+	__lpc_wdt_set_timeout(wdt);
+
+	return 0;
+}
+
+
+unsigned int lpc_wdt_get_timeleft(struct watchdog_device *wdt_dev)
+{
+	struct lpc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+	unsigned long clk_rate = clk_get_rate(wdt->wdt_clk);
+	unsigned int val;
+
+	val = readl(wdt->base + LPC_WDT_TV);
+	return ((val * LPC_WDT_CLK_DIV) / clk_rate);
+}
+
+static int lpc_wdt_start(struct watchdog_device *wdt_dev)
+{
+	unsigned int val;
+	struct lpc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	if (timer_pending(&wdt->timer))
+		del_timer(&wdt->timer);
+
+	val = readl(wdt->base + LPC_WDT_MOD);
+	val |= LPC_WDT_MOD_WDEN;
+	val |= LPC_WDT_MOD_WDRESET;
+	writel(val, wdt->base + LPC_WDT_MOD);
+
+	/*
+	 * Setting the WDEN bit in the WDMOD register is not sufficient to
+	 * enable the Watchdog. A valid feed sequence must be completed after
+	 * setting WDEN before the Watchdog is capable of generating a reset.
+	 */
+	lpc_wdt_feed(wdt_dev);
+
+	return 0;
+}
+
+static struct watchdog_info lpc_wdt_info = {
+	.identity	= "LPC 18XX Watchdog",
+	.options	= WDIOF_SETTIMEOUT |
+			  WDIOF_KEEPALIVEPING |
+			  WDIOF_MAGICCLOSE,
+};
+
+static const struct watchdog_ops lpc_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= lpc_wdt_start,
+	.stop		= lpc_wdt_stop,
+	.ping		= lpc_wdt_feed,
+	.set_timeout	= lpc_wdt_set_timeout,
+	.get_timeleft	= lpc_wdt_get_timeleft,
+};
+
+static int lpc_wdt_restart(struct notifier_block *this, unsigned long mode,
+			   void *cmd)
+{
+	int val;
+	unsigned long flags;
+	struct lpc_wdt_dev *wdt = container_of(this, struct lpc_wdt_dev,
+					       restart_handler);
+
+	/*
+	 * Incorrect feed sequence causes immediate watchdog reset if enabled.
+	 */
+	raw_local_irq_save(flags);
+
+	val = readl(wdt->base + LPC_WDT_MOD);
+	val |= LPC_WDT_MOD_WDEN;
+	val |= LPC_WDT_MOD_WDRESET;
+	writel(val, wdt->base + LPC_WDT_MOD);
+
+	writel(LPC_WDT_FEED_MAGIC1, wdt->base + LPC_WDT_FEED);
+	writel(LPC_WDT_FEED_MAGIC2, wdt->base + LPC_WDT_FEED);
+
+	writel(LPC_WDT_FEED_MAGIC1, wdt->base + LPC_WDT_FEED);
+	writel(LPC_WDT_FEED_MAGIC1, wdt->base + LPC_WDT_FEED);
+
+	raw_local_irq_restore(flags);
+
+	return NOTIFY_OK;
+}
+
+static int lpc_wdt_probe(struct platform_device *pdev)
+{
+	int ret;
+	unsigned long clk_rate;
+	struct resource *res;
+	struct lpc_wdt_dev *lpc_wdt;
+
+	lpc_wdt = devm_kzalloc(&pdev->dev, sizeof(*lpc_wdt), GFP_KERNEL);
+	if (!lpc_wdt)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	lpc_wdt->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(lpc_wdt->base))
+		return PTR_ERR(lpc_wdt->base);
+
+	lpc_wdt->sys_clk = devm_clk_get(&pdev->dev, "sys");
+	if (IS_ERR(lpc_wdt->sys_clk)) {
+		dev_err(&pdev->dev, "failed to get the sys clock\n");
+		return PTR_ERR(lpc_wdt->sys_clk);
+	}
+
+	lpc_wdt->wdt_clk = devm_clk_get(&pdev->dev, "wdt");
+	if (IS_ERR(lpc_wdt->wdt_clk)) {
+		dev_err(&pdev->dev, "failed to get the wdt clock\n");
+		return PTR_ERR(lpc_wdt->wdt_clk);
+	}
+
+	ret = clk_prepare_enable(lpc_wdt->sys_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "could not prepare or enable sys clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(lpc_wdt->wdt_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "could not prepare or enable wdt clock\n");
+		goto disable_sys_clk;
+	}
+
+	/* We use the clock rate to calculate timeouts */
+	clk_rate = clk_get_rate(lpc_wdt->wdt_clk);
+	if (clk_rate == 0) {
+		dev_err(&pdev->dev, "failed to get clock rate\n");
+		ret = -EINVAL;
+		goto disable_wdt_clk;
+	}
+
+	lpc_wdt->wdt_dev.info = &lpc_wdt_info;
+	lpc_wdt->wdt_dev.ops = &lpc_wdt_ops;
+
+	lpc_wdt->wdt_dev.min_timeout =
+		DIV_ROUND_UP(LPC_WDT_TC_MIN * LPC_WDT_CLK_DIV, clk_rate);
+
+	lpc_wdt->wdt_dev.max_timeout =
+		(LPC_WDT_TC_MAX * LPC_WDT_CLK_DIV) / clk_rate;
+
+	lpc_wdt->wdt_dev.parent = &pdev->dev;
+	watchdog_set_drvdata(&lpc_wdt->wdt_dev, lpc_wdt);
+
+	ret = watchdog_init_timeout(&lpc_wdt->wdt_dev, heartbeat, &pdev->dev);
+	if (ret < 0)
+		lpc_wdt->wdt_dev.timeout = LPC_WDT_DEF_TIMEOUT;
+
+	__lpc_wdt_set_timeout(lpc_wdt);
+
+	setup_timer(&lpc_wdt->timer, lpc_wdt_timer_feed,
+		    (unsigned long)&lpc_wdt->wdt_dev);
+
+	watchdog_set_nowayout(&lpc_wdt->wdt_dev, nowayout);
+
+	platform_set_drvdata(pdev, lpc_wdt);
+
+	ret = watchdog_register_device(&lpc_wdt->wdt_dev);
+	if (ret)
+		goto disable_wdt_clk;
+
+	lpc_wdt->restart_handler.notifier_call = lpc_wdt_restart;
+	lpc_wdt->restart_handler.priority = 128;
+	ret = register_restart_handler(&lpc_wdt->restart_handler);
+	if (ret)
+		dev_warn(&pdev->dev, "failed to register restart handler: %d\n",
+			 ret);
+
+	return 0;
+
+disable_wdt_clk:
+	clk_disable_unprepare(lpc_wdt->wdt_clk);
+disable_sys_clk:
+	clk_disable_unprepare(lpc_wdt->sys_clk);
+	return ret;
+}
+
+static void lpc_wdt_shutdown(struct platform_device *pdev)
+{
+	struct lpc_wdt_dev *lpc_wdt = platform_get_drvdata(pdev);
+
+	lpc_wdt_stop(&lpc_wdt->wdt_dev);
+}
+
+static int lpc_wdt_remove(struct platform_device *pdev)
+{
+	struct lpc_wdt_dev *lpc_wdt = platform_get_drvdata(pdev);
+
+	lpc_wdt_stop(&lpc_wdt->wdt_dev);
+	watchdog_unregister_device(&lpc_wdt->wdt_dev);
+	clk_disable_unprepare(lpc_wdt->wdt_clk);
+	clk_disable_unprepare(lpc_wdt->sys_clk);
+
+	return 0;
+}
+
+static const struct of_device_id lpc_wdt_match[] = {
+	{ .compatible = "nxp,lpc18xx-wdt" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, lpc_wdt_match);
+
+static struct platform_driver lpc_wdt_driver = {
+	.driver = {
+		.name = "lpc18xx-wdt",
+		.of_match_table	= lpc_wdt_match,
+	},
+	.probe = lpc_wdt_probe,
+	.remove = lpc_wdt_remove,
+	.shutdown = lpc_wdt_shutdown,
+};
+module_platform_driver(lpc_wdt_driver);
+
+MODULE_AUTHOR("Ariel D'Alessandro <ariel@vanguardiasur.com.ar>");
+MODULE_DESCRIPTION("NXP LPC18xx Windowed Watchdog Timer Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

