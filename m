Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45858 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbbHDCNv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Aug 2015 22:13:51 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/8] watchdog: Introduce WDOG_RUNNING flag
Date: Mon,  3 Aug 2015 19:13:29 -0700
Message-Id: <1438654414-29259-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The WDOG_RUNNING flag is expected to be set by watchdog drivers if
the hardware watchdog is running. If the flag is set, the watchdog
subsystem will ping the watchdog even if the watchdog device is closed.

The watchdog driver stop function is now optional and may be omitted
if the watchdog can not be stopped. If stopping the watchdog is not
possible but the driver implements a stop function, it is responsible
to set the WDOG_RUNNING flag in its stop function.

Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/watchdog/watchdog-kernel-api.txt | 19 ++++++++-----
 drivers/watchdog/watchdog_core.c               |  2 +-
 drivers/watchdog/watchdog_dev.c                | 39 ++++++++++++++++++++------
 include/linux/watchdog.h                       |  7 +++++
 4 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 5fa085276874..7fda3c86cf46 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -144,17 +144,18 @@ are:
   device.
   The routine needs a pointer to the watchdog timer device structure as a
   parameter. It returns zero on success or a negative errno code for failure.
-* stop: with this routine the watchdog timer device is being stopped.
-  The routine needs a pointer to the watchdog timer device structure as a
-  parameter. It returns zero on success or a negative errno code for failure.
-  Some watchdog timer hardware can only be started and not be stopped. The
-  driver supporting this hardware needs to make sure that a start and stop
-  routine is being provided. This can be done by using a timer in the driver
-  that regularly sends a keepalive ping to the watchdog timer hardware.
 
 Not all watchdog timer hardware supports the same functionality. That's why
 all other routines/operations are optional. They only need to be provided if
 they are supported. These optional routines/operations are:
+* stop: with this routine the watchdog timer device is being stopped.
+  The routine needs a pointer to the watchdog timer device structure as a
+  parameter. It returns zero on success or a negative errno code for failure.
+  Some watchdog timer hardware can only be started and not be stopped. A
+  driver supporting such hardware does not have to implement the stop routine.
+  If a driver has no stop function, the watchdog core will set WDOG_RUNNING and
+  start calling the driver's keepalive pings function after the watchdog device
+  is closed.
 * ping: this is the routine that sends a keepalive ping to the watchdog timer
   hardware.
   The routine needs a pointer to the watchdog timer device structure as a
@@ -206,6 +207,10 @@ bit-operations. The status bits that are defined are:
   any watchdog_ops, so that you can be sure that no operations (other then
   unref) will get called after unregister, even if userspace still holds a
   reference to /dev/watchdog
+* WDOG_RUNNING: Set by the watchdog driver if the hardware watchdog is running.
+  The bit must be set if the watchdog timer hardware can not be stopped;
+  otherwise it is optional. If set, the watchdog driver core will send
+  keepalive pings to the watchdog hardware while the watchdog device is closed.
 
   To set the WDOG_NO_WAY_OUT status bit (before registering your watchdog
   timer device) you can either:
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 1a8059455413..b38d1b7ae10e 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -145,7 +145,7 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 		return -EINVAL;
 
 	/* Mandatory operations need to be supported */
-	if (wdd->ops->start == NULL || wdd->ops->stop == NULL)
+	if (!wdd->ops->start)
 		return -EINVAL;
 
 	watchdog_check_min_max_timeout(wdd);
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 25849c1d6dc1..e0fbc4ac9bb7 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -58,8 +58,9 @@ static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 	unsigned int hm = wdd->max_hw_timeout_ms;
 	unsigned int m = wdd->max_timeout * 1000;
 
-	return watchdog_active(wdd) && hm && hm != m &&
-		wdd->timeout * 500 > hm;
+	return (watchdog_active(wdd) && hm && hm != m &&
+		wdd->timeout * 500 > hm) ||
+	       (!watchdog_active(wdd) && watchdog_running(wdd));
 }
 
 static inline void watchdog_update_worker(struct watchdog_device *wdd,
@@ -87,7 +88,7 @@ static int _watchdog_ping(struct watchdog_device *wdd)
 	if (test_bit(WDOG_UNREGISTERED, &wdd->status))
 		return -ENODEV;
 
-	if (!watchdog_active(wdd))
+	if (!watchdog_active(wdd) && !watchdog_running(wdd))
 		return 0;
 
 	if (wdd->ops->ping)
@@ -204,7 +205,11 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		goto out_stop;
 	}
 
-	err = wdd->ops->stop(wdd);
+	if (wdd->ops->stop)
+		err = wdd->ops->stop(wdd);
+	else
+		set_bit(WDOG_RUNNING, &wdd->status);
+
 	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
 		watchdog_update_worker(wdd, true, false);
@@ -489,7 +494,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	 * If the /dev/watchdog device is open, we don't want the module
 	 * to be unloaded.
 	 */
-	if (!try_module_get(wdd->ops->owner))
+	if (!watchdog_running(wdd) && !try_module_get(wdd->ops->owner))
 		goto out;
 
 	err = watchdog_start(wdd);
@@ -546,10 +551,15 @@ static int watchdog_release(struct inode *inode, struct file *file)
 		watchdog_ping(wdd);
 	}
 
-	cancel_delayed_work_sync(&wdd->work);
+	watchdog_update_worker(wdd, true, true);
 
-	/* Allow the owner module to be unloaded again */
-	module_put(wdd->ops->owner);
+	/*
+	 * Allow the owner module to be unloaded again unless the watchdog
+	 * is still running. If the watchdog is still running, it can not
+	 * be stopped, and its driver must not be unloaded.
+	 */
+	if (!watchdog_running(wdd))
+		module_put(wdd->ops->owner);
 
 	/* make sure that /dev/watchdog can be re-opened */
 	clear_bit(WDOG_DEV_OPEN, &wdd->status);
@@ -625,8 +635,19 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 			misc_deregister(&watchdog_miscdev);
 			old_wdd = NULL;
 		}
+		return err;
 	}
-	return err;
+
+	/*
+	 * If the watchdog is running, prevent its driver from being unloaded,
+	 * and schedule an immediate ping.
+	 */
+	if (watchdog_running(wdd)) {
+		__module_get(wdd->ops->owner);
+		queue_delayed_work(watchdog_wq, &wdd->work, 0);
+	}
+
+	return 0;
 }
 
 /*
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 2703b2511481..b29f0181130b 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -107,6 +107,7 @@ struct watchdog_device {
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
 #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
+#define WDOG_RUNNING		5	/* True if HW watchdog running */
 	struct delayed_work work;
 	struct list_head deferred;
 };
@@ -120,6 +121,12 @@ static inline bool watchdog_active(struct watchdog_device *wdd)
 	return test_bit(WDOG_ACTIVE, &wdd->status);
 }
 
+/* Use the following function to check whether or not the watchdog is running */
+static inline bool watchdog_running(struct watchdog_device *wdd)
+{
+	return test_bit(WDOG_RUNNING, &wdd->status);
+}
+
 /* Use the following function to set the nowayout feature */
 static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
 {
-- 
2.1.4

