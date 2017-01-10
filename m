Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 08/62] watchdog: bcm_kona_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 15:34:25 -0800
Message-Id: <1484091325-9199-9-git-send-email-linux@roeck-us.net>
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

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/bcm_kona_wdt.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index 76b00805cd87..4592a205d8f9 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -288,11 +288,6 @@ static struct watchdog_device bcm_kona_wdt_wdd = {
 	.timeout =	SECWDOG_MAX_COUNT >> SECWDOG_DEFAULT_RESOLUTION,
 };
 
-static void bcm_kona_wdt_shutdown(struct platform_device *pdev)
-{
-	bcm_kona_wdt_stop(&bcm_kona_wdt_wdd);
-}
-
 static int bcm_kona_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -319,7 +314,7 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 	spin_lock_init(&wdt->lock);
 	platform_set_drvdata(pdev, wdt);
 	watchdog_set_drvdata(&bcm_kona_wdt_wdd, wdt);
-	bcm_kona_wdt_wdd.parent = &pdev->dev;
+	bcm_kona_wdt_wdd.parent = dev;
 
 	ret = bcm_kona_wdt_set_timeout_reg(&bcm_kona_wdt_wdd, 0);
 	if (ret) {
@@ -327,7 +322,8 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = watchdog_register_device(&bcm_kona_wdt_wdd);
+	watchdog_stop_on_reboot(&bcm_kona_wdt_wdd);
+	ret = devm_watchdog_register_device(dev, &bcm_kona_wdt_wdd);
 	if (ret) {
 		dev_err(dev, "Failed to register watchdog device");
 		return ret;
@@ -342,8 +338,7 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 static int bcm_kona_wdt_remove(struct platform_device *pdev)
 {
 	bcm_kona_wdt_debug_exit(pdev);
-	bcm_kona_wdt_shutdown(pdev);
-	watchdog_unregister_device(&bcm_kona_wdt_wdd);
+	bcm_kona_wdt_stop(platform_get_drvdata(pdev));
 	dev_dbg(&pdev->dev, "Watchdog driver disabled");
 
 	return 0;
@@ -362,7 +357,6 @@ static struct platform_driver bcm_kona_wdt_driver = {
 		  },
 	.probe = bcm_kona_wdt_probe,
 	.remove = bcm_kona_wdt_remove,
-	.shutdown = bcm_kona_wdt_shutdown,
 };
 
 module_platform_driver(bcm_kona_wdt_driver);
-- 
2.7.4
