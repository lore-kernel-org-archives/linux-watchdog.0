Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42680 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935316AbdAKAr2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jan 2017 19:47:28 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 51/62] watchdog: shwdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 16:45:00 -0800
Message-Id: <1484095516-12720-21-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484095516-12720-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/shwdt.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index 517a733175ef..98cc70bd7821 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -269,7 +269,8 @@ static int sh_wdt_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "configured with heartbeat=%d sec (nowayout=%d)\n",
 		 sh_wdt_dev.timeout, nowayout);
 
-	rc = watchdog_register_device(&sh_wdt_dev);
+	watchdog_stop_on_reboot(&sh_wdt_dev);
+	rc = devm_watchdog_register_device(&pdev->dev, &sh_wdt_dev);
 	if (unlikely(rc)) {
 		dev_err(&pdev->dev, "Can't register watchdog (err=%d)\n", rc);
 		return rc;
@@ -287,18 +288,11 @@ static int sh_wdt_probe(struct platform_device *pdev)
 
 static int sh_wdt_remove(struct platform_device *pdev)
 {
-	watchdog_unregister_device(&sh_wdt_dev);
-
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
 
-static void sh_wdt_shutdown(struct platform_device *pdev)
-{
-	sh_wdt_stop(&sh_wdt_dev);
-}
-
 static struct platform_driver sh_wdt_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
@@ -306,7 +300,6 @@ static struct platform_driver sh_wdt_driver = {
 
 	.probe		= sh_wdt_probe,
 	.remove		= sh_wdt_remove,
-	.shutdown	= sh_wdt_shutdown,
 };
 
 static int __init sh_wdt_init(void)
-- 
2.7.4

