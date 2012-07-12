Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53094 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab2GLLsF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 12 Jul 2012 07:48:05 -0400
Received: by yenl2 with SMTP id l2so2275655yen.19
        for <linux-watchdog@vger.kernel.org>; Thu, 12 Jul 2012 04:48:03 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, ben-linux@fluff.org, sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH] watchdog: s3c2410_wdt: Use module_platform_driver()
Date: Thu, 12 Jul 2012 17:17:40 +0530
Message-Id: <1342093660-19735-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

module_platform_driver() replaces module_init() and module_exit()
and makes the code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/watchdog/s3c2410_wdt.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 200ece5..9245b4d 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -519,21 +519,7 @@ static struct platform_driver s3c2410wdt_driver = {
 	},
 };
 
-
-static int __init watchdog_init(void)
-{
-	pr_info("S3C2410 Watchdog Timer, (c) 2004 Simtec Electronics\n");
-
-	return platform_driver_register(&s3c2410wdt_driver);
-}
-
-static void __exit watchdog_exit(void)
-{
-	platform_driver_unregister(&s3c2410wdt_driver);
-}
-
-module_init(watchdog_init);
-module_exit(watchdog_exit);
+module_platform_driver(s3c2410wdt_driver);
 
 MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>, "
 	      "Dimitry Andric <dimitry.andric@tomtom.com>");
-- 
1.7.4.1

