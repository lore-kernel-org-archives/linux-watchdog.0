Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 28/62] watchdog: max63xx_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:45 -0800
Message-Id: <1484091325-9199-29-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
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
 drivers/watchdog/max63xx_wdt.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index ac5840d9689a..140897ca1fe5 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -225,7 +225,6 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	platform_set_drvdata(pdev, &wdt->wdd);
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 
 	wdt->wdd.parent = &pdev->dev;
@@ -235,7 +234,7 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
 
-	err = watchdog_register_device(&wdt->wdd);
+	err = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
 	if (err)
 		return err;
 
@@ -244,14 +243,6 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int max63xx_wdt_remove(struct platform_device *pdev)
-{
-	struct watchdog_device *wdd = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(wdd);
-	return 0;
-}
-
 static const struct platform_device_id max63xx_id_table[] = {
 	{ "max6369_wdt", (kernel_ulong_t)max6369_table, },
 	{ "max6370_wdt", (kernel_ulong_t)max6369_table, },
@@ -265,7 +256,6 @@ MODULE_DEVICE_TABLE(platform, max63xx_id_table);
 
 static struct platform_driver max63xx_wdt_driver = {
 	.probe		= max63xx_wdt_probe,
-	.remove		= max63xx_wdt_remove,
 	.id_table	= max63xx_id_table,
 	.driver		= {
 		.name	= "max63xx_wdt",
-- 
2.7.4
