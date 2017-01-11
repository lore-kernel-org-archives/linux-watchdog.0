Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 61/62] watchdog: ux500_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 18:09:15 -0800
Message-Id: <1484100561-17638-10-git-send-email-linux@roeck-us.net>
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

- Drop remove function
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/ux500_wdt.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/watchdog/ux500_wdt.c b/drivers/watchdog/ux500_wdt.c
index 37c084353cce..847b6658c36d 100644
--- a/drivers/watchdog/ux500_wdt.c
+++ b/drivers/watchdog/ux500_wdt.c
@@ -105,7 +105,7 @@ static int ux500_wdt_probe(struct platform_device *pdev)
 	/* set HW initial value */
 	prcmu_load_a9wdog(PRCMU_WDOG_ALL, timeout * 1000);
 
-	ret = watchdog_register_device(&ux500_wdt);
+	ret = devm_watchdog_register_device(&pdev->dev, &ux500_wdt);
 	if (ret)
 		return ret;
 
@@ -114,13 +114,6 @@ static int ux500_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ux500_wdt_remove(struct platform_device *dev)
-{
-	watchdog_unregister_device(&ux500_wdt);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int ux500_wdt_suspend(struct platform_device *pdev,
 			     pm_message_t state)
@@ -153,7 +146,6 @@ static int ux500_wdt_resume(struct platform_device *pdev)
 
 static struct platform_driver ux500_wdt_driver = {
 	.probe		= ux500_wdt_probe,
-	.remove		= ux500_wdt_remove,
 	.suspend	= ux500_wdt_suspend,
 	.resume		= ux500_wdt_resume,
 	.driver		= {
-- 
2.7.4
