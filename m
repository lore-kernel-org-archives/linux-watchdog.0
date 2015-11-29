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
Subject: [PATCH v6 1/9] watchdog: Introduce hardware maximum timeout in watchdog core
Date: Sun, 29 Nov 2015 11:28:43 -0800
Message-Id: <1448825331-28840-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1448825331-28840-1-git-send-email-linux@roeck-us.net>
References: <1448825331-28840-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Introduce an optional hardware maximum timeout in the watchdog core.
The hardware maximum timeout can be lower than the maximum timeout.

Drivers can set the maximum hardware timeout value in the watchdog data
structure. If the configured timeout exceeds the maximum hardware timeout,
the watchdog core enables a timer function to assist sending keepalive
requests to the watchdog driver.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v6:
- Set last_keepalive more accurately when starting the watchdog
- Rebased to v4.4-rc2
- Added Uwe's Acked-by:
v5:
- Rebased to v4.4-rc1
v4:
- Improved and fixed documentation
- Split hw_timeout_ms variable to timeout_ms, hw_timeout_ms for clarity
- Dropped redundant comments
- Added comments explaining failure conditions in watchdog_timeout_invalid().
- Moved the call to watchdog_update_worker() into _watchdog_ping().
v3:
- Reworked and cleaned up some of the functions.
- No longer call the worker update function if all that is needed is to stop
  the worker.
- max_timeout will now be ignored if max_hw_timeout_ms is provided.
v2:
- Improved and hopefully clarified documentation.
- Rearranged variables in struct watchdog_device such that internal variables
  come last.
- The code now ensures that the watchdog times out <timeout> seconds after
  the most recent keepalive sent from user space.
- The internal keepalive now stops silently and no longer generates a
  warning message. Reason is that it will now stop early, while there
  may still be a substantial amount of time for keepalives from user space
  to arrive. If such keepalives arrive late (for example if user space
  is configured to send keepalives just a few seconds before the watchdog
  times out), the message would just be noise and not provide any value.
---
 Documentation/watchdog/watchdog-kernel-api.txt |  28 ++++-
 drivers/watchdog/watchdog_dev.c                | 137 ++++++++++++++++++++++---
 include/linux/watchdog.h                       |  40 ++++++--
 3 files changed, 175 insertions(+), 30 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index d8b0d3367706..f66859117d1f 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -53,9 +53,12 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int max_hw_timeout_ms;
 	void *driver_data;
-	struct mutex lock;
 	unsigned long status;
+	struct mutex lock;
+	unsigned long last_keepalive;
+	struct delayed_work work;
 	struct list_head deferred;
 };
 
