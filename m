Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:1050 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbbHTRmV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 20 Aug 2015 13:42:21 -0400
From: Justin Chen <justinpopo6@gmail.com>
To: <linux-kernel@vger.kernel.org>
CC: <feedback-list@broadcom.com>, <devicetree@vger.kernel.org>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH 2/2] watchdog: Watchdog driver for Broadcom Set-Top Box
Date: Thu, 20 Aug 2015 10:41:26 -0700
Message-ID: <1440092486-16905-3-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1440092486-16905-1-git-send-email-justinpopo6@gmail.com>
References: <1440092486-16905-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Watchdog driver for Broadcom 7038 and newer chips.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/watchdog/Kconfig       |   8 ++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/bcm7038_wdt.c | 253 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 drivers/watchdog/bcm7038_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 241fafd..4fbe8ab 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1291,6 +1291,14 @@ config BCM_KONA_WDT_DEBUG
 
 	  If in doubt, say 'N'.
 
+config BCM7038_WDT
+	tristate "BCM7038 Watchdog"
+	select WATCHDOG_CORE
+	help
+	 Watchdog driver for the built-in hardware in Broadcom 7038 SoCs.
+
+	 Say 'Y or 'M' here to enable the driver.
+
 config IMGPDC_WDT
 	tristate "Imagination Technologies PDC Watchdog Timer"
 	depends on HAS_IOMEM
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 59ea9a1..65d4169 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
 obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
 obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
 obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
+obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
new file mode 100644
index 0000000..a70730b
--- /dev/null
+++ b/drivers/watchdog/bcm7038_wdt.c
@@ -0,0 +1,253 @@
+/*
+ * Copyright (C) 2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/pm.h>
+
+#define WDT_START_1		0xff00
+#define WDT_START_2		0x00ff
+#define WDT_STOP_1		0xee00
+#define WDT_STOP_2		0x00ee
+
+#define WDT_TIMEOUT_REG		0x0
+#define WDT_CMD_REG		0x4
+
+#define WDT_MIN_TIMEOUT		1 /* seconds */
+#define WDT_DEFAULT_TIMEOUT	30 /* seconds */
+#define WDT_DEFAULT_RATE	27000000
+
+struct bcm7038_watchdog {
+	void __iomem		*reg;
+	struct clk		*wdt_clk;
+	struct watchdog_device	wdd;
+	u32			hz;
+};
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+
+static unsigned long bcm7038_wdt_get_rate(struct bcm7038_watchdog *wdt)
+{
+	/* if clock is missing return hz */
+	if (!wdt->wdt_clk)
+		return wdt->hz;
+
+	return clk_get_rate(wdt->wdt_clk);
+
+}
+
+static void bcm7038_wdt_set_timeout_reg(struct watchdog_device *wdog)
+{
+	struct bcm7038_watchdog *wdt = watchdog_get_drvdata(wdog);
+	u32 timeout;
+
+	timeout = bcm7038_wdt_get_rate(wdt) * wdog->timeout;
+
+	writel(timeout, wdt->reg + WDT_TIMEOUT_REG);
+}
+
+static int bcm7038_wdt_ping(struct watchdog_device *wdog)
+{
+	struct bcm7038_watchdog *wdt = watchdog_get_drvdata(wdog);
+
+	writel(WDT_START_1, wdt->reg + WDT_CMD_REG);
+	writel(WDT_START_2, wdt->reg + WDT_CMD_REG);
+
+	return 0;
+}
+
+static int bcm7038_wdt_start(struct watchdog_device *wdog)
+{
+	bcm7038_wdt_set_timeout_reg(wdog);
+	bcm7038_wdt_ping(wdog);
+
+	return 0;
+}
+
+static int bcm7038_wdt_stop(struct watchdog_device *wdog)
+{
+	struct bcm7038_watchdog *wdt = watchdog_get_drvdata(wdog);
+
+	writel(WDT_STOP_1, wdt->reg + WDT_CMD_REG);
+	writel(WDT_STOP_2, wdt->reg + WDT_CMD_REG);
+
+	return 0;
+}
+
+static int bcm7038_wdt_set_timeout(struct watchdog_device *wdog,
+					unsigned int t)
+{
+	if (watchdog_timeout_invalid(wdog, t))
+		return -EINVAL;
+
+	/* Can't modify timeout value if watchdog timer is running */
+	bcm7038_wdt_stop(wdog);
+	wdog->timeout = t;
+	bcm7038_wdt_start(wdog);
+
+	return 0;
+}
+
+static unsigned int bcm7038_wdt_get_timeleft(struct watchdog_device *wdog)
+{
+	struct bcm7038_watchdog *wdt = watchdog_get_drvdata(wdog);
+	u32 time_left;
+
+	time_left = readl(wdt->reg + WDT_CMD_REG);
+
+	return time_left / bcm7038_wdt_get_rate(wdt);
+}
+
+static struct watchdog_info bcm7038_wdt_info = {
+	.identity	= "Broadcom Watchdog Timer",
+	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
+				WDIOF_MAGICCLOSE
+};
+
+static struct watchdog_ops bcm7038_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= bcm7038_wdt_start,
+	.stop		= bcm7038_wdt_stop,
+	.set_timeout	= bcm7038_wdt_set_timeout,
+	.get_timeleft	= bcm7038_wdt_get_timeleft,
+};
+
+static int bcm7038_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct bcm7038_watchdog *wdt;
+	struct resource *res;
+	unsigned long wdt_rate;
+	int err;
+
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, wdt);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	wdt->reg = devm_ioremap_resource(dev, res);
+	if (IS_ERR(wdt->reg))
+		return PTR_ERR(wdt->reg);
+
+	wdt->wdt_clk = devm_clk_get(dev, NULL);
+	/* If unable to get clock, set clock to NULL */
+	if (IS_ERR(wdt->wdt_clk)) {
+		wdt->wdt_clk = NULL;
+		err = of_property_read_u32(np, "clock-frequency", &wdt->hz);
+		if (err) {
+			wdt->hz = WDT_DEFAULT_RATE;
+			dev_info(dev, "Using default frequency\n");
+		}
+	}
+
+	clk_prepare_enable(wdt->wdt_clk);
+
+	wdt_rate = bcm7038_wdt_get_rate(wdt);
+
+	wdt->wdd.info		= &bcm7038_wdt_info;
+	wdt->wdd.ops		= &bcm7038_wdt_ops;
+	wdt->wdd.min_timeout	= WDT_MIN_TIMEOUT;
+	wdt->wdd.timeout	= WDT_DEFAULT_TIMEOUT;
+	wdt->wdd.max_timeout	= (0xffffffff / wdt_rate);
+	wdt->wdd.parent		= dev;
+	watchdog_set_drvdata(&wdt->wdd, wdt);
+
+	err = watchdog_register_device(&wdt->wdd);
+	if (err) {
+		dev_err(dev, "Failed to register watchdog device\n");
+		return err;
+	}
+
+	dev_info(dev, "Registered Broadcom Watchdog\n");
+
+	return 0;
+}
+
+static int bcm7038_wdt_remove(struct platform_device *pdev)
+{
+	struct bcm7038_watchdog *wdt = platform_get_drvdata(pdev);
+
+	if (!nowayout)
+		bcm7038_wdt_stop(&wdt->wdd);
+
+	watchdog_unregister_device(&wdt->wdd);
+	clk_disable_unprepare(wdt->wdt_clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int bcm7038_wdt_suspend(struct device *dev)
+{
+	struct bcm7038_watchdog *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&wdt->wdd))
+		return bcm7038_wdt_stop(&wdt->wdd);
+
+	return 0;
+}
+
+static int bcm7038_wdt_resume(struct device *dev)
+{
+	struct bcm7038_watchdog *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&wdt->wdd))
+		return bcm7038_wdt_start(&wdt->wdd);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(bcm7038_wdt_pm_ops, bcm7038_wdt_suspend,
+				bcm7038_wdt_resume);
+
+static void bcm7038_wdt_shutdown(struct platform_device *pdev)
+{
+	struct bcm7038_watchdog *wdt = platform_get_drvdata(pdev);
+
+	if (watchdog_active(&wdt->wdd))
+		bcm7038_wdt_stop(&wdt->wdd);
+}
+
+static const struct of_device_id bcm7038_wdt_match[] = {
+	{ .compatible = "brcm,bcm7038-wdt" },
+	{},
+};
+
+static struct platform_driver bcm7038_wdt_driver = {
+	.probe		= bcm7038_wdt_probe,
+	.remove		= bcm7038_wdt_remove,
+	.shutdown	= bcm7038_wdt_shutdown,
+	.driver		= {
+		.name		= "bcm7038-wdt",
+		.of_match_table	= bcm7038_wdt_match,
+		.pm		= &bcm7038_wdt_pm_ops,
+	}
+};
+module_platform_driver(bcm7038_wdt_driver);
+
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Driver for Broadcom 7038 SoCs Watchdog");
+MODULE_AUTHOR("Justin Chen");
-- 
2.1.0

