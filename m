Return-path: <joel@jms.id.au>
From: Joel Stanley <joel@jms.id.au>
To: linux@roeck-us.net,
	wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	jk@ozlabs.org,
	benh@kernel.crashing.org,
	arnd@arndb.de
Subject: [PATCH 2/2] watchdog: Add Aspeed watchdog driver
Date: Mon,  9 May 2016 22:04:37 +0930
Message-Id: <1462797277-14969-3-git-send-email-joel@jms.id.au>
In-Reply-To: <1462797277-14969-1-git-send-email-joel@jms.id.au>
References: <1462797277-14969-1-git-send-email-joel@jms.id.au>
List-ID: <linux-watchdog@vger.kernel.org>

Provides generic watchdog features as well as reboot support for the
Apeed SoC.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/watchdog/Kconfig      |  13 +++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/aspeed_wdt.c | 199 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 drivers/watchdog/aspeed_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index fb947655badd..4f0e2ded4785 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -661,6 +661,19 @@ config ATLAS7_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called atlas7_wdt.
 
+config ASPEED_WATCHDOG
+	tristate "Aspeed 2400 watchdog support"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer
+	  in Apseed BMC SoCs.
+
+	  This driver is required to reboot the SoC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called aspeed_wdt.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index feb6270fdbde..36855375e0ce 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
 obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
 obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
 obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
+obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
new file mode 100644
index 000000000000..46cc71963c62
--- /dev/null
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -0,0 +1,199 @@
+/*
+ * Copyright 2016 IBM Corporation
+ *
+ * Joel Stanley <joel@jms.id.au>
+ *
+ * Based on the qcom-watchdog driver
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/watchdog.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+struct aspeed_wdt {
+	struct watchdog_device	wdd;
+	unsigned long		rate;
+	void __iomem		*base;
+	u32			ctrl;
+};
+
+static const struct of_device_id aspeed_wdt_of_table[] = {
+	{ .compatible = "aspeed,wdt" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
+
+#define WDT_STATUS		0x00
+#define WDT_RELOAD_VALUE	0x04
+#define WDT_RESTART		0x08
+#define WDT_CTRL		0x0C
+#define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
+#define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
+#define	  WDT_CTRL_1MHZ_CLK		BIT(4)
+#define	  WDT_CTRL_WDT_EXT		BIT(3)
+#define	  WDT_CTRL_WDT_INTR		BIT(2)
+#define   WDT_CTRL_RESET_SYSTEM		BIT(1)
+#define   WDT_CTRL_ENABLE		BIT(0)
+
+#define	WDT_RESTART_MAGIC	0x4755
+
+static struct aspeed_wdt *to_aspeed_wdt(struct watchdog_device *wdd)
+{
+	return container_of(wdd, struct aspeed_wdt, wdd);
+}
+
+
+static void aspeed_wdt_enable(struct aspeed_wdt *wdt, int count)
+{
+	wdt->ctrl |= WDT_CTRL_ENABLE;
+
+	writel(0, wdt->base + WDT_CTRL);
+	writel(count, wdt->base + WDT_RELOAD_VALUE);
+	writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
+	writel(wdt->ctrl, wdt->base + WDT_CTRL);
+}
+
+static int aspeed_wdt_start(struct watchdog_device *wdd)
+{
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+
+	dev_dbg(wdd->parent, "starting with timeout of %d (rate %lu)\n",
+			wdd->timeout, wdt->rate);
+	aspeed_wdt_enable(wdt, wdd->timeout * wdt->rate);
+
+	return 0;
+}
+
+static int aspeed_wdt_stop(struct watchdog_device *wdd)
+{
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+
+	wdt->ctrl &= ~WDT_CTRL_ENABLE;
+	writel(wdt->ctrl, wdt->base + WDT_CTRL);
+
+	return 0;
+}
+
+static int aspeed_wdt_ping(struct watchdog_device *wdd)
+{
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+
+	dev_dbg(wdd->parent, "ping\n");
+	writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
+	return 0;
+}
+
+static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
+				  unsigned int timeout)
+{
+	dev_dbg(wdd->parent, "timeout set to %u\n", timeout);
+	wdd->timeout = timeout;
+
+	return aspeed_wdt_start(wdd);
+}
+
+static int aspeed_wdt_restart(struct watchdog_device *wdd,
+			      unsigned long action, void *data)
+{
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+
+	aspeed_wdt_enable(wdt, 128 * wdt->rate / 1000);
+
+	return 0;
+}
+
+static const struct watchdog_ops aspeed_wdt_ops = {
+	.start		= aspeed_wdt_start,
+	.stop		= aspeed_wdt_stop,
+	.ping		= aspeed_wdt_ping,
+	.set_timeout	= aspeed_wdt_set_timeout,
+	.restart	= aspeed_wdt_restart,
+	.owner		= THIS_MODULE,
+};
+
+static const struct watchdog_info aspeed_wdt_info = {
+	.options	= WDIOF_KEEPALIVEPING
+			| WDIOF_MAGICCLOSE
+			| WDIOF_SETTIMEOUT,
+	.identity	= KBUILD_MODNAME,
+};
+
+static int aspeed_wdt_remove(struct platform_device *pdev)
+{
+	struct aspeed_wdt *wdt = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(&wdt->wdd);
+
+	return 0;
+}
+
+static int aspeed_wdt_probe(struct platform_device *pdev)
+{
+	struct aspeed_wdt *wdt;
+	struct resource *res;
+	int ret;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	wdt->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
+
+	/*
+	 * The ast2400 wdt can run at PCLK, or 1MHz. The ast2500 only
+	 * runs at 1MHz. We chose to always run at 1MHz, as there's no
+	 * good reason to have a faster watchdog counter.
+	 */
+	wdt->rate = 1000000;
+	wdt->wdd.info = &aspeed_wdt_info;
+	wdt->wdd.ops = &aspeed_wdt_ops;
+	wdt->wdd.min_timeout = 1;
+	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
+	wdt->wdd.parent = &pdev->dev;
+
+	wdt->wdd.timeout = min(wdt->wdd.max_timeout, 30U);
+	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
+
+	wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
+		WDT_CTRL_1MHZ_CLK |
+		WDT_CTRL_RESET_SYSTEM;
+
+	/* Ensure hardware is in consistent state */
+	aspeed_wdt_stop(&wdt->wdd);
+
+	ret = watchdog_register_device(&wdt->wdd);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register\n");
+		goto err;
+	}
+
+	dev_info(&pdev->dev, "rate %lu, max timeout %u, timeout %d\n",
+		 wdt->rate, wdt->wdd.max_timeout, wdt->wdd.timeout);
+
+	platform_set_drvdata(pdev, wdt);
+err:
+	return ret;
+}
+
+static struct platform_driver aspeed_watchdog_driver = {
+	.probe = aspeed_wdt_probe,
+	.remove = aspeed_wdt_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = of_match_ptr(aspeed_wdt_of_table),
+	},
+};
+module_platform_driver(aspeed_watchdog_driver);
+
+MODULE_DESCRIPTION("Aspeed Watchdog Driver");
+MODULE_LICENSE("GPL");
-- 
2.8.1
