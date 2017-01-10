Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 06/62] watchdog: bcm47xx_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:23 -0800
Message-Id: <1484091325-9199-7-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace 'goto l; ... l: return e;' with 'return e;'
- Drop assignments to otherwise unused variables
- Drop remove function
- Call del_timer_sync() using devm_add_action()
  Introduce helper function since we can not call del_timer_sync() directly
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/bcm47xx_wdt.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index 35725e21b18a..83455ca1712e 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -177,6 +177,11 @@ static struct watchdog_ops bcm47xx_wdt_soft_ops = {
 	.restart        = bcm47xx_wdt_restart,
 };
 
+static void __del_timer_sync_cb(void *t)
+{
+	del_timer_sync(t);
+}
+
 static int bcm47xx_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -192,6 +197,10 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
 		wdt->wdd.ops = &bcm47xx_wdt_soft_ops;
 		setup_timer(&wdt->soft_timer, bcm47xx_wdt_soft_timer_tick,
 			    (long unsigned int)wdt);
+		ret = devm_add_action(&pdev->dev, __del_timer_sync_cb,
+				       &wdt->soft_timer);
+		if (ret)
+			return ret;
 	} else {
 		wdt->wdd.ops = &bcm47xx_wdt_hard_ops;
 	}
@@ -201,34 +210,19 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.parent = &pdev->dev;
 	ret = wdt->wdd.ops->set_timeout(&wdt->wdd, timeout);
 	if (ret)
-		goto err_timer;
+		return ret;
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
 	watchdog_set_restart_priority(&wdt->wdd, 64);
 	watchdog_stop_on_reboot(&wdt->wdd);
 
-	ret = watchdog_register_device(&wdt->wdd);
+	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
 	if (ret)
-		goto err_timer;
+		return ret;
 
 	dev_info(&pdev->dev, "BCM47xx Watchdog Timer enabled (%d seconds%s%s)\n",
 		timeout, nowayout ? ", nowayout" : "",
 		soft ? ", Software Timer" : "");
 	return 0;
-
-err_timer:
-	if (soft)
-		del_timer_sync(&wdt->soft_timer);
-
-	return ret;
-}
-
-static int bcm47xx_wdt_remove(struct platform_device *pdev)
-{
-	struct bcm47xx_wdt *wdt = dev_get_platdata(&pdev->dev);
-
-	watchdog_unregister_device(&wdt->wdd);
-
-	return 0;
 }
 
 static struct platform_driver bcm47xx_wdt_driver = {
@@ -236,7 +230,6 @@ static struct platform_driver bcm47xx_wdt_driver = {
 		.name	= "bcm47xx-wdt",
 	},
 	.probe		= bcm47xx_wdt_probe,
-	.remove		= bcm47xx_wdt_remove,
 };
 
 module_platform_driver(bcm47xx_wdt_driver);
-- 
2.7.4
