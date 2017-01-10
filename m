Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 14/62] watchdog: da9063_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:31 -0800
Message-Id: <1484091325-9199-15-git-send-email-linux@roeck-us.net>
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
- Replace 'if (e) return e; return 0;' with 'return e;'
- Drop assignments to otherwise unused variables
- Drop unused variables
- Drop remove function
- Drop dev_set_drvdata()
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Support Opensource <support.opensource@diasemi.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/da9063_wdt.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 5d6b4e5f7989..4691c5509129 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -151,7 +151,6 @@ static const struct watchdog_ops da9063_watchdog_ops = {
 
 static int da9063_wdt_probe(struct platform_device *pdev)
 {
-	int ret;
 	struct da9063 *da9063;
 	struct da9063_watchdog *wdt;
 
@@ -181,27 +180,12 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	watchdog_set_restart_priority(&wdt->wdtdev, 128);
 
 	watchdog_set_drvdata(&wdt->wdtdev, wdt);
-	dev_set_drvdata(&pdev->dev, wdt);
-
-	ret = watchdog_register_device(&wdt->wdtdev);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static int da9063_wdt_remove(struct platform_device *pdev)
-{
-	struct da9063_watchdog *wdt = dev_get_drvdata(&pdev->dev);
-
-	watchdog_unregister_device(&wdt->wdtdev);
 
-	return 0;
+	return devm_watchdog_register_device(&pdev->dev, &wdt->wdtdev);
 }
 
 static struct platform_driver da9063_wdt_driver = {
 	.probe = da9063_wdt_probe,
-	.remove = da9063_wdt_remove,
 	.driver = {
 		.name = DA9063_DRVNAME_WATCHDOG,
 	},
-- 
2.7.4
