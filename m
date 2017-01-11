Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 35/62] watchdog: mpc8xxx_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 16:44:44 -0800
Message-Id: <1484095516-12720-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484095516-12720-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
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
- Call del_timer_sync() using devm_add_action()
  Introduce helper function since we can not call del_timer_sync() directly
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/mpc8xxx_wdt.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 366e5c7e650b..262803fa413b 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -140,6 +140,11 @@ static struct watchdog_ops mpc8xxx_wdt_ops = {
 	.stop = mpc8xxx_wdt_stop,
 };
 
+static void __del_timer_sync_cb(void *t)
+{
+	del_timer_sync(t);
+}
+
 static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 {
 	int ret;
@@ -175,6 +180,10 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	spin_lock_init(&ddata->lock);
 	setup_timer(&ddata->timer, mpc8xxx_wdt_timer_ping,
 		    (unsigned long)ddata);
+	ret = devm_add_action(&ofdev->dev, __del_timer_sync_cb,
+			       &ddata->timer);
+	if (ret)
+		return ret;
 
 	ddata->wdd.info = &mpc8xxx_wdt_info,
 	ddata->wdd.ops = &mpc8xxx_wdt_ops,
@@ -186,7 +195,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 
 	watchdog_set_nowayout(&ddata->wdd, nowayout);
 
-	ret = watchdog_register_device(&ddata->wdd);
+	ret = devm_watchdog_register_device(&ofdev->dev, &ddata->wdd);
 	if (ret) {
 		pr_err("cannot register watchdog device (err=%d)\n", ret);
 		return ret;
@@ -203,19 +212,6 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	if (enabled)
 		mod_timer(&ddata->timer, jiffies);
 
-	platform_set_drvdata(ofdev, ddata);
-	return 0;
-}
-
-static int mpc8xxx_wdt_remove(struct platform_device *ofdev)
-{
-	struct mpc8xxx_wdt_ddata *ddata = platform_get_drvdata(ofdev);
-
-	pr_crit("Watchdog removed, expect the %s soon!\n",
-		reset ? "reset" : "machine check exception");
-	del_timer_sync(&ddata->timer);
-	watchdog_unregister_device(&ddata->wdd);
-
 	return 0;
 }
 
@@ -246,7 +242,6 @@ MODULE_DEVICE_TABLE(of, mpc8xxx_wdt_match);
 
 static struct platform_driver mpc8xxx_wdt_driver = {
 	.probe		= mpc8xxx_wdt_probe,
-	.remove		= mpc8xxx_wdt_remove,
 	.driver = {
 		.name = "mpc8xxx_wdt",
 		.of_match_table = mpc8xxx_wdt_match,
-- 
2.7.4
