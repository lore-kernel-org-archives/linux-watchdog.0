Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 12/62] watchdog: da9055_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:29 -0800
Message-Id: <1484091325-9199-13-git-send-email-linux@roeck-us.net>
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
- Drop assignments to otherwise unused variables
- Drop remove function
- Drop platform_set_drvdata()
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Support Opensource <support.opensource@diasemi.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/da9055_wdt.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
index 4f30818cf93f..50bdd1022186 100644
--- a/drivers/watchdog/da9055_wdt.c
+++ b/drivers/watchdog/da9055_wdt.c
@@ -147,32 +147,19 @@ static int da9055_wdt_probe(struct platform_device *pdev)
 	ret = da9055_wdt_stop(da9055_wdt);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to stop watchdog, %d\n", ret);
-		goto err;
+		return ret;
 	}
 
-	platform_set_drvdata(pdev, driver_data);
-
-	ret = watchdog_register_device(&driver_data->wdt);
+	ret = devm_watchdog_register_device(&pdev->dev, &driver_data->wdt);
 	if (ret != 0)
 		dev_err(da9055->dev, "watchdog_register_device() failed: %d\n",
 			ret);
 
-err:
 	return ret;
 }
 
-static int da9055_wdt_remove(struct platform_device *pdev)
-{
-	struct da9055_wdt_data *driver_data = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&driver_data->wdt);
-
-	return 0;
-}
-
 static struct platform_driver da9055_wdt_driver = {
 	.probe = da9055_wdt_probe,
-	.remove = da9055_wdt_remove,
 	.driver = {
 		.name	= "da9055-watchdog",
 	},
-- 
2.7.4
