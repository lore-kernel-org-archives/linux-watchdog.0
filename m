Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51273 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753728AbaA0P2J (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jan 2014 10:28:09 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v5 12/20] watchdog: orion: Add per-compatible clock initialization
Date: Mon, 27 Jan 2014 12:27:12 -0300
Message-Id: <1390836440-12744-13-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Following the introduction of the compatible-data field,
it's now possible to further abstract the clock initialization.
This will allow to support SoC with a different clock setup.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 540b5c9..4100d5b 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -42,10 +42,14 @@
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
@@ -57,6 +61,22 @@ struct orion_watchdog {
 	const struct orion_watchdog_data *data;
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
@@ -162,6 +182,7 @@ static const struct orion_watchdog_data orion_data = {
 	.rstout_enable_bit = BIT(1),
 	.wdt_enable_bit = BIT(4),
 	.wdt_counter_offset = 0x24,
+	.clock_init = orion_wdt_clock_init,
 };
 
 static const struct of_device_id orion_wdt_of_match_table[] = {
@@ -196,16 +217,6 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	dev->wdt.min_timeout = 1;
 	dev->data = match->data;
 
-	dev->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(dev->clk)) {
-		dev_err(&pdev->dev, "Orion Watchdog missing clock\n");
-		return PTR_ERR(dev->clk);
-	}
-	ret = clk_prepare_enable(dev->clk);
-	if (ret)
-		return ret;
-	dev->clk_rate = clk_get_rate(dev->clk);
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		ret = -ENODEV;
@@ -226,6 +237,12 @@ static int orion_wdt_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
+	ret = dev->data->clock_init(pdev, dev);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot initialize clock\n");
+		return ret;
+	}
+
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / dev->clk_rate;
 
 	dev->wdt.timeout = wdt_max_duration;
-- 
1.8.1.5

