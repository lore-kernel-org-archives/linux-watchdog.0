Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 2/9] watchdog: Introduce WDOG_HW_RUNNING flag
Date: Sun, 29 Nov 2015 11:28:44 -0800
Message-Id: <1448825331-28840-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1448825331-28840-1-git-send-email-linux@roeck-us.net>
References: <1448825331-28840-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The WDOG_HW_RUNNING flag is expected to be set by watchdog drivers if
the hardware watchdog is running. If the flag is set, the watchdog
subsystem will ping the watchdog even if the watchdog device is closed.

The watchdog driver stop function is now optional and may be omitted
if the watchdog can not be stopped. If stopping the watchdog is not
possible but the driver implements a stop function, it is responsible
to set the WDOG_HW_RUNNING flag in its stop function.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v6: Fixed typo in documentation.
    Renamed WDOG_RUNNING to WDOG_HW_RUNNING and watchdog_running() to
    watchdog_hw_running().
    Rebased to v4.4-rc2.
v5: Rebased to v4.4-rc1.
v4: No change.
v3: Clarified meaning of WDOG_ACTIVE.
    Do not call cancel_delayed_work_sync() from watchdog_update_worker().
    Call it directly where needed instead, to keep the common code simple.
    Do not (re-)start an already running watchdog when opening the watchdog
    device. Send a heartbeat request instead.
v2: Improved documentation.
---
 Documentation/watchdog/watchdog-kernel-api.txt | 29 +++++++++------
 drivers/watchdog/watchdog_core.c               |  2 +-
 drivers/watchdog/watchdog_dev.c                | 49 +++++++++++++++++++-------
 include/linux/watchdog.h                       | 10 ++++++
 4 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index f66859117d1f..44787ddd59de 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -146,17 +146,18 @@ are:
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
+  If a driver has no stop function, the watchdog core will set WDOG_HW_RUNNING
+  and start calling the driver's keepalive pings function after the watchdog
+  device is closed.
 * ping: this is the routine that sends a keepalive ping to the watchdog timer
   hardware.
   The routine needs a pointer to the watchdog timer device structure as a
@@ -196,9 +197,8 @@ they are supported. These optional routines/operations are:
 The status bits should (preferably) be set with the set_bit and clear_bit alike
 bit-operations. The status bits that are defined are:
 * WDOG_ACTIVE: this status bit indicates whether or not a watchdog timer device
-  is active or not. When the watchdog is active after booting, then you should
-  set this status bit (Note: when you register the watchdog timer device with
-  this bit set, then opening /dev/watchdog will skip the start operation)
+  is active or not from user perspective. User space is expected to send
+  heartbeat requests to the driver while this flag is set.
 * WDOG_DEV_OPEN: this status bit shows whether or not the watchdog device
   was opened via /dev/watchdog.
   (This bit should only be used by the WatchDog Timer Driver Core).
@@ -212,6 +212,15 @@ bit-operations. The status bits that are defined are:
   any watchdog_ops, so that you can be sure that no operations (other then
   unref) will get called after unregister, even if userspace still holds a
   reference to /dev/watchdog
+* WDOG_HW_RUNNING: Set by the watchdog driver if the hardware watchdog is
+  running. The bit must be set if the watchdog timer hardware can not be
+  stopped. The bit may also be set if the watchdog timer is running after
+  booting, before the watchdog device is opened. If set, the watchdog
+  infrastructure will send keepalives to the watchdog hardware while
+  WDOG_ACTIVE is not set.
+  Note: when you register the watchdog timer device with this bit set,
+  then opening /dev/watchdog will skip the start operation but send a keepalive
+  request instead.
 
   To set the WDOG_NO_WAY_OUT status bit (before registering your watchdog
   timer device) you can either:
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 873f13972cf4..c2202ab62490 100644
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
index 1e150f56d561..2c99c3bb2fcf 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -68,7 +68,8 @@ static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 	 *   requests.
 	 * - Userspace requests a longer timeout than the hardware can handle.
 	 */
-	return watchdog_active(wdd) && hm && t > hm;
+	return hm && ((watchdog_active(wdd) && t > hm) ||
+		      (t && !watchdog_active(wdd) && watchdog_hw_running(wdd)));
 }
 
 static long watchdog_next_keepalive(struct watchdog_device *wdd)
