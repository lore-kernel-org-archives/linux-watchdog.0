Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 36/62] watchdog: mt7621_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 16:44:45 -0800
Message-Id: <1484095516-12720-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484095516-12720-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop remove function
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/mt7621_wdt.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index 2fb5a3085521..ba4a4e1a68e2 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -145,23 +145,12 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
 			      &pdev->dev);
 	watchdog_set_nowayout(&mt7621_wdt_dev, nowayout);
 
-	ret = watchdog_register_device(&mt7621_wdt_dev);
+	watchdog_stop_on_reboot(&mt7621_wdt_dev);
+	ret = devm_watchdog_register_device(&pdev->dev, &mt7621_wdt_dev);
 
 	return 0;
 }
 
-static int mt7621_wdt_remove(struct platform_device *pdev)
-{
-	watchdog_unregister_device(&mt7621_wdt_dev);
-
-	return 0;
-}
-
-static void mt7621_wdt_shutdown(struct platform_device *pdev)
-{
-	mt7621_wdt_stop(&mt7621_wdt_dev);
-}
-
 static const struct of_device_id mt7621_wdt_match[] = {
 	{ .compatible = "mediatek,mt7621-wdt" },
 	{},
@@ -170,8 +159,6 @@ MODULE_DEVICE_TABLE(of, mt7621_wdt_match);
 
 static struct platform_driver mt7621_wdt_driver = {
 	.probe		= mt7621_wdt_probe,
-	.remove		= mt7621_wdt_remove,
-	.shutdown	= mt7621_wdt_shutdown,
 	.driver		= {
 		.name		= KBUILD_MODNAME,
 		.of_match_table	= mt7621_wdt_match,
-- 
2.7.4
