Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Pratyush Anand <panand@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/5] watchdog: Separate and maintain variables based on variable lifetime
Date: Sun, 20 Dec 2015 13:05:00 -0800
Message-Id: <1450645503-16661-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1450645503-16661-1-git-send-email-linux@roeck-us.net>
References: <1450645503-16661-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

All variables required by the watchdog core to manage a watchdog are
currently stored in struct watchdog_device. The lifetime of those
variables is determined by the watchdog driver. However, the lifetime
of variables used by the watchdog core differs from the lifetime of
struct watchdog_device. To remedy this situation, watchdog drivers
can implement ref and unref callbacks, to be used by the watchdog
core to lock struct watchdog_device in memory.

While this solves the immediate problem, it depends on watchdog drivers
to actually implement the ref/unref callbacks. This is error prone,
often not implemented in the first place, or not implemented correctly.

To solve the problem without requiring driver support, split the variables
in struct watchdog_device into two data structures - one for variables
associated with the watchdog driver, one for variables associated with
the watchdog core. With this approach, the watchdog core can keep track
of its variable lifetime and no longer depends on ref/unref callbacks
in the driver. As a side effect, some of the variables originally in
struct watchdog_driver are now private to the watchdog core and no longer
visible in watchdog drivers.

The 'ref' and 'unref' callbacks in struct watchdog_driver are no longer
used and marked as deprecated.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/watchdog/watchdog-kernel-api.txt |  45 +--
 drivers/watchdog/watchdog_core.c               |   2 -
 drivers/watchdog/watchdog_core.h               |  23 ++
 drivers/watchdog/watchdog_dev.c                | 377 +++++++++++++------------
 include/linux/watchdog.h                       |  21 +-
 5 files changed, 239 insertions(+), 229 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 0a37da76acef..3db5092924e5 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -44,7 +44,6 @@ The watchdog device structure looks like this:
 
 struct watchdog_device {
 	int id;
-	struct cdev cdev;
 	struct device *dev;
 	struct device *parent;
 	const struct watchdog_info *info;
@@ -56,7 +55,7 @@ struct watchdog_device {
 	struct notifier_block reboot_nb;
 	struct notifier_block restart_nb;
 	void *driver_data;
-	struct mutex lock;
+	void *wdd_data;
 	unsigned long status;
 	struct list_head deferred;
 };
@@ -66,8 +65,6 @@ It contains following fields:
   /dev/watchdog0 cdev (dynamic major, minor 0) as well as the old
   /dev/watchdog miscdev. The id is set automatically when calling
   watchdog_register_device.
-* cdev: cdev for the dynamic /dev/watchdog<id> device nodes. This
-  field is also populated by watchdog_register_device.
 * dev: device under the watchdog class (created by watchdog_register_device).
 * parent: set this to the parent device (or NULL) before calling
   watchdog_register_device.
@@ -89,11 +86,10 @@ It contains following fields:
 * driver_data: a pointer to the drivers private data of a watchdog device.
   This data should only be accessed via the watchdog_set_drvdata and
   watchdog_get_drvdata routines.
-* lock: Mutex for WatchDog Timer Driver Core internal use only.
+* wdd_data: a pointer to watchdog core internal data.
 * status: this field contains a number of status bits that give extra
   information about the status of the device (Like: is the watchdog timer
-  running/active, is the nowayout bit set, is the device opened via
-  the /dev/watchdog interface or not, ...).
+  running/active, or is the nowayout bit set).
 * deferred: entry in wtd_deferred_reg_list which is used to
   register early initialized watchdogs.
 
@@ -110,8 +106,8 @@ struct watchdog_ops {
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
 	int (*restart)(struct watchdog_device *);
-	void (*ref)(struct watchdog_device *);
-	void (*unref)(struct watchdog_device *);
+	void (*ref)(struct watchdog_device *) __deprecated;
+	void (*unref)(struct watchdog_device *) __deprecated;
 	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
 };
 
@@ -120,20 +116,6 @@ driver's operations. This module owner will be used to lock the module when
 the watchdog is active. (This to avoid a system crash when you unload the
 module and /dev/watchdog is still open).
 
