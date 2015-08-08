Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45969 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbbHHFC5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 8 Aug 2015 01:02:57 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/8] watchdog: watchdog_dev: Use single variable name for struct watchdog_device
Date: Fri,  7 Aug 2015 22:02:40 -0700
Message-Id: <1439010167-13818-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1439010167-13818-1-git-send-email-linux@roeck-us.net>
References: <1439010167-13818-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The current code uses 'wdd', wddev', and 'watchdog' as variable names
for struct watchdog_device. This is confusing and makes it difficult
to enhance the code. Replace it all with 'wdd'.

Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

---
v2: No changes
---
 drivers/watchdog/watchdog_dev.c | 151 ++++++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 76 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 6aaefbad303e..06171c73daf5 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -51,7 +51,7 @@ static struct watchdog_device *old_wdd;
 
 /*
  *	watchdog_ping: ping the watchdog.
- *	@wddev: the watchdog device to ping
+ *	@wdd: the watchdog device to ping
  *
  *	If the watchdog has no own ping operation then it needs to be
  *	restarted via the start operation. This wrapper function does
@@ -59,65 +59,65 @@ static struct watchdog_device *old_wdd;
  *	We only ping when the watchdog device is running.
  */
 
-static int watchdog_ping(struct watchdog_device *wddev)
+static int watchdog_ping(struct watchdog_device *wdd)
 {
 	int err = 0;
 
-	mutex_lock(&wddev->lock);
+	mutex_lock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
 		err = -ENODEV;
 		goto out_ping;
 	}
 
-	if (!watchdog_active(wddev))
+	if (!watchdog_active(wdd))
 		goto out_ping;
 
-	if (wddev->ops->ping)
-		err = wddev->ops->ping(wddev);  /* ping the watchdog */
+	if (wdd->ops->ping)
+		err = wdd->ops->ping(wdd);	/* ping the watchdog */
 	else
-		err = wddev->ops->start(wddev); /* restart watchdog */
+		err = wdd->ops->start(wdd);	/* restart watchdog */
 
 out_ping:
-	mutex_unlock(&wddev->lock);
+	mutex_unlock(&wdd->lock);
 	return err;
 }
 
 /*
  *	watchdog_start: wrapper to start the watchdog.
- *	@wddev: the watchdog device to start
+ *	@wdd: the watchdog device to start
  *
  *	Start the watchdog if it is not active and mark it active.
  *	This function returns zero on success or a negative errno code for
  *	failure.
  */
 
-static int watchdog_start(struct watchdog_device *wddev)
+static int watchdog_start(struct watchdog_device *wdd)
 {
 	int err = 0;
 
-	mutex_lock(&wddev->lock);
+	mutex_lock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
 		err = -ENODEV;
 		goto out_start;
 	}
 
-	if (watchdog_active(wddev))
+	if (watchdog_active(wdd))
 		goto out_start;
 
-	err = wddev->ops->start(wddev);
+	err = wdd->ops->start(wdd);
 	if (err == 0)
-		set_bit(WDOG_ACTIVE, &wddev->status);
+		set_bit(WDOG_ACTIVE, &wdd->status);
 
 out_start:
-	mutex_unlock(&wddev->lock);
+	mutex_unlock(&wdd->lock);
 	return err;
 }
 
 /*
  *	watchdog_stop: wrapper to stop the watchdog.
- *	@wddev: the watchdog device to stop
+ *	@wdd: the watchdog device to stop
  *
  *	Stop the watchdog if it is still active and unmark it active.
  *	This function returns zero on success or a negative errno code for
@@ -125,155 +125,154 @@ out_start:
  *	If the 'nowayout' feature was set, the watchdog cannot be stopped.
  */
 
-static int watchdog_stop(struct watchdog_device *wddev)
+static int watchdog_stop(struct watchdog_device *wdd)
 {
 	int err = 0;
 
-	mutex_lock(&wddev->lock);
+	mutex_lock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
 		err = -ENODEV;
 		goto out_stop;
 	}
 
-	if (!watchdog_active(wddev))
+	if (!watchdog_active(wdd))
 		goto out_stop;
 
