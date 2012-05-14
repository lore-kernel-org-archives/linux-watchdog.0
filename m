Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26018 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755747Ab2ENNaC (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 May 2012 09:30:02 -0400
From: Tomas Winkler <tomas.winkler@intel.com>
To: hdegoede@redhat.com, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 1/2 V3] watchdog: Add multiple device support
Date: Mon, 14 May 2012 16:29:55 +0300
Message-Id: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

We keep the old /dev/watchdog interface file for the first watchdog via
miscdev. This is basically a cut and paste of the relevant interface code
from the rtc driver layer tweaked for watchdog.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2 (by Wim):
    1. Clean split between core and dev related stuff. 
    2. Use ida instead of the watchdog_assign/release_id code.
    3. Rest it's basically the code that Alan produced with some minor changes
       with the comments that Hans made.
V3: (by Tomas) 
    1. Fix compilation error caused by missing include to watchdog_dev.h
    2. Add documentation changes to be part of this patch
    3. Make init and exit module functions static (fixes sparse error)
    4. Fix minor checkpatch.pl complains

 Documentation/watchdog/watchdog-kernel-api.txt |    6 +
 drivers/watchdog/watchdog_core.c               |   29 +++++-
 drivers/watchdog/watchdog_dev.c                |  131 ++++++++++++++++--------
 drivers/watchdog/watchdog_dev.h                |    2 +
 include/linux/watchdog.h                       |    6 +
 5 files changed, 125 insertions(+), 49 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 227f6cd..2d28950 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -46,10 +46,13 @@ struct watchdog_device {
 	unsigned int min_timeout;
 	unsigned int max_timeout;
 	void *driver_data;
+	int id;
+	struct cdev cdev;
 	unsigned long status;
 };
 
 It contains following fields:
