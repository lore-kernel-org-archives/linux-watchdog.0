Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52491 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751123AbaJVNgm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 09:36:42 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 2/4] watchdog: orion: Use the reference clock on Armada 375 SoC
Date: Wed, 22 Oct 2014 10:34:42 -0300
Message-Id: <1413984884-20273-3-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The 25 MHz reference clock has better stability so its use is preferred over the
core clock. Changes the Armada 375 clock initialization to use this reference
clock. To ensure the driver is compatible with an old devicetree, also provide
a fallback path which will silently return to the previous behavior.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 00d0741..6452fa2 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -114,6 +114,44 @@ static int armada370_wdt_clock_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int armada375_wdt_clock_init(struct platform_device *pdev,
+				    struct orion_watchdog *dev)
+{
+	int ret;
+
+	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
+	if (!IS_ERR(dev->clk)) {
+
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
+		return 0;
+	}
+
+	/* Mandatory fallback for proper devicetree backward compatibility */
+	dev->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
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
+	return 0;
+}
+
 static int armadaxp_wdt_clock_init(struct platform_device *pdev,
 				   struct orion_watchdog *dev)
 {
@@ -394,7 +432,7 @@ static const struct orion_watchdog_data armada375_data = {
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