-	if (test_bit(WDOG_NO_WAY_OUT, &wddev->status)) {
-		dev_info(wddev->dev, "nowayout prevents watchdog being stopped!\n");
+	if (test_bit(WDOG_NO_WAY_OUT, &wdd->status)) {
+		dev_info(wdd->dev, "nowayout prevents watchdog being stopped!\n");
 		err = -EBUSY;
 		goto out_stop;
 	}
 
-	err = wddev->ops->stop(wddev);
+	err = wdd->ops->stop(wdd);
 	if (err == 0)
-		clear_bit(WDOG_ACTIVE, &wddev->status);
+		clear_bit(WDOG_ACTIVE, &wdd->status);
 
 out_stop:
-	mutex_unlock(&wddev->lock);
+	mutex_unlock(&wdd->lock);
 	return err;
 }
 
 /*
  *	watchdog_get_status: wrapper to get the watchdog status
- *	@wddev: the watchdog device to get the status from
+ *	@wdd: the watchdog device to get the status from
  *	@status: the status of the watchdog device
  *
  *	Get the watchdog's status flags.
  */
 
-static int watchdog_get_status(struct watchdog_device *wddev,
+static int watchdog_get_status(struct watchdog_device *wdd,
 							unsigned int *status)
 {
 	int err = 0;
 
 	*status = 0;
-	if (!wddev->ops->status)
+	if (!wdd->ops->status)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&wddev->lock);
+	mutex_lock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
 		err = -ENODEV;
 		goto out_status;
 	}
 
-	*status = wddev->ops->status(wddev);
+	*status = wdd->ops->status(wdd);
 
 out_status:
-	mutex_unlock(&wddev->lock);
+	mutex_unlock(&wdd->lock);
 	return err;
 }
 
 /*
  *	watchdog_set_timeout: set the watchdog timer timeout
- *	@wddev: the watchdog device to set the timeout for
+ *	@wdd: the watchdog device to set the timeout for
  *	@timeout: timeout to set in seconds
  */
 
-static int watchdog_set_timeout(struct watchdog_device *wddev,
+static int watchdog_set_timeout(struct watchdog_device *wdd,
 							unsigned int timeout)
 {
 	int err;
 
-	if ((wddev->ops->set_timeout == NULL) ||
-	    !(wddev->info->options & WDIOF_SETTIMEOUT))
+	if (!wdd->ops->set_timeout || !(wdd->info->options & WDIOF_SETTIMEOUT))
 		return -EOPNOTSUPP;
 
-	if (watchdog_timeout_invalid(wddev, timeout))
+	if (watchdog_timeout_invalid(wdd, timeout))
 		return -EINVAL;
 
-	mutex_lock(&wddev->lock);
+	mutex_lock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
 		err = -ENODEV;
 		goto out_timeout;
 	}
 
-	err = wddev->ops->set_timeout(wddev, timeout);
+	err = wdd->ops->set_timeout(wdd, timeout);
 
 out_timeout:
-	mutex_unlock(&wddev->lock);
+	mutex_unlock(&wdd->lock);
 	return err;
 }
 
 /*
  *	watchdog_get_timeleft: wrapper to get the time left before a reboot
- *	@wddev: the watchdog device to get the remaining time from
+ *	@wdd: the watchdog device to get the remaining time from
  *	@timeleft: the time that's left
  *
  *	Get the time before a watchdog will reboot (if not pinged).
  */
 
-static int watchdog_get_timeleft(struct watchdog_device *wddev,
+static int watchdog_get_timeleft(struct watchdog_device *wdd,
 							unsigned int *timeleft)
 {
 	int err = 0;
 
 	*timeleft = 0;
-	if (!wddev->ops->get_timeleft)
+	if (!wdd->ops->get_timeleft)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&wddev->lock);
+	mutex_lock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
 		err = -ENODEV;
 		goto out_timeleft;
 	}
 
-	*timeleft = wddev->ops->get_timeleft(wddev);
+	*timeleft = wdd->ops->get_timeleft(wdd);
 
 out_timeleft:
-	mutex_unlock(&wddev->lock);
+	mutex_unlock(&wdd->lock);
 	return err;
 }
 
 /*
  *	watchdog_ioctl_op: call the watchdog drivers ioctl op if defined
- *	@wddev: the watchdog device to do the ioctl on
+ *	@wdd: the watchdog device to do the ioctl on
  *	@cmd: watchdog command
  *	@arg: argument pointer
  */
 
