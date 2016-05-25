Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36457 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754307AbcEYNsD (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 09:48:03 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
	linux-renesas-soc@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [RFC 1/2] watchdog: dev: add helper for creating uevent on dev
Date: Wed, 25 May 2016 15:47:41 +0200
Message-Id: <1464184062-5230-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1464184062-5230-1-git-send-email-wsa@the-dreams.de>
References: <1464184062-5230-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Mechanisms like pretimeout governors may want to notify userspace via
uevents. Add a helper because all the needed data is private to the
watchdog device. To allow calling it in atomic contexts, put actual
signalling to a workqueue.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/watchdog_dev.c | 20 ++++++++++++++++++++
 include/linux/watchdog.h        |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 9e2e668e1c6b2d..2a7d04034641dc 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -63,6 +63,7 @@ struct watchdog_core_data {
 	struct kref kref;
 	struct cdev cdev;
 	struct watchdog_device *wdd;
+	struct device *dev;
 	struct mutex lock;
 	unsigned long last_keepalive;
 	unsigned long last_hw_keepalive;
@@ -70,6 +71,7 @@ struct watchdog_core_data {
 	unsigned long status;		/* Internal status bits */
 #define _WDOG_DEV_OPEN		0	/* Opened ? */
 #define _WDOG_ALLOW_RELEASE	1	/* Did we receive the magic char ? */
+	struct work_struct uevent_work;
 };
 
 /* the dev_t structure to store the dynamically allocated watchdog devices */
@@ -821,6 +823,21 @@ static struct miscdevice watchdog_miscdev = {
 	.fops		= &watchdog_fops,
 };
 
+void watchdog_dev_uevent(struct watchdog_device *wdd)
+{
+	queue_work(watchdog_wq, &wdd->wd_data->uevent_work);
+}
+
+static void watchdog_dev_uevent_work(struct work_struct *work)
+{
+	struct watchdog_core_data *wd_data = container_of(work, struct watchdog_core_data,
+							  uevent_work);
+
+	mutex_lock(&wd_data->lock);
+	kobject_uevent(&wd_data->dev->kobj, KOBJ_CHANGE);
+	mutex_unlock(&wd_data->lock);
+}
+
 /*
  *	watchdog_cdev_register: register watchdog character device
  *	@wdd: watchdog device
@@ -849,6 +866,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 		return -ENODEV;
 
 	INIT_DELAYED_WORK(&wd_data->work, watchdog_ping_work);
+	INIT_WORK(&wd_data->uevent_work, watchdog_dev_uevent_work);
 
 	if (wdd->id == 0) {
 		old_wd_data = wd_data;
@@ -968,6 +986,8 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 		watchdog_cdev_unregister(wdd);
 	}
 
+	wdd->wd_data->dev = dev;
+
 	return ret;
 }
 
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 496e52e5b91fc7..f0f77f06d9813b 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -194,6 +194,9 @@ extern int watchdog_init_timeout(struct watchdog_device *wdd,
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
+/* drivers/watchdog/watchdog_dev.c */
+void watchdog_dev_uevent(struct watchdog_device *wdd);
+
 /* drivers/watchdog/watchdog_pretimeout.c */
 #ifdef CONFIG_WATCHDOG_PRETIMEOUT_GOV
 void watchdog_notify_pretimeout(struct watchdog_device *wdd);
-- 
2.8.1

