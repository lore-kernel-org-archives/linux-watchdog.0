Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15444 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758268Ab2EKKAp (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 11 May 2012 06:00:45 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 8/9] sch56xx-common: Add proper ref-counting of watchdog data
Date: Fri, 11 May 2012 12:00:26 +0200
Message-Id: <1336730427-1664-9-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1336730427-1664-1-git-send-email-hdegoede@redhat.com>
References: <1336730427-1664-1-git-send-email-hdegoede@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This fixes referencing free-ed memory in the corner case where /dev/watchdog
is open when the platform driver gets unbound from the platform device.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/sch56xx-common.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index 29020f2..7e2f3f7 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -67,6 +67,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 struct sch56xx_watchdog_data {
 	u16 addr;
 	struct mutex *io_lock;
+	struct kref kref;
 	struct watchdog_info wdinfo;
 	struct watchdog_device wddev;
 	u8 watchdog_preset;
@@ -257,6 +258,15 @@ EXPORT_SYMBOL(sch56xx_read_virtual_reg12);
  * Watchdog routines
  */
 
+/* Release our data struct when we're unregistered *and*
+   all references to our watchdog device are released */
+static void watchdog_release_resources(struct kref *r)
+{
+	struct sch56xx_watchdog_data *data =
+		container_of(r, struct sch56xx_watchdog_data, kref);
+	kfree(data);
+}
+
 static int watchdog_set_timeout(struct watchdog_device *wddev,
 				unsigned int timeout)
 {
@@ -385,12 +395,28 @@ static int watchdog_stop(struct watchdog_device *wddev)
 	return 0;
 }
 
+static void watchdog_ref(struct watchdog_device *wddev)
+{
+	struct sch56xx_watchdog_data *data = watchdog_get_drvdata(wddev);
+
+	kref_get(&data->kref);
+}
+
+static void watchdog_unref(struct watchdog_device *wddev)
+{
+	struct sch56xx_watchdog_data *data = watchdog_get_drvdata(wddev);
+
+	kref_put(&data->kref, watchdog_release_resources);
+}
+
 static const struct watchdog_ops watchdog_ops = {
 	.owner		= THIS_MODULE,
 	.start		= watchdog_start,
 	.stop		= watchdog_stop,
 	.ping		= watchdog_trigger,
 	.set_timeout	= watchdog_set_timeout,
+	.ref		= watchdog_ref,
+	.unref		= watchdog_unref,
 };
 
 struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
@@ -422,6 +448,7 @@ struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
 
 	data->addr = addr;
 	data->io_lock = io_lock;
+	kref_init(&data->kref);
 
 	strlcpy(data->wdinfo.identity, "sch56xx watchdog",
 		sizeof(data->wdinfo.identity));
@@ -467,7 +494,8 @@ EXPORT_SYMBOL(sch56xx_watchdog_register);
 void sch56xx_watchdog_unregister(struct sch56xx_watchdog_data *data)
 {
 	watchdog_unregister_device(&data->wddev);
-	kfree(data);
+	kref_put(&data->kref, watchdog_release_resources);
+	/* Don't touch data after this it may have been free-ed! */
 }
 EXPORT_SYMBOL(sch56xx_watchdog_unregister);
 
-- 
1.7.10

