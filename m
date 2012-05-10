Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:37264 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755445Ab2EJTs4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 10 May 2012 15:48:56 -0400
Date: Thu, 10 May 2012 21:20:23 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Hans de Goede <hdegoede@redhat.com>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/4] watchdog: Add multiple device support
Message-ID: <20120510192023.GA31117@spo001.leaseweb.com>
References: <20120321152418.20045.35525.stgit@bob.linux.org.uk> <20120504123815.GS3074@spo001.leaseweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120504123815.GS3074@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alan, Hans,

> > We keep the old /dev/watchdog interface file for the first watchdog via
> > miscdev. This is basically a cut and paste of the relevant interface code
> > from the rtc driver layer tweaked for watchdog.
> > 
> > Revised to fix problems noted by Hans de Goede
> > 
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> I'm ok with the principle. Need some more thoughts about the code (meaning: that the ID assignment should imho be in the watchdog_core.c file).
> 
> I do have one question though: why did you use your own assign_id routines and not ida_simple_get/ida_simple_remove for instance?

I re-tweaked it to fit the clean split between core and dev related stuff. I also used ida instead of the watchdog_assign/release_id code.
For the rest it's basically the code that Alan produced with some minor changes (and also with the comments that Hans made).

See attached the diff (I will need to add the kernel-api documentation update still).
Please comment and test.

Thanks in advance,
Wim.

---
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 14d768b..9a10bd4 100644
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
+		if (id != 0)
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
index 930cc7c..b6666ab 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -44,10 +44,10 @@
 
 #include "watchdog_dev.h"
 
-/* make sure we only register one /dev/watchdog device */
-static unsigned long watchdog_dev_busy;
 /* the watchdog device behind /dev/watchdog */
-static struct watchdog_device *wdd;
+static struct watchdog_device *old_wdd;
+/* the dev_t structure to store the dynamically allocated watchdog devices */
+static dev_t watchdog_devt;
 
 /*
  *	watchdog_ping: ping the watchdog.
@@ -138,6 +138,7 @@ static int watchdog_stop(struct watchdog_device *wddev)
 static ssize_t watchdog_write(struct file *file, const char __user *data,
 						size_t len, loff_t *ppos)
 {
+	struct watchdog_device *wdd = file->private_data;
 	size_t i;
 	char c;
 
@@ -177,6 +178,7 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
 static long watchdog_ioctl(struct file *file, unsigned int cmd,
 							unsigned long arg)
 {
+	struct watchdog_device *wdd = file->private_data;
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
 	unsigned int val;
@@ -249,11 +251,11 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
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
@@ -261,6 +263,12 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 static int watchdog_open(struct inode *inode, struct file *file)
 {
 	int err = -EBUSY;
+	struct watchdog_device *wdd;
+
+	/* Get the corresponding watchdog device */
+	if (imajor(inode) == MISC_MAJOR)
+		wdd = old_wdd;
+	else wdd = container_of(inode->i_cdev, struct watchdog_device, cdev);
 
 	/* the watchdog is single open! */
 	if (test_and_set_bit(WDOG_DEV_OPEN, &wdd->status))
@@ -277,6 +285,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	if (err < 0)
 		goto out_mod;
 
+	file->private_data = wdd;
+
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
 	return nonseekable_open(inode, file);
 
@@ -288,9 +298,9 @@ out:
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
@@ -299,6 +309,7 @@ out:
 
 static int watchdog_release(struct inode *inode, struct file *file)
 {
+	struct watchdog_device *wdd = file->private_data;
 	int err = -EBUSY;
 
 	/*
@@ -340,62 +351,90 @@ static struct miscdevice watchdog_miscdev = {
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
+int __init watchdog_init(void)
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
+void __exit watchdog_exit(void)
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
index 1984ea6..fd648ea 100644
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
