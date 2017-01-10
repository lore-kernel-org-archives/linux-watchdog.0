Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Johannes Thumshirn <morbidrsa@gmail.com>
Subject: [PATCH 30/62] watchdog: mena21_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 15:34:47 -0800
Message-Id: <1484091325-9199-31-git-send-email-linux@roeck-us.net>
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

- Replace 'goto l; ... l: return e;' with 'return e;'
- Drop assignments to otherwise unused variables
- Drop remove function
- Drop unnecessary mutex_destroy() on allocated data
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Johannes Thumshirn <morbidrsa@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/mena21_wdt.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index af6a7c489f08..045201a6fdb3 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -212,34 +212,15 @@ static int a21_wdt_probe(struct platform_device *pdev)
 	drv->wdt = a21_wdt;
 	dev_set_drvdata(&pdev->dev, drv);
 
-	ret = watchdog_register_device(&a21_wdt);
+	ret = devm_watchdog_register_device(&pdev->dev, &a21_wdt);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot register watchdog device\n");
-		goto err_register_wd;
+		return ret;
 	}
 
 	dev_info(&pdev->dev, "MEN A21 watchdog timer driver enabled\n");
 
 	return 0;
-
-err_register_wd:
-	mutex_destroy(&drv->lock);
-
-	return ret;
-}
-
-static int a21_wdt_remove(struct platform_device *pdev)
-{
-	struct a21_wdt_drv *drv = dev_get_drvdata(&pdev->dev);
-
-	dev_warn(&pdev->dev,
-		"Unregistering A21 watchdog driver, board may reboot\n");
-
-	watchdog_unregister_device(&drv->wdt);
-
-	mutex_destroy(&drv->lock);
-
-	return 0;
 }
 
 static void a21_wdt_shutdown(struct platform_device *pdev)
@@ -257,7 +238,6 @@ MODULE_DEVICE_TABLE(of, a21_wdt_ids);
 
 static struct platform_driver a21_wdt_driver = {
 	.probe = a21_wdt_probe,
-	.remove = a21_wdt_remove,
 	.shutdown = a21_wdt_shutdown,
 	.driver = {
 		.name = "a21-watchdog",
-- 
2.7.4
