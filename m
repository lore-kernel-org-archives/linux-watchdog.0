Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:57012 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934180Ab3ECULh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 May 2013 16:11:37 -0400
Received: by mail-pd0-f169.google.com with SMTP id 14so1095102pdc.14
        for <linux-watchdog@vger.kernel.org>; Fri, 03 May 2013 13:11:37 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, linux@roeck-us.net, sachin.kamat@linaro.org,
	Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH 3/5] watchdog: shwdt: Remove redundant platform_set_drvdata()
Date: Sat,  4 May 2013 01:41:16 +0530
Message-Id: <1367611878-3784-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
References: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 drivers/watchdog/shwdt.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index 6185af2..552b5c8 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -303,8 +303,6 @@ static int sh_wdt_remove(struct platform_device *pdev)
 {
 	struct sh_wdt *wdt = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	watchdog_unregister_device(&sh_wdt_dev);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.4.1

