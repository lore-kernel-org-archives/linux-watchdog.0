Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42343 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935059AbdAKAq5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jan 2017 19:46:57 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 46/62] watchdog: renesas_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 16:44:55 -0800
Message-Id: <1484095516-12720-16-git-send-email-linux@roeck-us.net>
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

- Drop assignments to otherwise unused variables
- Drop platform_set_drvdata()
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/renesas_wdt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index cf61c92f7ecd..f11a5c0583be 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -157,7 +157,6 @@ static int rwdt_probe(struct platform_device *pdev)
 	priv->wdev.max_timeout = 65536 / clks_per_sec;
 	priv->wdev.timeout = min(priv->wdev.max_timeout, RWDT_DEFAULT_TIMEOUT);
 
-	platform_set_drvdata(pdev, priv);
 	watchdog_set_drvdata(&priv->wdev, priv);
 	watchdog_set_nowayout(&priv->wdev, nowayout);
 
@@ -166,7 +165,7 @@ static int rwdt_probe(struct platform_device *pdev)
 	if (ret)
 		dev_warn(&pdev->dev, "Specified timeout value invalid, using default\n");
 
-	ret = watchdog_register_device(&priv->wdev);
+	ret = devm_watchdog_register_device(&pdev->dev, &priv->wdev);
 	if (ret < 0) {
 		pm_runtime_put(&pdev->dev);
 		pm_runtime_disable(&pdev->dev);
@@ -178,9 +177,6 @@ static int rwdt_probe(struct platform_device *pdev)
 
 static int rwdt_remove(struct platform_device *pdev)
 {
-	struct rwdt_priv *priv = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&priv->wdev);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.7.4

