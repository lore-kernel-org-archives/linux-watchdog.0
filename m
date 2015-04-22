Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:58606 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756247AbbDVLMB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Apr 2015 07:12:01 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv7 1/8] watchdog: Extend kernel API to know about HW limitations
Date: Wed, 22 Apr 2015 14:11:35 +0300
Message-Id: <1429701102-22320-2-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

There is a great deal of diversity in the watchdog hardware found on
different devices. Differen hardware have different contstraints on
them, many of the constraints that are excessively difficult for the
user space to satisfy.

One such constraint is the length of the timeout value, which in many
cases can be just a few seconds. Drivers are creating ad hoc solutions
with timers and workqueues to extend the timeout in order to give user
space more time between updates. Looking at the drivers it is clear
that this has resulted to a lot of duplicate code.

Add an extension to the watchdog kernel API that allows the driver to
describe tis HW constraints to the watchdog code. A kernel worker in
the core is then used to extend the watchdog timeout on behalf of the
user space. This allows the drivers to be simplified as core takes
over the timer extending.

Tested-by: Wenyou Yang <wenyou.yang@atmel.com>
Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 drivers/watchdog/watchdog_core.c | 101 +++++++++++++++++++++++++++++++++++++--
 drivers/watchdog/watchdog_dev.c  |  75 ++++++++++++++++++++++++++---
 include/linux/watchdog.h         |  23 +++++++++
 3 files changed, 189 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index cec9b55..fd12489 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -99,6 +99,89 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 EXPORT_SYMBOL_GPL(watchdog_init_timeout);
 
 /**
+ * watchdog_init_parms() - initialize generic watchdog parameters
+ * @wdd: Watchdog device to operate
+ * @dev: Device that stores the device tree properties
+ *
+ * Initialize the generic timeout parameters. The driver needs to set
+ * hw_features bitmask from @wdd prior calling this function in order
+ * to ensure the core knows how to handle the HW.
+ *
+ * A zero is returned on success and -EINVAL for failure.
+ */
+int watchdog_init_params(struct watchdog_device *wdd, struct device *dev)
+{
+	int ret = 0;
+
+	ret = watchdog_init_timeout(wdd, wdd->timeout, dev);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Max HW timeout needs to be set so that core knows when to
+	 * use a kernel worker to support longer watchdog timeouts
+	 */
+	if (!wdd->hw_max_timeout)
+		return -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(watchdog_init_params);
+
+static void watchdog_worker(struct work_struct *work)
+{
+	struct watchdog_device *wdd = container_of(to_delayed_work(work),
+						struct watchdog_device, work);
+	bool boot_keepalive;
+	bool active_keepalive;
+
+	mutex_lock(&wdd->lock);
+
+	boot_keepalive = !watchdog_active(wdd) &&
+		!watchdog_is_stoppable(wdd);
+
+	active_keepalive = watchdog_active(wdd) &&
+		wdd->hw_max_timeout < wdd->timeout * HZ;
+
+	if (time_after(jiffies, wdd->expires) && watchdog_active(wdd)) {
+		pr_crit("I will reset your machine !\n");
+		mutex_unlock(&wdd->lock);
+		return;
+	}
+
+	if (boot_keepalive || active_keepalive) {
+		if (wdd->ops->ping)
+			wdd->ops->ping(wdd);
+		else
+			wdd->ops->start(wdd);
+
+		schedule_delayed_work(&wdd->work,  wdd->hw_heartbeat);
+	}
+
+	mutex_unlock(&wdd->lock);
+}
+
+static int prepare_watchdog(struct watchdog_device *wdd)
+{
+	int err = 0;
+
+	/* Stop the watchdog now before user space opens the device */
+	if (watchdog_is_stoppable(wdd) &&
+		wdd->hw_features & WDOG_HW_RUNNING_AT_BOOT) {
+		err = wdd->ops->stop(wdd);
+
+	} else if (!watchdog_is_stoppable(wdd) &&
+		wdd->hw_features & WDOG_HW_RUNNING_AT_BOOT) {
+		/*
+		 * Can't stop it, use a delayed worker to tick it
+		 * until it's open by user space
+		 */
+		schedule_delayed_work(&wdd->work, wdd->hw_heartbeat);
+	}
+	return err;
+}
+
+/**
  * watchdog_register_device() - register a watchdog device
  * @wdd: watchdog device
  *
@@ -156,13 +239,24 @@ int watchdog_register_device(struct watchdog_device *wdd)
 	wdd->dev = device_create(watchdog_class, wdd->parent, devno,
 					NULL, "watchdog%d", wdd->id);
 	if (IS_ERR(wdd->dev)) {
-		watchdog_dev_unregister(wdd);
-		ida_simple_remove(&watchdog_ida, id);
 		ret = PTR_ERR(wdd->dev);
-		return ret;
+		goto dev_create_fail;
+	}
+
+	INIT_DELAYED_WORK(&wdd->work, watchdog_worker);
+
+	if (wdd->hw_max_timeout) {
+		ret = prepare_watchdog(wdd);
+		if (ret)
+			goto dev_create_fail;
 	}
 
 	return 0;
+
+dev_create_fail:
+	watchdog_dev_unregister(wdd);
+	ida_simple_remove(&watchdog_ida, id);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(watchdog_register_device);
 
@@ -181,6 +275,7 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
 	if (wdd == NULL)
 		return;
 
+	cancel_delayed_work_sync(&wdd->work);
 	devno = wdd->cdev.dev;
 	ret = watchdog_dev_unregister(wdd);
 	if (ret)
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 6aaefba..04ac68c 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -49,6 +49,14 @@ static dev_t watchdog_devt;
 /* the watchdog device behind /dev/watchdog */
 static struct watchdog_device *old_wdd;
 
+static int _watchdog_ping(struct watchdog_device *wddev)
+{
+	if (wddev->ops->ping)
+		return wddev->ops->ping(wddev);  /* ping the watchdog */
+	else
+		return wddev->ops->start(wddev); /* restart watchdog */
+}
+
 /*
  *	watchdog_ping: ping the watchdog.
  *	@wddev: the watchdog device to ping
@@ -73,10 +81,13 @@ static int watchdog_ping(struct watchdog_device *wddev)
 	if (!watchdog_active(wddev))
 		goto out_ping;
 
-	if (wddev->ops->ping)
-		err = wddev->ops->ping(wddev);  /* ping the watchdog */
-	else
-		err = wddev->ops->start(wddev); /* restart watchdog */
+	err = _watchdog_ping(wddev);
+
+	if (wddev->hw_max_timeout &&
+		wddev->timeout * HZ > wddev->hw_max_timeout) {
+		wddev->expires = jiffies + wddev->timeout * HZ;
+		schedule_delayed_work(&wddev->work, wddev->hw_heartbeat);
+	}
 
 out_ping:
 	mutex_unlock(&wddev->lock);
@@ -110,6 +121,13 @@ static int watchdog_start(struct watchdog_device *wddev)
 	if (err == 0)
 		set_bit(WDOG_ACTIVE, &wddev->status);
 
+	if (wddev->hw_max_timeout &&
+		wddev->timeout * HZ > wddev->hw_max_timeout) {
+		wddev->expires = jiffies + wddev->timeout * HZ;
+		schedule_delayed_work(&wddev->work, wddev->hw_heartbeat);
+	} else
+		cancel_delayed_work(&wddev->work);
+
 out_start:
 	mutex_unlock(&wddev->lock);
 	return err;
@@ -145,9 +163,21 @@ static int watchdog_stop(struct watchdog_device *wddev)
 		goto out_stop;
 	}
 
