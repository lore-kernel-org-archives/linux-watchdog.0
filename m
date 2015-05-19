Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:51232 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754534AbbESI0p (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 May 2015 04:26:45 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv8 02/10] watchdog: core: Ping watchdog on behalf of user space when needed
Date: Tue, 19 May 2015 11:26:01 +0300
Message-Id: <1432023969-20736-3-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Many watchdogs are not stoppable on the hardware level at all. Some
others have a very short maximum timeout value. Both of these limits
are problematic to the userspace and watchdog drivers have been
traditionally implementing workarounds of their own in order to
overcome the limitations. This obviously results in duplicate code in
the driver level and makes it harder to implement generic hardware
independent features.

Extend the watchdog core by allowing it do the most common tasks on
behalf of the driver. For this to work the watchdog core needs two new
values from the driver, hw_max_timeout and hw_heartbeat. The first one
tells the core what is the maximum supported timeout value in the
hardware and the second one tells the preferred heartbeat value for
the hardware. Both values are in milliseconds.

The driver needs to also call watchdog_init_params() in order to let
watchdog core fill in default watchdog paramters and let the core
check the validity of the values.

The watchdog core api changes slightly because of this change. Most
importantly, the watchdog core now stands out as a clear midlayer
between the driver and the user space. That is, the hw_max_timeout and
hw_heartbeat values are meant to be filled in by the driver for the
core. They will not be visible to user space any way. The timeout
variable however is part of user space API. The comments in watchdog.h
are changed also to reflect more clearly the difference. The
max_timeout also becomes obsolete as the worker can support arbitrary
timeout values.

