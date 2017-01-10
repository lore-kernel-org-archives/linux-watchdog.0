Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 25/62] watchdog: kempld_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 15:34:42 -0800
Message-Id: <1484091325-9199-26-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace &pdev->dev with dev if 'struct device *dev' is a declared
  variable
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/kempld_wdt.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
index 73c46b3a09ab..440b34ba3017 100644
--- a/drivers/watchdog/kempld_wdt.c
+++ b/drivers/watchdog/kempld_wdt.c
@@ -490,7 +490,8 @@ static int kempld_wdt_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, wdt_data);
-	ret = watchdog_register_device(wdd);
+	watchdog_stop_on_reboot(wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret)
 		return ret;
 
@@ -499,13 +500,6 @@ static int kempld_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void kempld_wdt_shutdown(struct platform_device *pdev)
-{
-	struct kempld_wdt_data *wdt_data = platform_get_drvdata(pdev);
-
-	kempld_wdt_stop(&wdt_data->wdd);
-}
-
 static int kempld_wdt_remove(struct platform_device *pdev)
 {
 	struct kempld_wdt_data *wdt_data = platform_get_drvdata(pdev);
@@ -514,7 +508,6 @@ static int kempld_wdt_remove(struct platform_device *pdev)
 
 	if (!nowayout)
 		ret = kempld_wdt_stop(wdd);
-	watchdog_unregister_device(wdd);
 
 	return ret;
 }
@@ -566,7 +559,6 @@ static struct platform_driver kempld_wdt_driver = {
 	},
 	.probe		= kempld_wdt_probe,
 	.remove		= kempld_wdt_remove,
-	.shutdown	= kempld_wdt_shutdown,
 	.suspend	= kempld_wdt_suspend,
 	.resume		= kempld_wdt_resume,
 };
-- 
2.7.4