-	err = wddev->ops->stop(wddev);
-	if (err == 0)
+	if (!wddev->hw_max_timeout || watchdog_is_stoppable(wddev)) {
+		cancel_delayed_work(&wddev->work);
+		err = wddev->ops->stop(wddev);
+		if (err == 0)
+			clear_bit(WDOG_ACTIVE, &wddev->status);
+	} else {
+		/* Unstoppable watchdogs need the worker to keep them alive */
 		clear_bit(WDOG_ACTIVE, &wddev->status);
+		/*
+		 * Ping it once as we don't know how much time there
+		 * is left in the watchdog timer.
+		 */
+		err = _watchdog_ping(wddev);
+		schedule_delayed_work(&wddev->work, wddev->hw_heartbeat);
+	}
 
 out_stop:
 	mutex_unlock(&wddev->lock);
@@ -194,7 +224,38 @@ out_status:
 static int watchdog_set_timeout(struct watchdog_device *wddev,
 							unsigned int timeout)
 {
-	int err;
+	int err = 0;
+
+	if (wddev->hw_max_timeout) {
+		int hw_timeout;
+		/*
+		 * We can't support too short timeout values. There is
+		 * really no maximu however, anything longer than HW
+		 * maximum will be supported by the watchdog core on
+		 * behalf of the actual HW.
+		 */
+		if (timeout < wddev->min_timeout)
+			return -EINVAL;
+
+		mutex_lock(&wddev->lock);
+		if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+			err = -ENODEV;
+			goto out_timeout;
+		}
+
+		if (timeout * HZ > wddev->hw_max_timeout)
+			schedule_delayed_work(&wddev->work,
+					wddev->hw_heartbeat);
+
+		hw_timeout = min(timeout, wddev->hw_max_timeout / HZ);
+		if (wddev->info->options & WDIOF_SETTIMEOUT)
+			err = wddev->ops->set_timeout(wddev, hw_timeout);
+
+		if (hw_timeout < timeout)
+			wddev->timeout = timeout;
+
+		goto out_timeout;
+	}
 
 	if ((wddev->ops->set_timeout == NULL) ||
 	    !(wddev->info->options & WDIOF_SETTIMEOUT))
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 395b70e..027c99d 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -12,6 +12,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/watchdog.h>
 
 struct watchdog_ops;
