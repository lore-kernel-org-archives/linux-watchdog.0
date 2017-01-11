Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 41/62] watchdog: orion_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 16:44:50 -0800
Message-Id: <1484095516-12720-11-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484095516-12720-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Use devm_clk_get() if the device parameter is not NULL
- Replace 'goto l; ... l: return e;' with 'return e;'
- Drop assignments to otherwise unused variables
- Replace 'if (e) { return expr; }' with 'if (e) return expr;'
- Drop remove function
- Replace 'of_clk_get_by_name(np, name)' with 'devm_clk_get(dev, name)'
- Drop platform_set_drvdata()
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/orion_wdt.c | 87 ++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 48 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 39be4dd8035e..8949c0b7498e 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -78,14 +78,17 @@ static int orion_wdt_clock_init(struct platform_device *pdev,
 {
 	int ret;
 
-	dev->clk = clk_get(&pdev->dev, NULL);
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
 	ret = clk_prepare_enable(dev->clk);
-	if (ret) {
-		clk_put(dev->clk);
+	if (ret)
+		return ret;
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       dev->clk);
+	if (ret)
 		return ret;
-	}
 
 	dev->clk_rate = clk_get_rate(dev->clk);
 	return 0;
@@ -96,14 +99,17 @@ static int armada370_wdt_clock_init(struct platform_device *pdev,
 {
 	int ret;
 
-	dev->clk = clk_get(&pdev->dev, NULL);
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
 	ret = clk_prepare_enable(dev->clk);
-	if (ret) {
-		clk_put(dev->clk);
+	if (ret)
+		return ret;
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       dev->clk);
+	if (ret)
 		return ret;
-	}
 
 	/* Setup watchdog input clock */
 	atomic_io_modify(dev->reg + TIMER_CTRL,
@@ -119,13 +125,16 @@ static int armada375_wdt_clock_init(struct platform_device *pdev,
 {
 	int ret;
 
-	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
+	dev->clk = devm_clk_get(&pdev->dev, "fixed");
 	if (!IS_ERR(dev->clk)) {
 		ret = clk_prepare_enable(dev->clk);
-		if (ret) {
-			clk_put(dev->clk);
+		if (ret)
+			return ret;
+		ret = devm_add_action_or_reset(&pdev->dev,
+					(void(*)(void *))clk_disable_unprepare,
+					dev->clk);
+		if (ret)
 			return ret;
-		}
 
 		atomic_io_modify(dev->reg + TIMER_CTRL,
 				WDT_AXP_FIXED_ENABLE_BIT,
@@ -136,15 +145,18 @@ static int armada375_wdt_clock_init(struct platform_device *pdev,
 	}
 
 	/* Mandatory fallback for proper devicetree backward compatibility */
-	dev->clk = clk_get(&pdev->dev, NULL);
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
 
 	ret = clk_prepare_enable(dev->clk);
-	if (ret) {
-		clk_put(dev->clk);
+	if (ret)
+		return ret;
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       dev->clk);
+	if (ret)
 		return ret;
-	}
 
 	atomic_io_modify(dev->reg + TIMER_CTRL,
 			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT),
@@ -159,14 +171,17 @@ static int armadaxp_wdt_clock_init(struct platform_device *pdev,
 {
 	int ret;
 
-	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
+	dev->clk = devm_clk_get(&pdev->dev, "fixed");
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
 	ret = clk_prepare_enable(dev->clk);
-	if (ret) {
-		clk_put(dev->clk);
+	if (ret)
+		return ret;
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       dev->clk);
+	if (ret)
 		return ret;
-	}
 
 	/* Enable the fixed watchdog clock input */
 	atomic_io_modify(dev->reg + TIMER_CTRL,
@@ -570,7 +585,6 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	dev->wdt.parent = &pdev->dev;
 	watchdog_init_timeout(&dev->wdt, heartbeat, &pdev->dev);
 
-	platform_set_drvdata(pdev, &dev->wdt);
 	watchdog_set_drvdata(&dev->wdt, dev);
 
 	/*
@@ -593,46 +607,23 @@ static int orion_wdt_probe(struct platform_device *pdev)
 				       pdev->name, dev);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "failed to request IRQ\n");
-			goto disable_clk;
+			return ret;
 		}
 	}
 
 	watchdog_set_nowayout(&dev->wdt, nowayout);
-	ret = watchdog_register_device(&dev->wdt);
+	watchdog_stop_on_reboot(&dev->wdt);
+	ret = devm_watchdog_register_device(&pdev->dev, &dev->wdt);
 	if (ret)
-		goto disable_clk;
+		return ret;
 
 	pr_info("Initial timeout %d sec%s\n",
 		dev->wdt.timeout, nowayout ? ", nowayout" : "");
 	return 0;
-
-disable_clk:
-	clk_disable_unprepare(dev->clk);
-	clk_put(dev->clk);
-	return ret;
-}
-
-static int orion_wdt_remove(struct platform_device *pdev)
-{
-	struct watchdog_device *wdt_dev = platform_get_drvdata(pdev);
-	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
-
-	watchdog_unregister_device(wdt_dev);
-	clk_disable_unprepare(dev->clk);
-	clk_put(dev->clk);
-	return 0;
-}
-
-static void orion_wdt_shutdown(struct platform_device *pdev)
-{
-	struct watchdog_device *wdt_dev = platform_get_drvdata(pdev);
-	orion_wdt_stop(wdt_dev);
 }
 
 static struct platform_driver orion_wdt_driver = {
 	.probe		= orion_wdt_probe,
-	.remove		= orion_wdt_remove,
-	.shutdown	= orion_wdt_shutdown,
 	.driver		= {
 		.name	= "orion_wdt",
 		.of_match_table = orion_wdt_of_match_table,
-- 
2.7.4
