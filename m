Return-Path: <linux@roeck-us.net>
Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/5] watchdog: it87: Use infrastructure to stop watchdog on reboot
Date: Sat, 10 Jun 2017 21:04:35 -0700
Message-Id: <1497153876-22921-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1497153876-22921-1-git-send-email-linux@roeck-us.net>
References: <1497153876-22921-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use watchdog_stop_on_reboot() to stop the watchdog on reboot instead
of registering a driver-specific notifier.

While at it, reorder remaining include files alphabetically.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/it87_wdt.c | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index 29aea28628c8..07f4727eb7f4 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -28,15 +28,13 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/watchdog.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
-#include <linux/io.h>
 
 #define WATCHDOG_NAME		"IT87 WDT"
 
@@ -260,18 +258,6 @@ static struct watchdog_device wdt_dev = {
 	.min_timeout = 1,
 };
 
-static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
-			  void *unused)
-{
-	if (code == SYS_DOWN || code == SYS_HALT)
-		wdt_stop(&wdt_dev);
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block wdt_notifier = {
-	.notifier_call = wdt_notify_sys,
-};
-
 static int __init it87_wdt_init(void)
 {
 	u8  chip_rev;
@@ -338,32 +324,22 @@ static int __init it87_wdt_init(void)
 	wdt_dev.timeout = timeout;
 	wdt_dev.max_timeout = max_units * 60;
 
-	rc = register_reboot_notifier(&wdt_notifier);
-	if (rc) {
-		pr_err("Cannot register reboot notifier (err=%d)\n", rc);
-		return rc;
-	}
-
+	watchdog_stop_on_reboot(&wdt_dev);
 	rc = watchdog_register_device(&wdt_dev);
 	if (rc) {
 		pr_err("Cannot register watchdog device (err=%d)\n", rc);
-		goto err_out_reboot;
+		return rc;
 	}
 
 	pr_info("Chip IT%04x revision %d initialized. timeout=%d sec (nowayout=%d testmode=%d)\n",
 		chip_type, chip_rev, timeout, nowayout, testmode);
 
 	return 0;
-
-err_out_reboot:
-	unregister_reboot_notifier(&wdt_notifier);
-	return rc;
 }
 
 static void __exit it87_wdt_exit(void)
 {
 	watchdog_unregister_device(&wdt_dev);
-	unregister_reboot_notifier(&wdt_notifier);
 }
 
 module_init(it87_wdt_init);
-- 
2.7.4