@@ -73,18 +76,31 @@ It contains following fields:
   additional information about the watchdog timer itself. (Like it's unique name)
 * ops: a pointer to the list of watchdog operations that the watchdog supports.
 * timeout: the watchdog timer's timeout value (in seconds).
+  This is the time after which the system will reboot if user space does
+  not send a heartbeat request if WDOG_ACTIVE is set.
 * min_timeout: the watchdog timer's minimum timeout value (in seconds).
-* max_timeout: the watchdog timer's maximum timeout value (in seconds).
+  If set, the minimum configurable value for 'timeout'.
+* max_timeout: the watchdog timer's maximum timeout value (in seconds),
+  as seen from userspace. If set, the maximum configurable value for
+  'timeout'. Not used if max_hw_timeout_ms is non-zero.
+* max_hw_timeout_ms: Maximum hardware timeout, in milli-seconds.
+  If set, the infrastructure will send heartbeats to the watchdog driver
+  if 'timeout' is larger than max_hw_timeout, unless WDOG_ACTIVE
+  is set and userspace failed to send a heartbeat for at least 'timeout'
+  seconds.
 * bootstatus: status of the device after booting (reported with watchdog
   WDIOF_* status bits).
 * driver_data: a pointer to the drivers private data of a watchdog device.
   This data should only be accessed via the watchdog_set_drvdata and
   watchdog_get_drvdata routines.
-* lock: Mutex for WatchDog Timer Driver Core internal use only.
 * status: this field contains a number of status bits that give extra
   information about the status of the device (Like: is the watchdog timer
   running/active, is the nowayout bit set, is the device opened via
   the /dev/watchdog interface or not, ...).
+* lock: Mutex for WatchDog Timer Driver Core internal use only.
+* last_keepalive: Time of most recent keepalive triggered from user space,
+  in jiffies.
+* work: Worker data structure for WatchDog Timer Driver Core internal use only.
 * deferred: entry in wtd_deferred_reg_list which is used to
   register early initialized watchdogs.
 
@@ -160,7 +176,11 @@ they are supported. These optional routines/operations are:
   and -EIO for "could not write value to the watchdog". On success this
   routine should set the timeout value of the watchdog_device to the
   achieved timeout value (which may be different from the requested one
-  because the watchdog does not necessarily has a 1 second resolution).
+  because the watchdog does not necessarily have a 1 second resolution).
+  Drivers implementing hw_max_timeout_ms set the hardware watchdog timeout
+  to the minimum of timeout and hw_max_timeout_ms. Those drivers set the
+  timeout value of the watchdog_device either to the requested timeout value
+  (if it is larger than hw_max_timeout_ms), or to the achieved timeout value.
   (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
   watchdog's info structure).
 * get_timeleft: this routines returns the time that's left before a reset.
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 56a649e66eb2..1e150f56d561 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -37,7 +37,9 @@
 #include <linux/errno.h>	/* For the -ENODEV/... values */
 #include <linux/kernel.h>	/* For printk/panic/... */
 #include <linux/fs.h>		/* For file operations */
+#include <linux/jiffies.h>	/* For timeout functions */
 #include <linux/watchdog.h>	/* For watchdog specific items */
+#include <linux/workqueue.h>	/* For workqueue */
 #include <linux/miscdevice.h>	/* For handling misc devices */
 #include <linux/init.h>		/* For __init/__exit/... */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
@@ -49,6 +51,80 @@ static dev_t watchdog_devt;
 /* the watchdog device behind /dev/watchdog */
 static struct watchdog_device *old_wdd;
 
+static struct workqueue_struct *watchdog_wq;
+
+static inline bool watchdog_need_worker(struct watchdog_device *wdd)
+{
+	/* All variables in milli-seconds */
+	unsigned int hm = wdd->max_hw_timeout_ms;
+	unsigned int t = wdd->timeout * 1000;
+
+	/*
+	 * A worker to generate heartbeat requests is needed if all of the
+	 * following conditions are true.
+	 * - Userspace activated the watchdog.
+	 * - The driver provided a value for the maximum hardware timeout, and
+	 *   thus is aware that the framework supports generating heartbeat
+	 *   requests.
+	 * - Userspace requests a longer timeout than the hardware can handle.
+	 */
+	return watchdog_active(wdd) && hm && t > hm;
+}
+
+static long watchdog_next_keepalive(struct watchdog_device *wdd)
+{
+	unsigned int timeout_ms = wdd->timeout * 1000;
+	unsigned long keepalive_interval;
+	unsigned long last_heartbeat;
+	unsigned long virt_timeout;
+	unsigned int hw_timeout_ms;
+
+	virt_timeout = wdd->last_keepalive + msecs_to_jiffies(timeout_ms);
+	hw_timeout_ms = min(timeout_ms, wdd->max_hw_timeout_ms);
+	keepalive_interval = msecs_to_jiffies(hw_timeout_ms / 2);
+
+	/*
+	 * To ensure that the watchdog times out wdd->timeout seconds
+	 * after the most recent ping from userspace, the last
+	 * worker ping has to come in hw_timeout_ms before this timeout.
+	 */
+	last_heartbeat = virt_timeout - msecs_to_jiffies(hw_timeout_ms);
+	return min_t(long, last_heartbeat - jiffies, keepalive_interval);
+}
+
+static inline void watchdog_update_worker(struct watchdog_device *wdd,
+					  bool cancel)
+{
+	if (watchdog_need_worker(wdd)) {
+		long t = watchdog_next_keepalive(wdd);
+
+		if (t > 0)
+			mod_delayed_work(watchdog_wq, &wdd->work, t);
+	} else if (cancel) {
+		cancel_delayed_work(&wdd->work);
+	}
+}
+
+static int _watchdog_ping(struct watchdog_device *wdd)
+{
+	int err;
+
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status))
+		return -ENODEV;
+
+	if (!watchdog_active(wdd))
+		return 0;
+
+	if (wdd->ops->ping)
+		err = wdd->ops->ping(wdd);  /* ping the watchdog */
+	else
+		err = wdd->ops->start(wdd); /* restart watchdog */
+
+	watchdog_update_worker(wdd, false);
+
+	return err;
+}
+
 /*
  *	watchdog_ping: ping the watchdog.
  *	@wdd: the watchdog device to ping
@@ -61,26 +137,25 @@ static struct watchdog_device *old_wdd;
 
 static int watchdog_ping(struct watchdog_device *wdd)
 {
-	int err = 0;
+	int err;
 
 	mutex_lock(&wdd->lock);
+	wdd->last_keepalive = jiffies;
+	err = _watchdog_ping(wdd);
+	mutex_unlock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_ping;
-	}
+	return err;
+}
 
-	if (!watchdog_active(wdd))
-		goto out_ping;
+static void watchdog_ping_work(struct work_struct *work)
+{
+	struct watchdog_device *wdd;
 
-	if (wdd->ops->ping)
-		err = wdd->ops->ping(wdd);	/* ping the watchdog */
-	else
-		err = wdd->ops->start(wdd);	/* restart watchdog */
+	wdd = container_of(to_delayed_work(work), struct watchdog_device, work);
 
