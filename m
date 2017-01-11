Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Andreas Werner <andreas.werner@men.de>
Subject: [PATCH 31/62] watchdog: menf21bmc_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 16:44:40 -0800
Message-Id: <1484095516-12720-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop assignments to otherwise unused variables
- Drop remove function
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Andreas Werner <andreas.werner@men.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/menf21bmc_wdt.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/watchdog/menf21bmc_wdt.c b/drivers/watchdog/menf21bmc_wdt.c
index 3aefddebb386..8d0f60ee7a7c 100644
--- a/drivers/watchdog/menf21bmc_wdt.c
+++ b/drivers/watchdog/menf21bmc_wdt.c
@@ -155,7 +155,7 @@ static int menf21bmc_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = watchdog_register_device(&drv_data->wdt);
+	ret = devm_watchdog_register_device(&pdev->dev, &drv_data->wdt);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register Watchdog device\n");
 		return ret;
@@ -166,18 +166,6 @@ static int menf21bmc_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int menf21bmc_wdt_remove(struct platform_device *pdev)
-{
-	struct menf21bmc_wdt *drv_data = platform_get_drvdata(pdev);
-
-	dev_warn(&pdev->dev,
-		 "Unregister MEN 14F021P00 BMC Watchdog device, board may reset\n");
-
-	watchdog_unregister_device(&drv_data->wdt);
-
-	return 0;
-}
-
 static void menf21bmc_wdt_shutdown(struct platform_device *pdev)
 {
 	struct menf21bmc_wdt *drv_data = platform_get_drvdata(pdev);
@@ -191,7 +179,6 @@ static struct  platform_driver menf21bmc_wdt = {
 		.name	= DEVNAME,
 	},
 	.probe		= menf21bmc_wdt_probe,
-	.remove		= menf21bmc_wdt_remove,
 	.shutdown	= menf21bmc_wdt_shutdown,
 };
 
-- 
2.7.4
