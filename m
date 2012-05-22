Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46646 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757318Ab2EVJk3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 May 2012 05:40:29 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/4] watchdog_dev: Add support for dynamically allocated watchdog_device structs
Date: Tue, 22 May 2012 11:40:26 +0200
Message-Id: <1337679627-21980-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1337679627-21980-1-git-send-email-hdegoede@redhat.com>
References: <1337679627-21980-1-git-send-email-hdegoede@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If a driver's watchdog_device struct is part of a dynamically allocated
struct (which it often will be), merely locking the module is not enough,
even with a drivers module locked, the driver can be unbound from the device,
examples:
1) The root user can unbind it through sysfd
2) The i2c bus master driver being unloaded for an i2c watchdog

I will gladly admit that these are corner cases, but we still need to handle
them correctly.

The fix for this consists of 2 parts:
1) Add ref / unref operations, so that the driver can refcount the struct
   holding the watchdog_device struct and delay freeing it until any
   open filehandles referring to it are closed
2) Most driver operations will do IO on the device and the driver should not
   do any IO on the device after it has been unbound. Rather then letting each
   driver deal with this internally, it is better to ensure at the watchdog
   core level that no operations (other then unref) will get called after
   the driver has called watchdog_unregister_device(). This actually is the
   bulk of this patch.

This patch also fixes some potential multithreading issues, despite only
allowing one process to open the /dev/watchdog device, we can still get
called multiple times at the same time, since a program could be using thread,
or could share the fd after a fork.

This causes 2 potential problems:
1) watchdog_start / open do an unlocked test_n_set / test_n_clear,
   if these 2 race, the watchdog could be stopped while the active
   bit indicates it is running or visa versa.

2) Most watchdog_dev drivers probably assume that only one
   watchdog-op will get called at a time, this is not necessary
   true atm.

Both of these issues are also addressed by this patch.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/watchdog/watchdog-kernel-api.txt |   24 ++++
 drivers/watchdog/watchdog_dev.c                |  172 ++++++++++++++++++++----
 include/linux/watchdog.h                       |    8 ++
 3 files changed, 180 insertions(+), 24 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 624f547..a23cfca 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -45,6 +45,7 @@ struct watchdog_device {
 	struct device *parent;
 	const struct watchdog_info *info;
 	const struct watchdog_ops *ops;
+	struct mutex lock;
 	unsigned int bootstatus;
 	unsigned int timeout;
 	unsigned int min_timeout;
@@ -66,6 +67,7 @@ It contains following fields:
 * info: a pointer to a watchdog_info structure. This structure gives some
   additional information about the watchdog timer itself. (Like it's unique name)
 * ops: a pointer to the list of watchdog operations that the watchdog supports.
+* lock: Mutex for WatchDog Timer Driver Core internal use only.
 * timeout: the watchdog timer's timeout value (in seconds).
 * min_timeout: the watchdog timer's minimum timeout value (in seconds).
 * max_timeout: the watchdog timer's maximum timeout value (in seconds).
@@ -87,6 +89,8 @@ struct watchdog_ops {
 	int (*start)(struct watchdog_device *);
 	int (*stop)(struct watchdog_device *);
 	/* optional operations */
+	void (*ref)(struct watchdog_device *);
+	void (*unref)(struct watchdog_device *);
 	int (*ping)(struct watchdog_device *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
@@ -98,6 +102,21 @@ It is important that you first define the module owner of the watchdog timer
 driver's operations. This module owner will be used to lock the module when
 the watchdog is active. (This to avoid a system crash when you unload the
 module and /dev/watchdog is still open).
+
+If the watchdog_device struct is dynamically allocated, just locking the module
+is not enough and a driver also needs to define the ref and unref operations to
+ensure the structure holding the watchdog_device does not go away.
+
+The simplest (and usually sufficient) implementation of this is to:
+1) Add a kref struct to the same structure which is holding the watchdog_device
+2) Define a release callback for the kref which frees the struct holding both
+3) Call kref_init on this kref *before* calling watchdog_register_device()
+4) Define a ref operation calling kref_get on this kref
+5) Define a unref operation calling kref_put on this kref
+6) When it is time to cleanup:
+ * Do not kfree() the struct holding both, the last kref_put will do this!
+ * *After* calling watchdog_unregister_device() call kref_put on the kref
+
 Some operations are mandatory and some are optional. The mandatory operations
 are:
 * start: this is a pointer to the routine that starts the watchdog timer
@@ -157,6 +176,11 @@ bit-operations. The status bits that are defined are:
   (This bit should only be used by the WatchDog Timer Driver Core).
 * WDOG_NO_WAY_OUT: this bit stores the nowayout setting for the watchdog.
   If this bit is set then the watchdog timer will not be able to stop.
