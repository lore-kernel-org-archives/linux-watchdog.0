Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42287 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935105AbdAKAqv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jan 2017 19:46:51 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 45/62] watchdog: qcom-wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 16:44:54 -0800
Message-Id: <1484095516-12720-15-git-send-email-linux@roeck-us.net>
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
 drivers/watchdog/qcom-wdt.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 4f47b5e90956..e021aaf73b47 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -185,6 +185,11 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to setup clock\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       wdt->clk);
+	if (ret)
+		return ret;
 
 	/*
 	 * We use the clock rate to calculate the max timeout, so ensure it's
@@ -198,8 +203,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	if (wdt->rate == 0 ||
 	    wdt->rate > 0x10000000U) {
 		dev_err(&pdev->dev, "invalid clock rate\n");
-		ret = -EINVAL;
-		goto err_clk_unprepare;
+		return -EINVAL;
 	}
 
 	wdt->wdd.info = &qcom_wdt_info;
@@ -220,26 +224,12 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.timeout = min(wdt->wdd.max_timeout, 30U);
 	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
 
-	ret = watchdog_register_device(&wdt->wdd);
+	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register watchdog\n");
-		goto err_clk_unprepare;
+		return ret;
 	}
 
-	platform_set_drvdata(pdev, wdt);
-	return 0;
-
-err_clk_unprepare:
-	clk_disable_unprepare(wdt->clk);
-	return ret;
-}
-
-static int qcom_wdt_remove(struct platform_device *pdev)
-{
-	struct qcom_wdt *wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&wdt->wdd);
-	clk_disable_unprepare(wdt->clk);
 	return 0;
 }
 
@@ -253,7 +243,6 @@ MODULE_DEVICE_TABLE(of, qcom_wdt_of_table);
 
 static struct platform_driver qcom_watchdog_driver = {
 	.probe	= qcom_wdt_probe,
-	.remove	= qcom_wdt_remove,
 	.driver	= {
 		.name		= KBUILD_MODNAME,
 		.of_match_table	= qcom_wdt_of_table,
-- 
2.7.4

