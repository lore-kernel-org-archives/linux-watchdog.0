Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 58/62] watchdog: ts4800_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 18:09:12 -0800
Message-Id: <1484100561-17638-7-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484100561-17638-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop assignments to otherwise unused variables
- Drop remove function
- Drop platform_set_drvdata()
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/ts4800_wdt.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
index 2b8de8602b67..93e0da560b48 100644
--- a/drivers/watchdog/ts4800_wdt.c
+++ b/drivers/watchdog/ts4800_wdt.c
@@ -168,15 +168,13 @@ static int ts4800_wdt_probe(struct platform_device *pdev)
 	 */
 	ts4800_wdt_stop(wdd);
 
-	ret = watchdog_register_device(wdd);
+	ret = devm_watchdog_register_device(&pdev->dev, wdd);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"failed to register watchdog device\n");
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, wdt);
-
 	dev_info(&pdev->dev,
 		 "initialized (timeout = %d sec, nowayout = %d)\n",
 		 wdd->timeout, nowayout);
@@ -184,15 +182,6 @@ static int ts4800_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ts4800_wdt_remove(struct platform_device *pdev)
-{
-	struct ts4800_wdt *wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&wdt->wdd);
-
-	return 0;
-}
-
 static const struct of_device_id ts4800_wdt_of_match[] = {
 	{ .compatible = "technologic,ts4800-wdt", },
 	{ },
@@ -201,7 +190,6 @@ MODULE_DEVICE_TABLE(of, ts4800_wdt_of_match);
 
 static struct platform_driver ts4800_wdt_driver = {
 	.probe		= ts4800_wdt_probe,
-	.remove		= ts4800_wdt_remove,
 	.driver		= {
 		.name	= "ts4800_wdt",
 		.of_match_table = ts4800_wdt_of_match,
-- 
2.7.4
