Return-Path: <ezequiel.garcia@free-electrons.com>
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RESEND/PATCH v4 6/9] watchdog: orion: Add Armada 375/380 SoC support
Date: Mon, 14 Apr 2014 10:23:30 -0300
Message-Id: <1397481813-4962-7-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

This commit adds support for the Armada 375 and Armada 380 SoCs.

This SoC variant has a second RSTOUT register, in addition to the already
existent, which is shared with the system-controller. To handle this RSTOUT,
we introduce a new MMIO register 'rstout_mask' to be required on
'armada-{375,380}-watchdog' new compatible string.

Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 103 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index ba316db..00d0741 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -55,6 +55,7 @@ struct orion_watchdog_data {
 	int wdt_counter_offset;
 	int wdt_enable_bit;
 	int rstout_enable_bit;
+	int rstout_mask_bit;
 	int (*clock_init)(struct platform_device *,
 			  struct orion_watchdog *);
 	int (*enabled)(struct orion_watchdog *);
@@ -66,6 +67,7 @@ struct orion_watchdog {
 	struct watchdog_device wdt;
 	void __iomem *reg;
 	void __iomem *rstout;
+	void __iomem *rstout_mask;
 	unsigned long clk_rate;
 	struct clk *clk;
 	const struct orion_watchdog_data *data;
@@ -144,6 +146,31 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int armada375_start(struct watchdog_device *wdt_dev)
+{
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+	u32 reg;
+
+	/* Set watchdog duration */
+	writel(dev->clk_rate * wdt_dev->timeout,
+	       dev->reg + dev->data->wdt_counter_offset);
+
+	/* Clear the watchdog expiration bit */
+	atomic_io_modify(dev->reg + TIMER_A370_STATUS, WDT_A370_EXPIRED, 0);
+
+	/* Enable watchdog timer */
+	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit,
+						dev->data->wdt_enable_bit);
+
+	/* Enable reset on watchdog */
+	reg = readl(dev->rstout);
+	reg |= dev->data->rstout_enable_bit;
+	writel(reg, dev->rstout);
+
+	atomic_io_modify(dev->rstout_mask, dev->data->rstout_mask_bit, 0);
+	return 0;
+}
+
 static int armada370_start(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
@@ -207,6 +234,24 @@ static int orion_stop(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int armada375_stop(struct watchdog_device *wdt_dev)
+{
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+	u32 reg;
+
+	/* Disable reset on watchdog */
+	atomic_io_modify(dev->rstout_mask, dev->data->rstout_mask_bit,
+					   dev->data->rstout_mask_bit);
+	reg = readl(dev->rstout);
+	reg &= ~dev->data->rstout_enable_bit;
+	writel(reg, dev->rstout);
+
+	/* Disable watchdog timer */
+	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit, 0);
+
+	return 0;
+}
+
 static int armada370_stop(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
@@ -240,6 +285,17 @@ static int orion_enabled(struct orion_watchdog *dev)
 	return enabled && running;
 }
 
+static int armada375_enabled(struct orion_watchdog *dev)
+{
+	bool masked, enabled, running;
+
+	masked = readl(dev->rstout_mask) & dev->data->rstout_mask_bit;
+	enabled = readl(dev->rstout) & dev->data->rstout_enable_bit;
+	running = readl(dev->reg + TIMER_CTRL) & dev->data->wdt_enable_bit;
+
+	return !masked && enabled && running;
+}
+
 static int orion_wdt_enabled(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
@@ -333,6 +389,28 @@ static const struct orion_watchdog_data armadaxp_data = {
 	.stop = armada370_stop,
 };
 
+static const struct orion_watchdog_data armada375_data = {
+	.rstout_enable_bit = BIT(8),
+	.rstout_mask_bit = BIT(10),
+	.wdt_enable_bit = BIT(8),
+	.wdt_counter_offset = 0x34,
+	.clock_init = armada370_wdt_clock_init,
+	.enabled = armada375_enabled,
+	.start = armada375_start,
+	.stop = armada375_stop,
+};
+
+static const struct orion_watchdog_data armada380_data = {
+	.rstout_enable_bit = BIT(8),
+	.rstout_mask_bit = BIT(10),
+	.wdt_enable_bit = BIT(8),
+	.wdt_counter_offset = 0x34,
+	.clock_init = armadaxp_wdt_clock_init,
+	.enabled = armada375_enabled,
+	.start = armada375_start,
+	.stop = armada375_stop,
+};
+
 static const struct of_device_id orion_wdt_of_match_table[] = {
 	{
 		.compatible = "marvell,orion-wdt",
@@ -346,6 +424,14 @@ static const struct of_device_id orion_wdt_of_match_table[] = {
 		.compatible = "marvell,armada-xp-wdt",
 		.data = &armadaxp_data,
 	},
+	{
+		.compatible = "marvell,armada-375-wdt",
+		.data = &armada375_data,
+	},
+	{
+		.compatible = "marvell,armada-380-wdt",
+		.data = &armada380_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
@@ -381,6 +467,23 @@ static int orion_wdt_get_regs(struct platform_device *pdev,
 		if (IS_ERR(dev->rstout))
 			return PTR_ERR(dev->rstout);
 
+	} else if (of_device_is_compatible(node, "marvell,armada-375-wdt") ||
+		   of_device_is_compatible(node, "marvell,armada-380-wdt")) {
+
+		/* Dedicated RSTOUT register, can be requested. */
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		dev->rstout = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(dev->rstout))
+			return PTR_ERR(dev->rstout);
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		if (!res)
+			return -ENODEV;
+		dev->rstout_mask = devm_ioremap(&pdev->dev, res->start,
+						resource_size(res));
+		if (!dev->rstout_mask)
+			return -ENOMEM;
+
 	} else {
 		return -ENODEV;
 	}
-- 
1.9.1
