Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42409 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935059AbdAKArI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jan 2017 19:47:08 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 47/62] watchdog: retu_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 16:44:56 -0800
Message-Id: <1484095516-12720-17-git-send-email-linux@roeck-us.net>
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

- Drop assignments to otherwise unused variables
- Drop remove function
- Drop platform_set_drvdata()
- Call cancel_delayed_work_sync() using devm_add_action_or_reset()
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/retu_wdt.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/retu_wdt.c b/drivers/watchdog/retu_wdt.c
index 39cd51df2ffc..deba0e956c9f 100644
--- a/drivers/watchdog/retu_wdt.c
+++ b/drivers/watchdog/retu_wdt.c
@@ -136,8 +136,13 @@ static int retu_wdt_probe(struct platform_device *pdev)
 	wdev->dev		= &pdev->dev;
 
 	INIT_DELAYED_WORK(&wdev->ping_work, retu_wdt_ping_work);
+	ret = devm_add_action_or_reset(&pdev->dev,
+				(void(*)(void *))cancel_delayed_work_sync,
+				&wdev->ping_work);
+	if (ret)
+		return ret;
 
-	ret = watchdog_register_device(retu_wdt);
+	ret = devm_watchdog_register_device(&pdev->dev, retu_wdt);
 	if (ret < 0)
 		return ret;
 
@@ -146,25 +151,11 @@ static int retu_wdt_probe(struct platform_device *pdev)
 	else
 		retu_wdt_ping_enable(wdev);
 
-	platform_set_drvdata(pdev, retu_wdt);
-
-	return 0;
-}
-
-static int retu_wdt_remove(struct platform_device *pdev)
-{
-	struct watchdog_device *wdog = platform_get_drvdata(pdev);
-	struct retu_wdt_dev *wdev = watchdog_get_drvdata(wdog);
-
-	watchdog_unregister_device(wdog);
-	cancel_delayed_work_sync(&wdev->ping_work);
-
 	return 0;
 }
 
 static struct platform_driver retu_wdt_driver = {
 	.probe		= retu_wdt_probe,
-	.remove		= retu_wdt_remove,
 	.driver		= {
 		.name	= "retu-wdt",
 	},
-- 
2.7.4

