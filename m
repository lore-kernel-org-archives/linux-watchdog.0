Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42300 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756496AbaBFRV3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Feb 2014 12:21:29 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v6 13/19] watchdog: orion: Add support for Armada 370 and Armada XP SoC
Date: Thu,  6 Feb 2014 14:20:20 -0300
Message-Id: <1391707226-18258-14-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Using the added infrastructure for handling SoC differences,
this commit adds support for the watchdog controller available
in Armada 370 and Armada XP SoCs.

Also, and because the AXP clock initialization uses of_clk_get_by_name,
this commit changes the orion clock initialization to use clk_get() and
adds a proper clk_put() on the common exit/error paths.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/watchdog/marvel.txt        |   3 +
 drivers/watchdog/orion_wdt.c                       | 106 ++++++++++++++++++++-
 2 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
index 1544fe9..de11eb4 100644
--- a/Documentation/devicetree/bindings/watchdog/marvel.txt
+++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
@@ -3,6 +3,9 @@
 Required Properties:
 
 - Compatibility : "marvell,orion-wdt"
+		  "marvell,armada-370-wdt"
+		  "marvell,armada-xp-wdt"
+
 - reg		: Should contain two entries: first one with the
 		  timer control address, second one with the
 		  rstout enable address.
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index ce0c365..860a99b 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -36,9 +36,17 @@
  * Watchdog timer block registers.
  */
 #define TIMER_CTRL		0x0000
+#define TIMER_A370_STATUS	0x04
 
 #define WDT_MAX_CYCLE_COUNT	0xffffffff
 
+#define WDT_A370_RATIO_MASK(v)	((v) << 16)
+#define WDT_A370_RATIO_SHIFT	5
+#define WDT_A370_RATIO		(1 << WDT_A370_RATIO_SHIFT)
+
+#define WDT_AXP_FIXED_ENABLE_BIT BIT(10)
+#define WDT_A370_EXPIRED	BIT(31)
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = -1;		/* module parameter (seconds) */
 
@@ -67,12 +75,60 @@ static int orion_wdt_clock_init(struct platform_device *pdev,
 {
 	int ret;
 
-	dev->clk = devm_clk_get(&pdev->dev, NULL);
+	dev->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
 	ret = clk_prepare_enable(dev->clk);
-	if (ret)
+	if (ret) {
+		clk_put(dev->clk);
 		return ret;
+	}
+
+	dev->clk_rate = clk_get_rate(dev->clk);
+	return 0;
+}
+
+static int armada370_wdt_clock_init(struct platform_device *pdev,
+				    struct orion_watchdog *dev)
+{
+	int ret;
+
+	dev->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
+	ret = clk_prepare_enable(dev->clk);
+	if (ret) {
+		clk_put(dev->clk);
+		return ret;
+	}
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
+	int ret;
+
+	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
+	ret = clk_prepare_enable(dev->clk);
+	if (ret) {
+		clk_put(dev->clk);
+		return ret;
+	}
+
+	/* Enable the fixed watchdog clock input */
+	atomic_io_modify(dev->reg + TIMER_CTRL,
+			 WDT_AXP_FIXED_ENABLE_BIT,
+			 WDT_AXP_FIXED_ENABLE_BIT);
 
 	dev->clk_rate = clk_get_rate(dev->clk);
 	return 0;
@@ -87,6 +143,26 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int armada370_start(struct watchdog_device *wdt_dev)
+{
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
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
+	return 0;
+}
+
 static int orion_start(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
@@ -195,11 +271,35 @@ static const struct orion_watchdog_data orion_data = {
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
@@ -285,6 +385,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
 
 disable_clk:
 	clk_disable_unprepare(dev->clk);
+	clk_put(dev->clk);
 	return ret;
 }
 
@@ -295,6 +396,7 @@ static int orion_wdt_remove(struct platform_device *pdev)
 
 	watchdog_unregister_device(wdt_dev);
 	clk_disable_unprepare(dev->clk);
+	clk_put(dev->clk);
 	return 0;
 }
 
-- 
1.8.1.5

