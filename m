Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 04/62] watchdog: atlas7_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 15:34:21 -0800
Message-Id: <1484091325-9199-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'val = e; return val;' with 'return e;'
- Replace 'if (e) return e; return 0;' with 'return e;'
- Drop assignments to otherwise unused variables
- Replace 'if (e) { return expr; }' with 'if (e) return expr;'
- Replace 'of_clk_get(np, 0)' with 'devm_clk_get(dev, NULL)'
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/atlas7_wdt.c | 43 ++++++++++++-------------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/watchdog/atlas7_wdt.c b/drivers/watchdog/atlas7_wdt.c
index ed80734befae..62b75d34f1a0 100644
--- a/drivers/watchdog/atlas7_wdt.c
+++ b/drivers/watchdog/atlas7_wdt.c
@@ -127,7 +127,6 @@ static const struct of_device_id atlas7_wdt_ids[] = {
 
 static int atlas7_wdt_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct atlas7_wdog *wdt;
 	struct resource *res;
 	struct clk *clk;
@@ -141,23 +140,26 @@ static int atlas7_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
-	clk = of_clk_get(np, 0);
+	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 	ret = clk_prepare_enable(clk);
 	if (ret) {
 		dev_err(&pdev->dev, "clk enable failed\n");
-		goto err;
+		return ret;
 	}
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       clk);
+	if (ret)
+		return ret;
 
 	/* disable watchdog hardware */
 	writel(0, wdt->base + ATLAS7_WDT_CNT_CTRL);
 
 	wdt->tick_rate = clk_get_rate(clk);
-	if (!wdt->tick_rate) {
-		ret = -EINVAL;
-		goto err1;
-	}
+	if (!wdt->tick_rate)
+		return -EINVAL;
 
 	wdt->clk = clk;
 	atlas7_wdd.min_timeout = 1;
@@ -169,35 +171,15 @@ static int atlas7_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&atlas7_wdd, wdt);
 	platform_set_drvdata(pdev, &atlas7_wdd);
 
-	ret = watchdog_register_device(&atlas7_wdd);
-	if (ret)
-		goto err1;
-
-	return 0;
-
-err1:
-	clk_disable_unprepare(clk);
-err:
-	clk_put(clk);
-	return ret;
-}
-
-static void atlas7_wdt_shutdown(struct platform_device *pdev)
-{
-	struct watchdog_device *wdd = platform_get_drvdata(pdev);
-	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
-
-	atlas7_wdt_disable(wdd);
-	clk_disable_unprepare(wdt->clk);
+	watchdog_stop_on_reboot(&atlas7_wdd);
+	return devm_watchdog_register_device(&pdev->dev, &atlas7_wdd);
 }
 
 static int atlas7_wdt_remove(struct platform_device *pdev)
 {
 	struct watchdog_device *wdd = platform_get_drvdata(pdev);
-	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
 
-	atlas7_wdt_shutdown(pdev);
-	clk_put(wdt->clk);
+	atlas7_wdt_disable(wdd);
 	return 0;
 }
 
@@ -237,7 +219,6 @@ static struct platform_driver atlas7_wdt_driver = {
 	},
 	.probe = atlas7_wdt_probe,
 	.remove = atlas7_wdt_remove,
-	.shutdown = atlas7_wdt_shutdown,
 };
 module_platform_driver(atlas7_wdt_driver);
 
-- 
2.7.4