As long as we have still old drivers that don't tell the core about
their hw capabilities, we need to support the old driver handling
too. Add watchdog_needs_legacy_handling() function to watchdog.h so we
can implement easily the old driver behavior and it becomes clear from
the code which parts can be removed once all existing drivers supply
the new parameters to watchdog core.

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 drivers/watchdog/watchdog_core.c | 124 ++++++++++++++++++++++++++++++++++++++-
 drivers/watchdog/watchdog_dev.c  | 105 ++++++++++++++++++++++++++-------
 include/linux/watchdog.h         |  64 ++++++++++++++++++--
 3 files changed, 265 insertions(+), 28 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index cec9b55..16e10e0 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -45,6 +45,9 @@ static struct class *watchdog_class;
 
 static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 {
+	/* Newer drivers don't need this check any more */
+	if (!watchdog_needs_legacy_handling(wdd))
+		return;
 	/*
 	 * Check that we have valid min and max timeout values, if
 	 * not reset them both to 0 (=not used or unknown)
@@ -98,6 +101,110 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 }
 EXPORT_SYMBOL_GPL(watchdog_init_timeout);
 
+static void watchdog_set_default_timeout(struct watchdog_device *wdd,
+					 struct device *dev)
+{
+	int ret;
+	/*
+	 * If driver has already set up a timeout, eg. from a module
+	 * parameter, no need to do anything here
+	 */
+	if (!watchdog_timeout_invalid(wdd, wdd->timeout))
+		return;
+
+	/* Query device tree */
+	if (dev && dev->of_node) {
+		ret = of_property_read_u32(dev->of_node, "timeout-sec",
+					   &wdd->timeout);
+		if (!ret && !watchdog_timeout_invalid(wdd, wdd->timeout))
+			return;
+	}
+
+	/*
+	 * If no other preference is given, use 60 seconds as the
+	 * default timeout value
+	 */
+	wdd->timeout = 60;
+}
+
+/**
+ * watchdog_init_parms() - initialize generic watchdog parameters
+ * @wdd: Watchdog device to operate
+ * @dev: Device that stores the device tree properties
+ *
+ * Initialize the generic watchdog parameters. At least hw_max_timeout
+ * must be set prior calling this function. Other unset parameters are
+ * set based on information gathered from different sources (kernel
+ * config, device tree, ...) or set up with a reasonable defaults.
+ *
+ * A zero is returned on success and -EINVAL for failure.
+ */
+int watchdog_init_params(struct watchdog_device *wdd, struct device *dev)
+{
+	int ret = 0;
+
+	watchdog_set_default_timeout(wdd, dev);
+
+	if (wdd->max_timeout)
+		dev_err(dev, "Driver setting deprecated max_timeout, please fix\n");
+
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
+	bool stopped_keepalive;
+	bool extend_keepalive;
+
+	mutex_lock(&wdd->lock);
+
+	/* Watchdog device is not open but HW does not support stopping */
+	stopped_keepalive = watchdog_hw_active(wdd) &&
+		!watchdog_dev_open(wdd);
+
+	/* Keepalive time is longer than what hardware is capable */
+	extend_keepalive = watchdog_dev_open(wdd) &&
+		msecs_to_jiffies(wdd->hw_max_timeout) < wdd->timeout * HZ;
+
+	if (time_after(jiffies, wdd->expires) && watchdog_dev_open(wdd)) {
+		/*
+		 * Userspace has exceeded its timeout, the watchdog is
+		 * going to trigger soon.
+		 */
+		mutex_unlock(&wdd->lock);
+		return;
+	}
+
+	if (stopped_keepalive || extend_keepalive) {
+		unsigned long expires = msecs_to_jiffies(wdd->hw_heartbeat);
+
+		_watchdog_ping(wdd);
+		schedule_delayed_work(&wdd->work, expires);
+	}
+
+	mutex_unlock(&wdd->lock);
+}
+
+static int prepare_watchdog(struct watchdog_device *wdd)
+{
+	if (watchdog_needs_legacy_handling(wdd)) {
+		pr_info("Incomplete watchdog driver implementation, please report or fix\n");
+		return 0;
+	}
+
+	if (!watchdog_hw_active(wdd))
+		return 0;
+
+	/* Stop the watchdog now until user space opens the device */
+	return watchdog_stop(wdd);
+}
+
 /**
  * watchdog_register_device() - register a watchdog device
  * @wdd: watchdog device
@@ -156,13 +263,23 @@ int watchdog_register_device(struct watchdog_device *wdd)
 	wdd->dev = device_create(watchdog_class, wdd->parent, devno,
 					NULL, "watchdog%d", wdd->id);
 	if (IS_ERR(wdd->dev)) {
-		watchdog_dev_unregister(wdd);
-		ida_simple_remove(&watchdog_ida, id);
 		ret = PTR_ERR(wdd->dev);
-		return ret;
+		goto dev_create_fail;
 	}
 
+	INIT_DELAYED_WORK(&wdd->work, watchdog_worker);
+
+	ret = prepare_watchdog(wdd);
+	if (ret)
+		goto dev_prepare_fail;
+
 	return 0;
+
+dev_prepare_fail:
+dev_create_fail:
+	watchdog_dev_unregister(wdd);
+	ida_simple_remove(&watchdog_ida, id);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(watchdog_register_device);
 
@@ -181,6 +298,7 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
 	if (wdd == NULL)
 		return;
 
+	cancel_delayed_work_sync(&wdd->work);
 	devno = wdd->cdev.dev;
 	ret = watchdog_dev_unregister(wdd);
 	if (ret)
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 2c4d3f1..ac17668 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -73,10 +73,13 @@ static int watchdog_ping(struct watchdog_device *wddev)
 	if (!watchdog_hw_active(wddev))
 		goto out_ping;
 
-	if (wddev->ops->ping)
-		err = wddev->ops->ping(wddev);  /* ping the watchdog */
-	else
-		err = wddev->ops->start(wddev); /* restart watchdog */
+	err = _watchdog_ping(wddev);
+
+	if (wddev->hw_max_timeout &&
+		wddev->timeout * 1000 > wddev->hw_max_timeout) {
+		wddev->expires = jiffies + wddev->timeout * HZ;
+		schedule_delayed_work(&wddev->work, wddev->hw_heartbeat);
+	}
 
 out_ping:
 	mutex_unlock(&wddev->lock);
@@ -92,7 +95,7 @@ out_ping:
  *	failure.
  */
 
-static int watchdog_start(struct watchdog_device *wddev)
+int watchdog_start(struct watchdog_device *wddev)
 {
 	int err = 0;
 
@@ -100,17 +103,26 @@ static int watchdog_start(struct watchdog_device *wddev)
 
 	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
 		err = -ENODEV;
-		goto out_start;
+		goto out_no_start;
 	}
 
+	if (wddev->hw_max_timeout &&
+		wddev->timeout * HZ > msecs_to_jiffies(wddev->hw_max_timeout)) {
+		wddev->expires = jiffies + wddev->timeout * HZ;
+		schedule_delayed_work(&wddev->work,
+				      msecs_to_jiffies(wddev->hw_heartbeat));
+	} else
+		cancel_delayed_work(&wddev->work);
+
 	if (watchdog_hw_active(wddev))