-If the watchdog_device struct is dynamically allocated, just locking the module
-is not enough and a driver also needs to define the ref and unref operations to
-ensure the structure holding the watchdog_device does not go away.
-
-The simplest (and usually sufficient) implementation of this is to:
-1) Add a kref struct to the same structure which is holding the watchdog_device
-2) Define a release callback for the kref which frees the struct holding both
-3) Call kref_init on this kref *before* calling watchdog_register_device()
-4) Define a ref operation calling kref_get on this kref
-5) Define a unref operation calling kref_put on this kref
-6) When it is time to cleanup:
- * Do not kfree() the struct holding both, the last kref_put will do this!
- * *After* calling watchdog_unregister_device() call kref_put on the kref
-
 Some operations are mandatory and some are optional. The mandatory operations
 are:
 * start: this is a pointer to the routine that starts the watchdog timer
@@ -176,34 +158,21 @@ they are supported. These optional routines/operations are:
 * get_timeleft: this routines returns the time that's left before a reset.
 * restart: this routine restarts the machine. It returns 0 on success or a
   negative errno code for failure.
-* ref: the operation that calls kref_get on the kref of a dynamically
-  allocated watchdog_device struct.
-* unref: the operation that calls kref_put on the kref of a dynamically
-  allocated watchdog_device struct.
 * ioctl: if this routine is present then it will be called first before we do
   our own internal ioctl call handling. This routine should return -ENOIOCTLCMD
   if a command is not supported. The parameters that are passed to the ioctl
   call are: watchdog_device, cmd and arg.
 
+The 'ref' and 'unref' operations are no longer used and deprecated.
+
 The status bits should (preferably) be set with the set_bit and clear_bit alike
 bit-operations. The status bits that are defined are:
 * WDOG_ACTIVE: this status bit indicates whether or not a watchdog timer device
   is active or not. When the watchdog is active after booting, then you should
   set this status bit (Note: when you register the watchdog timer device with
   this bit set, then opening /dev/watchdog will skip the start operation)
-* WDOG_DEV_OPEN: this status bit shows whether or not the watchdog device
-  was opened via /dev/watchdog.
-  (This bit should only be used by the WatchDog Timer Driver Core).
-* WDOG_ALLOW_RELEASE: this bit stores whether or not the magic close character
-  has been sent (so that we can support the magic close feature).
-  (This bit should only be used by the WatchDog Timer Driver Core).
 * WDOG_NO_WAY_OUT: this bit stores the nowayout setting for the watchdog.
   If this bit is set then the watchdog timer will not be able to stop.
-* WDOG_UNREGISTERED: this bit gets set by the WatchDog Timer Driver Core
-  after calling watchdog_unregister_device, and then checked before calling
-  any watchdog_ops, so that you can be sure that no operations (other then
-  unref) will get called after unregister, even if userspace still holds a
-  reference to /dev/watchdog
 
   To set the WDOG_NO_WAY_OUT status bit (before registering your watchdog
   timer device) you can either:
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index f0293f7d2b80..ec1ab6c1a80b 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -210,8 +210,6 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 	 * corrupted in a later stage then we expect a kernel panic!
 	 */
 
