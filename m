Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45849 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbbHDCNt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Aug 2015 22:13:49 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/8] watchdog: Introduce hardware maximum timeout in watchdog core
Date: Mon,  3 Aug 2015 19:13:28 -0700
Message-Id: <1438654414-29259-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Introduce an optional hardware maximum timeout in the watchdog core.
The hardware maximum timeout can be lower than the maximum timeout.

Drivers can set the maximum hardare timeout value in the watchdog data
structure. If the configured timeout exceeds half the value of the
maximum hardware timeout, the watchdog core enables a timer function
to assist sending keepalive requests to the watchdog driver.

Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/watchdog/watchdog-kernel-api.txt |  14 +++
 drivers/watchdog/watchdog_dev.c                | 121 +++++++++++++++++++++----
 include/linux/watchdog.h                       |  21 ++++-
 3 files changed, 135 insertions(+), 21 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index d8b0d3367706..5fa085276874 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -53,9 +53,12 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int max_hw_timeout_ms;
+	unsigned long last_keepalive;
 	void *driver_data;
 	struct mutex lock;
 	unsigned long status;
+	struct delayed_work work;
 	struct list_head deferred;
 };
 
@@ -73,8 +76,18 @@ It contains following fields:
   additional information about the watchdog timer itself. (Like it's unique name)
 * ops: a pointer to the list of watchdog operations that the watchdog supports.
 * timeout: the watchdog timer's timeout value (in seconds).
+  This is the time after which the system will reboot if user space does
+  not send a heartbeat request if the watchdog device is opened.
+  This may or may not be the hardware watchdog timeout. See max_hw_timeout_ms
+  for more details.
 * min_timeout: the watchdog timer's minimum timeout value (in seconds).
 * max_timeout: the watchdog timer's maximum timeout value (in seconds).
+* max_hw_timeout_ms: Maximum hardware timeout, in milli-seconds. May differ
+  from max_timeout. If set, the infrastructure will send a heartbeat to the
+  watchdog driver if 'timeout' is larger than 'max_hw_timeout / 2',
+  unless user space failed to ping the watchdog for 'timeout' seconds.
+* last_keepalive: Time of most recent keepalive triggered from user space,
+  in jiffies.
 * bootstatus: status of the device after booting (reported with watchdog
   WDIOF_* status bits).
 * driver_data: a pointer to the drivers private data of a watchdog device.
@@ -85,6 +98,7 @@ It contains following fields:
   information about the status of the device (Like: is the watchdog timer
   running/active, is the nowayout bit set, is the device opened via
   the /dev/watchdog interface or not, ...).
+* work: Worker data structure for WatchDog Timer Driver Core internal use only.
 * deferred: entry in wtd_deferred_reg_list which is used to
   register early initialized watchdogs.
 
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 06171c73daf5..25849c1d6dc1 100644
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
@@ -49,6 +51,53 @@ static dev_t watchdog_devt;
 /* the watchdog device behind /dev/watchdog */
 static struct watchdog_device *old_wdd;
 
+static struct workqueue_struct *watchdog_wq;
+
+static inline bool watchdog_need_worker(struct watchdog_device *wdd)
+{
+	unsigned int hm = wdd->max_hw_timeout_ms;
+	unsigned int m = wdd->max_timeout * 1000;
+
+	return watchdog_active(wdd) && hm && hm != m &&
+		wdd->timeout * 500 > hm;
+}
+
+static inline void watchdog_update_worker(struct watchdog_device *wdd,
+					  bool cancel, bool sync)
+{
+	if (watchdog_need_worker(wdd)) {
+		unsigned int t = wdd->timeout * 1000;
+
+		if (wdd->max_hw_timeout_ms && t > wdd->max_hw_timeout_ms)
+			t = wdd->max_hw_timeout_ms;
+		queue_delayed_work(watchdog_wq, &wdd->work,
+				   msecs_to_jiffies(t / 2));
+	} else if (cancel) {
+		if (sync)
+			cancel_delayed_work_sync(&wdd->work);
+		else
+			cancel_delayed_work(&wdd->work);
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
+	return err;
+}
+
 /*
  *	watchdog_ping: ping the watchdog.
  *	@wdd: the watchdog device to ping
@@ -61,26 +110,34 @@ static struct watchdog_device *old_wdd;
 
 static int watchdog_ping(struct watchdog_device *wdd)
 {
-	int err = 0;
+	int err;
 
 	mutex_lock(&wdd->lock);
+	err = _watchdog_ping(wdd);
+	wdd->last_keepalive = jiffies;
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
+	if (watchdog_active(wdd) &&
+	    time_after(jiffies, wdd->last_keepalive +
+		       msecs_to_jiffies(wdd->timeout * 1000))) {
+		dev_crit(wdd->dev, "Timer expired. System will reboot soon!\n");
+		goto out;
+	}
+	_watchdog_ping(wdd);
+	watchdog_update_worker(wdd, false, false);
+
+out:
 	mutex_unlock(&wdd->lock);
-	return err;
 }
 
 /*
@@ -107,8 +164,10 @@ static int watchdog_start(struct watchdog_device *wdd)
 		goto out_start;
 
 	err = wdd->ops->start(wdd);
-	if (err == 0)
+	if (err == 0) {
 		set_bit(WDOG_ACTIVE, &wdd->status);
+		watchdog_update_worker(wdd, false, false);
+	}
 
 out_start:
 	mutex_unlock(&wdd->lock);
@@ -146,8 +205,10 @@ static int watchdog_stop(struct watchdog_device *wdd)
 	}
 
 	err = wdd->ops->stop(wdd);
-	if (err == 0)
+	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
+		watchdog_update_worker(wdd, true, false);
+	}
 
 out_stop:
 	mutex_unlock(&wdd->lock);
@@ -211,6 +272,8 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 
 	err = wdd->ops->set_timeout(wdd, timeout);
 
+	watchdog_update_worker(wdd, true, false);
+
 out_timeout:
 	mutex_unlock(&wdd->lock);
 	return err;
@@ -483,6 +546,8 @@ static int watchdog_release(struct inode *inode, struct file *file)
 		watchdog_ping(wdd);
 	}
 
+	cancel_delayed_work_sync(&wdd->work);
+
 	/* Allow the owner module to be unloaded again */
 	module_put(wdd->ops->owner);
 
@@ -523,6 +588,14 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 {
 	int err, devno;
 
+	if (!watchdog_wq)
+		return -ENODEV;
+
+	INIT_DELAYED_WORK(&wdd->work, watchdog_ping_work);
+
+	if (!wdd->max_hw_timeout_ms)
+		wdd->max_hw_timeout_ms = wdd->max_timeout * 1000;
+
 	if (wdd->id == 0) {
 		old_wdd = wdd;
 		watchdog_miscdev.parent = wdd->parent;
@@ -574,6 +647,9 @@ int watchdog_dev_unregister(struct watchdog_device *wdd)
 		misc_deregister(&watchdog_miscdev);
 		old_wdd = NULL;
 	}
+
+	cancel_delayed_work_sync(&wdd->work);
+
 	return 0;
 }
 
@@ -585,9 +661,21 @@ int watchdog_dev_unregister(struct watchdog_device *wdd)
 
 int __init watchdog_dev_init(void)
 {
-	int err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
+	int err;
+
+	watchdog_wq = alloc_workqueue("watchdogd",
+				      WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+	if (!watchdog_wq) {
+		pr_err("Failed to create watchdog workqueue\n");
+		err = -ENOMEM;
+		goto abort;
+	}
+
+	err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
 	if (err < 0)
 		pr_err("watchdog: unable to allocate char dev region\n");
+
+abort:
 	return err;
 }
 
@@ -600,4 +688,5 @@ int __init watchdog_dev_init(void)
 void __exit watchdog_dev_exit(void)
 {
 	unregister_chrdev_region(watchdog_devt, MAX_DOGS);
+	destroy_workqueue(watchdog_wq);
 }
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index f47feada5b42..2703b2511481 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -12,6 +12,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/watchdog.h>
 
 struct watchdog_ops;
@@ -59,14 +60,21 @@ struct watchdog_ops {
  * @info:	Pointer to a watchdog_info structure.
  * @ops:	Pointer to the list of watchdog operations.
  * @bootstatus:	Status of the watchdog device at boot.
- * @timeout:	The watchdog devices timeout value.
- * @min_timeout:The watchdog devices minimum timeout value.
- * @max_timeout:The watchdog devices maximum timeout value.
+ * @timeout:	The watchdog devices timeout value, in seconds.
+ * @min_timeout:The watchdog devices minimum timeout value, in seconds.
+ * @max_timeout:The watchdog devices maximum timeout value, in seconds.
+ * @max_hw_timeout_ms:
+ *		Hardware limit for maximum timeout, in milli-seconds,
+ *		if different from max_timeout.
+ * @last_keepalive:
+ *		Time of most recent keepalive triggered from user space,
+ *		in jiffies (watchdog core internal).
  * @driver-data:Pointer to the drivers private data.
  * @lock:	Lock for watchdog core internal use only.
  * @status:	Field that contains the devices internal status bits.
- * @deferred: entry in wtd_deferred_reg_list which is used to
- *			   register early initialized watchdogs.
+ * @work:	Data structure for worker function (watchdog core internal).
+ * @deferred:	entry in wtd_deferred_reg_list which is used to
+ *		register early initialized watchdogs.
  *
  * The watchdog_device structure contains all information about a
  * watchdog timer device.
@@ -88,6 +96,8 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int max_hw_timeout_ms;
+	unsigned long last_keepalive;
 	void *driver_data;
 	struct mutex lock;
 	unsigned long status;
@@ -97,6 +107,7 @@ struct watchdog_device {
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
 #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
+	struct delayed_work work;
 	struct list_head deferred;
 };
 
-- 
2.1.4

