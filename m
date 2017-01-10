Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 18/62] watchdog: ep93xx_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:35 -0800
Message-Id: <1484091325-9199-19-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop remove function
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/ep93xx_wdt.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 0a4d7cc05d54..343299e84445 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -138,7 +138,7 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 
 	setup_timer(&timer, ep93xx_wdt_timer_ping, 1);
 
-	err = watchdog_register_device(&ep93xx_wdt_wdd);
+	err = devm_watchdog_register_device(&pdev->dev, &ep93xx_wdt_wdd);
 	if (err)
 		return err;
 
@@ -149,18 +149,11 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ep93xx_wdt_remove(struct platform_device *pdev)
-{
-	watchdog_unregister_device(&ep93xx_wdt_wdd);
-	return 0;
-}
-
 static struct platform_driver ep93xx_wdt_driver = {
 	.driver		= {
 		.name	= "ep93xx-wdt",
 	},
 	.probe		= ep93xx_wdt_probe,
-	.remove		= ep93xx_wdt_remove,
 };
 
 module_platform_driver(ep93xx_wdt_driver);
-- 
2.7.4
