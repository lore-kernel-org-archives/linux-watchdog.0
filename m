Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 2/7] watchdog: bcm47xx_wdt: use core reboot notifier
Date: Wed, 18 Nov 2015 16:02:17 -0500
Message-Id: <1447880542-19320-3-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Get rid of the custom reboot notifier block registration and use the one
provided by the watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>
---
 drivers/watchdog/bcm47xx_wdt.c | 24 ++----------------------
 include/linux/bcm47xx_wdt.h    |  2 --
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index 01bffe1..df1c2a4 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -20,7 +20,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/timer.h>
@@ -168,17 +167,6 @@ static const struct watchdog_info bcm47xx_wdt_info = {
 				WDIOF_MAGICCLOSE,
 };
 
-static int bcm47xx_wdt_notify_sys(struct notifier_block *this,
-				  unsigned long code, void *unused)
-{
-	struct bcm47xx_wdt *wdt;
-
-	wdt = container_of(this, struct bcm47xx_wdt, notifier);
-	if (code == SYS_DOWN || code == SYS_HALT)
-		wdt->wdd.ops->stop(&wdt->wdd);
-	return NOTIFY_DONE;
-}
-
 static struct watchdog_ops bcm47xx_wdt_soft_ops = {
 	.owner		= THIS_MODULE,
 	.start		= bcm47xx_wdt_soft_start,
@@ -215,24 +203,17 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
 		goto err_timer;
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
 	watchdog_set_restart_priority(&wdt->wdd, 64);
-
-	wdt->notifier.notifier_call = &bcm47xx_wdt_notify_sys;
-
-	ret = register_reboot_notifier(&wdt->notifier);
-	if (ret)
-		goto err_timer;
+	watchdog_stop_on_reboot(&wdt->wdd);
 
 	ret = watchdog_register_device(&wdt->wdd);
 	if (ret)
-		goto err_notifier;
+		goto err_timer;
 
 	dev_info(&pdev->dev, "BCM47xx Watchdog Timer enabled (%d seconds%s%s)\n",
 		timeout, nowayout ? ", nowayout" : "",
 		soft ? ", Software Timer" : "");
 	return 0;
 
-err_notifier:
-	unregister_reboot_notifier(&wdt->notifier);
 err_timer:
 	if (soft)
 		del_timer_sync(&wdt->soft_timer);
@@ -248,7 +229,6 @@ static int bcm47xx_wdt_remove(struct platform_device *pdev)
 		return -ENXIO;
 
 	watchdog_unregister_device(&wdt->wdd);
-	unregister_reboot_notifier(&wdt->notifier);
 
 	return 0;
 }
diff --git a/include/linux/bcm47xx_wdt.h b/include/linux/bcm47xx_wdt.h
index b708786..8d9d07e 100644
--- a/include/linux/bcm47xx_wdt.h
+++ b/include/linux/bcm47xx_wdt.h
@@ -1,7 +1,6 @@
 #ifndef LINUX_BCM47XX_WDT_H_
 #define LINUX_BCM47XX_WDT_H_
 
-#include <linux/notifier.h>
 #include <linux/timer.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
@@ -15,7 +14,6 @@ struct bcm47xx_wdt {
 	void *driver_data;
 
 	struct watchdog_device wdd;
-	struct notifier_block notifier;
 
 	struct timer_list soft_timer;
 	atomic_t soft_ticks;
-- 
2.5.0
