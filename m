Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:51336 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934198Ab3ECULn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 May 2013 16:11:43 -0400
Received: by mail-pa0-f45.google.com with SMTP id lj1so1095871pab.18
        for <linux-watchdog@vger.kernel.org>; Fri, 03 May 2013 13:11:43 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, linux@roeck-us.net, sachin.kamat@linaro.org,
	Timo Kokkonen <timo.t.kokkonen@nokia.com>
Subject: [PATCH 5/5] watchdog: twl4030: Remove redundant platform_set_drvdata()
Date: Sat,  4 May 2013 01:41:18 +0530
Message-Id: <1367611878-3784-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
References: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Timo Kokkonen <timo.t.kokkonen@nokia.com>
---
 drivers/watchdog/twl4030_wdt.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 0f03106..2d4535d 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -90,10 +90,8 @@ static int twl4030_wdt_probe(struct platform_device *pdev)
 	twl4030_wdt_stop(wdt);
 
 	ret = watchdog_register_device(wdt);
-	if (ret) {
-		platform_set_drvdata(pdev, NULL);
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
@@ -103,7 +101,6 @@ static int twl4030_wdt_remove(struct platform_device *pdev)
 	struct watchdog_device *wdt = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(wdt);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.4.1

