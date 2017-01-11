Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52217 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935739AbdAKCJZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jan 2017 21:09:25 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Barry Song <baohua@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 52/62] watchdog: sirfsoc_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 18:09:06 -0800
Message-Id: <1484100561-17638-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
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

Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sirfsoc_wdt.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
index 3050a0031479..fb88e04d18ae 100644
--- a/drivers/watchdog/sirfsoc_wdt.c
+++ b/drivers/watchdog/sirfsoc_wdt.c
@@ -161,7 +161,8 @@ static int sirfsoc_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(&sirfsoc_wdd, nowayout);
 	sirfsoc_wdd.parent = &pdev->dev;
 
-	ret = watchdog_register_device(&sirfsoc_wdd);
+	watchdog_stop_on_reboot(&sirfsoc_wdd);
+	ret = devm_watchdog_register_device(&pdev->dev, &sirfsoc_wdd);
 	if (ret)
 		return ret;
 
@@ -170,16 +171,9 @@ static int sirfsoc_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void sirfsoc_wdt_shutdown(struct platform_device *pdev)
-{
-	struct watchdog_device *wdd = platform_get_drvdata(pdev);
-
-	sirfsoc_wdt_disable(wdd);
-}
-
 static int sirfsoc_wdt_remove(struct platform_device *pdev)
 {
-	sirfsoc_wdt_shutdown(pdev);
+	sirfsoc_wdt_disable(platform_get_drvdata(pdev));
 	return 0;
 }
 
@@ -221,7 +215,6 @@ static struct platform_driver sirfsoc_wdt_driver = {
 	},
 	.probe = sirfsoc_wdt_probe,
 	.remove = sirfsoc_wdt_remove,
-	.shutdown = sirfsoc_wdt_shutdown,
 };
 module_platform_driver(sirfsoc_wdt_driver);
 
-- 
2.7.4