+
 * info: a pointer to a watchdog_info structure. This structure gives some
   additional information about the watchdog timer itself. (Like it's unique name)
 * ops: a pointer to the list of watchdog operations that the watchdog supports.
@@ -61,6 +64,9 @@ It contains following fields:
 * driver_data: a pointer to the drivers private data of a watchdog device.
   This data should only be accessed via the watchdog_set_drvadata and
   watchdog_get_drvdata routines.
+* id: set by watchdog_register_device. id 0 is special, it has both cdev with
+  dynamic major and minor 0 (/dev/watchdog0) and as well as the old miscdev /dev/watchdog
+* cdev: cdev for the dynamic major /dev/watchdog<id> device nodes
 * status: this field contains a number of status bits that give extra
   information about the status of the device (Like: is the watchdog timer
   running/active, is the nowayout bit set, is the device opened via
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 14d768b..f6f3828 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -34,9 +34,12 @@
 #include <linux/kernel.h>	/* For printk/panic/... */
 #include <linux/watchdog.h>	/* For watchdog specific items */
 #include <linux/init.h>		/* For __init/__exit/... */
+#include <linux/idr.h>		/* For ida_* macros */
 
 #include "watchdog_dev.h"	/* For watchdog_dev_register/... */
 
+static DEFINE_IDA(watchdog_ida);
+
 /**
  * watchdog_register_device() - register a watchdog device
  * @wdd: watchdog device
@@ -49,7 +52,7 @@
  */
 int watchdog_register_device(struct watchdog_device *wdd)
 {
-	int ret;
+	int ret, id;
 
 	if (wdd == NULL || wdd->info == NULL || wdd->ops == NULL)
 		return -EINVAL;
@@ -74,11 +77,28 @@ int watchdog_register_device(struct watchdog_device *wdd)
 	 * corrupted in a later stage then we expect a kernel panic!
 	 */
 
-	/* We only support 1 watchdog device via the /dev/watchdog interface */
+	id = ida_simple_get(&watchdog_ida, 0, MAX_DOGS, GFP_KERNEL);
+	if (id < 0)
+		return id;
+	wdd->id = id;
+
 	ret = watchdog_dev_register(wdd);
 	if (ret) {
-		pr_err("error registering /dev/watchdog (err=%d)\n", ret);
-		return ret;
+		ida_simple_remove(&watchdog_ida, id);
+		if (!(id == 0 || ret == -EBUSY))
+			return ret;
+
+		/* Retry in case a legacy watchdog module exists */
+		id = ida_simple_get(&watchdog_ida, 1, MAX_DOGS, GFP_KERNEL);
+		if (id < 0)
+			return id;
+		wdd->id = id;
+
+		ret = watchdog_dev_register(wdd);
+		if (ret) {
+			ida_simple_remove(&watchdog_ida, id);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -102,6 +122,7 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
 	ret = watchdog_dev_unregister(wdd);
 	if (ret)
 		pr_err("error unregistering /dev/watchdog (err=%d)\n", ret);
+	ida_simple_remove(&watchdog_ida, wdd->id);
 }
 EXPORT_SYMBOL_GPL(watchdog_unregister_device);
 
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 8558da9..4ce3b78 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -41,11 +41,12 @@
 #include <linux/miscdevice.h>	/* For handling misc devices */
 #include <linux/init.h>		/* For __init/__exit/... */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
+#include "watchdog_dev.h"
 
-/* make sure we only register one /dev/watchdog device */
-static unsigned long watchdog_dev_busy;
 /* the watchdog device behind /dev/watchdog */
-static struct watchdog_device *wdd;
+static struct watchdog_device *old_wdd;
+/* the dev_t structure to store the dynamically allocated watchdog devices */
+static dev_t watchdog_devt;
 
 /*
  *	watchdog_ping: ping the watchdog.
@@ -136,6 +137,7 @@ static int watchdog_stop(struct watchdog_device *wddev)
 static ssize_t watchdog_write(struct file *file, const char __user *data,
 						size_t len, loff_t *ppos)
 {
+	struct watchdog_device *wdd = file->private_data;
 	size_t i;
 	char c;
 
@@ -175,6 +177,7 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
 static long watchdog_ioctl(struct file *file, unsigned int cmd,
 							unsigned long arg)
 {
+	struct watchdog_device *wdd = file->private_data;
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
 	unsigned int val;
@@ -247,11 +250,11 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 }
 
 /*
- *	watchdog_open: open the /dev/watchdog device.
+ *	watchdog_open: open the /dev/watchdog* devices.
  *	@inode: inode of device
  *	@file: file handle to device
  *
- *	When the /dev/watchdog device gets opened, we start the watchdog.
+ *	When the /dev/watchdog* device gets opened, we start the watchdog.
  *	Watch out: the /dev/watchdog device is single open, so we make sure
  *	it can only be opened once.
  */
@@ -259,6 +262,13 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 static int watchdog_open(struct inode *inode, struct file *file)
 {
 	int err = -EBUSY;
+	struct watchdog_device *wdd;
+
+	/* Get the corresponding watchdog device */
+	if (imajor(inode) == MISC_MAJOR)
+		wdd = old_wdd;
+	else
+		wdd = container_of(inode->i_cdev, struct watchdog_device, cdev);
 
 	/* the watchdog is single open! */
 	if (test_and_set_bit(WDOG_DEV_OPEN, &wdd->status))
@@ -275,6 +285,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	if (err < 0)
 		goto out_mod;
 
+	file->private_data = wdd;
+
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
 	return nonseekable_open(inode, file);
 
@@ -286,9 +298,9 @@ out:
 }
 
 /*
- *      watchdog_release: release the /dev/watchdog device.
- *      @inode: inode of device
- *      @file: file handle to device
+ *	watchdog_release: release the watchdog device.
+ *	@inode: inode of device
+ *	@file: file handle to device
  *
  *	This is the code for when /dev/watchdog gets closed. We will only
  *	stop the watchdog when we have received the magic char (and nowayout
@@ -297,6 +309,7 @@ out:
 
 static int watchdog_release(struct inode *inode, struct file *file)
 {
+	struct watchdog_device *wdd = file->private_data;
 	int err = -EBUSY;
 
 	/*
@@ -338,62 +351,90 @@ static struct miscdevice watchdog_miscdev = {
 };
 
 /*
- *	watchdog_dev_register:
+ *	watchdog_dev_register: register a watchdog device
  *	@watchdog: watchdog device
  *
- *	Register a watchdog device as /dev/watchdog. /dev/watchdog
- *	is actually a miscdevice and thus we set it up like that.
+ *	Register a watchdog device including handling the legacy
+ *	/dev/watchdog node. /dev/watchdog is actually a miscdevice and
+ *	thus we set it up like that.
  */
 
 int watchdog_dev_register(struct watchdog_device *watchdog)
 {
-	int err;
-
-	/* Only one device can register for /dev/watchdog */
-	if (test_and_set_bit(0, &watchdog_dev_busy)) {
-		pr_err("only one watchdog can use /dev/watchdog\n");
-		return -EBUSY;
+	int err, devno;
+
+	if (watchdog->id == 0) {
+		err = misc_register(&watchdog_miscdev);
+		if (err != 0) {
+			pr_err("%s: cannot register miscdev on minor=%d (err=%d).\n",
+				watchdog->info->identity, WATCHDOG_MINOR, err);
+			if (err == -EBUSY)
+				pr_err("%s: a legacy watchdog module is probably present.\n",
+					watchdog->info->identity);
+			return err;
+		}
+		old_wdd = watchdog;
 	}
 
-	wdd = watchdog;
-
-	err = misc_register(&watchdog_miscdev);
-	if (err != 0) {
-		pr_err("%s: cannot register miscdev on minor=%d (err=%d)\n",
-		       watchdog->info->identity, WATCHDOG_MINOR, err);
-		goto out;
+	/* Fill in the data structures */
+	devno = MKDEV(MAJOR(watchdog_devt), watchdog->id);
+	cdev_init(&watchdog->cdev, &watchdog_fops);
+	watchdog->cdev.owner = watchdog->ops->owner;
+
+	/* Add the device */
+	err  = cdev_add(&watchdog->cdev, devno, 1);
+	if (err) {
+		pr_err("watchdog%d unable to add device %d:%d\n",
+			watchdog->id,  MAJOR(watchdog_devt), watchdog->id);
+		if (watchdog->id == 0) {
+			misc_deregister(&watchdog_miscdev);
+			old_wdd = NULL;
+		}
 	}
-
-	return 0;
-
-out:
-	wdd = NULL;
-	clear_bit(0, &watchdog_dev_busy);
 	return err;
 }
 
 /*
- *	watchdog_dev_unregister:
+ *	watchdog_dev_unregister: unregister a watchdog device
  *	@watchdog: watchdog device
  *
- *	Deregister the /dev/watchdog device.
+ *	Unregister the watchdog and if needed the legacy /dev/watchdog device.
  */
 
 int watchdog_dev_unregister(struct watchdog_device *watchdog)
 {
-	/* Check that a watchdog device was registered in the past */
-	if (!test_bit(0, &watchdog_dev_busy) || !wdd)
-		return -ENODEV;
-
-	/* We can only unregister the watchdog device that was registered */
-	if (watchdog != wdd) {
-		pr_err("%s: watchdog was not registered as /dev/watchdog\n",
-		       watchdog->info->identity);
-		return -ENODEV;
+	cdev_del(&watchdog->cdev);
+	if (watchdog->id == 0) {
+		misc_deregister(&watchdog_miscdev);
+		old_wdd = NULL;
 	}
-
-	misc_deregister(&watchdog_miscdev);
-	wdd = NULL;
-	clear_bit(0, &watchdog_dev_busy);
 	return 0;
 }
+
+/*
+ *	watchdog_init: module init call
+ *
+ *	Allocate a range of chardev nodes to use for watchdog devices
+ */
+
+static int __init watchdog_init(void)
+{
+	int err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
+	if (err < 0)
+		pr_err("watchdog: unable to allocate char dev region\n");
+	return err;
+}
+
+/*
+ *	watchdog_exit: module exit
+ *
+ *	Release the range of chardev nodes used for watchdog devices
+ */
+
+static void __exit watchdog_exit(void)
+{
+	unregister_chrdev_region(watchdog_devt, MAX_DOGS);
+}
+
+module_init(watchdog_init);
+module_exit(watchdog_exit);
diff --git a/drivers/watchdog/watchdog_dev.h b/drivers/watchdog/watchdog_dev.h
index bc7612b..0eb8f6f 100644
--- a/drivers/watchdog/watchdog_dev.h
+++ b/drivers/watchdog/watchdog_dev.h
@@ -26,6 +26,8 @@
  *	This material is provided "AS-IS" and at no charge.
  */
 
+#define MAX_DOGS	32	/* Maximum number of watchdog devices */
+
 /*
  *	Functions/procedures to be called by the core
  */
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index ac40716..1397cbc 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -54,6 +54,8 @@ struct watchdog_info {
 #ifdef __KERNEL__
 
 #include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/cdev.h>
 
 struct watchdog_ops;
 struct watchdog_device;
@@ -96,6 +98,8 @@ struct watchdog_ops {
  * @min_timeout:The watchdog devices minimum timeout value.
  * @max_timeout:The watchdog devices maximum timeout value.
  * @driver-data:Pointer to the drivers private data.
+ * @id:		The watchdog's ID.
+ * @cdev:	The watchdog's Character device.
  * @status:	Field that contains the devices internal status bits.
  *
  * The watchdog_device structure contains all information about a
@@ -112,6 +116,8 @@ struct watchdog_device {
 	unsigned int min_timeout;
 	unsigned int max_timeout;
 	void *driver_data;
+	int id;
+	struct cdev cdev;
 	unsigned long status;
 /* Bit numbers for status flags */
 #define WDOG_ACTIVE		0	/* Is the watchdog running/active */
-- 
1.7.4.4

