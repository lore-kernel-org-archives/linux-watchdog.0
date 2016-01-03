Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/3] watchdog: Drop pointer to watchdog device from struct watchdog_device
Date: Sun,  3 Jan 2016 15:11:58 -0800
Message-Id: <1451862718-31073-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1451862718-31073-1-git-send-email-linux@roeck-us.net>
References: <1451862718-31073-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The lifetime of the watchdog device pointer is different from the lifetime
of its character device. Remove it entirely to avoid race conditions.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/watchdog/watchdog-kernel-api.txt | 2 --
 drivers/watchdog/watchdog_core.c               | 8 ++++----
 drivers/watchdog/watchdog_dev.c                | 9 ++++-----
 include/linux/watchdog.h                       | 2 --
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 312f60009c3e..55120a055a14 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -44,7 +44,6 @@ The watchdog device structure looks like this:
 
 struct watchdog_device {
 	int id;
-	struct device *dev;
 	struct device *parent;
 	const struct attribute_group **groups;
 	const struct watchdog_info *info;
@@ -66,7 +65,6 @@ It contains following fields:
   /dev/watchdog0 cdev (dynamic major, minor 0) as well as the old
   /dev/watchdog miscdev. The id is set automatically when calling
   watchdog_register_device.
-* dev: device under the watchdog class (created by watchdog_register_device).
 * parent: set this to the parent device (or NULL) before calling
   watchdog_register_device.
 * groups: List of sysfs attribute groups to create when creating the watchdog
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index ec1ab6c1a80b..e600fd93b7de 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -249,8 +249,8 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 
 		ret = register_reboot_notifier(&wdd->reboot_nb);
 		if (ret) {
-			dev_err(wdd->dev, "Cannot register reboot notifier (%d)\n",
-				ret);
+			pr_err("watchdog%d: Cannot register reboot notifier (%d)\n",
+			       wdd->id, ret);
 			watchdog_dev_unregister(wdd);
 			ida_simple_remove(&watchdog_ida, wdd->id);
 			return ret;
@@ -262,8 +262,8 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 
 		ret = register_restart_handler(&wdd->restart_nb);
 		if (ret)
-			dev_warn(wdd->dev, "Cannot register restart handler (%d)\n",
-				 ret);
+			pr_warn("watchog%d: Cannot register restart handler (%d)\n",
+				wdd->id, ret);
 	}
 
 	return 0;
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e89ccb2e9603..ba2ecce4aae6 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -143,7 +143,8 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		return 0;
 
 	if (test_bit(WDOG_NO_WAY_OUT, &wdd->status)) {
-		dev_info(wdd->dev, "nowayout prevents watchdog being stopped!\n");
+		pr_info("watchdog%d: nowayout prevents watchdog being stopped!\n",
+			wdd->id);
 		return -EBUSY;
 	}
 
@@ -604,7 +605,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
 
 	/* If the watchdog was not stopped, send a keepalive ping */
 	if (err < 0) {
-		dev_crit(wdd->dev, "watchdog did not stop!\n");
+		pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
 		watchdog_ping(wdd);
 	}
 
@@ -751,7 +752,6 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 		watchdog_cdev_unregister(wdd);
 		return PTR_ERR(dev);
 	}
-	wdd->dev = dev;
 
 	return ret;
 }
@@ -766,8 +766,7 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 
 void watchdog_dev_unregister(struct watchdog_device *wdd)
 {
-	device_destroy(&watchdog_class, wdd->dev->devt);
-	wdd->dev = NULL;
+	device_destroy(&watchdog_class, wdd->wd_data->cdev.dev);
 	watchdog_cdev_unregister(wdd);
 }
 
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 2a68370411a9..1fb11c5a49c6 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -55,7 +55,6 @@ struct watchdog_ops {
 /** struct watchdog_device - The structure that defines a watchdog device
  *
  * @id:		The watchdog's ID. (Allocated by watchdog_register_device)
- * @dev:	The device for our watchdog
  * @parent:	The parent bus device
  * @groups:	List of sysfs attribute groups to create when creating the
  *		watchdog device.
@@ -84,7 +83,6 @@ struct watchdog_ops {
  */
 struct watchdog_device {
 	int id;
-	struct device *dev;
 	struct device *parent;
 	const struct attribute_group **groups;
 	const struct watchdog_info *info;
-- 
2.1.4
