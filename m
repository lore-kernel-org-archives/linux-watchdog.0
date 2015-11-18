Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 7/7] watchdog: w83627hf_wdt: use core reboot notifier
Date: Wed, 18 Nov 2015 16:02:22 -0500
Message-Id: <1447880542-19320-8-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Get rid of the custom reboot notifier block registration and use the one
provided by the watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>
---
 drivers/watchdog/w83627hf_wdt.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 5824e25..cab14bc 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -36,8 +36,6 @@
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/ioport.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/io.h>
 
@@ -288,18 +286,6 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
 }
 
 /*
- *	Notifier for system down
- */
-static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
-	void *unused)
-{
-	if (code == SYS_DOWN || code == SYS_HALT)
-		wdt_set_time(0);	/* Turn the WDT off */
-
-	return NOTIFY_DONE;
-}
-
-/*
  *	Kernel Interfaces
  */
 
@@ -329,10 +315,6 @@ static struct watchdog_device wdt_dev = {
  *	turn the timebomb registers off.
  */
 
-static struct notifier_block wdt_notifier = {
-	.notifier_call = wdt_notify_sys,
-};
-
 static int wdt_find(int addr)
 {
 	u8 val;
@@ -456,6 +438,7 @@ static int __init wdt_init(void)
 
 	watchdog_init_timeout(&wdt_dev, timeout, NULL);
 	watchdog_set_nowayout(&wdt_dev, nowayout);
+	watchdog_stop_on_reboot(&wdt_dev);
 
 	ret = w83627hf_init(&wdt_dev, chip);
 	if (ret) {
@@ -463,30 +446,19 @@ static int __init wdt_init(void)
 		return ret;
 	}
 
-	ret = register_reboot_notifier(&wdt_notifier);
-	if (ret != 0) {
-		pr_err("cannot register reboot notifier (err=%d)\n", ret);
-		return ret;
-	}
-
 	ret = watchdog_register_device(&wdt_dev);
 	if (ret)
-		goto unreg_reboot;
+		return ret;
 
 	pr_info("initialized. timeout=%d sec (nowayout=%d)\n",
 		wdt_dev.timeout, nowayout);
 
 	return ret;
-
-unreg_reboot:
-	unregister_reboot_notifier(&wdt_notifier);
-	return ret;
 }
 
 static void __exit wdt_exit(void)
 {
 	watchdog_unregister_device(&wdt_dev);
-	unregister_reboot_notifier(&wdt_notifier);
 }
 
 module_init(wdt_init);
-- 
2.5.0