+* WDOG_UNREGISTERED: this bit gets set by the WatchDog Timer Driver Core
+  after calling watchdog_unregister_device, and then checked before calling
+  any watchdog_ops, so that you can be sure that no operations (other then
+  unref) will get called after unregister, even if userspace still holds a
+  reference to /dev/watchdog
 
   To set the WDOG_NO_WAY_OUT status bit (before registering your watchdog
   timer device) you can either:
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ba90769..f1e7b92 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -61,13 +61,24 @@ static struct watchdog_device *old_wdd;
 
 static int watchdog_ping(struct watchdog_device *wddev)
 {
+	int err = 0;
+
+	mutex_lock(&wddev->lock);
+
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		err = -ENODEV;
+		goto leave;
+	}
+
 	if (test_bit(WDOG_ACTIVE, &wddev->status)) {
 		if (wddev->ops->ping)
-			return wddev->ops->ping(wddev);  /* ping the watchdog */
+			err = wddev->ops->ping(wddev);  /* ping the watchdog */
 		else
-			return wddev->ops->start(wddev); /* restart watchdog */
+			err = wddev->ops->start(wddev); /* restart watchdog */
 	}
-	return 0;
+leave:
+	mutex_unlock(&wddev->lock);
+	return err;
 }
 
 /*
@@ -81,16 +92,25 @@ static int watchdog_ping(struct watchdog_device *wddev)
 
 static int watchdog_start(struct watchdog_device *wddev)
 {
-	int err;
+	int err = 0;
+
+	mutex_lock(&wddev->lock);
+
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		err = -ENODEV;
+		goto leave;
+	}
 
 	if (!test_bit(WDOG_ACTIVE, &wddev->status)) {
 		err = wddev->ops->start(wddev);
 		if (err < 0)
-			return err;
+			goto leave;
 
 		set_bit(WDOG_ACTIVE, &wddev->status);
 	}
-	return 0;
+leave:
+	mutex_unlock(&wddev->lock);
+	return err;
 }
 
 /*
@@ -105,21 +125,116 @@ static int watchdog_start(struct watchdog_device *wddev)
 
 static int watchdog_stop(struct watchdog_device *wddev)
 {
-	int err = -EBUSY;
+	int err = 0;
+
+	mutex_lock(&wddev->lock);
+
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		err = -ENODEV;
+		goto leave;
+	}
 
 	if (test_bit(WDOG_NO_WAY_OUT, &wddev->status)) {
 		dev_info(wddev->dev, "nowayout prevents watchdog being stopped!\n");
-		return err;
+		err = -EBUSY;
+		goto leave;
 	}
 
 	if (test_bit(WDOG_ACTIVE, &wddev->status)) {
 		err = wddev->ops->stop(wddev);
 		if (err < 0)
-			return err;
+			goto leave;
 
 		clear_bit(WDOG_ACTIVE, &wddev->status);
 	}
-	return 0;
+leave:
+	mutex_unlock(&wddev->lock);
+	return err;
+}
+
+/*
+ *	watchdog_ioctl_op: call the watchdog drivers ioctl op if defined
+ *	@wddev: the watchdog device to do the ioctl on
+ *	@cmd: watchdog command
+ *	@arg: argument pointer
+ */
+
+static int watchdog_ioctl_op(struct watchdog_device *wddev, unsigned int cmd,
+					unsigned long arg)
+{
+	int err;
+
+	if (!wddev->ops->ioctl)
+		return -ENOIOCTLCMD;
+
+	mutex_lock(&wddev->lock);
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		err = -ENODEV;
+		goto leave;
+	}
+
+	err = wddev->ops->ioctl(wddev, cmd, arg);
+leave:
+	mutex_unlock(&wddev->lock);
+	return err;
+}
+
+/*
+ *	watchdog_get_status: get the watchdog status
+ *	@wddev: the watchdog device to get the status from
+ */
+
+static int watchdog_get_status(struct watchdog_device *wddev,
+					unsigned int *status)
+{
+	int err = 0;
+
+	*status = 0;
+	if (!wddev->ops->status)
+		return 0;
+
+	mutex_lock(&wddev->lock);
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		err = -ENODEV;
+		goto leave;
+	}
+
+	*status = wddev->ops->status(wddev);
+leave:
+	mutex_unlock(&wddev->lock);
+	return err;
+}
+
+/*
+ *	watchdog_set_timeout: set the watchdog timer timeout
+ *	@wddev: the watchdog device to set the timeout for
+ *	@timeout: timeout to set in seconds
+ *	@arg: argument pointer
+ */
+
+static int watchdog_set_timeout(struct watchdog_device *wddev,
+					unsigned int timeout)
+{
+	int err;
+
+	if ((wddev->ops->set_timeout == NULL) ||
+	    !(wddev->info->options & WDIOF_SETTIMEOUT))
+		return -EOPNOTSUPP;
+
+	if ((wddev->max_timeout != 0) &&
+	    (timeout < wddev->min_timeout || timeout > wddev->max_timeout))
+		return -EINVAL;
+
+	mutex_lock(&wddev->lock);
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		err = -ENODEV;
+		goto leave;
+	}
+
+	err = wddev->ops->set_timeout(wddev, timeout);
+leave:
+	mutex_unlock(&wddev->lock);
+	return err;
 }
 
 /*
@@ -183,18 +298,18 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 	unsigned int val;
 	int err;
 
-	if (wdd->ops->ioctl) {
-		err = wdd->ops->ioctl(wdd, cmd, arg);
-		if (err != -ENOIOCTLCMD)
-			return err;
-	}
+	err = watchdog_ioctl_op(wdd, cmd, arg);
+	if (err != -ENOIOCTLCMD)
+		return err;
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
 		return copy_to_user(argp, wdd->info,
 			sizeof(struct watchdog_info)) ? -EFAULT : 0;
 	case WDIOC_GETSTATUS:
-		val = wdd->ops->status ? wdd->ops->status(wdd) : 0;
+		err = watchdog_get_status(wdd, &val);
+		if (err)
+			return err;
 		return put_user(val, p);
 	case WDIOC_GETBOOTSTATUS:
 		return put_user(wdd->bootstatus, p);
@@ -218,15 +333,9 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 		watchdog_ping(wdd);
 		return 0;
 	case WDIOC_SETTIMEOUT:
-		if ((wdd->ops->set_timeout == NULL) ||
-		    !(wdd->info->options & WDIOF_SETTIMEOUT))
-			return -EOPNOTSUPP;
 		if (get_user(val, p))
 			return -EFAULT;
-		if ((wdd->max_timeout != 0) &&
-		    (val < wdd->min_timeout || val > wdd->max_timeout))
-				return -EINVAL;
-		err = wdd->ops->set_timeout(wdd, val);
+		err = watchdog_set_timeout(wdd, val);
 		if (err < 0)
 			return err;
 		/* If the watchdog is active then we send a keepalive ping
@@ -286,6 +395,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 		goto out_mod;
 
 	file->private_data = wdd;
+	if (wdd->ops->ref)
+		wdd->ops->ref(wdd);
 
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
 	return nonseekable_open(inode, file);
@@ -323,7 +434,10 @@ static int watchdog_release(struct inode *inode, struct file *file)
 
 	/* If the watchdog was not stopped, send a keepalive ping */
 	if (err < 0) {
-		dev_crit(wdd->dev, "watchdog did not stop!\n");
+		mutex_lock(&wdd->lock);
+		if (!test_bit(WDOG_UNREGISTERED, &wdd->status))
+			dev_crit(wdd->dev, "watchdog did not stop!\n");
+		mutex_unlock(&wdd->lock);
 		watchdog_ping(wdd);
 	}
 
