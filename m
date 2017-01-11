Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	patches@opensource.wolfsonmicro.com
Subject: [PATCH 62/62] watchdog: wm831x_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 18:09:16 -0800
Message-Id: <1484100561-17638-11-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484100561-17638-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
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

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/wm831x_wdt.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index 8d1184aee932..1ddc1f742cd4 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -194,7 +194,7 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(wm831x->dev, "Failed to read watchdog status: %d\n",
 			ret);
-		goto err;
+		return ret;
 	}
 	reg = ret;
 
@@ -203,10 +203,8 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 
 	driver_data = devm_kzalloc(&pdev->dev, sizeof(*driver_data),
 				   GFP_KERNEL);
-	if (!driver_data) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!driver_data)
+		return -ENOMEM;
 
 	mutex_init(&driver_data->lock);
 	driver_data->wm831x = wm831x;
@@ -253,7 +251,7 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 				dev_err(wm831x->dev,
 					"Failed to request update GPIO: %d\n",
 					ret);
-				goto err;
+				return ret;
 			}
 
 			driver_data->update_gpio = pdata->update_gpio;
@@ -269,37 +267,22 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 		} else {
 			dev_err(wm831x->dev,
 				"Failed to unlock security key: %d\n", ret);
-			goto err;
+			return ret;
 		}
 	}
 
-	ret = watchdog_register_device(&driver_data->wdt);
+	ret = devm_watchdog_register_device(&pdev->dev, &driver_data->wdt);
 	if (ret != 0) {
 		dev_err(wm831x->dev, "watchdog_register_device() failed: %d\n",
 			ret);
-		goto err;
+		return ret;
 	}
 
-	platform_set_drvdata(pdev, driver_data);
-
-	return 0;
-
-err:
-	return ret;
-}
-
-static int wm831x_wdt_remove(struct platform_device *pdev)
-{
-	struct wm831x_wdt_drvdata *driver_data = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&driver_data->wdt);
-
 	return 0;
 }
 
 static struct platform_driver wm831x_wdt_driver = {
 	.probe = wm831x_wdt_probe,
-	.remove = wm831x_wdt_remove,
 	.driver = {
 		.name = "wm831x-watchdog",
 	},
-- 
2.7.4
