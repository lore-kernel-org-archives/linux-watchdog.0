Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44348 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbcACXMC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 3 Jan 2016 18:12:02 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/3] watchdog: ziirave: Use watchdog infrastructure to create sysfs attributes
Date: Sun,  3 Jan 2016 15:11:57 -0800
Message-Id: <1451862718-31073-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1451862718-31073-1-git-send-email-linux@roeck-us.net>
References: <1451862718-31073-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog core now supports creating driver specific sysfs attributes
when creating the watchdog device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/ziirave_wdt.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index b498fdcc231a..0c7cb7302cf0 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -207,10 +207,7 @@ static struct attribute *ziirave_wdt_attrs[] = {
 	&dev_attr_reset_reason.attr,
 	NULL
 };
-
-static const struct attribute_group ziirave_wdt_sysfs_files = {
-	.attrs  = ziirave_wdt_attrs,
-};
+ATTRIBUTE_GROUPS(ziirave_wdt);
 
 static int ziirave_wdt_init_duration(struct i2c_client *client)
 {
@@ -260,6 +257,7 @@ static int ziirave_wdt_probe(struct i2c_client *client,
 	w_priv->wdd.min_timeout = ZIIRAVE_TIMEOUT_MIN;
 	w_priv->wdd.max_timeout = ZIIRAVE_TIMEOUT_MAX;
 	w_priv->wdd.parent = &client->dev;
+	w_priv->wdd.groups = ziirave_wdt_groups;
 
 	ret = watchdog_init_timeout(&w_priv->wdd, wdt_timeout, &client->dev);
 	if (ret) {
@@ -327,26 +325,14 @@ static int ziirave_wdt_probe(struct i2c_client *client,
 		return -ENODEV;
 
 	ret = watchdog_register_device(&w_priv->wdd);
-	if (ret)
-		return ret;
-
-	ret = sysfs_create_group(&w_priv->wdd.dev->kobj,
-				 &ziirave_wdt_sysfs_files);
-	if (ret) {
-		watchdog_unregister_device(&w_priv->wdd);
 
-		return ret;
-	}
-
-	return 0;
+	return ret;
 }
 
 static int ziirave_wdt_remove(struct i2c_client *client)
 {
 	struct ziirave_wdt_data *w_priv = i2c_get_clientdata(client);
 
-	sysfs_remove_group(&client->dev.kobj, &ziirave_wdt_sysfs_files);
-
 	watchdog_unregister_device(&w_priv->wdd);
 
 	return 0;
-- 
2.1.4

