Return-path: <21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
To: wim@iguana.be,
	linux-watchdog@vger.kernel.org
Cc: workgroup.linux@csr.com,
	Guo Zeng <Guo.Zeng@csr.com>,
	Guenter Roeck <linux@roeck-us.net>,
	William Wang <William.Wang@csr.com>,
	Barry Song <Baohua.Song@csr.com>
Subject: [PATCH v4] watchdog: atlas7: add watchdog driver of CSRatlas7
Date: Wed,  2 Dec 2015 03:37:47 +0000
Message-Id: <1449027467-29333-1-git-send-email-21cnbao@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Guo Zeng <Guo.Zeng@csr.com>

This patch adds watchdog driver for CSRatlas7 platform.
On CSRatlas7, the 6th timer can act as a watchdog timer
when the Watchdog mode is enabled.

Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
Signed-off-by: William Wang <William.Wang@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/watchdog/Kconfig      |  10 ++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/atlas7_wdt.c | 242 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 253 insertions(+)
 create mode 100644 drivers/watchdog/atlas7_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1c427be..52b308f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -578,6 +578,16 @@ config LPC18XX_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called lpc18xx_wdt.
 
+config ATLAS7_WATCHDOG
+	tristate "CSRatlas7 watchdog"
+	depends on ARCH_ATLAS7
+	help
+	  Say Y here to include Watchdog timer support for the watchdog
+	  existing on the CSRatlas7 series platforms.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called atlas7_wdt.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 53d4827..e2bc52c 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
 obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
 obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
 obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
+obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/atlas7_wdt.c b/drivers/watchdog/atlas7_wdt.c
new file mode 100644
index 0000000..df6d924
--- /dev/null
+++ b/drivers/watchdog/atlas7_wdt.c
@@ -0,0 +1,242 @@
+/*
+ * Watchdog driver for CSR Atlas7
+ *
+ * Copyright (c) 2015 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+
+#define ATLAS7_TIMER_WDT_INDEX		5
+#define ATLAS7_WDT_DEFAULT_TIMEOUT	20
+
+#define ATLAS7_WDT_CNT_CTRL	(0 + 4 * ATLAS7_TIMER_WDT_INDEX)
+#define ATLAS7_WDT_CNT_MATCH	(0x18 + 4 * ATLAS7_TIMER_WDT_INDEX)
+#define ATLAS7_WDT_CNT		(0x48 +  4 * ATLAS7_TIMER_WDT_INDEX)
+#define ATLAS7_WDT_CNT_EN	(BIT(0) | BIT(1))
+#define ATLAS7_WDT_EN		0x64
+
+static unsigned int timeout = ATLAS7_WDT_DEFAULT_TIMEOUT;
+static bool nowayout = WATCHDOG_NOWAYOUT;
+
+module_param(timeout, uint, 0);
+module_param(nowayout, bool, 0);
+
+MODULE_PARM_DESC(timeout, "Default watchdog timeout (in seconds)");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct atlas7_wdog {
+	struct device *dev;
+	void __iomem *base;
+	unsigned long tick_rate;
+	struct clk *clk;
+};
+
+static unsigned int atlas7_wdt_gettimeleft(struct watchdog_device *wdd)
+{
+	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
+	u32 counter, match, delta;
+
+	counter = readl(wdt->base + ATLAS7_WDT_CNT);
+	match = readl(wdt->base + ATLAS7_WDT_CNT_MATCH);
+	delta = match - counter;
+
+	return  delta / wdt->tick_rate;
+}
+
+static int atlas7_wdt_ping(struct watchdog_device *wdd)
+{
+	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
+	u32 counter, match, delta;
+
+	counter = readl(wdt->base + ATLAS7_WDT_CNT);
+	delta = wdd->timeout * wdt->tick_rate;
+	match = counter + delta;
+
+	writel(match, wdt->base + ATLAS7_WDT_CNT_MATCH);
+
+	return 0;
+}
+
+static int atlas7_wdt_enable(struct watchdog_device *wdd)
+{
+	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
+
+	atlas7_wdt_ping(wdd);
+
+	writel(readl(wdt->base + ATLAS7_WDT_CNT_CTRL) | ATLAS7_WDT_CNT_EN,
+	      wdt->base + ATLAS7_WDT_CNT_CTRL);
+	writel(1, wdt->base + ATLAS7_WDT_EN);
+
+	return 0;
+}
+
+static int atlas7_wdt_disable(struct watchdog_device *wdd)
+{
+	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
+
+	writel(0, wdt->base + ATLAS7_WDT_EN);
+	writel(readl(wdt->base + ATLAS7_WDT_CNT_CTRL) & ~ATLAS7_WDT_CNT_EN,
+	      wdt->base + ATLAS7_WDT_CNT_CTRL);
+
+	return 0;
+}
+
+static int atlas7_wdt_settimeout(struct watchdog_device *wdd, unsigned int to)
+{
+	wdd->timeout = to;
+
+	return 0;
+}
+
+#define OPTIONS (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
+
+static const struct watchdog_info atlas7_wdt_ident = {
+	.options = OPTIONS,
+	.firmware_version = 0,
+	.identity = "atlas7 Watchdog",
+};
+
+static struct watchdog_ops atlas7_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = atlas7_wdt_enable,
+	.stop = atlas7_wdt_disable,
+	.get_timeleft = atlas7_wdt_gettimeleft,
+	.ping = atlas7_wdt_ping,
+	.set_timeout = atlas7_wdt_settimeout,
+};
+
+static struct watchdog_device atlas7_wdd = {
+	.info = &atlas7_wdt_ident,
+	.ops = &atlas7_wdt_ops,
+	.timeout = ATLAS7_WDT_DEFAULT_TIMEOUT,
+};
+
+static const struct of_device_id atlas7_wdt_ids[] = {
+	{ .compatible = "sirf,atlas7-tick"},
+	{}
+};
+
+static int atlas7_wdt_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct atlas7_wdog *wdt;
+	struct resource *res;
+	struct clk *clk;
+	int ret;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	wdt->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(&pdev->dev, "clk enable failed\n");
+		goto err;
+	}
+
+	/* disable watchdog hardware */
+	writel(0, wdt->base + ATLAS7_WDT_CNT_CTRL);
+
+	wdt->tick_rate = clk_get_rate(clk);
+	wdt->clk = clk;
+	atlas7_wdd.min_timeout = 1;
+	atlas7_wdd.max_timeout = UINT_MAX / wdt->tick_rate;
+
+	watchdog_init_timeout(&atlas7_wdd, 0, &pdev->dev);
+	watchdog_set_nowayout(&atlas7_wdd, nowayout);
+
+	watchdog_set_drvdata(&atlas7_wdd, wdt);
+	platform_set_drvdata(pdev, &atlas7_wdd);
+
+	ret = watchdog_register_device(&atlas7_wdd);
+	if (ret)
+		goto err1;
+
+	return 0;
+
+err1:
+	clk_disable_unprepare(clk);
+err:
+	clk_put(clk);
+	return ret;
+}
+
+static void atlas7_wdt_shutdown(struct platform_device *pdev)
+{
+	struct watchdog_device *wdd = platform_get_drvdata(pdev);
+	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
+
+	atlas7_wdt_disable(wdd);
+	clk_disable_unprepare(wdt->clk);
+}
+
+static int atlas7_wdt_remove(struct platform_device *pdev)
+{
+	struct watchdog_device *wdd = platform_get_drvdata(pdev);
+	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
+
+	atlas7_wdt_shutdown(pdev);
+	clk_put(wdt->clk);
+	return 0;
+}
+
+static int __maybe_unused atlas7_wdt_suspend(struct device *dev)
+{
+	/*
+	 * NOTE:timer controller registers settings are saved
+	 * and restored back by the timer-atlas7.c
+	 */
+	return 0;
+}
+
+static int __maybe_unused atlas7_wdt_resume(struct device *dev)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	/*
+	 * NOTE: Since timer controller registers settings are saved
+	 * and restored back by the timer-atlas7.c, so we need not
+	 * update WD settings except refreshing timeout.
+	 */
+	atlas7_wdt_ping(wdd);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(atlas7_wdt_pm_ops,
+		atlas7_wdt_suspend, atlas7_wdt_resume);
+
+MODULE_DEVICE_TABLE(of, atlas7_wdt_ids);
+
+static struct platform_driver atlas7_wdt_driver = {
+	.driver = {
+		.name = "atlas7-wdt",
+		.pm = &atlas7_wdt_pm_ops,
+		.of_match_table	= atlas7_wdt_ids,
+	},
+	.probe = atlas7_wdt_probe,
+	.remove = atlas7_wdt_remove,
+	.shutdown = atlas7_wdt_shutdown,
+};
+module_platform_driver(atlas7_wdt_driver);
+
+MODULE_DESCRIPTION("CSRatlas7 watchdog driver");
+MODULE_AUTHOR("Guo Zeng <Guo.Zeng@csr.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:atlas7-wdt");
-- 
1.9.1
