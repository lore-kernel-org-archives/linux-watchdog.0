Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 6/7] watchdog: softdog: use core reboot notifier
Date: Wed, 18 Nov 2015 16:02:21 -0500
Message-Id: <1447880542-19320-7-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Get rid of the custom reboot notifier block registration and use the one
provided by the watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>
---
 drivers/watchdog/softdog.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index 0dc5e323d..fe1e151 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -43,7 +43,6 @@
 #include <linux/types.h>
 #include <linux/timer.h>
 #include <linux/watchdog.h>
-#include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
@@ -122,26 +121,9 @@ static int softdog_set_timeout(struct watchdog_device *w, unsigned int t)
 }
 
 /*
- *	Notifier for system down
- */
-
-static int softdog_notify_sys(struct notifier_block *this, unsigned long code,
-	void *unused)
-{
-	if (code == SYS_DOWN || code == SYS_HALT)
-		/* Turn the WDT off */
-		softdog_stop(NULL);
-	return NOTIFY_DONE;
-}
-
-/*
  *	Kernel Interfaces
  */
 
-static struct notifier_block softdog_notifier = {
-	.notifier_call	= softdog_notify_sys,
-};
-
 static struct watchdog_info softdog_info = {
 	.identity = "Software Watchdog",
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
@@ -175,18 +157,11 @@ static int __init watchdog_init(void)
 	softdog_dev.timeout = soft_margin;
 
 	watchdog_set_nowayout(&softdog_dev, nowayout);
-
-	ret = register_reboot_notifier(&softdog_notifier);
-	if (ret) {
-		pr_err("cannot register reboot notifier (err=%d)\n", ret);
-		return ret;
-	}
+	watchdog_stop_on_reboot(&softdog_dev);
 
 	ret = watchdog_register_device(&softdog_dev);
-	if (ret) {
-		unregister_reboot_notifier(&softdog_notifier);
+	if (ret)
 		return ret;
-	}
 
 	pr_info("Software Watchdog Timer: 0.08 initialized. soft_noboot=%d soft_margin=%d sec soft_panic=%d (nowayout=%d)\n",
 		soft_noboot, soft_margin, soft_panic, nowayout);
@@ -197,7 +172,6 @@ static int __init watchdog_init(void)
 static void __exit watchdog_exit(void)
 {
 	watchdog_unregister_device(&softdog_dev);
-	unregister_reboot_notifier(&softdog_notifier);
 }
 
 module_init(watchdog_init);
-- 
2.5.0
