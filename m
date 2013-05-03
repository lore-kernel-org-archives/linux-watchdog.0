Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:56502 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934180Ab3ECULb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 May 2013 16:11:31 -0400
Received: by mail-pa0-f41.google.com with SMTP id rl6so1101512pac.0
        for <linux-watchdog@vger.kernel.org>; Fri, 03 May 2013 13:11:31 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, linux@roeck-us.net, sachin.kamat@linaro.org,
	Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: [PATCH 1/5] watchdog: at32ap700x: Remove redundant platform_set_drvdata()
Date: Sat,  4 May 2013 01:41:14 +0530
Message-Id: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
---
 drivers/watchdog/at32ap700x_wdt.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/at32ap700x_wdt.c b/drivers/watchdog/at32ap700x_wdt.c
index 7a715e3..18c6e61 100644
--- a/drivers/watchdog/at32ap700x_wdt.c
+++ b/drivers/watchdog/at32ap700x_wdt.c
@@ -364,7 +364,7 @@ static int __init at32_wdt_probe(struct platform_device *pdev)
 	ret = misc_register(&wdt->miscdev);
 	if (ret) {
 		dev_dbg(&pdev->dev, "failed to register wdt miscdev\n");
-		goto err_register;
+		goto err_iounmap;
 	}
 
 	dev_info(&pdev->dev,
@@ -373,8 +373,6 @@ static int __init at32_wdt_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_register:
-	platform_set_drvdata(pdev, NULL);
 err_iounmap:
 	iounmap(wdt->regs);
 err_free:
@@ -394,7 +392,6 @@ static int __exit at32_wdt_remove(struct platform_device *pdev)
 		iounmap(wdt->regs);
 		kfree(wdt);
 		wdt = NULL;
-		platform_set_drvdata(pdev, NULL);
 	}
 	return 0;
 }
-- 
1.7.4.1

