Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:39747 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753419AbaAUJNS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 04:13:18 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 11/15] watchdog: orion: Add support for Armada 370 and Armada XP SoC
Date: Tue, 21 Jan 2014 06:12:37 -0300
Message-Id: <1390295561-3466-12-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Using the added infrastructure for handling SoC differences,
this commit adds support for the watchdog controller available
in Armada 370 and Armada XP SoCs.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index d6009fe..8631756 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -31,6 +31,7 @@
  * Watchdog timer block registers.
  */
 #define TIMER_CTRL		0x0000
+#define TIMER_A370_STATUS	0x04
 
 #define WDT_MAX_CYCLE_COUNT	0xffffffff
 #define WDT_IN_USE		0
@@ -42,6 +43,12 @@
 
 #define WDT_AXP_FIXED_ENABLE_BIT BIT(10)
 
+#define WDT_A370_RATIO_MASK(v)	((v) << 16)
+#define WDT_A370_RATIO_SHIFT	5
+#define WDT_A370_RATIO		(1 << WDT_A370_RATIO_SHIFT)
+
+#define WDT_A370_EXPIRED	BIT(31)
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = -1;		/* module parameter (seconds) */
 
@@ -77,6 +84,40 @@ static int orion_wdt_clock_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int armada370_wdt_clock_init(struct platform_device *pdev,
+				    struct orion_watchdog *dev)
+{
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dev->clk))
+		return -ENODEV;
+	clk_prepare_enable(dev->clk);
+
+	/* Setup watchdog input clock */
+	atomic_io_modify(dev->reg + TIMER_CTRL,
+			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT),
+			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT));
+
+	dev->clk_rate = clk_get_rate(dev->clk) / WDT_A370_RATIO;
+	return 0;
+}
+
+static int armadaxp_wdt_clock_init(struct platform_device *pdev,
+				   struct orion_watchdog *dev)
+{
+	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
+	if (IS_ERR(dev->clk))
+		return -ENODEV;
+	clk_prepare_enable(dev->clk);
+
+	/* Enable the fixed watchdog clock input */
+	atomic_io_modify(dev->reg + TIMER_CTRL,
+		WDT_AXP_FIXED_ENABLE_BIT,
+		WDT_AXP_FIXED_ENABLE_BIT);
+
+	dev->clk_rate = clk_get_rate(dev->clk);
+	return 0;
+}
+
 static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
@@ -90,6 +131,30 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int armada370_start(struct watchdog_device *wdt_dev)
+{
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+
+	spin_lock(&dev->lock);
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
+	atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit,
+				      dev->data->rstout_enable_bit);
+
+	spin_unlock(&dev->lock);
+	return 0;
+}
+
 static int orion_start(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
@@ -184,11 +249,35 @@ static const struct orion_watchdog_data orion_data = {
 	.start = orion_start,
 };
 
+static const struct orion_watchdog_data armada370_data = {
+	.rstout_enable_bit = BIT(8),
+	.wdt_enable_bit = BIT(8),
+	.wdt_counter_offset = 0x34,
+	.clock_init = armada370_wdt_clock_init,
+	.start = armada370_start,
+};
+
+static const struct orion_watchdog_data armadaxp_data = {
+	.rstout_enable_bit = BIT(8),
+	.wdt_enable_bit = BIT(8),
+	.wdt_counter_offset = 0x34,
+	.clock_init = armadaxp_wdt_clock_init,
+	.start = armada370_start,
+};
+
 static const struct of_device_id orion_wdt_of_match_table[] = {
 	{
 		.compatible = "marvell,orion-wdt",
 		.data = &orion_data,
 	},
+	{
+		.compatible = "marvell,armada-370-wdt",
+		.data = &armada370_data,
+	},
+	{
+		.compatible = "marvell,armada-xp-wdt",
+		.data = &armadaxp_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
-- 
1.8.1.5

