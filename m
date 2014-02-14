Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59318 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753056AbaBNWZJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Feb 2014 17:25:09 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RESEND/PATCH v7 10/18] watchdog: orion: Add per-compatible clock initialization
Date: Fri, 14 Feb 2014 19:24:10 -0300
Message-Id: <1392416658-2780-11-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Following the introduction of the compatible-data field,
it's now possible to further abstract the clock initialization.
This will allow to support SoC with a different clock setup.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 53 ++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index b220e34..b48fd08 100644
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
+	int (*clock_init)(struct platform_device *,
+			  struct orion_watchdog *);
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
@@ -172,6 +192,7 @@ static const struct orion_watchdog_data orion_data = {
 	.rstout_enable_bit = BIT(1),
 	.wdt_enable_bit = BIT(4),
 	.wdt_counter_offset = 0x24,
+	.clock_init = orion_wdt_clock_init,
 };
 
 static const struct of_device_id orion_wdt_of_match_table[] = {
@@ -206,34 +227,24 @@ static int orion_wdt_probe(struct platform_device *pdev)
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
-	if (!res) {
-		ret = -ENODEV;
-		goto disable_clk;
-	}
+	if (!res)
+		return -ENODEV;
 
 	dev->reg = devm_ioremap(&pdev->dev, res->start,
 			       resource_size(res));
-	if (!dev->reg) {
-		ret = -ENOMEM;
-		goto disable_clk;
-	}
+	if (!dev->reg)
+		return -ENOMEM;
 
 	dev->rstout = orion_wdt_ioremap_rstout(pdev, res->start &
 						     INTERNAL_REGS_MASK);
-	if (!dev->rstout) {
-		ret = -ENODEV;
-		goto disable_clk;
+	if (!dev->rstout)
+		return -ENODEV;
+
+	ret = dev->data->clock_init(pdev, dev);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot initialize clock\n");
+		return ret;
 	}
 
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / dev->clk_rate;
-- 
1.8.1.5

