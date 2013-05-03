Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:34849 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934180Ab3ECULk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 May 2013 16:11:40 -0400
Received: by mail-da0-f50.google.com with SMTP id i23so958797dad.37
        for <linux-watchdog@vger.kernel.org>; Fri, 03 May 2013 13:11:40 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, linux@roeck-us.net, sachin.kamat@linaro.org,
	Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH 4/5] watchdog: ts72xx: Remove redundant platform_set_drvdata()
Date: Sat,  4 May 2013 01:41:17 +0530
Message-Id: <1367611878-3784-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
References: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
---
 drivers/watchdog/ts72xx_wdt.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index b8a9245..be59bf1 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -463,7 +463,6 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
 	return 0;
 
 fail_unmap_feed:
-	platform_set_drvdata(pdev, NULL);
 	iounmap(wdt->feed_reg);
 fail_free_feed:
 	release_mem_region(r2->start, resource_size(r2));
@@ -483,7 +482,6 @@ static int ts72xx_wdt_remove(struct platform_device *pdev)
 	int error;
 
 	error = misc_deregister(&ts72xx_wdt_miscdev);
-	platform_set_drvdata(pdev, NULL);
 
 	iounmap(wdt->feed_reg);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-- 
1.7.4.1

