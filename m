Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42145 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934946AbdAKAqi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jan 2017 19:46:38 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 43/62] watchdog: pic32-wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 16:44:52 -0800
Message-Id: <1484095516-12720-13-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484095516-12720-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'val = e; return val;' with 'return e;'
- Drop assignments to otherwise unused variables
- Drop remove function
- Drop platform_set_drvdata()
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/pic32-wdt.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/watchdog/pic32-wdt.c b/drivers/watchdog/pic32-wdt.c
index e2761068dc6f..818d868c4f3e 100644
--- a/drivers/watchdog/pic32-wdt.c
+++ b/drivers/watchdog/pic32-wdt.c
@@ -197,19 +197,22 @@ static int pic32_wdt_drv_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "clk enable failed\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       wdt->clk);
+	if (ret)
+		return ret;
 
 	if (pic32_wdt_is_win_enabled(wdt)) {
 		dev_err(&pdev->dev, "windowed-clear mode is not supported.\n");
-		ret = -ENODEV;
-		goto out_disable_clk;
+		return -ENODEV;
 	}
 
 	wdd->timeout = pic32_wdt_get_timeout_secs(wdt, &pdev->dev);
 	if (!wdd->timeout) {
 		dev_err(&pdev->dev,
 			"failed to read watchdog register timeout\n");
-		ret = -EINVAL;
-		goto out_disable_clk;
+		return -EINVAL;
 	}
 
 	dev_info(&pdev->dev, "timeout %d\n", wdd->timeout);
@@ -219,36 +222,17 @@ static int pic32_wdt_drv_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(wdd, WATCHDOG_NOWAYOUT);
 	watchdog_set_drvdata(wdd, wdt);
 
-	ret = watchdog_register_device(wdd);
+	ret = devm_watchdog_register_device(&pdev->dev, wdd);
 	if (ret) {
 		dev_err(&pdev->dev, "watchdog register failed, err %d\n", ret);
-		goto out_disable_clk;
+		return ret;
 	}
 
-	platform_set_drvdata(pdev, wdd);
-
-	return 0;
-
-out_disable_clk:
-	clk_disable_unprepare(wdt->clk);
-
-	return ret;
-}
-
-static int pic32_wdt_drv_remove(struct platform_device *pdev)
-{
-	struct watchdog_device *wdd = platform_get_drvdata(pdev);
-	struct pic32_wdt *wdt = watchdog_get_drvdata(wdd);
-
-	watchdog_unregister_device(wdd);
-	clk_disable_unprepare(wdt->clk);
-
 	return 0;
 }
 
 static struct platform_driver pic32_wdt_driver = {
 	.probe		= pic32_wdt_drv_probe,
-	.remove		= pic32_wdt_drv_remove,
 	.driver		= {
 		.name		= "pic32-wdt",
 		.of_match_table = of_match_ptr(pic32_wdt_dt_ids),
-- 
2.7.4

