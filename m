Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 11/62] watchdog: da9052_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:28 -0800
Message-Id: <1484091325-9199-12-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'val = e; return val;' with 'return e;'
- Drop assignments to otherwise unused variables
- Replace 'if (e) { return expr; }' with 'if (e) return expr;'
- Drop remove function
- Drop platform_set_drvdata()
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Support Opensource <support.opensource@diasemi.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/da9052_wdt.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index d86a57e3d17d..d6d5006efa71 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -128,16 +128,14 @@ static int da9052_wdt_ping(struct watchdog_device *wdt_dev)
 	ret = da9052_reg_update(da9052, DA9052_CONTROL_D_REG,
 				DA9052_CONTROLD_WATCHDOG, 1 << 7);
 	if (ret < 0)
-		goto err_strobe;
+		return ret;
 
 	/*
 	 * FIXME: Reset the watchdog core, in general PMIC
 	 * is supposed to do this
 	 */
-	ret = da9052_reg_update(da9052, DA9052_CONTROL_D_REG,
-				DA9052_CONTROLD_WATCHDOG, 0 << 7);
-err_strobe:
-	return ret;
+	return da9052_reg_update(da9052, DA9052_CONTROL_D_REG,
+				 DA9052_CONTROLD_WATCHDOG, 0 << 7);
 }
 
 static const struct watchdog_info da9052_wdt_info = {
@@ -163,10 +161,8 @@ static int da9052_wdt_probe(struct platform_device *pdev)
 
 	driver_data = devm_kzalloc(&pdev->dev, sizeof(*driver_data),
 				   GFP_KERNEL);
-	if (!driver_data) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!driver_data)
+		return -ENOMEM;
 	driver_data->da9052 = da9052;
 
 	da9052_wdt = &driver_data->wdt;
@@ -182,33 +178,21 @@ static int da9052_wdt_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to disable watchdog bits, %d\n",
 			ret);
-		goto err;
+		return ret;
 	}
 
-	ret = watchdog_register_device(&driver_data->wdt);
+	ret = devm_watchdog_register_device(&pdev->dev, &driver_data->wdt);
 	if (ret != 0) {
 		dev_err(da9052->dev, "watchdog_register_device() failed: %d\n",
 			ret);
-		goto err;
+		return ret;
 	}
 
-	platform_set_drvdata(pdev, driver_data);
-err:
 	return ret;
 }
 
-static int da9052_wdt_remove(struct platform_device *pdev)
-{
-	struct da9052_wdt_data *driver_data = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&driver_data->wdt);
-
-	return 0;
-}
-
 static struct platform_driver da9052_wdt_driver = {
 	.probe = da9052_wdt_probe,
-	.remove = da9052_wdt_remove,
 	.driver = {
 		.name	= "da9052-watchdog",
 	},
-- 
2.7.4