-		goto out_start;
+		goto out_started;
 
 	err = wddev->ops->start(wddev);
 	if (err == 0)
 		set_bit(WDOG_ACTIVE, &wddev->status);
 
-out_start:
+out_started:
+out_no_start:
 	mutex_unlock(&wddev->lock);
 	return err;
 }
@@ -125,7 +137,7 @@ out_start:
  *	If the 'nowayout' feature was set, the watchdog cannot be stopped.
  */
 
-static int watchdog_stop(struct watchdog_device *wddev)
+int watchdog_stop(struct watchdog_device *wddev)
 {
 	int err = 0;
 
@@ -146,9 +158,29 @@ static int watchdog_stop(struct watchdog_device *wddev)
 	}
 
 	err = wddev->ops->stop(wddev);
-	if (err == 0)
-		clear_bit(WDOG_ACTIVE, &wddev->status);
+	if (err == -ENOTSUPP) {
+		/*
+		 * Unstoppable watchdogs need the worker to keep them
+		 * alive. Ping it once as we don't know how much time
+		 * there is left in the watchdog timer and it will
+		 * take a while until the worker pings it.
+		 */
+		err = _watchdog_ping(wddev);
+		schedule_delayed_work(&wddev->work,
+				      msecs_to_jiffies(wddev->hw_heartbeat));
+		goto out_stop;
+	} else {
+		/*
+		 * in case there was some other failure to stop the
+		 * watchdog, return error and be prepared for a
+		 * watchdog reset..
+		 */
+		goto out_err_stop;
+	}
 
+	clear_bit(WDOG_ACTIVE, &wddev->status);
+
+out_err_stop:
 out_stop:
 	mutex_unlock(&wddev->lock);
 	return err;
