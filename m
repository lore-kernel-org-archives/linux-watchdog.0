Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41668 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754558AbaAUN0t (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 08:26:49 -0500
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
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 09/15] watchdog: orion: Add per-compatible clock initialization
Date: Tue, 21 Jan 2014 10:26:08 -0300
Message-Id: <1390310774-20781-10-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Following the introduction of the compatible-data field,
it's now possible to further abstract the clock initialization.
This will allow to support SoC with a different clock setup.

While we're at it, let's fix the clock error handling by returning
PTR_ERR and checking clk_prepare_enable().

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 5108496..b8d0f87 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -44,10 +44,14 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = -1;		/* module parameter (seconds) */
 
+struct orion_watchdog;
+
 struct orion_watchdog_data {
 	int wdt_counter_offset;
 	int wdt_enable_bit;
 	int rstout_enable_bit;
+	int (*clock_init) (struct platform_device *,
+			   struct orion_watchdog *);
 };
 
 struct orion_watchdog {
@@ -59,6 +63,22 @@ struct orion_watchdog {
 	struct orion_watchdog_data *data;
 };
 
+static int orion_wdt_clock_init(struct platform_device *pdev,
+				struct orion_watchdog *dev)
+{
+	int ret;
+
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
+	ret = clk_prepare_enable(dev->clk);
+	if (ret)
+		return ret;
+
+	dev->clk_rate = clk_get_rate(dev->clk);
+	return 0;
+}
+
 static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
@@ -137,6 +157,7 @@ static const struct orion_watchdog_data orion_data = {
 	.rstout_enable_bit = BIT(1),
 	.wdt_enable_bit = BIT(4),
 	.wdt_counter_offset = 0x24,
+	.clock_init = orion_wdt_clock_init,
 };
 
 static const struct of_device_id orion_wdt_of_match_table[] = {
@@ -171,14 +192,6 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	dev->wdt.min_timeout = 1;
 	dev->data = (struct orion_watchdog_data *)match->data;
 
-	dev->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(dev->clk)) {
-		dev_err(&pdev->dev, "Orion Watchdog missing clock\n");
-		return -ENODEV;
-	}
-	clk_prepare_enable(dev->clk);
-	dev->clk_rate = clk_get_rate(dev->clk);
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
@@ -194,6 +207,12 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	if (!dev->rstout)
 		return -ENOMEM;
 
+	ret = dev->data->clock_init(pdev, dev);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot initialize clock\n");
+		return ret;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq > 0) {
 		/*
-- 
1.8.1.5

