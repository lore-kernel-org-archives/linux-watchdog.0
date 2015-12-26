Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Pratyush Anand <panand@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 5/6] watchdog: da9055_wdt: Drop reference counting
Date: Fri, 25 Dec 2015 16:01:44 -0800
Message-Id: <1451088105-1722-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1451088105-1722-1-git-send-email-linux@roeck-us.net>
References: <1451088105-1722-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Reference counting is now implemented in the watchdog core and no longer
required in watchdog drivers.

Since it was implememented a no-op, and since the local memory is allocated
with devm_kzalloc(), the reference counting code in the driver really did
not really work anyway, and this patch effectively fixes a bug which could
cause a crash on unloading if the watchdog device was still open.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Add note that the patch also fixes a bug.

 drivers/watchdog/da9055_wdt.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
index 04d1430d93d2..8377c43f3f20 100644
--- a/drivers/watchdog/da9055_wdt.c
+++ b/drivers/watchdog/da9055_wdt.c
@@ -35,7 +35,6 @@ MODULE_PARM_DESC(nowayout,
 struct da9055_wdt_data {
 	struct watchdog_device wdt;
 	struct da9055 *da9055;
-	struct kref kref;
 };
 
 static const struct {
@@ -99,24 +98,6 @@ static int da9055_wdt_ping(struct watchdog_device *wdt_dev)
 				 DA9055_WATCHDOG_MASK, 1);
 }
 
-static void da9055_wdt_release_resources(struct kref *r)
-{
-}
-
-static void da9055_wdt_ref(struct watchdog_device *wdt_dev)
-{
-	struct da9055_wdt_data *driver_data = watchdog_get_drvdata(wdt_dev);
-
-	kref_get(&driver_data->kref);
-}
-
-static void da9055_wdt_unref(struct watchdog_device *wdt_dev)
-{
-	struct da9055_wdt_data *driver_data = watchdog_get_drvdata(wdt_dev);
-
-	kref_put(&driver_data->kref, da9055_wdt_release_resources);
-}
-
 static int da9055_wdt_start(struct watchdog_device *wdt_dev)
 {
 	return da9055_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
@@ -138,8 +119,6 @@ static const struct watchdog_ops da9055_wdt_ops = {
 	.stop = da9055_wdt_stop,
 	.ping = da9055_wdt_ping,
 	.set_timeout = da9055_wdt_set_timeout,
-	.ref = da9055_wdt_ref,
-	.unref = da9055_wdt_unref,
 };
 
 static int da9055_wdt_probe(struct platform_device *pdev)
@@ -165,8 +144,6 @@ static int da9055_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(da9055_wdt, nowayout);
 	watchdog_set_drvdata(da9055_wdt, driver_data);
 
-	kref_init(&driver_data->kref);
-
 	ret = da9055_wdt_stop(da9055_wdt);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to stop watchdog, %d\n", ret);
@@ -189,7 +166,6 @@ static int da9055_wdt_remove(struct platform_device *pdev)
 	struct da9055_wdt_data *driver_data = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(&driver_data->wdt);
-	kref_put(&driver_data->kref, da9055_wdt_release_resources);
 
 	return 0;
 }
-- 
2.1.4