-	mutex_init(&wdd->lock);
-
 	/* Use alias for watchdog id if possible */
 	if (wdd->parent) {
 		ret = of_alias_get_id(wdd->parent->of_node, "watchdog");
diff --git a/drivers/watchdog/watchdog_core.h b/drivers/watchdog/watchdog_core.h
index 86ff962d1e15..c9b0656284de 100644
--- a/drivers/watchdog/watchdog_core.h
+++ b/drivers/watchdog/watchdog_core.h
@@ -26,9 +26,32 @@
  *	This material is provided "AS-IS" and at no charge.
  */
 
+#include <linux/cdev.h>
+#include <linux/kref.h>
+#include <linux/mutex.h>
+#include <linux/watchdog.h>
+
 #define MAX_DOGS	32	/* Maximum number of watchdog devices */
 
 /*
+ * struct _watchdog_device - watchdog core internal data
+ * @kref:	Reference count.
+ * @cdev:	The watchdog's Character device.
+ * @wdd:	Pointer to watchdog device.
+ * @lock:	Lock for watchdog core.
+ * @status:	Watchdog core internal status bits.
+ */
+struct _watchdog_device {
+	struct kref kref;
+	struct cdev cdev;
+	struct watchdog_device *wdd;
+	struct mutex lock;
+	unsigned long status;		/* Internal status bits */
+#define _WDOG_DEV_OPEN		0	/* Opened ? */
+#define _WDOG_ALLOW_RELEASE	1	/* Did we receive the magic char ? */
+};
+
+/*
  *	Functions/procedures to be called by the core
  */
 extern int watchdog_dev_register(struct watchdog_device *);
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index c24392623e98..e8416bdc7037 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -37,6 +37,7 @@
 #include <linux/errno.h>	/* For the -ENODEV/... values */
 #include <linux/kernel.h>	/* For printk/panic/... */
 #include <linux/fs.h>		/* For file operations */
+#include <linux/slab.h>		/* For memory functions */
 #include <linux/watchdog.h>	/* For watchdog specific items */
 #include <linux/miscdevice.h>	/* For handling misc devices */
 #include <linux/init.h>		/* For __init/__exit/... */
@@ -47,12 +48,14 @@
 /* the dev_t structure to store the dynamically allocated watchdog devices */
 static dev_t watchdog_devt;
 /* the watchdog device behind /dev/watchdog */
-static struct watchdog_device *old_wdd;
+static struct _watchdog_device *_old_wdd;
 
 /*
  *	watchdog_ping: ping the watchdog.
  *	@wdd: the watchdog device to ping
  *
+ *	The caller must hold _wdd->lock.
+ *
  *	If the watchdog has no own ping operation then it needs to be
  *	restarted via the start operation. This wrapper function does
  *	exactly that.
@@ -61,25 +64,37 @@ static struct watchdog_device *old_wdd;
 
 static int watchdog_ping(struct watchdog_device *wdd)
 {
-	int err = 0;
-
-	mutex_lock(&wdd->lock);
-
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_ping;
-	}
+	int err;
 
 	if (!watchdog_active(wdd))
-		goto out_ping;
+		return 0;
 
 	if (wdd->ops->ping)
 		err = wdd->ops->ping(wdd);	/* ping the watchdog */
 	else
 		err = wdd->ops->start(wdd);	/* restart watchdog */
 
-out_ping:
-	mutex_unlock(&wdd->lock);
+	return err;
+}
+
+/*
+ *	_watchdog_ping: ping the watchdog.
+ *	@_wdd: Watchdog core device data
+ *
+ *	Acquire _wdd->lock and call watchdog_ping() unless the watchdog
+ *	driver has been unregistered.
+ */
+static int _watchdog_ping(struct _watchdog_device *_wdd)
+{
+	struct watchdog_device *wdd;
+	int err = -ENODEV;
+
+	mutex_lock(&_wdd->lock);
+	wdd = _wdd->wdd;
+	if (wdd)
+		err = watchdog_ping(wdd);
+	mutex_unlock(&_wdd->lock);
+
 	return err;
 }
 
@@ -87,6 +102,8 @@ out_ping:
  *	watchdog_start: wrapper to start the watchdog.
  *	@wdd: the watchdog device to start
  *
+ *	The caller must hold _wdd->lock.
+ *
  *	Start the watchdog if it is not active and mark it active.
  *	This function returns zero on success or a negative errno code for
  *	failure.
@@ -94,24 +111,15 @@ out_ping:
 
 static int watchdog_start(struct watchdog_device *wdd)
 {
-	int err = 0;
-
-	mutex_lock(&wdd->lock);
-
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_start;
-	}
+	int err;
 
 	if (watchdog_active(wdd))
-		goto out_start;
+		return 0;
 
 	err = wdd->ops->start(wdd);
 	if (err == 0)
 		set_bit(WDOG_ACTIVE, &wdd->status);
 
-out_start:
-	mutex_unlock(&wdd->lock);
 	return err;
 }
 
@@ -119,6 +127,8 @@ out_start:
  *	watchdog_stop: wrapper to stop the watchdog.
  *	@wdd: the watchdog device to stop
  *
+ *	The caller must hold _wdd->lock.
+ *
  *	Stop the watchdog if it is still active and unmark it active.
  *	This function returns zero on success or a negative errno code for
  *	failure.
