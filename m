Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:32825 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011AbcB1VM2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 28 Feb 2016 16:12:28 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v8 02/10] watchdog: Introduce hardware maximum heartbeat in watchdog core
Date: Sun, 28 Feb 2016 13:12:15 -0800
Message-Id: <1456693943-6876-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1456693943-6876-1-git-send-email-linux@roeck-us.net>
References: <1456693943-6876-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Introduce an optional hardware maximum heartbeat in the watchdog core.
The hardware maximum heartbeat can be lower than the maximum timeout.

Drivers can set the maximum hardware heartbeat value in the watchdog data
structure. If the configured timeout exceeds the maximum hardware heartbeat,
the watchdog core enables a timer function to assist sending keepalive
requests to the watchdog driver.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>

---
v8:
- Rebased to v4.5-rc5
- Now second patch of series
- max_hw_timeout_ms -> max_hw_heartbeat_ms
- Merged 'watchdog: Simplify update_worker' into this patch
v7:
- Rebased to v4.5-rc1
- Moved new variables to local data structure
- Dropped Uwe's Acked-by: due to substantial changes
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
 Documentation/watchdog/watchdog-kernel-api.txt |  19 +++-
 drivers/watchdog/watchdog_dev.c                | 129 +++++++++++++++++++++++--
 include/linux/watchdog.h                       |  28 ++++--
 3 files changed, 158 insertions(+), 18 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index dd8f912c0576..15a02595ade1 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -52,6 +52,7 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int max_hw_heartbeat_ms;
 	struct notifier_block reboot_nb;
 	struct notifier_block restart_nb;
 	void *driver_data;
@@ -73,8 +74,18 @@ It contains following fields:
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
+  'timeout'. Not used if max_hw_heartbeat_ms is non-zero.
+* max_hw_heartbeat_ms: Maximum hardware heartbeat, in milli-seconds.
+  If set, the infrastructure will send heartbeats to the watchdog driver
+  if 'timeout' is larger than max_hw_heartbeat_ms, unless WDOG_ACTIVE
+  is set and userspace failed to send a heartbeat for at least 'timeout'
+  seconds.
 * reboot_nb: notifier block that is registered for reboot notifications, for
   internal use only. If the driver calls watchdog_stop_on_reboot, watchdog core
   will stop the watchdog on such notifications.
