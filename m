Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55643 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758026Ab2DMJQ6 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Apr 2012 05:16:58 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q3D9Gw9e031288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Apr 2012 05:16:58 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/5] sch56xx-common: Add proper ref-counting of watchdog data
Date: Fri, 13 Apr 2012 11:19:09 +0200
Message-Id: <1334308750-2859-4-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1334308750-2859-1-git-send-email-hdegoede@redhat.com>
References: <1334308750-2859-1-git-send-email-hdegoede@redhat.com>
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
1.7.9.3