@@ -127,93 +137,58 @@ out_start:
 
 static int watchdog_stop(struct watchdog_device *wdd)
 {
-	int err = 0;
-
-	mutex_lock(&wdd->lock);
-
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_stop;
-	}
+	int err;
 
 	if (!watchdog_active(wdd))
-		goto out_stop;
+		return 0;
 
 	if (test_bit(WDOG_NO_WAY_OUT, &wdd->status)) {
 		dev_info(wdd->dev, "nowayout prevents watchdog being stopped!\n");
-		err = -EBUSY;
-		goto out_stop;
+		return -EBUSY;
 	}
 
 	err = wdd->ops->stop(wdd);
 	if (err == 0)
 		clear_bit(WDOG_ACTIVE, &wdd->status);
 
-out_stop:
-	mutex_unlock(&wdd->lock);
 	return err;
 }
 
 /*
  *	watchdog_get_status: wrapper to get the watchdog status
  *	@wdd: the watchdog device to get the status from
- *	@status: the status of the watchdog device
+ *
+ *	The caller must hold _wdd->lock.
  *
  *	Get the watchdog's status flags.
  */
 
-static int watchdog_get_status(struct watchdog_device *wdd,
-							unsigned int *status)
+static unsigned int watchdog_get_status(struct watchdog_device *wdd)
 {
-	int err = 0;
-
-	*status = 0;
 	if (!wdd->ops->status)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&wdd->lock);
-
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_status;
-	}
-
-	*status = wdd->ops->status(wdd);
+		return 0;
 
-out_status:
-	mutex_unlock(&wdd->lock);
-	return err;
+	return wdd->ops->status(wdd);
 }
 
 /*
  *	watchdog_set_timeout: set the watchdog timer timeout
  *	@wdd: the watchdog device to set the timeout for
  *	@timeout: timeout to set in seconds
+ *
+ *	The caller must hold _wdd->lock.
  */
 
 static int watchdog_set_timeout(struct watchdog_device *wdd,
 							unsigned int timeout)
 {
-	int err;
-
 	if (!wdd->ops->set_timeout || !(wdd->info->options & WDIOF_SETTIMEOUT))
 		return -EOPNOTSUPP;
 
 	if (watchdog_timeout_invalid(wdd, timeout))
 		return -EINVAL;
 
-	mutex_lock(&wdd->lock);
-
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_timeout;
-	}
-
-	err = wdd->ops->set_timeout(wdd, timeout);
-
-out_timeout:
-	mutex_unlock(&wdd->lock);
-	return err;
+	return wdd->ops->set_timeout(wdd, timeout);
 }
 
 /*
@@ -221,30 +196,22 @@ out_timeout:
  *	@wdd: the watchdog device to get the remaining time from
  *	@timeleft: the time that's left
  *
+ *	The caller must hold _wdd->lock.
+ *
  *	Get the time before a watchdog will reboot (if not pinged).
  */
 
 static int watchdog_get_timeleft(struct watchdog_device *wdd,
 							unsigned int *timeleft)
 {
-	int err = 0;
-
 	*timeleft = 0;
+
 	if (!wdd->ops->get_timeleft)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&wdd->lock);
-
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_timeleft;
-	}
-
 	*timeleft = wdd->ops->get_timeleft(wdd);
 
-out_timeleft:
-	mutex_unlock(&wdd->lock);
-	return err;
+	return 0;
 }
 
 #ifdef CONFIG_WATCHDOG_SYSFS
@@ -261,14 +228,14 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
-	ssize_t status;
-	unsigned int val;
+	struct _watchdog_device *_wdd = wdd->wdd_data;
+	unsigned int status;
 
-	status = watchdog_get_status(wdd, &val);
-	if (!status)
-		status = sprintf(buf, "%u\n", val);
+	mutex_lock(&_wdd->lock);
+	status = watchdog_get_status(wdd);
+	mutex_unlock(&_wdd->lock);
 
-	return status;
+	return sprintf(buf, "%u\n", status);
 }
 static DEVICE_ATTR_RO(status);
 
@@ -285,10 +252,13 @@ static ssize_t timeleft_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
+	struct _watchdog_device *_wdd = wdd->wdd_data;
 	ssize_t status;
 	unsigned int val;
 
+	mutex_lock(&_wdd->lock);
 	status = watchdog_get_timeleft(wdd, &val);
