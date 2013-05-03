Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:49971 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934180Ab3ECULe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 May 2013 16:11:34 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj3so1094797pad.1
        for <linux-watchdog@vger.kernel.org>; Fri, 03 May 2013 13:11:33 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, linux@roeck-us.net, sachin.kamat@linaro.org
Subject: [PATCH 2/5] watchdog: mpcore: Remove redundant platform_set_drvdata()
Date: Sat,  4 May 2013 01:41:15 +0530
Message-Id: <1367611878-3784-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
References: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/watchdog/mpcore_wdt.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 233cfad..4f5ac40 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -379,8 +379,6 @@ static int mpcore_wdt_probe(struct platform_device *pdev)
 
 static int mpcore_wdt_remove(struct platform_device *pdev)
 {
-	platform_set_drvdata(pdev, NULL);
-
 	misc_deregister(&mpcore_wdt_miscdev);
 
 	mpcore_wdt_pdev = NULL;
-- 
1.7.4.1

