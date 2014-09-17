Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:54989 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939AbaIQUM1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Sep 2014 16:12:27 -0400
Received: by mail-wi0-f174.google.com with SMTP id n3so1935025wiv.1
        for <linux-watchdog@vger.kernel.org>; Wed, 17 Sep 2014 13:12:25 -0700 (PDT)
From: Carlo Caione <carlo@caione.org>
To: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, b.galvani@gmail.com,
	linux@arm.linux.org.uk
Cc: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2 2/4] ARM: meson: add watchdog driver
Date: Wed, 17 Sep 2014 22:12:04 +0200
Message-Id: <1410984726-18944-3-git-send-email-carlo@caione.org>
In-Reply-To: <1410984726-18944-1-git-send-email-carlo@caione.org>
References: <1410984726-18944-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds the watchdog driver for the Amlogic Meson SoCs used also
to reboot the device.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 drivers/watchdog/Kconfig     |  10 ++
 drivers/watchdog/Makefile    |   1 +
 drivers/watchdog/meson_wdt.c | 237 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 drivers/watchdog/meson_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f57312f..836cb00 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -443,6 +443,16 @@ config TEGRA_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called tegra_wdt.
 
+config MESON_WATCHDOG
+	tristate "Amlogic Meson SoCs watchdog support"
+	depends on ARCH_MESON
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer
+	  in Amlogic Meson SoCs.
+	  To compile this driver as a module, choose M here: the
+	  module will be called meson_wdt.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 468c320..e7a9259 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_MOXART_WDT) += moxart_wdt.o
 obj-$(CONFIG_SIRFSOC_WATCHDOG) += sirfsoc_wdt.o
 obj-$(CONFIG_BCM_KONA_WDT) += bcm_kona_wdt.o
 obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
+obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
new file mode 100644
index 0000000..3fbe147
--- /dev/null
+++ b/drivers/watchdog/meson_wdt.c
@@ -0,0 +1,237 @@
+/*
+ *      Meson Watchdog Driver
+ *
+ *      Copyright (c) 2014 Carlo Caione
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+#define DRV_NAME		"meson_wdt"
+
+#define MESON_WDT_TC		0x00
+#define MESON_WDT_TC_EN		BIT(22)
+#define MESON_WDT_TC_TM_MASK	0x3fffff
+#define MESON_WDT_DC_RESET	(3 << 24)
+
+#define MESON_WDT_RESET		0x04
+
+#define MESON_WDT_TIMEOUT	40
+#define MESON_WDT_MIN_TIMEOUT	1
+#define MESON_WDT_MAX_TIMEOUT	30
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+static unsigned int timeout = MESON_WDT_TIMEOUT;
+
+struct meson_wdt_dev {
+	struct watchdog_device wdt_dev;
+	void __iomem *wdt_base;
+	struct notifier_block restart_handler;
+};
+
+static int meson_restart_handle(struct notifier_block *this, unsigned long mode,
+				void *cmd)
+{
+	u32 tc_reboot = MESON_WDT_DC_RESET | MESON_WDT_TC_EN | 100;
+	struct meson_wdt_dev *meson_wdt = container_of(this,
+						       struct meson_wdt_dev,
+						       restart_handler);
+
+	writel(tc_reboot, meson_wdt->wdt_base + MESON_WDT_TC);
+	writel(0, meson_wdt->wdt_base + MESON_WDT_RESET);
+
+	while (1) {
+		mdelay(5);
+		writel(tc_reboot, meson_wdt->wdt_base + MESON_WDT_TC);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int meson_wdt_ping(struct watchdog_device *wdt_dev)
+{
+	struct meson_wdt_dev *meson_wdt = watchdog_get_drvdata(wdt_dev);
+
+	writel(0, meson_wdt->wdt_base + MESON_WDT_RESET);
+
+	return 0;
+}
+
+static int meson_wdt_set_timeout(struct watchdog_device *wdt_dev,
+				 unsigned int timeout)
+{
+	struct meson_wdt_dev *meson_wdt = watchdog_get_drvdata(wdt_dev);
+	u32 reg;
+
+	meson_wdt->wdt_dev.timeout = timeout;
+
+	reg = readl(meson_wdt->wdt_base + MESON_WDT_TC);
+	reg &= ~MESON_WDT_TC_TM_MASK;
+	reg |= (timeout * 100 * 1000);
+	writel(reg, meson_wdt->wdt_base + MESON_WDT_TC);
+
+	meson_wdt_ping(wdt_dev);
+
+	return 0;
+}
+
+static int meson_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	struct meson_wdt_dev *meson_wdt = watchdog_get_drvdata(wdt_dev);
+	u32 reg;
+
+	writel(0, meson_wdt->wdt_base + MESON_WDT_RESET);
+	reg = readl(meson_wdt->wdt_base + MESON_WDT_TC);
+	reg &= ~MESON_WDT_TC_EN;
+	writel(reg, meson_wdt->wdt_base + MESON_WDT_TC);
+
+	return 0;
+}
+
+static int meson_wdt_start(struct watchdog_device *wdt_dev)
+{
+	struct meson_wdt_dev *meson_wdt = watchdog_get_drvdata(wdt_dev);
+	u32 reg;
+	int ret;
+
+	ret = meson_wdt_set_timeout(&meson_wdt->wdt_dev,
+				    meson_wdt->wdt_dev.timeout);
+	if (ret < 0)
+		return ret;
+
+	writel(0, meson_wdt->wdt_base + MESON_WDT_RESET);
+	reg = readl(meson_wdt->wdt_base + MESON_WDT_TC);
+	reg |= MESON_WDT_TC_EN;
+	writel(reg, meson_wdt->wdt_base + MESON_WDT_TC);
+
+	return 0;
+}
+
+static const struct watchdog_info meson_wdt_info = {
+	.identity	= DRV_NAME,
+	.options	= WDIOF_SETTIMEOUT |
+			  WDIOF_KEEPALIVEPING |
+			  WDIOF_MAGICCLOSE,
+};
+
+static const struct watchdog_ops meson_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= meson_wdt_start,
+	.stop		= meson_wdt_stop,
+	.ping		= meson_wdt_ping,
+	.set_timeout	= meson_wdt_set_timeout,
+};
+
+static int meson_wdt_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct meson_wdt_dev *meson_wdt;
+	int err;
+
+	meson_wdt = devm_kzalloc(&pdev->dev, sizeof(*meson_wdt), GFP_KERNEL);
+	if (!meson_wdt)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	meson_wdt->wdt_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(meson_wdt->wdt_base))
+		return PTR_ERR(meson_wdt->wdt_base);
+
+	meson_wdt->wdt_dev.parent = &pdev->dev;
+	meson_wdt->wdt_dev.info = &meson_wdt_info;
+	meson_wdt->wdt_dev.ops = &meson_wdt_ops;
+	meson_wdt->wdt_dev.timeout = MESON_WDT_TIMEOUT;
+	meson_wdt->wdt_dev.max_timeout = MESON_WDT_MAX_TIMEOUT;
+	meson_wdt->wdt_dev.min_timeout = MESON_WDT_MIN_TIMEOUT;
+
+	watchdog_set_drvdata(&meson_wdt->wdt_dev, meson_wdt);
+
+	watchdog_init_timeout(&meson_wdt->wdt_dev, timeout, &pdev->dev);
+	watchdog_set_nowayout(&meson_wdt->wdt_dev, nowayout);
+
+	meson_wdt_stop(&meson_wdt->wdt_dev);
+
+	err = watchdog_register_device(&meson_wdt->wdt_dev);
+	if (unlikely(err))
+		return err;
+
+	platform_set_drvdata(pdev, meson_wdt);
+
+	meson_wdt->restart_handler.notifier_call = meson_restart_handle;
+	meson_wdt->restart_handler.priority = 128;
+	err = register_restart_handler(&meson_wdt->restart_handler);
+	if (err)
+		dev_err(&pdev->dev,
+			"cannot register restart handler (err=%d)\n", err);
+
+	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
+		 meson_wdt->wdt_dev.timeout, nowayout);
+
+	return 0;
+}
+
+static int meson_wdt_remove(struct platform_device *pdev)
+{
+	struct meson_wdt_dev *meson_wdt = platform_get_drvdata(pdev);
+
+	unregister_restart_handler(&meson_wdt->restart_handler);
+
+	watchdog_unregister_device(&meson_wdt->wdt_dev);
+	watchdog_set_drvdata(&meson_wdt->wdt_dev, NULL);
+
+	return 0;
+}
+
+static void meson_wdt_shutdown(struct platform_device *pdev)
+{
+	struct meson_wdt_dev *meson_wdt = platform_get_drvdata(pdev);
+
+	meson_wdt_stop(&meson_wdt->wdt_dev);
+}
+
+static const struct of_device_id meson_wdt_dt_ids[] = {
+	{ .compatible = "amlogic,meson-wdt" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, meson_wdt_dt_ids);
+
+static struct platform_driver meson_wdt_driver = {
+	.probe		= meson_wdt_probe,
+	.remove		= meson_wdt_remove,
+	.shutdown	= meson_wdt_shutdown,
+	.driver		= {
+		.owner		= THIS_MODULE,
+		.name		= DRV_NAME,
+		.of_match_table	= meson_wdt_dt_ids,
+	},
+};
+
+module_platform_driver(meson_wdt_driver);
+
+module_param(timeout, uint, 0);
+MODULE_PARM_DESC(timeout, "Watchdog heartbeat in seconds");
+
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
+		"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Carlo Caione <carlo@caione.org>");
+MODULE_DESCRIPTION("Meson Watchdog Timer Driver");
-- 
1.9.1