+	mutex_unlock(&_wdd->lock);
 	if (!status)
 		status = sprintf(buf, "%u\n", val);
 
@@ -363,28 +333,17 @@ __ATTRIBUTE_GROUPS(wdt);
  *	@wdd: the watchdog device to do the ioctl on
  *	@cmd: watchdog command
  *	@arg: argument pointer
+ *
+ *	The caller must hold _wdd->lock.
  */
 
 static int watchdog_ioctl_op(struct watchdog_device *wdd, unsigned int cmd,
 							unsigned long arg)
 {
-	int err;
-
 	if (!wdd->ops->ioctl)
 		return -ENOIOCTLCMD;
 
-	mutex_lock(&wdd->lock);
-
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_ioctl;
-	}
-
-	err = wdd->ops->ioctl(wdd, cmd, arg);
-
-out_ioctl:
-	mutex_unlock(&wdd->lock);
-	return err;
+	return wdd->ops->ioctl(wdd, cmd, arg);
 }
 
 /*
@@ -402,7 +361,7 @@ out_ioctl:
 static ssize_t watchdog_write(struct file *file, const char __user *data,
 						size_t len, loff_t *ppos)
 {
-	struct watchdog_device *wdd = file->private_data;
+	struct _watchdog_device *_wdd = file->private_data;
 	size_t i;
 	char c;
 	int err;
@@ -414,18 +373,18 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
 	 * Note: just in case someone wrote the magic character
 	 * five months ago...
 	 */
-	clear_bit(WDOG_ALLOW_RELEASE, &wdd->status);
+	clear_bit(_WDOG_ALLOW_RELEASE, &_wdd->status);
 
 	/* scan to see whether or not we got the magic character */
 	for (i = 0; i != len; i++) {
 		if (get_user(c, data + i))
 			return -EFAULT;
 		if (c == 'V')
-			set_bit(WDOG_ALLOW_RELEASE, &wdd->status);
+			set_bit(_WDOG_ALLOW_RELEASE, &_wdd->status);
 	}
 
 	/* someone wrote to us, so we send the watchdog a keepalive ping */
-	err = watchdog_ping(wdd);
+	err = _watchdog_ping(_wdd);
 	if (err < 0)
 		return err;
 
@@ -445,71 +404,94 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
 static long watchdog_ioctl(struct file *file, unsigned int cmd,
 							unsigned long arg)
 {
-	struct watchdog_device *wdd = file->private_data;
+	struct _watchdog_device *_wdd = file->private_data;
 	void __user *argp = (void __user *)arg;
+	struct watchdog_device *wdd;
 	int __user *p = argp;
 	unsigned int val;
-	int err;
+	int err = 0;
+
+	mutex_lock(&_wdd->lock);
+
+	wdd = _wdd->wdd;
+	if (!wdd) {
+		err = -ENODEV;
+		goto out_ioctl;
+	}
 
 	err = watchdog_ioctl_op(wdd, cmd, arg);
 	if (err != -ENOIOCTLCMD)
-		return err;
+		goto out_ioctl;
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-		return copy_to_user(argp, wdd->info,
+		err = copy_to_user(argp, wdd->info,
 			sizeof(struct watchdog_info)) ? -EFAULT : 0;
+		break;
 	case WDIOC_GETSTATUS:
-		err = watchdog_get_status(wdd, &val);
-		if (err == -ENODEV)
-			return err;
-		return put_user(val, p);
+		val = watchdog_get_status(wdd);
+		err = put_user(val, p);
+		break;
 	case WDIOC_GETBOOTSTATUS:
-		return put_user(wdd->bootstatus, p);
+		err = put_user(wdd->bootstatus, p);
+		break;
 	case WDIOC_SETOPTIONS:
-		if (get_user(val, p))
-			return -EFAULT;
+		if (get_user(val, p)) {
+			err = -EFAULT;
+			break;
+		}
 		if (val & WDIOS_DISABLECARD) {
 			err = watchdog_stop(wdd);
 			if (err < 0)
-				return err;
+				break;
 		}
-		if (val & WDIOS_ENABLECARD) {
+		if (val & WDIOS_ENABLECARD)
 			err = watchdog_start(wdd);
-			if (err < 0)
-				return err;
-		}
-		return 0;
+		break;
 	case WDIOC_KEEPALIVE:
-		if (!(wdd->info->options & WDIOF_KEEPALIVEPING))
-			return -EOPNOTSUPP;
-		return watchdog_ping(wdd);
+		if (!(wdd->info->options & WDIOF_KEEPALIVEPING)) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+		err = watchdog_ping(wdd);
+		break;
 	case WDIOC_SETTIMEOUT:
-		if (get_user(val, p))
-			return -EFAULT;
+		if (get_user(val, p)) {
+			err = -EFAULT;
+			break;
+		}
 		err = watchdog_set_timeout(wdd, val);
 		if (err < 0)
-			return err;
+			break;
 		/* If the watchdog is active then we send a keepalive ping
 		 * to make sure that the watchdog keep's running (and if
 		 * possible that it takes the new timeout) */
 		err = watchdog_ping(wdd);
 		if (err < 0)
-			return err;
+			break;
 		/* Fall */
 	case WDIOC_GETTIMEOUT:
 		/* timeout == 0 means that we don't know the timeout */
-		if (wdd->timeout == 0)
-			return -EOPNOTSUPP;
-		return put_user(wdd->timeout, p);
+		if (wdd->timeout == 0) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+		err = put_user(wdd->timeout, p);
+		break;
 	case WDIOC_GETTIMELEFT:
 		err = watchdog_get_timeleft(wdd, &val);
-		if (err)
-			return err;
-		return put_user(val, p);
+		if (err < 0)
+			break;
+		err = put_user(val, p);
+		break;
 	default:
-		return -ENOTTY;
+		err = -ENOTTY;
+		break;
 	}
+
+out_ioctl:
+	mutex_unlock(&_wdd->lock);
+	return err;
 }
 
 /*
@@ -524,45 +506,68 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 
 static int watchdog_open(struct inode *inode, struct file *file)
 {
-	int err = -EBUSY;
+	struct _watchdog_device *_wdd;
 	struct watchdog_device *wdd;
+	int err;
 
 	/* Get the corresponding watchdog device */
 	if (imajor(inode) == MISC_MAJOR)