-out_ping:
+	mutex_lock(&wdd->lock);
+	_watchdog_ping(wdd);
 	mutex_unlock(&wdd->lock);
-	return err;
 }
 
 /*
@@ -94,6 +169,7 @@ out_ping:
 
 static int watchdog_start(struct watchdog_device *wdd)
 {
+	unsigned long started_at;
 	int err = 0;
 
 	mutex_lock(&wdd->lock);
@@ -106,9 +182,13 @@ static int watchdog_start(struct watchdog_device *wdd)
 	if (watchdog_active(wdd))
 		goto out_start;
 
+	started_at = jiffies;
 	err = wdd->ops->start(wdd);
-	if (err == 0)
+	if (err == 0) {
 		set_bit(WDOG_ACTIVE, &wdd->status);
+		wdd->last_keepalive = started_at;
+		watchdog_update_worker(wdd, true);
+	}
 
 out_start:
 	mutex_unlock(&wdd->lock);
@@ -146,8 +226,10 @@ static int watchdog_stop(struct watchdog_device *wdd)
 	}
 
 	err = wdd->ops->stop(wdd);
-	if (err == 0)
+	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
+		cancel_delayed_work(&wdd->work);
+	}
 
 out_stop:
 	mutex_unlock(&wdd->lock);
@@ -211,6 +293,8 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 
 	err = wdd->ops->set_timeout(wdd, timeout);
 
+	watchdog_update_worker(wdd, true);
+
 out_timeout:
 	mutex_unlock(&wdd->lock);
 	return err;
@@ -487,6 +571,8 @@ static int watchdog_release(struct inode *inode, struct file *file)
 		watchdog_ping(wdd);
 	}
 
+	cancel_delayed_work_sync(&wdd->work);
+
 	/* Allow the owner module to be unloaded again */
 	module_put(wdd->ops->owner);
 
@@ -527,6 +613,11 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 {
 	int err, devno;
 
+	if (!watchdog_wq)
+		return -ENODEV;
+
+	INIT_DELAYED_WORK(&wdd->work, watchdog_ping_work);
+
 	if (wdd->id == 0) {
 		old_wdd = wdd;
 		watchdog_miscdev.parent = wdd->parent;
@@ -578,6 +669,9 @@ int watchdog_dev_unregister(struct watchdog_device *wdd)
 		misc_deregister(&watchdog_miscdev);
 		old_wdd = NULL;
 	}
+
+	cancel_delayed_work_sync(&wdd->work);
+
 	return 0;
 }
 
