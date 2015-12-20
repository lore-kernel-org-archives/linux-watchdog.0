Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Pratyush Anand <panand@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/5] watchdog: da9052_wdt: Drop reference counting
Date: Sun, 20 Dec 2015 13:05:01 -0800
Message-Id: <1450645503-16661-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1450645503-16661-1-git-send-email-linux@roeck-us.net>
References: <1450645503-16661-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Reference counting is now implemented in the watchdog core and no longer
required in watchdog drivers.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/da9052_wdt.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index 67e67977bd29..2fc19a32a320 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -31,7 +31,6 @@
 struct da9052_wdt_data {
 	struct watchdog_device wdt;
 	struct da9052 *da9052;
-	struct kref kref;
 	unsigned long jpast;
 };
 
@@ -51,10 +50,6 @@ static const struct {
 };
 
 
-static void da9052_wdt_release_resources(struct kref *r)
-{
-}
-
 static int da9052_wdt_set_timeout(struct watchdog_device *wdt_dev,
 				  unsigned int timeout)
 {
@@ -104,20 +99,6 @@ static int da9052_wdt_set_timeout(struct watchdog_device *wdt_dev,
 	return 0;
 }
 
-static void da9052_wdt_ref(struct watchdog_device *wdt_dev)
-{
-	struct da9052_wdt_data *driver_data = watchdog_get_drvdata(wdt_dev);
-
-	kref_get(&driver_data->kref);
-}
-
-static void da9052_wdt_unref(struct watchdog_device *wdt_dev)
-{
-	struct da9052_wdt_data *driver_data = watchdog_get_drvdata(wdt_dev);
-
-	kref_put(&driver_data->kref, da9052_wdt_release_resources);
-}
-
 static int da9052_wdt_start(struct watchdog_device *wdt_dev)
 {
 	return da9052_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
@@ -170,8 +151,6 @@ static const struct watchdog_ops da9052_wdt_ops = {
 	.stop = da9052_wdt_stop,
 	.ping = da9052_wdt_ping,
 	.set_timeout = da9052_wdt_set_timeout,
-	.ref = da9052_wdt_ref,
-	.unref = da9052_wdt_unref,
 };
 
 
@@ -198,8 +177,6 @@ static int da9052_wdt_probe(struct platform_device *pdev)
 	da9052_wdt->parent = &pdev->dev;
 	watchdog_set_drvdata(da9052_wdt, driver_data);
 
-	kref_init(&driver_data->kref);
-
 	ret = da9052_reg_update(da9052, DA9052_CONTROL_D_REG,
 				DA9052_CONTROLD_TWDSCALE, 0);
 	if (ret < 0) {
@@ -225,7 +202,6 @@ static int da9052_wdt_remove(struct platform_device *pdev)
 	struct da9052_wdt_data *driver_data = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(&driver_data->wdt);
-	kref_put(&driver_data->kref, da9052_wdt_release_resources);
 
 	return 0;
 }
-- 
2.1.4
