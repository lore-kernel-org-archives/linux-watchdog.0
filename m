Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 13/62] watchdog: da9062_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:30 -0800
Message-Id: <1484091325-9199-14-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace 'val = e; return val;' with 'return e;'
- Drop assignments to otherwise unused variables
- Drop remove function
- Drop dev_set_drvdata()
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Support Opensource <support.opensource@diasemi.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/da9062_wdt.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index a02cee6820a1..9083d3d922b0 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -220,9 +220,8 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 	wdt->wdtdev.parent = &pdev->dev;
 
 	watchdog_set_drvdata(&wdt->wdtdev, wdt);
-	dev_set_drvdata(&pdev->dev, wdt);
 
-	ret = watchdog_register_device(&wdt->wdtdev);
+	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdtdev);
 	if (ret < 0) {
 		dev_err(wdt->hw->dev,
 			"watchdog registration failed (%d)\n", ret);
@@ -231,24 +230,11 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 
 	da9062_set_window_start(wdt);
 
-	ret = da9062_wdt_ping(&wdt->wdtdev);
-	if (ret < 0)
-		watchdog_unregister_device(&wdt->wdtdev);
-
-	return ret;
-}
-
-static int da9062_wdt_remove(struct platform_device *pdev)
-{
-	struct da9062_watchdog *wdt = dev_get_drvdata(&pdev->dev);
-
-	watchdog_unregister_device(&wdt->wdtdev);
-	return 0;
+	return da9062_wdt_ping(&wdt->wdtdev);
 }
 
 static struct platform_driver da9062_wdt_driver = {
 	.probe = da9062_wdt_probe,
-	.remove = da9062_wdt_remove,
 	.driver = {
 		.name = "da9062-watchdog",
 		.of_match_table = da9062_compatible_id_table,
-- 
2.7.4
