Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42468 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935197AbdAKArK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jan 2017 19:47:10 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 48/62] watchdog: rt2880_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 16:44:57 -0800
Message-Id: <1484095516-12720-18-git-send-email-linux@roeck-us.net>
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

- Drop remove function
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/rt2880_wdt.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index 4c471fe7b854..a364a5f79823 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -166,25 +166,14 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
 			      &pdev->dev);
 	watchdog_set_nowayout(&rt288x_wdt_dev, nowayout);
 
-	ret = watchdog_register_device(&rt288x_wdt_dev);
+	watchdog_stop_on_reboot(&rt288x_wdt_dev);
+	ret = devm_watchdog_register_device(&pdev->dev, &rt288x_wdt_dev);
 	if (!ret)
 		dev_info(&pdev->dev, "Initialized\n");
 
 	return 0;
 }
 
-static int rt288x_wdt_remove(struct platform_device *pdev)
-{
-	watchdog_unregister_device(&rt288x_wdt_dev);
-
-	return 0;
-}
-
-static void rt288x_wdt_shutdown(struct platform_device *pdev)
-{
-	rt288x_wdt_stop(&rt288x_wdt_dev);
-}
-
 static const struct of_device_id rt288x_wdt_match[] = {
 	{ .compatible = "ralink,rt2880-wdt" },
 	{},
@@ -193,8 +182,6 @@ MODULE_DEVICE_TABLE(of, rt288x_wdt_match);
 
 static struct platform_driver rt288x_wdt_driver = {
 	.probe		= rt288x_wdt_probe,
-	.remove		= rt288x_wdt_remove,
-	.shutdown	= rt288x_wdt_shutdown,
 	.driver		= {
 		.name		= KBUILD_MODNAME,
 		.of_match_table	= rt288x_wdt_match,
-- 
2.7.4

