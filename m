Return-Path: <ezequiel.garcia@free-electrons.com>
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v4 11/18] watchdog: orion: Introduce per-compatible of_device_id data
Date: Wed, 22 Jan 2014 20:05:08 -0300
Message-Id: <1390431915-5115-12-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

This commit adds an orion_watchdog_data structure to hold compatible-data
information. This allows to remove the driver-wide definition and to
be able to add support for multiple compatible-strings in the future.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 58 +++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 96dba41..c978bcd 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -24,6 +24,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 
 /* RSTOUT mask register physical address for Orion5x, Kirkwood and Dove */
 #define ORION_RSTOUT_MASK_OFFSET	0x20108
@@ -35,29 +36,33 @@
  * Watchdog timer block registers.
  */
 #define TIMER_CTRL		0x0000
-#define WDT_EN			0x0010
-#define WDT_VAL			0x0024
 
 #define WDT_MAX_CYCLE_COUNT	0xffffffff
 
-#define WDT_RESET_OUT_EN	BIT(1)
-
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = -1;		/* module parameter (seconds) */
 
+struct orion_watchdog_data {
+	int wdt_counter_offset;
+	int wdt_enable_bit;
+	int rstout_enable_bit;
+};
+
 struct orion_watchdog {
 	struct watchdog_device wdt;
 	void __iomem *reg;
 	void __iomem *rstout;
 	unsigned long clk_rate;
 	struct clk *clk;
+	const struct orion_watchdog_data *data;
 };
 
 static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
 	/* Reload watchdog duration */
-	writel(dev->clk_rate * wdt_dev->timeout, dev->reg + WDT_VAL);
+	writel(dev->clk_rate * wdt_dev->timeout,
+	       dev->reg + dev->data->wdt_counter_offset);
 	return 0;
 }
 
@@ -66,13 +71,16 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
 
 	/* Set watchdog duration */
-	writel(dev->clk_rate * wdt_dev->timeout, dev->reg + WDT_VAL);
+	writel(dev->clk_rate * wdt_dev->timeout,
+	       dev->reg + dev->data->wdt_counter_offset);
 
 	/* Enable watchdog timer */
-	atomic_io_modify(dev->reg + TIMER_CTRL, WDT_EN, WDT_EN);
+	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit,
+						dev->data->wdt_enable_bit);
 
 	/* Enable reset on watchdog */
-	atomic_io_modify(dev->rstout, WDT_RESET_OUT_EN, WDT_RESET_OUT_EN);
+	atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit,
+				      dev->data->rstout_enable_bit);
 
 	return 0;
 }
@@ -82,10 +90,10 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
 
 	/* Disable reset on watchdog */
-	atomic_io_modify(dev->rstout, WDT_RESET_OUT_EN, 0);
+	atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit, 0);
 
 	/* Disable watchdog timer */
-	atomic_io_modify(dev->reg + TIMER_CTRL, WDT_EN, 0);
+	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit, 0);
 
 	return 0;
 }
@@ -93,7 +101,7 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 static unsigned int orion_wdt_get_timeleft(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
-	return readl(dev->reg + WDT_VAL) / dev->clk_rate;
+	return readl(dev->reg + dev->data->wdt_counter_offset) / dev->clk_rate;
 }
 
 static int orion_wdt_set_timeout(struct watchdog_device *wdt_dev,
@@ -150,9 +158,25 @@ static void __iomem * try_rstout_ioremap(struct platform_device *pdev,
 	return devm_ioremap(&pdev->dev, rstout, 0x4);
 }
 
+static const struct orion_watchdog_data orion_data = {
+	.rstout_enable_bit = BIT(1),
+	.wdt_enable_bit = BIT(4),
+	.wdt_counter_offset = 0x24,
+};
+
+static const struct of_device_id orion_wdt_of_match_table[] = {
+	{
+		.compatible = "marvell,orion-wdt",
+		.data = &orion_data,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
+
 static int orion_wdt_probe(struct platform_device *pdev)
 {
 	struct orion_watchdog *dev;
+	const struct of_device_id *match;
 	unsigned int wdt_max_duration;	/* (seconds) */
 	struct resource *res;
 	int ret, irq;
@@ -162,9 +186,15 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	if (!dev)
 		return -ENOMEM;
 
+	match = of_match_device(orion_wdt_of_match_table, &pdev->dev);
+	if (!match)
+		/* Default legacy match */
+		match = &orion_wdt_of_match_table[0];
+
 	dev->wdt.info = &orion_wdt_info;
 	dev->wdt.ops = &orion_wdt_ops;
 	dev->wdt.min_timeout = 1;
+	dev->data = match->data;
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
@@ -252,12 +282,6 @@ static void orion_wdt_shutdown(struct platform_device *pdev)
 	orion_wdt_stop(wdt_dev);
 }
 
-static const struct of_device_id orion_wdt_of_match_table[] = {
-	{ .compatible = "marvell,orion-wdt", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
-
 static struct platform_driver orion_wdt_driver = {
 	.probe		= orion_wdt_probe,
 	.remove		= orion_wdt_remove,
-- 
1.8.1.5
