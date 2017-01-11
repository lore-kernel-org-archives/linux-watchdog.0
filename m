Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42518 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935059AbdAKArQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jan 2017 19:47:16 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 49/62] watchdog: sama5d4_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 16:44:58 -0800
Message-Id: <1484095516-12720-19-git-send-email-linux@roeck-us.net>
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

- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sama5d4_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index a49634cdc1cc..8bb9d5bd7eab 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -234,7 +234,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(wdd, nowayout);
 
-	ret = watchdog_register_device(wdd);
+	ret = devm_watchdog_register_device(&pdev->dev, wdd);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register watchdog device\n");
 		return ret;
@@ -254,8 +254,6 @@ static int sama5d4_wdt_remove(struct platform_device *pdev)
 
 	sama5d4_wdt_stop(&wdt->wdd);
 
-	watchdog_unregister_device(&wdt->wdd);
-
 	return 0;
 }
 
-- 
2.7.4