@@ -589,9 +683,19 @@ int watchdog_dev_unregister(struct watchdog_device *wdd)
 
 int __init watchdog_dev_init(void)
 {
-	int err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
+	int err;
+
+	watchdog_wq = alloc_workqueue("watchdogd",
+				      WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+	if (!watchdog_wq) {
+		pr_err("Failed to create watchdog workqueue\n");
+		return -ENOMEM;
+	}
+
+	err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
 	if (err < 0)
 		pr_err("watchdog: unable to allocate char dev region\n");
+
 	return err;
 }
 
@@ -604,4 +708,5 @@ int __init watchdog_dev_init(void)
 void __exit watchdog_dev_exit(void)
 {
 	unregister_chrdev_region(watchdog_devt, MAX_DOGS);
+	destroy_workqueue(watchdog_wq);
 }
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 027b1f43f12d..b535b02b1d7f 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -10,8 +10,10 @@
 
 
 #include <linux/bitops.h>
-#include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/watchdog.h>
 
 struct watchdog_ops;
@@ -61,12 +63,21 @@ struct watchdog_ops {
  * @bootstatus:	Status of the watchdog device at boot.
  * @timeout:	The watchdog devices timeout value (in seconds).
  * @min_timeout:The watchdog devices minimum timeout value (in seconds).
- * @max_timeout:The watchdog devices maximum timeout value (in seconds).
+ * @max_timeout:The watchdog devices maximum timeout value (in seconds)
+ *		as configurable from user space. Only relevant if
+ *		max_hw_timeout_ms is not provided.
+ * @max_hw_timeout_ms:
+ *		Hardware limit for maximum timeout, in milli-seconds.
+ *		Replaces max_timeout if specified.
  * @driver-data:Pointer to the drivers private data.
- * @lock:	Lock for watchdog core internal use only.
  * @status:	Field that contains the devices internal status bits.
- * @deferred: entry in wtd_deferred_reg_list which is used to
- *			   register early initialized watchdogs.
+ * @lock:	Lock for watchdog core internal use only.
+ * @last_keepalive:
+ *		Time of most recent keepalive triggered from user space,
+ *		in jiffies (watchdog core internal).
+ * @work:	Data structure for worker function (watchdog core internal).
+ * @deferred:	entry in wtd_deferred_reg_list which is used to
+ *		register early initialized watchdogs.
  *
  * The watchdog_device structure contains all information about a
  * watchdog timer device.
@@ -88,8 +99,8 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int max_hw_timeout_ms;
 	void *driver_data;
-	struct mutex lock;
 	unsigned long status;
 /* Bit numbers for status flags */
 #define WDOG_ACTIVE		0	/* Is the watchdog running/active */
@@ -97,6 +108,10 @@ struct watchdog_device {
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
 #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
+	/* the following variables are for internal use only */
+	struct mutex lock;
+	unsigned long last_keepalive;
+	struct delayed_work work;
 	struct list_head deferred;
 };
 
@@ -121,13 +136,18 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
 {
 	/*
 	 * The timeout is invalid if
+	 * - the requested value is larger than UINT_MAX / 1000
+	 *   (since internal calculations are done in milli-seconds),
+	 * or
 	 * - the requested value is smaller than the configured minimum timeout,
 	 * or
-	 * - a maximum timeout is configured, and the requested value is larger
-	 *   than the maximum timeout.
+	 * - a maximum hardware timeout is not configured, a maximum timeout
+	 *   is configured, and the requested value is larger than the
+	 *   configured maximum timeout.
 	 */
-	return t < wdd->min_timeout ||
-		(wdd->max_timeout && t > wdd->max_timeout);
+	return t > UINT_MAX / 1000 || t < wdd->min_timeout ||
+		(!wdd->max_hw_timeout_ms && wdd->max_timeout &&
+		 t > wdd->max_timeout);
 }
 
 /* Use the following functions to manipulate watchdog driver specific data */
-- 
2.1.4
