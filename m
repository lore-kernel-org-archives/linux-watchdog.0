Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 17/62] watchdog: dw_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:34 -0800
Message-Id: <1484091325-9199-18-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

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
- Drop remove function
- Replace &pdev->dev with dev if 'struct device *dev' is a declared
  variable
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/dw_wdt.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 914da3a4d334..4d372fc36385 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -227,12 +227,15 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(dw_wdt->clk);
 	if (ret)
 		return ret;
+	ret = devm_add_action_or_reset(dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       dw_wdt->clk);
+	if (ret)
+		return ret;
 
 	dw_wdt->rate = clk_get_rate(dw_wdt->clk);
-	if (dw_wdt->rate == 0) {
-		ret = -EINVAL;
-		goto out_disable_clk;
-	}
+	if (dw_wdt->rate == 0)
+		return -EINVAL;
 
 	wdd = &dw_wdt->wdd;
 	wdd->info = &dw_wdt_ident;
@@ -263,25 +266,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	watchdog_set_restart_priority(wdd, 128);
 
-	ret = watchdog_register_device(wdd);
-	if (ret)
-		goto out_disable_clk;
-
-	return 0;
-
-out_disable_clk:
-	clk_disable_unprepare(dw_wdt->clk);
-	return ret;
-}
-
-static int dw_wdt_drv_remove(struct platform_device *pdev)
-{
-	struct dw_wdt *dw_wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&dw_wdt->wdd);
-	clk_disable_unprepare(dw_wdt->clk);
-
-	return 0;
+	return devm_watchdog_register_device(dev, wdd);
 }
 
 #ifdef CONFIG_OF
@@ -294,7 +279,6 @@ MODULE_DEVICE_TABLE(of, dw_wdt_of_match);
 
 static struct platform_driver dw_wdt_driver = {
 	.probe		= dw_wdt_drv_probe,
-	.remove		= dw_wdt_drv_remove,
 	.driver		= {
 		.name	= "dw_wdt",
 		.of_match_table = of_match_ptr(dw_wdt_of_match),
-- 
2.7.4
