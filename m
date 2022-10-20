Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB6EC433FE
	for <linux-watchdog@archiver.kernel.org>; Thu, 20 Oct 2022 18:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJTSvg (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiJTSve (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 20 Oct 2022 14:51:34 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70B6156256;
        Thu, 20 Oct 2022 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666291856; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQZXeiJoM7b+oCY4wSe+cuIVpnUFu+3jGMCQghIgiAE=;
        b=KSZlzIwZ7zv1BtHDprWFJCCjVtX4LG3si1Q25EIAcmMdewXUHIeQr8V34Pk0vndAl3QbKZ
        sQLsF8O/cDlz6G5XYNv0t4kVmyJuowLOOHpRguseqO/vJY+nbcXW+xRq3S4W58bfCpGGCs
        E2/FZlre0GIYViQn5b6BNTPxLPLCnzg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/4] watchdog: kempld: Remove #ifdef guards for PM related functions
Date:   Thu, 20 Oct 2022 19:50:47 +0100
Message-Id: <20221020185047.1001522-5-paul@crapouillou.net>
In-Reply-To: <20221020185047.1001522-1-paul@crapouillou.net>
References: <20221020185047.1001522-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Use the pm_ptr() macro to handle the .suspend/.resume callbacks.

This macro allows the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards. Not using #ifdef guards means that the code is
always compiled independently of any Kconfig option, and thanks to that
bugs and regressions are easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/watchdog/kempld_wdt.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
index 40bd518ed873..e6c7a2906680 100644
--- a/drivers/watchdog/kempld_wdt.c
+++ b/drivers/watchdog/kempld_wdt.c
@@ -75,9 +75,7 @@ struct kempld_wdt_data {
 	struct watchdog_device		wdd;
 	unsigned int			pretimeout;
 	struct kempld_wdt_stage		stage[KEMPLD_WDT_MAX_STAGES];
-#ifdef CONFIG_PM
 	u8				pm_status_store;
-#endif
 };
 
 #define DEFAULT_TIMEOUT		30 /* seconds */
@@ -495,7 +493,6 @@ static int kempld_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 /* Disable watchdog if it is active during suspend */
 static int kempld_wdt_suspend(struct platform_device *pdev,
 				pm_message_t message)
@@ -531,18 +528,14 @@ static int kempld_wdt_resume(struct platform_device *pdev)
 	else
 		return kempld_wdt_stop(wdd);
 }
-#else
-#define kempld_wdt_suspend	NULL
-#define kempld_wdt_resume	NULL
-#endif
 
 static struct platform_driver kempld_wdt_driver = {
 	.driver		= {
 		.name	= "kempld-wdt",
 	},
 	.probe		= kempld_wdt_probe,
-	.suspend	= kempld_wdt_suspend,
-	.resume		= kempld_wdt_resume,
+	.suspend	= pm_ptr(kempld_wdt_suspend),
+	.resume		= pm_ptr(kempld_wdt_resume),
 };
 
 module_platform_driver(kempld_wdt_driver);
-- 
2.35.1