@@ -83,6 +84,9 @@ static long watchdog_next_keepalive(struct watchdog_device *wdd)
 	hw_timeout_ms = min(timeout_ms, wdd->max_hw_timeout_ms);
 	keepalive_interval = msecs_to_jiffies(hw_timeout_ms / 2);
 
+	if (!watchdog_active(wdd))
+		return keepalive_interval;
+
 	/*
 	 * To ensure that the watchdog times out wdd->timeout seconds
 	 * after the most recent ping from userspace, the last
@@ -112,7 +116,7 @@ static int _watchdog_ping(struct watchdog_device *wdd)
 	if (test_bit(WDOG_UNREGISTERED, &wdd->status))
 		return -ENODEV;
 
-	if (!watchdog_active(wdd))
+	if (!watchdog_active(wdd) && !watchdog_hw_running(wdd))
 		return 0;
 
 	if (wdd->ops->ping)
@@ -179,11 +183,11 @@ static int watchdog_start(struct watchdog_device *wdd)
 		goto out_start;
 	}
 
-	if (watchdog_active(wdd))
-		goto out_start;
-
 	started_at = jiffies;
-	err = wdd->ops->start(wdd);
+	if (watchdog_hw_running(wdd) && wdd->ops->ping)
+		err = wdd->ops->ping(wdd);
+	else
+		err = wdd->ops->start(wdd);
 	if (err == 0) {
 		set_bit(WDOG_ACTIVE, &wdd->status);
 		wdd->last_keepalive = started_at;
@@ -225,10 +229,14 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		goto out_stop;
 	}
 
-	err = wdd->ops->stop(wdd);
+	if (wdd->ops->stop)
+		err = wdd->ops->stop(wdd);
+	else
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+
 	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
-		cancel_delayed_work(&wdd->work);
+		watchdog_update_worker(wdd, true);
 	}
 
 out_stop:
@@ -514,7 +522,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	 * If the /dev/watchdog device is open, we don't want the module
 	 * to be unloaded.
 	 */
-	if (!try_module_get(wdd->ops->owner))
+	if (!watchdog_hw_running(wdd) && !try_module_get(wdd->ops->owner))
 		goto out;
 
 	err = watchdog_start(wdd);
@@ -572,9 +580,15 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	}
 
 	cancel_delayed_work_sync(&wdd->work);
+	watchdog_update_worker(wdd, false);
 
-	/* Allow the owner module to be unloaded again */
-	module_put(wdd->ops->owner);
+	/*
+	 * Allow the owner module to be unloaded again unless the watchdog
+	 * is still running. If the watchdog is still running, it can not
+	 * be stopped, and its driver must not be unloaded.
+	 */
+	if (!watchdog_hw_running(wdd))
+		module_put(wdd->ops->owner);
 
 	/* make sure that /dev/watchdog can be re-opened */
 	clear_bit(WDOG_DEV_OPEN, &wdd->status);
@@ -647,8 +661,19 @@ int watchdog_dev_register(struct watchdog_device *wdd)
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
+	if (watchdog_hw_running(wdd)) {
+		__module_get(wdd->ops->owner);
+		queue_delayed_work(watchdog_wq, &wdd->work, 0);
+	}
+
+	return 0;
 }
 
 /*
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index b535b02b1d7f..98f79db93600 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -108,6 +108,7 @@ struct watchdog_device {
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
 #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
+#define WDOG_HW_RUNNING		5	/* True if HW watchdog running */
 	/* the following variables are for internal use only */
 	struct mutex lock;
 	unsigned long last_keepalive;
@@ -124,6 +125,15 @@ static inline bool watchdog_active(struct watchdog_device *wdd)
 	return test_bit(WDOG_ACTIVE, &wdd->status);
 }
 
+/*
+ * Use the following function to check whether or not the hardware watchdog
+ * is running
+ */
+static inline bool watchdog_hw_running(struct watchdog_device *wdd)
+{
+	return test_bit(WDOG_HW_RUNNING, &wdd->status);
+}
+
 /* Use the following function to set the nowayout feature */
 static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
 {
-- 
2.1.4
