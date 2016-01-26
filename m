Return-path: <linux@roeck-us.net>
From: Guenter Roeck <patchwork@patchwork.roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v7 2/9] watchdog: Introduce WDOG_HW_RUNNING flag
Date: Mon, 25 Jan 2016 18:53:09 -0800
Message-Id: <1453776796-3885-3-git-send-email-patchwork@patchwork.roeck-us.net>
In-Reply-To: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
References: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

From: Guenter Roeck <linux@roeck-us.net>

The WDOG_HW_RUNNING flag is expected to be set by watchdog drivers if
the hardware watchdog is running. If the flag is set, the watchdog
subsystem will ping the watchdog even if the watchdog device is closed.

The watchdog driver stop function is now optional and may be omitted
if the watchdog can not be stopped. If stopping the watchdog is not
possible but the driver implements a stop function, it is responsible
to set the WDOG_HW_RUNNING flag in its stop function.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v7: Fix typos in documentation (hw_max_timeout_ms -> max_hw_timeout_ms).
    Enforce that max_hw_timeout_ms must be set if the stop function is
    not implemented by a driver.
    Rebased to v4.5-rc1
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
 Documentation/watchdog/watchdog-kernel-api.txt | 34 ++++++++++-----
 drivers/watchdog/watchdog_core.c               |  2 +-
 drivers/watchdog/watchdog_dev.c                | 58 +++++++++++++++++++-------
 include/linux/watchdog.h                       | 10 +++++
 4 files changed, 78 insertions(+), 26 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 46979568b9e5..738bd6809328 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -85,7 +85,8 @@ It contains following fields:
   If set, the infrastructure will send heartbeats to the watchdog driver
   if 'timeout' is larger than max_hw_timeout_ms, unless WDOG_ACTIVE
   is set and userspace failed to send a heartbeat for at least 'timeout'
-  seconds.
+  seconds. max_hw_timeout_ms must be set if a driver does not implement
+  the stop function.
 * reboot_nb: notifier block that is registered for reboot notifications, for
   internal use only. If the driver calls watchdog_stop_on_reboot, watchdog core
   will stop the watchdog on such notifications.
@@ -134,17 +135,20 @@ are:
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
+  If a watchdog driver does not implement the stop function, it must set
+  max_hw_timeout_ms.
 * ping: this is the routine that sends a keepalive ping to the watchdog timer
   hardware.
   The routine needs a pointer to the watchdog timer device structure as a
@@ -184,11 +188,19 @@ The 'ref' and 'unref' operations are no longer used and deprecated.
 The status bits should (preferably) be set with the set_bit and clear_bit alike
 bit-operations. The status bits that are defined are:
 * WDOG_ACTIVE: this status bit indicates whether or not a watchdog timer device
-  is active or not. When the watchdog is active after booting, then you should
-  set this status bit (Note: when you register the watchdog timer device with
-  this bit set, then opening /dev/watchdog will skip the start operation)
+  is active or not from user perspective. User space is expected to send
+  heartbeat requests to the driver while this flag is set.
 * WDOG_NO_WAY_OUT: this bit stores the nowayout setting for the watchdog.
   If this bit is set then the watchdog timer will not be able to stop.
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
index e600fd93b7de..07c9931e2123 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -199,7 +199,7 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 		return -EINVAL;
 
 	/* Mandatory operations need to be supported */
-	if (wdd->ops->start == NULL || wdd->ops->stop == NULL)
+	if (!wdd->ops->start || (!wdd->ops->stop && !wdd->max_hw_timeout_ms))
 		return -EINVAL;
 
 	watchdog_check_min_max_timeout(wdd);
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 20e4ce0ebf6c..469b13b8363b 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -92,7 +92,8 @@ static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 	 *   requests.
 	 * - Userspace requests a longer timeout than the hardware can handle.
 	 */
-	return watchdog_active(wdd) && hm && t > hm;
+	return hm && ((watchdog_active(wdd) && t > hm) ||
+		      (t && !watchdog_active(wdd) && watchdog_hw_running(wdd)));
 }
 
 static long watchdog_next_keepalive(struct watchdog_device *wdd)
@@ -108,6 +109,9 @@ static long watchdog_next_keepalive(struct watchdog_device *wdd)
 	hw_timeout_ms = min(timeout_ms, wdd->max_hw_timeout_ms);
 	keepalive_interval = msecs_to_jiffies(hw_timeout_ms / 2);
 