-static int watchdog_ioctl_op(struct watchdog_device *wddev, unsigned int cmd,
+static int watchdog_ioctl_op(struct watchdog_device *wdd, unsigned int cmd,
 							unsigned long arg)
 {
 	int err;
 
-	if (!wddev->ops->ioctl)
+	if (!wdd->ops->ioctl)
 		return -ENOIOCTLCMD;
 
-	mutex_lock(&wddev->lock);
+	mutex_lock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
 		err = -ENODEV;
 		goto out_ioctl;
 	}
 
-	err = wddev->ops->ioctl(wddev, cmd, arg);
+	err = wdd->ops->ioctl(wdd, cmd, arg);
 
 out_ioctl:
-	mutex_unlock(&wddev->lock);
+	mutex_unlock(&wdd->lock);
 	return err;
 }
 
@@ -513,43 +512,43 @@ static struct miscdevice watchdog_miscdev = {
 
 /*
  *	watchdog_dev_register: register a watchdog device
- *	@watchdog: watchdog device
+ *	@wdd: watchdog device
  *
  *	Register a watchdog device including handling the legacy
  *	/dev/watchdog node. /dev/watchdog is actually a miscdevice and
  *	thus we set it up like that.
  */
 
-int watchdog_dev_register(struct watchdog_device *watchdog)
+int watchdog_dev_register(struct watchdog_device *wdd)
 {
 	int err, devno;
 
-	if (watchdog->id == 0) {
-		old_wdd = watchdog;
-		watchdog_miscdev.parent = watchdog->parent;
+	if (wdd->id == 0) {
+		old_wdd = wdd;
+		watchdog_miscdev.parent = wdd->parent;
 		err = misc_register(&watchdog_miscdev);
 		if (err != 0) {
 			pr_err("%s: cannot register miscdev on minor=%d (err=%d).\n",
-				watchdog->info->identity, WATCHDOG_MINOR, err);
+				wdd->info->identity, WATCHDOG_MINOR, err);
 			if (err == -EBUSY)
 				pr_err("%s: a legacy watchdog module is probably present.\n",
-					watchdog->info->identity);
+					wdd->info->identity);
 			old_wdd = NULL;
 			return err;
 		}
 	}
 
 	/* Fill in the data structures */
-	devno = MKDEV(MAJOR(watchdog_devt), watchdog->id);
-	cdev_init(&watchdog->cdev, &watchdog_fops);
-	watchdog->cdev.owner = watchdog->ops->owner;
+	devno = MKDEV(MAJOR(watchdog_devt), wdd->id);
+	cdev_init(&wdd->cdev, &watchdog_fops);
+	wdd->cdev.owner = wdd->ops->owner;
 
 	/* Add the device */
-	err  = cdev_add(&watchdog->cdev, devno, 1);
+	err  = cdev_add(&wdd->cdev, devno, 1);
 	if (err) {
 		pr_err("watchdog%d unable to add device %d:%d\n",
-			watchdog->id,  MAJOR(watchdog_devt), watchdog->id);
-		if (watchdog->id == 0) {
+			wdd->id,  MAJOR(watchdog_devt), wdd->id);
+		if (wdd->id == 0) {
 			misc_deregister(&watchdog_miscdev);
 			old_wdd = NULL;
 		}
@@ -564,14 +563,14 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
  *	Unregister the watchdog and if needed the legacy /dev/watchdog device.
  */
 
-int watchdog_dev_unregister(struct watchdog_device *watchdog)
+int watchdog_dev_unregister(struct watchdog_device *wdd)
 {
-	mutex_lock(&watchdog->lock);
-	set_bit(WDOG_UNREGISTERED, &watchdog->status);
-	mutex_unlock(&watchdog->lock);
+	mutex_lock(&wdd->lock);
+	set_bit(WDOG_UNREGISTERED, &wdd->status);
+	mutex_unlock(&wdd->lock);
 
-	cdev_del(&watchdog->cdev);
-	if (watchdog->id == 0) {
+	cdev_del(&wdd->cdev);
+	if (wdd->id == 0) {
 		misc_deregister(&watchdog_miscdev);
 		old_wdd = NULL;
 	}
-- 
2.1.4

