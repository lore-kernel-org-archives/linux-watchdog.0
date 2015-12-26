Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52228 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbbLZABz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 25 Dec 2015 19:01:55 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Pratyush Anand <panand@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 6/6] hwmon: (sch56xx) Drop watchdog driver data reference count callbacks
Date: Fri, 25 Dec 2015 16:01:45 -0800
Message-Id: <1451088105-1722-7-git-send-email-linux@roeck-us.net>
In-Reply-To: <1451088105-1722-1-git-send-email-linux@roeck-us.net>
References: <1451088105-1722-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Reference counting is now implemented in the watchdog core and no longer
required in watchdog drivers.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Add missing kfree().

 drivers/hwmon/sch56xx-common.c | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index 738681983284..68c350c704fb 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -30,7 +30,6 @@
 #include <linux/watchdog.h>
 #include <linux/miscdevice.h>
 #include <linux/uaccess.h>
-#include <linux/kref.h>
 #include <linux/slab.h>
 #include "sch56xx-common.h"
 
@@ -67,7 +66,6 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 struct sch56xx_watchdog_data {
 	u16 addr;
 	struct mutex *io_lock;
-	struct kref kref;
 	struct watchdog_info wdinfo;
 	struct watchdog_device wddev;
 	u8 watchdog_preset;
@@ -258,15 +256,6 @@ EXPORT_SYMBOL(sch56xx_read_virtual_reg12);
  * Watchdog routines
  */
 
-/* Release our data struct when we're unregistered *and*
-   all references to our watchdog device are released */
-static void watchdog_release_resources(struct kref *r)
-{
-	struct sch56xx_watchdog_data *data =
-		container_of(r, struct sch56xx_watchdog_data, kref);
-	kfree(data);
-}
-
 static int watchdog_set_timeout(struct watchdog_device *wddev,
 				unsigned int timeout)
 {
@@ -395,28 +384,12 @@ static int watchdog_stop(struct watchdog_device *wddev)
 	return 0;
 }
 
-static void watchdog_ref(struct watchdog_device *wddev)
-{
-	struct sch56xx_watchdog_data *data = watchdog_get_drvdata(wddev);
-
-	kref_get(&data->kref);
-}
-
-static void watchdog_unref(struct watchdog_device *wddev)
-{
-	struct sch56xx_watchdog_data *data = watchdog_get_drvdata(wddev);
-
-	kref_put(&data->kref, watchdog_release_resources);
-}
-
 static const struct watchdog_ops watchdog_ops = {
 	.owner		= THIS_MODULE,
 	.start		= watchdog_start,
 	.stop		= watchdog_stop,
 	.ping		= watchdog_trigger,
 	.set_timeout	= watchdog_set_timeout,
-	.ref		= watchdog_ref,
-	.unref		= watchdog_unref,
 };
 
 struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
@@ -448,7 +421,6 @@ struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
 
 	data->addr = addr;
 	data->io_lock = io_lock;
-	kref_init(&data->kref);
 
 	strlcpy(data->wdinfo.identity, "sch56xx watchdog",
 		sizeof(data->wdinfo.identity));
@@ -494,8 +466,7 @@ EXPORT_SYMBOL(sch56xx_watchdog_register);
 void sch56xx_watchdog_unregister(struct sch56xx_watchdog_data *data)
 {
 	watchdog_unregister_device(&data->wddev);
-	kref_put(&data->kref, watchdog_release_resources);
-	/* Don't touch data after this it may have been free-ed! */
+	kfree(data);
 }
 EXPORT_SYMBOL(sch56xx_watchdog_unregister);
 
-- 
2.1.4