+	if (!watchdog_active(wdd))
+		return keepalive_interval;
+
 	/*
 	 * To ensure that the watchdog times out wdd->timeout seconds
 	 * after the most recent ping from userspace, the last
@@ -162,7 +166,7 @@ static int watchdog_ping(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data = wdd->wd_data;
 
-	if (!watchdog_active(wdd))
+	if (!watchdog_active(wdd) && !watchdog_hw_running(wdd))
 		return 0;
 
 	wd_data->last_keepalive = jiffies;
@@ -179,7 +183,7 @@ static void watchdog_ping_work(struct work_struct *work)
 
 	mutex_lock(&wd_data->lock);
 	wdd = wd_data->wdd;
-	if (wdd && watchdog_active(wdd))
+	if (wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd)))
 		__watchdog_ping(wdd);
 	mutex_unlock(&wd_data->lock);
 }
@@ -205,7 +209,10 @@ static int watchdog_start(struct watchdog_device *wdd)
 		return 0;
 
 	started_at = jiffies;
-	err = wdd->ops->start(wdd);
+	if (watchdog_hw_running(wdd) && wdd->ops->ping)
+		err = wdd->ops->ping(wdd);
+	else
+		err = wdd->ops->start(wdd);
 	if (err == 0) {
 		set_bit(WDOG_ACTIVE, &wdd->status);
 		wd_data->last_keepalive = started_at;
@@ -229,8 +236,7 @@ static int watchdog_start(struct watchdog_device *wdd)
 
 static int watchdog_stop(struct watchdog_device *wdd)
 {
-	struct watchdog_core_data *wd_data = wdd->wd_data;
-	int err;
+	int err = 0;
 
 	if (!watchdog_active(wdd))
 		return 0;
@@ -241,10 +247,14 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		return -EBUSY;
 	}
 
-	err = wdd->ops->stop(wdd);
+	if (wdd->ops->stop)
+		err = wdd->ops->stop(wdd);
+	else
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+
 	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
-		cancel_delayed_work(&wd_data->work);
+		watchdog_update_worker(wdd, true);
 	}
 
 	return err;
@@ -639,7 +649,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	 * If the /dev/watchdog device is open, we don't want the module
 	 * to be unloaded.
 	 */
-	if (!try_module_get(wdd->ops->owner)) {
+	if (!watchdog_hw_running(wdd) && !try_module_get(wdd->ops->owner)) {
 		err = -EBUSY;
 		goto out_clear;
 	}
@@ -650,7 +660,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 
 	file->private_data = wd_data;
 
-	kref_get(&wd_data->kref);
+	if (!watchdog_hw_running(wdd))
+		kref_get(&wd_data->kref);
 
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
 	return nonseekable_open(inode, file);
@@ -711,15 +722,22 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	}
 
 	cancel_delayed_work_sync(&wd_data->work);
+	watchdog_update_worker(wdd, false);
 
 	/* make sure that /dev/watchdog can be re-opened */
 	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
 
 done:
 	mutex_unlock(&wd_data->lock);
-	/* Allow the owner module to be unloaded again */
-	module_put(wd_data->cdev.owner);
-	kref_put(&wd_data->kref, watchdog_core_data_release);
+	/*
+	 * Allow the owner module to be unloaded again unless the watchdog
+	 * is still running. If the watchdog is still running, it can not
+	 * be stopped, and its driver must not be unloaded.
+	 */
+	if (!watchdog_hw_running(wdd)) {
+		module_put(wdd->ops->owner);
+		kref_put(&wd_data->kref, watchdog_core_data_release);
+	}
 	return 0;
 }
 
@@ -796,8 +814,20 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 			old_wd_data = NULL;
 			kref_put(&wd_data->kref, watchdog_core_data_release);
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
+		kref_get(&wd_data->kref);
+		queue_delayed_work(watchdog_wq, &wd_data->work, 0);
+	}
+
+	return 0;
 }
 
 /*
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index cd5e6f84bf2f..19c675eed80f 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -105,6 +105,7 @@ struct watchdog_device {
 #define WDOG_ACTIVE		0	/* Is the watchdog running/active */
 #define WDOG_NO_WAY_OUT		1	/* Is 'nowayout' feature set ? */
 #define WDOG_STOP_ON_REBOOT	2	/* Should be stopped on reboot */
+#define WDOG_HW_RUNNING		3	/* True if HW watchdog running */
 	struct list_head deferred;
 };
 
@@ -117,6 +118,15 @@ static inline bool watchdog_active(struct watchdog_device *wdd)
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
