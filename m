Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34796 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750985AbaKDNXT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Nov 2014 08:23:19 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Nadav Haklai <nadavh@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 2/3] watchdog: orion: Use the reference clock on Armada 375 SoC
Date: Tue,  4 Nov 2014 10:21:32 -0300
Message-Id: <1415107293-19258-3-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1415107293-19258-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1415107293-19258-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The 25 MHz reference clock has better stability so its use is prefered over the
core clock. Change the Armada 375 clock initialization to use this reference
clock. To ensure the driver is compatible with an old devicetree, also provide
a fallback path which will silently return to the previous behavior.

While here, add the clock specification to the binding documentation.

Acked-by: Jason Cooper <jason@lakedaemon.net>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/watchdog/marvel.txt        | 13 +++++++
 drivers/watchdog/orion_wdt.c                       | 42 +++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
index 97223fd..858ed92 100644
--- a/Documentation/devicetree/bindings/watchdog/marvel.txt
+++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
@@ -17,6 +17,18 @@ For "marvell,armada-375-wdt" and "marvell,armada-380-wdt":
 - reg		: A third entry is mandatory and should contain the
                   shared mask/unmask RSTOUT address.
 
+Clocks required for compatibles = "marvell,orion-wdt",
+				  "marvell,armada-370-wdt":
+- clocks : Must contain a single entry describing the clock input
+
+Clocks required for compatibles = "marvell,armada-xp-wdt"
+				  "marvell,armada-375-wdt"
+				  "marvell,armada-380-wdt":
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Must include the following entries:
+  "nbclk" (L2/coherency fabric clock),
+  "fixed" (Reference 25 MHz fixed-clock).
+
 Optional properties:
 
 - interrupts	: Contains the IRQ for watchdog expiration
@@ -30,4 +42,5 @@ Example:
 		interrupts = <3>;
 		timeout-sec = <10>;
 		status = "okay";
+		clocks = <&gate_clk 7>;
 	};
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 00d0741..8cb1ff3 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -114,6 +114,46 @@ static int armada370_wdt_clock_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int armada375_wdt_clock_init(struct platform_device *pdev,
+				    struct orion_watchdog *dev)
+{
+	int ret;
+
+	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
+	if (!IS_ERR(dev->clk)) {
+		ret = clk_prepare_enable(dev->clk);
+		if (ret) {
+			clk_put(dev->clk);
+			return ret;
+		}
+
+		atomic_io_modify(dev->reg + TIMER_CTRL,
+				WDT_AXP_FIXED_ENABLE_BIT,
+				WDT_AXP_FIXED_ENABLE_BIT);
+		dev->clk_rate = clk_get_rate(dev->clk);
+
+		return 0;
+	}
+
+	/* Mandatory fallback for proper devicetree backward compatibility */
+	dev->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
+
+	ret = clk_prepare_enable(dev->clk);
+	if (ret) {
+		clk_put(dev->clk);
+		return ret;
+	}
+
+	atomic_io_modify(dev->reg + TIMER_CTRL,
+			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT),
+			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT));
+	dev->clk_rate = clk_get_rate(dev->clk) / WDT_A370_RATIO;
+
+	return 0;
+}
+
 static int armadaxp_wdt_clock_init(struct platform_device *pdev,
 				   struct orion_watchdog *dev)
 {
@@ -394,7 +434,7 @@ static const struct orion_watchdog_data armada375_data = {
 	.rstout_mask_bit = BIT(10),
 	.wdt_enable_bit = BIT(8),
 	.wdt_counter_offset = 0x34,
-	.clock_init = armada370_wdt_clock_init,
+	.clock_init = armada375_wdt_clock_init,
 	.enabled = armada375_enabled,
 	.start = armada375_start,
 	.stop = armada375_stop,
-- 
2.1.0