-		wdd = old_wdd;
+		_wdd = _old_wdd;
 	else
-		wdd = container_of(inode->i_cdev, struct watchdog_device, cdev);
+		_wdd = container_of(inode->i_cdev, struct _watchdog_device,
+				    cdev);
 
 	/* the watchdog is single open! */
-	if (test_and_set_bit(WDOG_DEV_OPEN, &wdd->status))
+	if (test_and_set_bit(_WDOG_DEV_OPEN, &_wdd->status))
 		return -EBUSY;
 
+	mutex_lock(&_wdd->lock);
+
+	wdd = _wdd->wdd;
+	if (!wdd) {
+		err = -ENODEV;
+		goto out_clear;
+	}
+
 	/*
 	 * If the /dev/watchdog device is open, we don't want the module
 	 * to be unloaded.
 	 */
-	if (!try_module_get(wdd->ops->owner))
-		goto out;
+	if (!try_module_get(wdd->ops->owner)) {
+		err = -EBUSY;
+		goto out_clear;
+	}
 
 	err = watchdog_start(wdd);
 	if (err < 0)
 		goto out_mod;
 
-	file->private_data = wdd;
+	file->private_data = _wdd;
 
-	if (wdd->ops->ref)
-		wdd->ops->ref(wdd);
+	kref_get(&_wdd->kref);
 
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
-	return nonseekable_open(inode, file);
+	err = nonseekable_open(inode, file);
+	goto out_unlock;
 
 out_mod:
-	module_put(wdd->ops->owner);
-out:
-	clear_bit(WDOG_DEV_OPEN, &wdd->status);
+	module_put(_wdd->wdd->ops->owner);
+out_clear:
+	clear_bit(_WDOG_DEV_OPEN, &_wdd->status);
+out_unlock:
+	mutex_unlock(&_wdd->lock);
 	return err;
 }
 