@@ -62,9 +63,13 @@ struct watchdog_ops {
  * @timeout:	The watchdog devices timeout value.
  * @min_timeout:The watchdog devices minimum timeout value.
  * @max_timeout:The watchdog devices maximum timeout value.
+ * @hw_max_timeout:The watchdog hardware maximum timeout value.
+ * @hw_heartbeat:Time interval in HW between timer pings.
  * @driver-data:Pointer to the drivers private data.
  * @lock:	Lock for watchdog core internal use only.
+ * @work:	Worker used to provide longer timeouts than hardware supports.
  * @status:	Field that contains the devices internal status bits.
+ * @hw_features:Feature bits describing how the watchdog HW works.
  *
  * The watchdog_device structure contains all information about a
  * watchdog timer device.
@@ -86,8 +91,12 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int hw_max_timeout; /* in jiffies */
+	unsigned int hw_heartbeat; /* in jiffies */
+	unsigned long int expires; /* for keepalive worker */
 	void *driver_data;
 	struct mutex lock;
+	struct delayed_work work;
 	unsigned long status;
 /* Bit numbers for status flags */
 #define WDOG_ACTIVE		0	/* Is the watchdog running/active */
@@ -95,6 +104,14 @@ struct watchdog_device {
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
 #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
+
+/* Bits describing features supported by the HW */
+	unsigned long hw_features;
+
+/* Can the watchdog be stopped and started */
+#define WDOG_HW_IS_STOPPABLE		BIT(0)
+/* Is the watchdog already running when the driver starts up */
+#define WDOG_HW_RUNNING_AT_BOOT		BIT(1)
 };
 
 #define WATCHDOG_NOWAYOUT		IS_BUILTIN(CONFIG_WATCHDOG_NOWAYOUT)
@@ -120,6 +137,11 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
 		(t < wdd->min_timeout || t > wdd->max_timeout));
 }
 
+static inline bool watchdog_is_stoppable(struct watchdog_device *wdd)
+{
+	return wdd->hw_features & WDOG_HW_IS_STOPPABLE;
+}
+
 /* Use the following functions to manipulate watchdog driver specific data */
 static inline void watchdog_set_drvdata(struct watchdog_device *wdd, void *data)
 {
@@ -134,6 +156,7 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 /* drivers/watchdog/watchdog_core.c */
 extern int watchdog_init_timeout(struct watchdog_device *wdd,
 				  unsigned int timeout_parm, struct device *dev);
+int watchdog_init_params(struct watchdog_device *wdd, struct device *dev);
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
-- 
2.1.0

