Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v2 03/13] watchdog: da9063_wdt: use core restart handler
Date: Mon, 16 Nov 2015 12:28:01 -0500
Message-Id: <1447694891-24831-4-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1447694891-24831-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1447694891-24831-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Get rid of the custom restart handler by using the one provided by the
watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/da9063_wdt.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 6bf130b..11e8875 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -20,7 +20,6 @@
 #include <linux/delay.h>
 #include <linux/mfd/da9063/registers.h>
 #include <linux/mfd/da9063/core.h>
-#include <linux/reboot.h>
 #include <linux/regmap.h>
 
 /*
@@ -39,7 +38,6 @@ static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
 struct da9063_watchdog {
 	struct da9063 *da9063;
 	struct watchdog_device wdtdev;
-	struct notifier_block restart_handler;
 };
 
 static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
@@ -121,12 +119,9 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 	return ret;
 }
 
-static int da9063_wdt_restart_handler(struct notifier_block *this,
-				      unsigned long mode, void *cmd)
+static int da9063_wdt_restart(struct watchdog_device *wdd)
 {
-	struct da9063_watchdog *wdt = container_of(this,
-						   struct da9063_watchdog,
-						   restart_handler);
+	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
 	int ret;
 
 	ret = regmap_write(wdt->da9063->regmap, DA9063_REG_CONTROL_F,
@@ -135,7 +130,7 @@ static int da9063_wdt_restart_handler(struct notifier_block *this,
 		dev_alert(wdt->da9063->dev, "Failed to shutdown (err = %d)\n",
 			  ret);
 
-	return NOTIFY_DONE;
+	return ret;
 }
 
 static const struct watchdog_info da9063_watchdog_info = {
@@ -149,6 +144,7 @@ static const struct watchdog_ops da9063_watchdog_ops = {
 	.stop = da9063_wdt_stop,
 	.ping = da9063_wdt_ping,
 	.set_timeout = da9063_wdt_set_timeout,
+	.restart = da9063_wdt_restart,
 };
 
 static int da9063_wdt_probe(struct platform_device *pdev)
@@ -179,6 +175,8 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 
 	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
 
+	watchdog_set_restart_priority(&wdt->wdtdev, 128);
+
 	watchdog_set_drvdata(&wdt->wdtdev, wdt);
 	dev_set_drvdata(&pdev->dev, wdt);
 
@@ -186,13 +184,6 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	wdt->restart_handler.notifier_call = da9063_wdt_restart_handler;
-	wdt->restart_handler.priority = 128;
-	ret = register_restart_handler(&wdt->restart_handler);
-	if (ret)
-		dev_err(wdt->da9063->dev,
-			"Failed to register restart handler (err = %d)\n", ret);
-
 	return 0;
 }
 
@@ -200,8 +191,6 @@ static int da9063_wdt_remove(struct platform_device *pdev)
 {
 	struct da9063_watchdog *wdt = dev_get_drvdata(&pdev->dev);
 
-	unregister_restart_handler(&wdt->restart_handler);
-
 	watchdog_unregister_device(&wdt->wdtdev);
 
 	return 0;
-- 
2.5.0