+static void watchdog_wdd_release(struct kref *kref)
+{
+	struct _watchdog_device *_wdd;
+
+	_wdd = container_of(kref, struct _watchdog_device, kref);
+
+	kfree(_wdd);
+}
+
 /*
  *	watchdog_release: release the watchdog device.
  *	@inode: inode of device
@@ -575,9 +580,16 @@ out:
 
 static int watchdog_release(struct inode *inode, struct file *file)
 {
-	struct watchdog_device *wdd = file->private_data;
+	struct _watchdog_device *_wdd = file->private_data;
+	struct watchdog_device *wdd;
 	int err = -EBUSY;
 
+	mutex_lock(&_wdd->lock);
+
+	wdd = _wdd->wdd;
+	if (!wdd)
+		goto done;
+
 	/*
 	 * We only stop the watchdog if we received the magic character
 	 * or if WDIOF_MAGICCLOSE is not set. If nowayout was set then
@@ -585,29 +597,24 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	 */
 	if (!test_bit(WDOG_ACTIVE, &wdd->status))
 		err = 0;
-	else if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
+	else if (test_and_clear_bit(_WDOG_ALLOW_RELEASE, &_wdd->status) ||
 		 !(wdd->info->options & WDIOF_MAGICCLOSE))
 		err = watchdog_stop(wdd);
 
 	/* If the watchdog was not stopped, send a keepalive ping */
 	if (err < 0) {
-		mutex_lock(&wdd->lock);
-		if (!test_bit(WDOG_UNREGISTERED, &wdd->status))
-			dev_crit(wdd->dev, "watchdog did not stop!\n");
-		mutex_unlock(&wdd->lock);
+		dev_crit(wdd->dev, "watchdog did not stop!\n");
 		watchdog_ping(wdd);
 	}
 
-	/* Allow the owner module to be unloaded again */
-	module_put(wdd->ops->owner);
-
 	/* make sure that /dev/watchdog can be re-opened */
-	clear_bit(WDOG_DEV_OPEN, &wdd->status);
-
-	/* Note wdd may be gone after this, do not use after this! */
-	if (wdd->ops->unref)
-		wdd->ops->unref(wdd);
+	clear_bit(_WDOG_DEV_OPEN, &_wdd->status);
 
+done:
+	mutex_unlock(&_wdd->lock);
+	/* Allow the owner module to be unloaded again */
+	module_put(_wdd->cdev.owner);
+	kref_put(&_wdd->kref, watchdog_wdd_release);
 	return 0;
 }
 
