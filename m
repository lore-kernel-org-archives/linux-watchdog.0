Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26018 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755747Ab2ENNaE (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 May 2012 09:30:04 -0400
From: Tomas Winkler <tomas.winkler@intel.com>
To: hdegoede@redhat.com, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, Alan Cox <alan@linux.intel.com>
Subject: [PATCH 2/2 V3] watchdog: create all the proper device files
Date: Mon, 14 May 2012 16:29:56 +0300
Message-Id: <1337002196-32569-2-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com>
References: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
V2,V3: Rebase

 drivers/watchdog/watchdog_dev.c |   38 ++++++++++++++++++++++++++++++++------
 include/linux/watchdog.h        |    4 ++++
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 4ce3b78..0b6a774 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -47,6 +47,8 @@
 static struct watchdog_device *old_wdd;
 /* the dev_t structure to store the dynamically allocated watchdog devices */
 static dev_t watchdog_devt;
+/* the class for the dynamically allocated watchdog devices */
+static struct class *watchdog_class;
 
 /*
  *	watchdog_ping: ping the watchdog.
@@ -386,10 +388,22 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
 	if (err) {
 		pr_err("watchdog%d unable to add device %d:%d\n",
 			watchdog->id,  MAJOR(watchdog_devt), watchdog->id);
-		if (watchdog->id == 0) {
-			misc_deregister(&watchdog_miscdev);
-			old_wdd = NULL;
-		}
+		goto error;
+	}
+	watchdog->dev = device_create(watchdog_class, watchdog->busdev, devno,
+					NULL, "watchdog%d", watchdog->id);
+	if (IS_ERR(watchdog->dev)) {
+		cdev_del(&watchdog->cdev);
+		err = PTR_ERR(watchdog->dev);
+		goto error;
+	}
+
+	return 0;
+
+error:
+	if (watchdog->id == 0) {
+		misc_deregister(&watchdog_miscdev);
+		old_wdd = NULL;
 	}
 	return err;
 }
@@ -404,6 +418,10 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
 int watchdog_dev_unregister(struct watchdog_device *watchdog)
 {
 	cdev_del(&watchdog->cdev);
+	device_destroy(watchdog_class,
+		       MKDEV(MAJOR(watchdog_devt), watchdog->id));
+	watchdog->dev = NULL;
+
 	if (watchdog->id == 0) {
 		misc_deregister(&watchdog_miscdev);
 		old_wdd = NULL;
@@ -420,9 +438,16 @@ int watchdog_dev_unregister(struct watchdog_device *watchdog)
 static int __init watchdog_init(void)
 {
 	int err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
-	if (err < 0)
+	if (err < 0) {
 		pr_err("watchdog: unable to allocate char dev region\n");
-	return err;
+		return err;
+	}
+	watchdog_class = class_create(THIS_MODULE, "watchdog");
+	if (IS_ERR(watchdog_class)) {
+		unregister_chrdev_region(watchdog_devt, MAX_DOGS);
+		return PTR_ERR(watchdog_class);
+	}
+	return 0;
 }
 
 /*
@@ -434,6 +459,7 @@ static int __init watchdog_init(void)
 static void __exit watchdog_exit(void)
 {
 	unregister_chrdev_region(watchdog_devt, MAX_DOGS);
+	class_destroy(watchdog_class);
 }
 
 module_init(watchdog_init);
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 1397cbc..522aa61 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -100,6 +100,8 @@ struct watchdog_ops {
  * @driver-data:Pointer to the drivers private data.
  * @id:		The watchdog's ID.
  * @cdev:	The watchdog's Character device.
+ * @dev:	The device for our node
+ * @busdev:	Parent bus device
  * @status:	Field that contains the devices internal status bits.
  *
  * The watchdog_device structure contains all information about a
@@ -118,6 +120,8 @@ struct watchdog_device {
 	void *driver_data;
 	int id;
 	struct cdev cdev;
+	struct device *dev;
+	struct device *busdev;
 	unsigned long status;
 /* Bit numbers for status flags */
 #define WDOG_ACTIVE		0	/* Is the watchdog running/active */
-- 
1.7.4.4

