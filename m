Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44342 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbcACXMB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 3 Jan 2016 18:12:01 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/3] watchdog: Add support for creating driver specific sysfs attributes
Date: Sun,  3 Jan 2016 15:11:56 -0800
Message-Id: <1451862718-31073-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1451862718-31073-1-git-send-email-linux@roeck-us.net>
References: <1451862718-31073-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The Zodiac watchdog driver attaches additional sysfs attributes to the
watchdog device. This has a number of problems: The watchdog device
lifetime differs from the driver lifetime, and the device structure
should therefore not be accessed from drivers. Also, creating sysfs
attributes after driver registration results in a potential race condition
if user space expects the attributes to exist but they don't exist yet.

Add support for creating driver specific sysfs attributes to the watchdog
core to solve the problems.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/watchdog/watchdog-kernel-api.txt | 3 +++
 drivers/watchdog/watchdog_dev.c                | 5 +++--
 include/linux/watchdog.h                       | 3 +++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 72a009478b15..312f60009c3e 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -46,6 +46,7 @@ struct watchdog_device {
 	int id;
 	struct device *dev;
 	struct device *parent;
+	const struct attribute_group **groups;
 	const struct watchdog_info *info;
 	const struct watchdog_ops *ops;
 	unsigned int bootstatus;
@@ -68,6 +69,8 @@ It contains following fields:
 * dev: device under the watchdog class (created by watchdog_register_device).
 * parent: set this to the parent device (or NULL) before calling
   watchdog_register_device.
+* groups: List of sysfs attribute groups to create when creating the watchdog
+  device.
 * info: a pointer to a watchdog_info structure. This structure gives some
   additional information about the watchdog timer itself. (Like it's unique name)
 * ops: a pointer to the list of watchdog operations that the watchdog supports.
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 3cab6f6e7f1c..e89ccb2e9603 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -744,8 +744,9 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 	if (ret)
 		return ret;
 
-	dev = device_create(&watchdog_class, wdd->parent, devno, wdd,
-			    "watchdog%d", wdd->id);
+	dev = device_create_with_groups(&watchdog_class, wdd->parent,
+					devno, wdd, wdd->groups,
+					"watchdog%d", wdd->id);
 	if (IS_ERR(dev)) {
 		watchdog_cdev_unregister(wdd);
 		return PTR_ERR(dev);
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 850af04fe0c7..2a68370411a9 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -57,6 +57,8 @@ struct watchdog_ops {
  * @id:		The watchdog's ID. (Allocated by watchdog_register_device)
  * @dev:	The device for our watchdog
  * @parent:	The parent bus device
+ * @groups:	List of sysfs attribute groups to create when creating the
+ *		watchdog device.
  * @info:	Pointer to a watchdog_info structure.
  * @ops:	Pointer to the list of watchdog operations.
  * @bootstatus:	Status of the watchdog device at boot.
@@ -84,6 +86,7 @@ struct watchdog_device {
 	int id;
 	struct device *dev;
 	struct device *parent;
+	const struct attribute_group **groups;
 	const struct watchdog_info *info;
 	const struct watchdog_ops *ops;
 	unsigned int bootstatus;
-- 
2.1.4

