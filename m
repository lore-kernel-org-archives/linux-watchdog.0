Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33469 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752912AbdDKQGm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 11 Apr 2017 12:06:42 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, cphealy@gmail.com,
        linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] watchdog: core: Make use of devm_register_reboot_notifier()
Date: Tue, 11 Apr 2017 09:06:15 -0700
Message-Id: <20170411160615.9784-1-andrew.smirnov@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Save a bit of cleanup code by leveraging newly added
devm_register_reboot_notifier().

Cc: cphealy@gmail.com
Cc: linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Guenter, Andy:

Here's the second version of the patch originally submitted in
[v1]. This time I tried to follow Guenter's suggestion of moving this
bit on initialization in watchdog_dev_register().

If I missed something obvious why this patch wouldn't work, again,
please let me know.

Patch introducting devm_register_reboot_notifier() can be found in
[other-patch]

Thanks,
Andrey Smirnov

[v1] https://lkml.org/lkml/2017/4/4/388
[other-patch] https://lkml.org/lkml/2017/3/20/671


 drivers/watchdog/watchdog_core.c | 35 -----------------------------------
 drivers/watchdog/watchdog_dev.c  | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 74265b2..8a8d952 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -137,25 +137,6 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 }
 EXPORT_SYMBOL_GPL(watchdog_init_timeout);
 
-static int watchdog_reboot_notifier(struct notifier_block *nb,
-				    unsigned long code, void *data)
-{
-	struct watchdog_device *wdd = container_of(nb, struct watchdog_device,
-						   reboot_nb);
-
-	if (code == SYS_DOWN || code == SYS_HALT) {
-		if (watchdog_active(wdd)) {
-			int ret;
-
-			ret = wdd->ops->stop(wdd);
-			if (ret)
-				return NOTIFY_BAD;
-		}
-	}
-
-	return NOTIFY_DONE;
-}
-
 static int watchdog_restart_notifier(struct notifier_block *nb,
 				     unsigned long action, void *data)
 {
@@ -244,19 +225,6 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 		}
 	}
 
-	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status)) {
-		wdd->reboot_nb.notifier_call = watchdog_reboot_notifier;
-
-		ret = register_reboot_notifier(&wdd->reboot_nb);
-		if (ret) {
-			pr_err("watchdog%d: Cannot register reboot notifier (%d)\n",
-			       wdd->id, ret);
-			watchdog_dev_unregister(wdd);
-			ida_simple_remove(&watchdog_ida, wdd->id);
-			return ret;
-		}
-	}
-
 	if (wdd->ops->restart) {
 		wdd->restart_nb.notifier_call = watchdog_restart_notifier;
 
@@ -302,9 +270,6 @@ static void __watchdog_unregister_device(struct watchdog_device *wdd)
 	if (wdd->ops->restart)
 		unregister_restart_handler(&wdd->restart_nb);
 
-	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status))
-		unregister_reboot_notifier(&wdd->reboot_nb);
-
 	watchdog_dev_unregister(wdd);
 	ida_simple_remove(&watchdog_ida, wdd->id);
 }
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 32930a0..9a52990 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -42,6 +42,7 @@
 #include <linux/miscdevice.h>	/* For handling misc devices */
 #include <linux/module.h>	/* For module stuff/... */
 #include <linux/mutex.h>	/* For mutexes */
+#include <linux/reboot.h>	/* For reboot notifier */
 #include <linux/slab.h>		/* For memory functions */
 #include <linux/types.h>	/* For standard types (like size_t) */
 #include <linux/watchdog.h>	/* For watchdog specific items */
@@ -998,6 +999,25 @@ static struct class watchdog_class = {
 	.dev_groups =	wdt_groups,
 };
 
+static int watchdog_reboot_notifier(struct notifier_block *nb,
+				    unsigned long code, void *data)
+{
+	struct watchdog_device *wdd = container_of(nb, struct watchdog_device,
+						   reboot_nb);
+
+	if (code == SYS_DOWN || code == SYS_HALT) {
+		if (watchdog_active(wdd)) {
+			int ret;
+
+			ret = wdd->ops->stop(wdd);
+			if (ret)
+				return NOTIFY_BAD;
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
 /*
  *	watchdog_dev_register: register a watchdog device
  *	@wdd: watchdog device
@@ -1031,6 +1051,18 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 	if (ret) {
 		device_destroy(&watchdog_class, devno);
 		watchdog_cdev_unregister(wdd);
+		return ret;
+	}
+
+	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status)) {
+		wdd->reboot_nb.notifier_call = watchdog_reboot_notifier;
+
+		ret = devm_register_reboot_notifier(dev, &wdd->reboot_nb);
+		if (ret) {
+			pr_err("watchdog%d: Cannot register reboot notifier (%d)\n",
+			       wdd->id, ret);
+			watchdog_dev_unregister(wdd);
+		}
 	}
 
 	return ret;
-- 
2.9.3

