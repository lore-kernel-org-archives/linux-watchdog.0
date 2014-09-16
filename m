Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:57086 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbaIPUny (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Sep 2014 16:43:54 -0400
Received: by mail-wg0-f42.google.com with SMTP id x12so418484wgg.1
        for <linux-watchdog@vger.kernel.org>; Tue, 16 Sep 2014 13:43:53 -0700 (PDT)
From: Carlo Caione <carlo@caione.org>
To: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, b.galvani@gmail.com,
	linux@arm.linux.org.uk
Cc: Carlo Caione <carlo@caione.org>
Subject: [PATCH 2/4] ARM: meson: add watchdog driver
Date: Tue, 16 Sep 2014 22:43:35 +0200
Message-Id: <1410900217-5162-3-git-send-email-carlo@caione.org>
In-Reply-To: <1410900217-5162-1-git-send-email-carlo@caione.org>
References: <1410900217-5162-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds the watchdog driver for the Amlogic Meson SoCs used also
to reboot the device.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 drivers/watchdog/Kconfig     |  10 ++
 drivers/watchdog/Makefile    |   1 +
 drivers/watchdog/meson_wdt.c | 219 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
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
index 0000000..3ac835c
--- /dev/null
+++ b/drivers/watchdog/meson_wdt.c
@@ -0,0 +1,219 @@
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
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+#include <asm/system_misc.h>
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
+static void __iomem *reboot_wdt_base;
+
+static void meson_wdt_restart(enum reboot_mode mode, const char *cmd)
+{
+	u32 tc_reboot = MESON_WDT_DC_RESET | MESON_WDT_TC_EN | 100;
+
+	writel(tc_reboot, reboot_wdt_base + MESON_WDT_TC);
+	writel(0, reboot_wdt_base + MESON_WDT_RESET);
+
+	while (1) {
+		mdelay(5);
+		writel(tc_reboot, reboot_wdt_base + MESON_WDT_TC);
+	}
+}
+
+static int meson_wdt_ping(struct watchdog_device *meson_wdt_dev)
+{
+	void __iomem *base = watchdog_get_drvdata(meson_wdt_dev);
+
+	writel(0, base + MESON_WDT_RESET);
+
+	return 0;
+}
+
+static int meson_wdt_set_timeout(struct watchdog_device *meson_wdt_dev,
+				 unsigned int timeout)
+{
+	void __iomem *base = watchdog_get_drvdata(meson_wdt_dev);
+	u32 reg;
+
+	meson_wdt_dev->timeout = timeout;
+
+	reg = readl(base + MESON_WDT_TC);
+	reg &= ~MESON_WDT_TC_TM_MASK;
+	reg |= (timeout * 100 * 1000);
+	writel(reg, base + MESON_WDT_TC);
+
+	meson_wdt_ping(meson_wdt_dev);
+
+	return 0;
+}
+
+static int meson_wdt_stop(struct watchdog_device *meson_wdt_dev)
+{
+	void __iomem *base = watchdog_get_drvdata(meson_wdt_dev);
+	u32 reg;
+
+	writel(0, base + MESON_WDT_RESET);
+	reg = readl(base + MESON_WDT_TC);
+	reg &= ~MESON_WDT_TC_EN;
+	writel(reg, base + MESON_WDT_TC);
+
+	return 0;
+}
+
+static int meson_wdt_start(struct watchdog_device *meson_wdt_dev)
+{
+	void __iomem *base = watchdog_get_drvdata(meson_wdt_dev);
+	u32 reg;
+	int ret;
+
+	ret = meson_wdt_set_timeout(meson_wdt_dev, meson_wdt_dev->timeout);
+	if (ret < 0)
+		return ret;
+
+	writel(0, base + MESON_WDT_RESET);
+	reg = readl(base + MESON_WDT_TC);
+	reg |= MESON_WDT_TC_EN;
+	writel(reg, base + MESON_WDT_TC);
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
+static struct watchdog_device meson_wdt_dev = {
+	.info		= &meson_wdt_info,
+	.ops		= &meson_wdt_ops,
+	.timeout	= MESON_WDT_TIMEOUT,
+	.max_timeout	= MESON_WDT_MAX_TIMEOUT,
+	.min_timeout	= MESON_WDT_MIN_TIMEOUT,
+};
+
+static int meson_wdt_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	void __iomem *base;
+	int err;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	meson_wdt_dev.parent = &pdev->dev;
+	watchdog_set_drvdata(&meson_wdt_dev, base);
+
+	watchdog_init_timeout(&meson_wdt_dev, timeout, &pdev->dev);
+	watchdog_set_nowayout(&meson_wdt_dev, nowayout);
+
+	meson_wdt_stop(&meson_wdt_dev);
+
+	err = watchdog_register_device(&meson_wdt_dev);
+	if (unlikely(err))
+		return err;
+
+	platform_set_drvdata(pdev, &meson_wdt_dev);
+
+	reboot_wdt_base = base;
+	arm_pm_restart = meson_wdt_restart;
+
+	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
+		 meson_wdt_dev.timeout, nowayout);
+
+	return 0;
+}
+
+static int meson_wdt_remove(struct platform_device *pdev)
+{
+	struct watchdog_device *meson_wdt_dev = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(meson_wdt_dev);
+	watchdog_set_drvdata(meson_wdt_dev, NULL);
+
+	return 0;
+}
+
+static void meson_wdt_shutdown(struct platform_device *pdev)
+{
+	struct watchdog_device *meson_wdt_dev = platform_get_drvdata(pdev);
+
+	meson_wdt_stop(meson_wdt_dev);
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