@@ -153,7 +164,11 @@ they are supported. These optional routines/operations are:
   and -EIO for "could not write value to the watchdog". On success this
   routine should set the timeout value of the watchdog_device to the
   achieved timeout value (which may be different from the requested one
-  because the watchdog does not necessarily has a 1 second resolution).
+  because the watchdog does not necessarily have a 1 second resolution).
+  Drivers implementing max_hw_heartbeat_ms set the hardware watchdog heartbeat
+  to the minimum of timeout and max_hw_heartbeat_ms. Those drivers set the
+  timeout value of the watchdog_device either to the requested timeout value
+  (if it is larger than max_hw_heartbeat_ms), or to the achieved timeout value.
   (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
   watchdog's info structure).
   If the watchdog driver does not have to perform any action but setting the
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index b5e700186ae0..e668a9e8b648 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -36,6 +36,7 @@
 #include <linux/errno.h>	/* For the -ENODEV/... values */
 #include <linux/fs.h>		/* For file operations */
 #include <linux/init.h>		/* For __init/__exit/... */
+#include <linux/jiffies.h>	/* For timeout functions */
 #include <linux/kernel.h>	/* For printk/panic/... */
 #include <linux/kref.h>		/* For data references */
 #include <linux/miscdevice.h>	/* For handling misc devices */
@@ -44,6 +45,7 @@
 #include <linux/slab.h>		/* For memory functions */
 #include <linux/types.h>	/* For standard types (like size_t) */
 #include <linux/watchdog.h>	/* For watchdog specific items */
+#include <linux/workqueue.h>	/* For workqueue */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
 
 #include "watchdog_core.h"
@@ -61,6 +63,8 @@ struct watchdog_core_data {
 	struct cdev cdev;
 	struct watchdog_device *wdd;
 	struct mutex lock;
+	unsigned long last_keepalive;
+	struct delayed_work work;
 	unsigned long status;		/* Internal status bits */
 #define _WDOG_DEV_OPEN		0	/* Opened ? */
 #define _WDOG_ALLOW_RELEASE	1	/* Did we receive the magic char ? */
@@ -71,6 +75,76 @@ static dev_t watchdog_devt;
 /* Reference to watchdog device behind /dev/watchdog */
 static struct watchdog_core_data *old_wd_data;
 
+static struct workqueue_struct *watchdog_wq;
+
+static inline bool watchdog_need_worker(struct watchdog_device *wdd)
+{
+	/* All variables in milli-seconds */
+	unsigned int hm = wdd->max_hw_heartbeat_ms;
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
+	struct watchdog_core_data *wd_data = wdd->wd_data;
+	unsigned int timeout_ms = wdd->timeout * 1000;
+	unsigned long keepalive_interval;
+	unsigned long last_heartbeat;
+	unsigned long virt_timeout;
+	unsigned int hw_heartbeat_ms;
+
+	virt_timeout = wd_data->last_keepalive + msecs_to_jiffies(timeout_ms);
+	hw_heartbeat_ms = min(timeout_ms, wdd->max_hw_heartbeat_ms);
+	keepalive_interval = msecs_to_jiffies(hw_heartbeat_ms / 2);
+
+	/*
+	 * To ensure that the watchdog times out wdd->timeout seconds
+	 * after the most recent ping from userspace, the last
+	 * worker ping has to come in hw_heartbeat_ms before this timeout.
+	 */
+	last_heartbeat = virt_timeout - msecs_to_jiffies(hw_heartbeat_ms);
+	return min_t(long, last_heartbeat - jiffies, keepalive_interval);
+}
+
+static inline void watchdog_update_worker(struct watchdog_device *wdd)
+{
+	struct watchdog_core_data *wd_data = wdd->wd_data;
+
+	if (watchdog_need_worker(wdd)) {
+		long t = watchdog_next_keepalive(wdd);
+
+		if (t > 0)
+			mod_delayed_work(watchdog_wq, &wd_data->work, t);
+	} else {
+		cancel_delayed_work(&wd_data->work);
+	}
+}
+
+static int __watchdog_ping(struct watchdog_device *wdd)
+{
+	int err;
+
+	if (wdd->ops->ping)
+		err = wdd->ops->ping(wdd);  /* ping the watchdog */
+	else
+		err = wdd->ops->start(wdd); /* restart watchdog */
+
+	watchdog_update_worker(wdd);
+
+	return err;
+}
+
 /*
  *	watchdog_ping: ping the watchdog.
  *	@wdd: the watchdog device to ping
@@ -85,17 +159,28 @@ static struct watchdog_core_data *old_wd_data;
 
 static int watchdog_ping(struct watchdog_device *wdd)
 {
-	int err;
+	struct watchdog_core_data *wd_data = wdd->wd_data;
 
 	if (!watchdog_active(wdd))
 		return 0;
 
-	if (wdd->ops->ping)
-		err = wdd->ops->ping(wdd);	/* ping the watchdog */
-	else
-		err = wdd->ops->start(wdd);	/* restart watchdog */
+	wd_data->last_keepalive = jiffies;
+	return __watchdog_ping(wdd);
+}
 
-	return err;
+static void watchdog_ping_work(struct work_struct *work)
+{
+	struct watchdog_core_data *wd_data;
+	struct watchdog_device *wdd;
+
+	wd_data = container_of(to_delayed_work(work), struct watchdog_core_data,
+			       work);
+
+	mutex_lock(&wd_data->lock);
+	wdd = wd_data->wdd;
+	if (wdd && watchdog_active(wdd))
+		__watchdog_ping(wdd);
+	mutex_unlock(&wd_data->lock);
 }
 
 /*
@@ -111,14 +196,20 @@ static int watchdog_ping(struct watchdog_device *wdd)
 
 static int watchdog_start(struct watchdog_device *wdd)
 {
+	struct watchdog_core_data *wd_data = wdd->wd_data;
+	unsigned long started_at;
 	int err;
 
 	if (watchdog_active(wdd))
 		return 0;
 
+	started_at = jiffies;
 	err = wdd->ops->start(wdd);
-	if (err == 0)
+	if (err == 0) {
 		set_bit(WDOG_ACTIVE, &wdd->status);
+		wd_data->last_keepalive = started_at;
+		watchdog_update_worker(wdd);
+	}
 
 	return err;
 }
@@ -137,6 +228,7 @@ static int watchdog_start(struct watchdog_device *wdd)
 
 static int watchdog_stop(struct watchdog_device *wdd)
 {
+	struct watchdog_core_data *wd_data = wdd->wd_data;
 	int err;
 
 	if (!watchdog_active(wdd))
@@ -149,8 +241,10 @@ static int watchdog_stop(struct watchdog_device *wdd)
 	}
 
 	err = wdd->ops->stop(wdd);
-	if (err == 0)
+	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
+		cancel_delayed_work(&wd_data->work);
+	}
 
 	return err;
 }
@@ -196,6 +290,8 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 	else
 		wdd->timeout = timeout;
 
+	watchdog_update_worker(wdd);
+
 	return err;
 }
 
@@ -616,6 +712,8 @@ static int watchdog_release(struct inode *inode, struct file *file)
 		watchdog_ping(wdd);
 	}
 
+	cancel_delayed_work_sync(&wd_data->work);
+
 	/* make sure that /dev/watchdog can be re-opened */
 	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
 
@@ -665,6 +763,11 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 	wd_data->wdd = wdd;
 	wdd->wd_data = wd_data;
 
+	if (!watchdog_wq)
+		return -ENODEV;
+
+	INIT_DELAYED_WORK(&wd_data->work, watchdog_ping_work);
+
 	if (wdd->id == 0) {
 		old_wd_data = wd_data;
 		watchdog_miscdev.parent = wdd->parent;
@@ -722,6 +825,8 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 	wdd->wd_data = NULL;
 	mutex_unlock(&wd_data->lock);
 
+	cancel_delayed_work_sync(&wd_data->work);
+
 	kref_put(&wd_data->kref, watchdog_core_data_release);
 }
 
@@ -787,6 +892,13 @@ int __init watchdog_dev_init(void)
 {
 	int err;
 
+	watchdog_wq = alloc_workqueue("watchdogd",
+				      WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+	if (!watchdog_wq) {
+		pr_err("Failed to create watchdog workqueue\n");
+		return -ENOMEM;
+	}
+
 	err = class_register(&watchdog_class);
 	if (err < 0) {
 		pr_err("couldn't register class\n");
@@ -813,4 +925,5 @@ void __exit watchdog_dev_exit(void)
 {
 	unregister_chrdev_region(watchdog_devt, MAX_DOGS);
 	class_unregister(&watchdog_class);
+	destroy_workqueue(watchdog_wq);
 }
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index b585fa2507ee..a94404917762 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -10,8 +10,9 @@
 
 
 #include <linux/bitops.h>
-#include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
 #include <linux/notifier.h>
 #include <uapi/linux/watchdog.h>
 
@@ -61,14 +62,19 @@ struct watchdog_ops {
  * @bootstatus:	Status of the watchdog device at boot.
  * @timeout:	The watchdog devices timeout value (in seconds).
  * @min_timeout:The watchdog devices minimum timeout value (in seconds).
- * @max_timeout:The watchdog devices maximum timeout value (in seconds).
+ * @max_timeout:The watchdog devices maximum timeout value (in seconds)
+ *		as configurable from user space. Only relevant if
+ *		max_hw_heartbeat_ms is not provided.
+ * @max_hw_heartbeat_ms:
+ *		Hardware limit for maximum timeout, in milli-seconds.
+ *		Replaces max_timeout if specified.
  * @reboot_nb:	The notifier block to stop watchdog on reboot.
  * @restart_nb:	The notifier block to register a restart function.
  * @driver_data:Pointer to the drivers private data.
  * @wd_data:	Pointer to watchdog core internal data.
  * @status:	Field that contains the devices internal status bits.
- * @deferred: entry in wtd_deferred_reg_list which is used to
- *			   register early initialized watchdogs.
+ * @deferred:	Entry in wtd_deferred_reg_list which is used to
+ *		register early initialized watchdogs.
  *
  * The watchdog_device structure contains all information about a
  * watchdog timer device.
@@ -89,6 +95,7 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int max_hw_heartbeat_ms;
 	struct notifier_block reboot_nb;
 	struct notifier_block restart_nb;
 	void *driver_data;
@@ -128,13 +135,18 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
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
+		(!wdd->max_hw_heartbeat_ms && wdd->max_timeout &&
+		 t > wdd->max_timeout);
 }
 
 /* Use the following functions to manipulate watchdog driver specific data */
-- 
2.5.0

