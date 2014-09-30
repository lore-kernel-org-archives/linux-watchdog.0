Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:53742 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752017AbaI3MoO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 30 Sep 2014 08:44:14 -0400
From: Janusz Uzycki <j.uzycki@elproma.com.pl>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH 1/6] watchdog: watchdog_dev: WATCHDOG_KEEP_ON feature
Date: Tue, 30 Sep 2014 14:46:30 +0200
Message-Id: <1412081190-30699-2-git-send-email-j.uzycki@elproma.com.pl>
In-Reply-To: <1412081190-30699-1-git-send-email-j.uzycki@elproma.com.pl>
References: <542A3392.8020903@roeck-us.net>
 <1412081190-30699-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Some applications require to start watchdog before userspace software.
This patch enables such feature. Only the flag is necessary
to enable it.
Moreover kernel's ping is re-enabled when userspace software closed
watchdog using the magic character. The features improves kernel's
reliability if hardware watchdog is available.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/watchdog/watchdog_dev.c | 65 ++++++++++++++++++++++++++-
 include/linux/watchdog.h        |  4 ++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 6aaefba..afc14f7 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -41,6 +41,7 @@
 #include <linux/miscdevice.h>	/* For handling misc devices */
 #include <linux/init.h>		/* For __init/__exit/... */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
+#include <linux/jiffies.h>	/* for ping timer */
 
 #include "watchdog_core.h"
 
@@ -277,6 +278,60 @@ out_ioctl:
 	return err;
 }
 
+static void watchdog_ping_timer_cb(unsigned long data)
+{
+	struct watchdog_device *wdd = (struct watchdog_device *)data;
+	watchdog_ping(wdd);
+	/* call next ping half the timeout value */
+	mod_timer(&wdd->ping_timer,
+			jiffies + msecs_to_jiffies(wdd->timeout * 500));
+}
+
+static void watchdog_timer_start(struct watchdog_device *wdd)
+{
+	/* TODO: watchdog_start():
+	 * it should probably be handled by the caller, to let us separate
+	 * cases where the watchdog is already running (for example on close). */
+	watchdog_start(wdd);
+	watchdog_ping_timer_cb((unsigned long)wdd);
+}
+
+static void watchdog_timer_stop(struct watchdog_device *wdd)
+{
+	del_timer_sync(&wdd->ping_timer);
+}
+
+static int watchdog_timer_restart(struct watchdog_device *wdd)
+{
+	if (test_bit(WDOG_KEEP_ON, &wdd->status)) {
+		watchdog_timer_start(wdd);
+		return 0;
+	}
+	return watchdog_stop(wdd);
+}
+
+static int watchdog_timer_register(struct watchdog_device *wdd)
+{
+	if (test_bit(WDOG_KEEP_ON, &wdd->status)) {
+		if (!try_module_get(wdd->ops->owner))
+			return -ENODEV;
+		setup_timer(&wdd->ping_timer, watchdog_ping_timer_cb,
+				(unsigned long)wdd);
+		watchdog_timer_start(wdd);
+	}
+	return 0;
+}
+
+static int watchdog_timer_unregister(struct watchdog_device *wdd)
+{
+	if (test_bit(WDOG_KEEP_ON, &wdd->status)) {
+		watchdog_timer_stop(wdd);
+		watchdog_stop(wdd);
+		module_put(wdd->ops->owner);
+	}
+	return 0;
+}
+
 /*
  *	watchdog_write: writes to the watchdog.
  *	@file: file from VFS
@@ -430,6 +485,9 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	if (!try_module_get(wdd->ops->owner))
 		goto out;
 
+	if (test_bit(WDOG_KEEP_ON, &wdd->status))
+		watchdog_timer_stop(wdd);
+
 	err = watchdog_start(wdd);
 	if (err < 0)
 		goto out_mod;
@@ -473,7 +531,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
 		err = 0;
 	else if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
 		 !(wdd->info->options & WDIOF_MAGICCLOSE))
-		err = watchdog_stop(wdd);
+		err = watchdog_timer_restart(wdd);
 
 	/* If the watchdog was not stopped, send a keepalive ping */
 	if (err < 0) {
@@ -553,7 +611,10 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
 			misc_deregister(&watchdog_miscdev);
 			old_wdd = NULL;
 		}
+		return err;
 	}
+
+	err = watchdog_timer_register(watchdog);
 	return err;
 }
 
@@ -575,6 +636,8 @@ int watchdog_dev_unregister(struct watchdog_device *watchdog)
 		misc_deregister(&watchdog_miscdev);
 		old_wdd = NULL;
 	}
+
+	watchdog_timer_unregister(watchdog);
 	return 0;
 }
 
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 2a3038e..0afeabd 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -12,6 +12,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/timer.h>		/* for ping timer */
 #include <uapi/linux/watchdog.h>
 
 struct watchdog_ops;
@@ -95,6 +96,8 @@ struct watchdog_device {
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
 #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
+#define WDOG_KEEP_ON		5	/* Is 'keep on' feature set? */
+	struct timer_list ping_timer;	/* timer to keep on hardware ping */
 };
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
@@ -104,6 +107,7 @@ struct watchdog_device {
 #define WATCHDOG_NOWAYOUT		0
 #define WATCHDOG_NOWAYOUT_INIT_STATUS	0
 #endif
+#define WATCHDOG_KEEP_ON		(1 << WDOG_KEEP_ON)
 
 /* Use the following function to check whether or not the watchdog is active */
 static inline bool watchdog_active(struct watchdog_device *wdd)
-- 
1.7.11.3