@@ -333,6 +447,10 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	/* make sure that /dev/watchdog can be re-opened */
 	clear_bit(WDOG_DEV_OPEN, &wdd->status);
 
+	/* Note wdd may be gone after this, do not use after this! */
+	if (wdd->ops->unref)
+		wdd->ops->unref(wdd);
+
 	return 0;
 }
 
@@ -363,6 +481,8 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
 {
 	int err, devno;
 
+	mutex_init(&watchdog->lock);
+
 	if (watchdog->id == 0) {
 		watchdog_miscdev.parent = watchdog->parent;
 		err = misc_register(&watchdog_miscdev);
@@ -404,6 +524,10 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
 
 int watchdog_dev_unregister(struct watchdog_device *watchdog)
 {
+	mutex_lock(&watchdog->lock);
+	set_bit(WDOG_UNREGISTERED, &watchdog->status);
+	mutex_unlock(&watchdog->lock);
+
 	cdev_del(&watchdog->cdev);
 	if (watchdog->id == 0) {
 		misc_deregister(&watchdog_miscdev);
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 779849d..6672509 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -84,6 +84,8 @@ struct watchdog_ops {
 	int (*start)(struct watchdog_device *);
 	int (*stop)(struct watchdog_device *);
 	/* optional operations */
+	void (*ref)(struct watchdog_device *);
+	void (*unref)(struct watchdog_device *);
 	int (*ping)(struct watchdog_device *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
@@ -99,6 +101,7 @@ struct watchdog_ops {
  * @parent:	The parent bus device
  * @info:	Pointer to a watchdog_info structure.
  * @ops:	Pointer to the list of watchdog operations.
+ * @lock:       Lock for watchdog core internal use only.
  * @bootstatus:	Status of the watchdog device at boot.
  * @timeout:	The watchdog devices timeout value.
  * @min_timeout:The watchdog devices minimum timeout value.
@@ -111,6 +114,9 @@ struct watchdog_ops {
  *
  * The driver-data field may not be accessed directly. It must be accessed
  * via the watchdog_set_drvdata and watchdog_get_drvdata helpers.
+ *
+ * The lock field is for watchdog core internal use only and should not be
+ * touched.
  */
 struct watchdog_device {
 	int id;
@@ -119,6 +125,7 @@ struct watchdog_device {
 	struct device *parent;
 	const struct watchdog_info *info;
 	const struct watchdog_ops *ops;
+	struct mutex lock;
 	unsigned int bootstatus;
 	unsigned int timeout;
 	unsigned int min_timeout;
@@ -130,6 +137,7 @@ struct watchdog_device {
 #define WDOG_DEV_OPEN		1	/* Opened via /dev/watchdog ? */
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
+#define WDOG_UNREGISTERED	4	/* The device has been unregistered */
 };
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
-- 
1.7.10

