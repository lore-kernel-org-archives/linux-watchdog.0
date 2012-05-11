Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59266 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757825Ab2EKKAf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 11 May 2012 06:00:35 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Alan Cox <alan@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/9] watchdog: create all the proper device files
Date: Fri, 11 May 2012 12:00:20 +0200
Message-Id: <1336730427-1664-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1336730427-1664-1-git-send-email-hdegoede@redhat.com>
References: <1336730427-1664-1-git-send-email-hdegoede@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/watchdog/watchdog_dev.c |   38 ++++++++++++++++++++++++++++++++------
 include/linux/watchdog.h        |    4 ++++
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 7ba784c..db5daef 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -48,6 +48,8 @@
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
 int __init watchdog_init(void)
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
@@ -434,6 +459,7 @@ int __init watchdog_init(void)
 void __exit watchdog_exit(void)
 {
 	unregister_chrdev_region(watchdog_devt, MAX_DOGS);
+	class_destroy(watchdog_class);
 }
 
 module_init(watchdog_init);
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index eee8ac4..0759920 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -102,6 +102,8 @@ struct watchdog_ops {
  * @driver-data:Pointer to the drivers private data.
  * @id:		The watchdog's ID.
  * @cdev:	The watchdog's Character device.
+ * @dev:	The device for our node
+ * @busdev:	Parent bus device
  * @status:	Field that contains the devices internal status bits.
  *
  * The watchdog_device structure contains all information about a
@@ -120,6 +122,8 @@ struct watchdog_device {
 	void *driver_data;
 	int id;
 	struct cdev cdev;
+	struct device *dev;
+	struct device *busdev;
 	unsigned long status;
 /* Bit numbers for status flags */
 #define WDOG_ACTIVE		0	/* Is the watchdog running/active */
-- 
1.7.10

