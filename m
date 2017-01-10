Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 09/62] watchdog: cadence_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 15:34:26 -0800
Message-Id: <1484091325-9199-10-git-send-email-linux@roeck-us.net>
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
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/cadence_wdt.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index 8d61e8bfe60b..a77c4be54da9 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -340,8 +340,7 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 	wdt->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(wdt->clk)) {
 		dev_err(&pdev->dev, "input clock not found\n");
-		ret = PTR_ERR(wdt->clk);
-		return ret;
+		return PTR_ERR(wdt->clk);
 	}
 
 	ret = clk_prepare_enable(wdt->clk);
@@ -349,6 +348,11 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "unable to enable clock\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       wdt->clk);
+	if (ret)
+		return ret;
 
 	clock_f = clk_get_rate(wdt->clk);
 	if (clock_f <= CDNS_WDT_CLK_75MHZ) {
@@ -361,10 +365,11 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 
 	spin_lock_init(&wdt->io_lock);
 
-	ret = watchdog_register_device(cdns_wdt_device);
+	watchdog_stop_on_reboot(cdns_wdt_device);
+	ret = devm_watchdog_register_device(&pdev->dev, cdns_wdt_device);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register wdt device\n");
-		goto err_clk_disable;
+		return ret;
 	}
 	platform_set_drvdata(pdev, wdt);
 
@@ -373,11 +378,6 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 		 nowayout ? ", nowayout" : "");
 
 	return 0;
-
-err_clk_disable:
-	clk_disable_unprepare(wdt->clk);
-
-	return ret;
 }
 
 /**
@@ -393,27 +393,11 @@ static int cdns_wdt_remove(struct platform_device *pdev)
 	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
 
 	cdns_wdt_stop(&wdt->cdns_wdt_device);
-	watchdog_unregister_device(&wdt->cdns_wdt_device);
-	clk_disable_unprepare(wdt->clk);
 
 	return 0;
 }
 
 /**
- * cdns_wdt_shutdown - Stop the device.
- *
- * @pdev: handle to the platform structure.
- *
- */
-static void cdns_wdt_shutdown(struct platform_device *pdev)
-{
-	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
-
-	cdns_wdt_stop(&wdt->cdns_wdt_device);
-	clk_disable_unprepare(wdt->clk);
-}
-
-/**
  * cdns_wdt_suspend - Stop the device.
  *
  * @dev: handle to the device structure.
@@ -468,7 +452,6 @@ MODULE_DEVICE_TABLE(of, cdns_wdt_of_match);
 static struct platform_driver cdns_wdt_driver = {
 	.probe		= cdns_wdt_probe,
 	.remove		= cdns_wdt_remove,
-	.shutdown	= cdns_wdt_shutdown,
 	.driver		= {
 		.name	= "cdns-wdt",
 		.of_match_table = cdns_wdt_of_match,
-- 
2.7.4
