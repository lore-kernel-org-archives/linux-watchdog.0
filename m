Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 59/62] watchdog: twl4030_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 18:09:13 -0800
Message-Id: <1484100561-17638-8-git-send-email-linux@roeck-us.net>
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

- Replace 'val = e; return val;' with 'return e;'
- Replace 'if (e) return e; return 0;' with 'return e;'
- Drop assignments to otherwise unused variables
- Drop remove function
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/twl4030_wdt.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 9bf3cc0f3961..9fd8073b0cde 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -70,7 +70,6 @@ static const struct watchdog_ops twl4030_wdt_ops = {
 
 static int twl4030_wdt_probe(struct platform_device *pdev)
 {
-	int ret = 0;
 	struct watchdog_device *wdt;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
@@ -90,20 +89,7 @@ static int twl4030_wdt_probe(struct platform_device *pdev)
 
 	twl4030_wdt_stop(wdt);
 
-	ret = watchdog_register_device(wdt);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static int twl4030_wdt_remove(struct platform_device *pdev)
-{
-	struct watchdog_device *wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(wdt);
-
-	return 0;
+	return devm_watchdog_register_device(&pdev->dev, wdt);
 }
 
 #ifdef CONFIG_PM
@@ -137,7 +123,6 @@ MODULE_DEVICE_TABLE(of, twl_wdt_of_match);
 
 static struct platform_driver twl4030_wdt_driver = {
 	.probe		= twl4030_wdt_probe,
-	.remove		= twl4030_wdt_remove,
 	.suspend	= twl4030_wdt_suspend,
 	.resume		= twl4030_wdt_resume,
 	.driver		= {
-- 
2.7.4