@@ -194,14 +226,8 @@ out_status:
 static int watchdog_set_timeout(struct watchdog_device *wddev,
 							unsigned int timeout)
 {
-	int err;
-
-	if ((wddev->ops->set_timeout == NULL) ||
-	    !(wddev->info->options & WDIOF_SETTIMEOUT))
-		return -EOPNOTSUPP;
-
-	if (watchdog_timeout_invalid(wddev, timeout))
-		return -EINVAL;
+	int hw_timeout_sec;
+	int err = 0;
 
 	mutex_lock(&wddev->lock);
 
@@ -210,7 +236,46 @@ static int watchdog_set_timeout(struct watchdog_device *wddev,
 		goto out_timeout;
 	}
 
-	err = wddev->ops->set_timeout(wddev, timeout);
+	if (watchdog_needs_legacy_handling(wddev)) {
+		if ((wddev->ops->set_timeout == NULL) ||
+			!(wddev->info->options & WDIOF_SETTIMEOUT)) {
+			err = -EOPNOTSUPP;
+			goto out_timeout;
+		}
+
+		if (watchdog_timeout_invalid(wddev, timeout)) {
+			err = -EINVAL;
+			goto out_timeout;
+		}
+
+		err = wddev->ops->set_timeout(wddev, timeout);
+		goto out_timeout;
+	}
+
+	if (timeout < wddev->min_timeout)
+		return -EINVAL;
+
+	hw_timeout_sec = min(timeout, wddev->hw_max_timeout / 1000);
+	if (wddev->info->options & WDIOF_SETTIMEOUT)
+		err = wddev->ops->set_timeout(wddev, hw_timeout_sec);
+
+	if (timeout * 1000 > wddev->hw_max_timeout) {
+		/*
+		 * Worker heartbeat period might have changed, restart
+		 * the worker to ensure the next keepalive ping
+		 * happens at the right moment.
+		 */
+		cancel_delayed_work(&wddev->work);
+		schedule_delayed_work(&wddev->work,
+				msecs_to_jiffies(wddev->hw_heartbeat));
+	}
+
+	/*
+	 * The watchdog core emulates all timeouts that are longer
+	 * than what the HW is capable of.
+	 */
+	if (hw_timeout_sec < timeout)
+		wddev->timeout = timeout;
 
 out_timeout:
 	mutex_unlock(&wddev->lock);
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 5b84578..03f0553 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -12,6 +12,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/watchdog.h>
 
 struct watchdog_ops;
@@ -59,11 +60,14 @@ struct watchdog_ops {
  * @info:	Pointer to a watchdog_info structure.
  * @ops:	Pointer to the list of watchdog operations.
  * @bootstatus:	Status of the watchdog device at boot.
- * @timeout:	The watchdog devices timeout value.
+ * @timeout:	The watchdog devices timeout value for userspace, in seconds.
  * @min_timeout:The watchdog devices minimum timeout value.
- * @max_timeout:The watchdog devices maximum timeout value.
+ * @max_timeout:The watchdog devices maximum timeout value. DEPRECATED!
+ * @hw_max_timeout:The watchdog hardware maximum timeout value.
+ * @hw_heartbeat:Time interval in HW between timer pings.
  * @driver-data:Pointer to the drivers private data.
  * @lock:	Lock for watchdog core internal use only.
+ * @work:	Worker used to provide longer timeouts than hardware supports.
  * @status:	Field that contains the devices internal status bits.
  *
  * The watchdog_device structure contains all information about a
@@ -85,9 +89,13 @@ struct watchdog_device {
 	unsigned int bootstatus;
 	unsigned int timeout;
 	unsigned int min_timeout;
-	unsigned int max_timeout;
+	unsigned int max_timeout; /* DEPRECATED, do not use */
+	unsigned int hw_max_timeout; /* in msec */
+	unsigned int hw_heartbeat; /* in msec */
 	void *driver_data;
 	struct mutex lock;
+	struct delayed_work work;  /* keepalive worker */
+	unsigned long int expires; /* for keepalive worker */
 	unsigned long status;
 /* Bit numbers for status flags */
 #define WDOG_ACTIVE		0	/* Is the watchdog hw running/active */
@@ -106,6 +114,22 @@ static inline bool watchdog_hw_active(struct watchdog_device *wdd)
 	return test_bit(WDOG_ACTIVE, &wdd->status);
 }
 
+/* Use to test whether userspace has /dev/watchdog open */
+static inline bool watchdog_dev_open(struct watchdog_device *wdd)
+{
+	return test_bit(WDOG_DEV_OPEN, &wdd->status);
+}
+
+/*
+ * Test whether driver still expects legacy behavior from core. Once
+ * all drivers are converted, remove this function and all code
+ * depending on it.
+ */
+static inline bool watchdog_needs_legacy_handling(struct watchdog_device *wdd)
+{
+	return !wdd->hw_max_timeout;
+}
+
 /* Use the following function to set the nowayout feature */
 static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
 {
@@ -113,11 +137,30 @@ static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool noway
 		set_bit(WDOG_NO_WAY_OUT, &wdd->status);
 }
 
+/* Use for setting active flag */
+static inline void watchdog_set_hw_active(struct watchdog_device *wdd,
+					bool active)
+{
+	if (active)
+		set_bit(WDOG_ACTIVE, &wdd->status);
+	else
+		clear_bit(WDOG_ACTIVE, &wdd->status);
+}
+
 /* Use the following function to check if a timeout value is invalid */
 static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
 {
-	return ((wdd->max_timeout != 0) &&
-		(t < wdd->min_timeout || t > wdd->max_timeout));
+	if (!wdd->hw_max_timeout) {
+		/*
+		 * Legacy drivers still have meaningful
+		 * max_timeout. Newer drivers don't have maximum as
+		 * core can extend the timeout indefinitely
+		 */
+		return ((wdd->max_timeout != 0) &&
+			(t < wdd->min_timeout || t > wdd->max_timeout));
+	}
+
+	return t > wdd->min_timeout;
 }
 
 /* Use the following functions to manipulate watchdog driver specific data */
@@ -131,9 +174,20 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 	return wdd->driver_data;
 }
 
+static inline int _watchdog_ping(struct watchdog_device *wddev)
+{
+	if (wddev->ops->ping)
+		return wddev->ops->ping(wddev);  /* ping the watchdog */
+	else
+		return wddev->ops->start(wddev); /* restart watchdog */
+}
+
 /* drivers/watchdog/watchdog_core.c */
 extern int watchdog_init_timeout(struct watchdog_device *wdd,
 				  unsigned int timeout_parm, struct device *dev);
+int watchdog_init_params(struct watchdog_device *wdd, struct device *dev);
+int watchdog_start(struct watchdog_device *wddev);
+int watchdog_stop(struct watchdog_device *wddev);
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
-- 
2.1.0

