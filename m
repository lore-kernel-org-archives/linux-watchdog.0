Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v3 1/2] watchdog: core: create device before registering char dev
Date: Thu, 26 Nov 2015 15:35:06 -0500
Message-Id: <1448570107-3106-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Currently, the entry in /dev is created before the device associated
with the watchdog is created. Therefore, a user can do operations on the
watchdog before it is fully ready.

This patch changes order of operations to create the device first. As
the core might try to create the device with different ids, it is
simpler to group the device creation and the char device registration in
the same function. This commit also adds a counterpart function to group
unregistration and device destruction.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
Changes in v3:
 - changed order of operations to first create the device and then
   register the char dev. On cleanup, unregister then destroy.

Changes in v2:
 - move call to device_destroy before watchdog_dev_unregister 

 drivers/watchdog/watchdog_core.c | 60 +++++++++++++++++++++++-----------------
 drivers/watchdog/watchdog_core.h |  1 +
 drivers/watchdog/watchdog_dev.c  |  7 ++++-
 3 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 551af04..13a7a58 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -192,9 +192,39 @@ void watchdog_set_restart_priority(struct watchdog_device *wdd, int priority)
 }
 EXPORT_SYMBOL_GPL(watchdog_set_restart_priority);
 
+static int __watchdog_create_register(struct watchdog_device *wdd)
+{
+	dev_t devno;
+	int ret;
+
+	devno = watchdog_dev_get_devno(wdd);
+	wdd->dev = device_create(watchdog_class, wdd->parent, devno,
+					wdd, "watchdog%d", wdd->id);
+	if (IS_ERR(wdd->dev))
+		return PTR_ERR(wdd->dev);
+
+	ret = watchdog_dev_register(wdd);
+	if (ret)
+		device_destroy(watchdog_class, devno);
+
+	return ret;
+}
+
+static void __watchdog_unregister_destroy(struct watchdog_device *wdd)
+{
+	dev_t devno = wdd->cdev.dev;
+	int ret;
+
+	ret = watchdog_dev_unregister(wdd);
+	if (ret)
+		pr_err("error unregistering /dev/watchdog (err=%d)\n", ret);
+	device_destroy(watchdog_class, devno);
+	wdd->dev = NULL;
+}
+
 static int __watchdog_register_device(struct watchdog_device *wdd)
 {
-	int ret, id = -1, devno;
+	int ret, id = -1;
 
 	if (wdd == NULL || wdd->info == NULL || wdd->ops == NULL)
 		return -EINVAL;
@@ -228,7 +258,7 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 		return id;
 	wdd->id = id;
 
-	ret = watchdog_dev_register(wdd);
+	ret = __watchdog_create_register(wdd);
 	if (ret) {
 		ida_simple_remove(&watchdog_ida, id);
 		if (!(id == 0 && ret == -EBUSY))
@@ -240,23 +270,13 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 			return id;
 		wdd->id = id;
 
-		ret = watchdog_dev_register(wdd);
+		ret = __watchdog_create_register(wdd);
 		if (ret) {
 			ida_simple_remove(&watchdog_ida, id);
 			return ret;
 		}
 	}
 
-	devno = wdd->cdev.dev;
-	wdd->dev = device_create(watchdog_class, wdd->parent, devno,
-					wdd, "watchdog%d", wdd->id);
-	if (IS_ERR(wdd->dev)) {
-		watchdog_dev_unregister(wdd);
-		ida_simple_remove(&watchdog_ida, id);
-		ret = PTR_ERR(wdd->dev);
-		return ret;
-	}
-
 	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status)) {
 		wdd->reboot_nb.notifier_call = watchdog_reboot_notifier;
 
@@ -264,10 +284,8 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 		if (ret) {
 			dev_err(wdd->dev, "Cannot register reboot notifier (%d)\n",
 				ret);
-			watchdog_dev_unregister(wdd);
-			device_destroy(watchdog_class, devno);
+			__watchdog_unregister_destroy(wdd);
 			ida_simple_remove(&watchdog_ida, wdd->id);
-			wdd->dev = NULL;
 			return ret;
 		}
 	}
@@ -311,9 +329,6 @@ EXPORT_SYMBOL_GPL(watchdog_register_device);
 
 static void __watchdog_unregister_device(struct watchdog_device *wdd)
 {
-	int ret;
-	int devno;
-
 	if (wdd == NULL)
 		return;
 
@@ -323,13 +338,8 @@ static void __watchdog_unregister_device(struct watchdog_device *wdd)
 	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status))
 		unregister_reboot_notifier(&wdd->reboot_nb);
 
-	devno = wdd->cdev.dev;
-	ret = watchdog_dev_unregister(wdd);
-	if (ret)
-		pr_err("error unregistering /dev/watchdog (err=%d)\n", ret);
-	device_destroy(watchdog_class, devno);
+	__watchdog_unregister_destroy(wdd);
 	ida_simple_remove(&watchdog_ida, wdd->id);
-	wdd->dev = NULL;
 }
 
 /**
diff --git a/drivers/watchdog/watchdog_core.h b/drivers/watchdog/watchdog_core.h
index 1c8d6b0..8c98164 100644
--- a/drivers/watchdog/watchdog_core.h
+++ b/drivers/watchdog/watchdog_core.h
@@ -35,3 +35,4 @@ extern int watchdog_dev_register(struct watchdog_device *);
 extern int watchdog_dev_unregister(struct watchdog_device *);
 extern struct class * __init watchdog_dev_init(void);
 extern void __exit watchdog_dev_exit(void);
+dev_t watchdog_dev_get_devno(struct watchdog_device *);
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 21224bd..140a995 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -632,6 +632,11 @@ static struct miscdevice watchdog_miscdev = {
  *	thus we set it up like that.
  */
 
+dev_t watchdog_dev_get_devno(struct watchdog_device *wdd)
+{
+	return MKDEV(MAJOR(watchdog_devt), wdd->id);
+}
+
 int watchdog_dev_register(struct watchdog_device *wdd)
 {
 	int err, devno;
@@ -652,7 +657,7 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 	}
 
 	/* Fill in the data structures */
-	devno = MKDEV(MAJOR(watchdog_devt), wdd->id);
+	devno = wdd->dev->devt;
 	cdev_init(&wdd->cdev, &watchdog_fops);
 	wdd->cdev.owner = wdd->ops->owner;
 
-- 
2.5.0