@@ -637,10 +644,20 @@ static struct miscdevice watchdog_miscdev = {
 
 static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 {
+	struct _watchdog_device *_wdd;
 	int err;
 
+	_wdd = kzalloc(sizeof(struct _watchdog_device), GFP_KERNEL);
+	if (!_wdd)
+		return -ENOMEM;
+	kref_init(&_wdd->kref);
+	mutex_init(&_wdd->lock);
+
+	_wdd->wdd = wdd;
+	wdd->wdd_data = _wdd;
+
 	if (wdd->id == 0) {
-		old_wdd = wdd;
+		_old_wdd = _wdd;
 		watchdog_miscdev.parent = wdd->parent;
 		err = misc_register(&watchdog_miscdev);
 		if (err != 0) {
@@ -649,23 +666,25 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 			if (err == -EBUSY)
 				pr_err("%s: a legacy watchdog module is probably present.\n",
 					wdd->info->identity);
-			old_wdd = NULL;
+			_old_wdd = NULL;
+			kfree(_wdd);
 			return err;
 		}
 	}
 
 	/* Fill in the data structures */
-	cdev_init(&wdd->cdev, &watchdog_fops);
-	wdd->cdev.owner = wdd->ops->owner;
+	cdev_init(&_wdd->cdev, &watchdog_fops);
+	_wdd->cdev.owner = wdd->ops->owner;
 
 	/* Add the device */
-	err  = cdev_add(&wdd->cdev, devno, 1);
+	err = cdev_add(&_wdd->cdev, devno, 1);
 	if (err) {
 		pr_err("watchdog%d unable to add device %d:%d\n",
 			wdd->id,  MAJOR(watchdog_devt), wdd->id);
 		if (wdd->id == 0) {
 			misc_deregister(&watchdog_miscdev);
-			old_wdd = NULL;
+			_old_wdd = NULL;
+			kref_put(&_wdd->kref, watchdog_wdd_release);
 		}
 	}
 	return err;
@@ -681,15 +700,23 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 
 static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 {
-	mutex_lock(&wdd->lock);
-	set_bit(WDOG_UNREGISTERED, &wdd->status);
-	mutex_unlock(&wdd->lock);
+	struct _watchdog_device *_wdd = wdd->wdd_data;
 
-	cdev_del(&wdd->cdev);
+	cdev_del(&_wdd->cdev);
 	if (wdd->id == 0) {
 		misc_deregister(&watchdog_miscdev);
-		old_wdd = NULL;
+		_old_wdd = NULL;
 	}
+
+	if (watchdog_active(wdd))
+		pr_crit("watchdog%d: watchdog still running!\n", wdd->id);
+
+	mutex_lock(&_wdd->lock);
+	_wdd->wdd = NULL;
+	wdd->wdd_data = NULL;
+	mutex_unlock(&_wdd->lock);
+
+	kref_put(&_wdd->kref, watchdog_wdd_release);
 }
 
 static struct class watchdog_class = {
@@ -742,9 +769,9 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 
 void watchdog_dev_unregister(struct watchdog_device *wdd)
 {
-	watchdog_cdev_unregister(wdd);
 	device_destroy(&watchdog_class, wdd->dev->devt);
 	wdd->dev = NULL;
+	watchdog_cdev_unregister(wdd);
 }
 
 /*
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index a88f955fde92..1d3363aeb6e4 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -28,8 +28,6 @@ struct watchdog_device;
  * @set_timeout:The routine for setting the watchdog devices timeout value (in seconds).
  * @get_timeleft:The routine that gets the time left before a reset (in seconds).
  * @restart:	The routine for restarting the machine.
- * @ref:	The ref operation for dyn. allocated watchdog_device structs
- * @unref:	The unref operation for dyn. allocated watchdog_device structs
  * @ioctl:	The routines that handles extra ioctl calls.
  *
  * The watchdog_ops structure contains a list of low-level operations
@@ -48,15 +46,14 @@ struct watchdog_ops {
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
 	int (*restart)(struct watchdog_device *);
-	void (*ref)(struct watchdog_device *);
-	void (*unref)(struct watchdog_device *);
+	void (*ref)(struct watchdog_device *) __deprecated;
+	void (*unref)(struct watchdog_device *) __deprecated;
 	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
 };
 
 /** struct watchdog_device - The structure that defines a watchdog device
  *
  * @id:		The watchdog's ID. (Allocated by watchdog_register_device)
- * @cdev:	The watchdog's Character device.
  * @dev:	The device for our watchdog
  * @parent:	The parent bus device
  * @info:	Pointer to a watchdog_info structure.
@@ -67,8 +64,8 @@ struct watchdog_ops {
  * @max_timeout:The watchdog devices maximum timeout value (in seconds).
  * @reboot_nb:	The notifier block to stop watchdog on reboot.
  * @restart_nb:	The notifier block to register a restart function.
- * @driver-data:Pointer to the drivers private data.
- * @lock:	Lock for watchdog core internal use only.
+ * @driver_data:Pointer to the drivers private data.
+ * @wdd_data:	Pointer to watchdog core internal data.
  * @status:	Field that contains the devices internal status bits.
  * @deferred: entry in wtd_deferred_reg_list which is used to
  *			   register early initialized watchdogs.
@@ -84,7 +81,6 @@ struct watchdog_ops {
  */
 struct watchdog_device {
 	int id;
-	struct cdev cdev;
 	struct device *dev;
 	struct device *parent;
 	const struct watchdog_info *info;
@@ -96,15 +92,12 @@ struct watchdog_device {
 	struct notifier_block reboot_nb;
 	struct notifier_block restart_nb;
 	void *driver_data;
-	struct mutex lock;
+	void *wdd_data;
 	unsigned long status;
 /* Bit numbers for status flags */
 #define WDOG_ACTIVE		0	/* Is the watchdog running/active */
-#define WDOG_DEV_OPEN		1	/* Opened via /dev/watchdog ? */
-#define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
-#define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
-#define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
-#define WDOG_STOP_ON_REBOOT	5	/* Should be stopped on reboot */
+#define WDOG_NO_WAY_OUT		1	/* Is 'nowayout' feature set ? */
+#define WDOG_STOP_ON_REBOOT	2	/* Should be stopped on reboot */
 	struct list_head deferred;
 };
 
-- 
2.1.4
