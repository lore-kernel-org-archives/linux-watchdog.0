Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 55/62] watchdog: sunxi_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 18:09:09 -0800
Message-Id: <1484100561-17638-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484100561-17638-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop assignments to otherwise unused variables
- Drop remove function
- Drop platform_set_drvdata()
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sunxi_wdt.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index 953bb7b7446f..9728fa32c357 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -242,8 +242,6 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 	if (!sunxi_wdt)
 		return -EINVAL;
 
-	platform_set_drvdata(pdev, sunxi_wdt);
-
 	device = of_match_device(sunxi_wdt_dt_ids, &pdev->dev);
 	if (!device)
 		return -ENODEV;
@@ -270,7 +268,8 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 
 	sunxi_wdt_stop(&sunxi_wdt->wdt_dev);
 
-	err = watchdog_register_device(&sunxi_wdt->wdt_dev);
+	watchdog_stop_on_reboot(&sunxi_wdt->wdt_dev);
+	err = devm_watchdog_register_device(&pdev->dev, &sunxi_wdt->wdt_dev);
 	if (unlikely(err))
 		return err;
 
@@ -280,27 +279,8 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sunxi_wdt_remove(struct platform_device *pdev)
-{
-	struct sunxi_wdt_dev *sunxi_wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&sunxi_wdt->wdt_dev);
-	watchdog_set_drvdata(&sunxi_wdt->wdt_dev, NULL);
-
-	return 0;
-}
-
-static void sunxi_wdt_shutdown(struct platform_device *pdev)
-{
-	struct sunxi_wdt_dev *sunxi_wdt = platform_get_drvdata(pdev);
-
-	sunxi_wdt_stop(&sunxi_wdt->wdt_dev);
-}
-
 static struct platform_driver sunxi_wdt_driver = {
 	.probe		= sunxi_wdt_probe,
-	.remove		= sunxi_wdt_remove,
-	.shutdown	= sunxi_wdt_shutdown,
 	.driver		= {
 		.name		= DRV_NAME,
 		.of_match_table	= sunxi_wdt_dt_ids,
-- 
2.7.4
