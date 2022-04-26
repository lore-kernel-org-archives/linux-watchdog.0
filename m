Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C431FC433F5
	for <linux-watchdog@archiver.kernel.org>; Tue, 26 Apr 2022 10:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348817AbiDZKfD (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 26 Apr 2022 06:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349317AbiDZKeU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 26 Apr 2022 06:34:20 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 488C416364C;
        Tue, 26 Apr 2022 03:11:51 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.218:37508.612897310
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.38 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id 18CDD2800CF;
        Tue, 26 Apr 2022 18:11:48 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.218])
        by app0025 with ESMTP id 42be121b77544c41ad37d78d886e96d1 for wim@linux-watchdog.org;
        Tue, 26 Apr 2022 18:11:51 CST
X-Transaction-ID: 42be121b77544c41ad37d78d886e96d1
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net, tzungbi@kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v6 1/1] watchdog: iTCO_wdt: Using existing macro define covers more scenarios
Date:   Tue, 26 Apr 2022 18:11:45 +0800
Message-Id: <1650967905-3199-1-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

For power management, SET_NOIRQ_SYSTEM_SLEEP_PM_OPS defined for
CONFIG_PM_SLEEP, will point ->suspend_noirq, ->freeze_noirq and
->poweroff_noirq to the same function. Vice versa happens for
->resume_noirq, ->thaw_noirq and ->restore_noirq.

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 drivers/watchdog/iTCO_wdt.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 3f2f4343644f..34693f11385f 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -596,7 +596,6 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 /*
  * Suspend-to-idle requires this, because it stops the ticks and timekeeping, so
  * the watchdog cannot be pinged while in that state.  In ACPI sleep states the
@@ -604,15 +603,15 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
  */
 
 #ifdef CONFIG_ACPI
-static inline bool need_suspend(void)
+static inline bool __maybe_unused need_suspend(void)
 {
 	return acpi_target_system_state() == ACPI_STATE_S0;
 }
 #else
-static inline bool need_suspend(void) { return true; }
+static inline bool __maybe_unused need_suspend(void) { return true; }
 #endif
 
-static int iTCO_wdt_suspend_noirq(struct device *dev)
+static int __maybe_unused iTCO_wdt_suspend_noirq(struct device *dev)
 {
 	struct iTCO_wdt_private *p = dev_get_drvdata(dev);
 	int ret = 0;
@@ -626,7 +625,7 @@ static int iTCO_wdt_suspend_noirq(struct device *dev)
 	return ret;
 }
 
-static int iTCO_wdt_resume_noirq(struct device *dev)
+static int __maybe_unused iTCO_wdt_resume_noirq(struct device *dev)
 {
 	struct iTCO_wdt_private *p = dev_get_drvdata(dev);
 
@@ -637,20 +636,15 @@ static int iTCO_wdt_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops iTCO_wdt_pm = {
-	.suspend_noirq = iTCO_wdt_suspend_noirq,
-	.resume_noirq = iTCO_wdt_resume_noirq,
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(iTCO_wdt_suspend_noirq,
+				      iTCO_wdt_resume_noirq)
 };
 
-#define ITCO_WDT_PM_OPS	(&iTCO_wdt_pm)
-#else
-#define ITCO_WDT_PM_OPS	NULL
-#endif /* CONFIG_PM_SLEEP */
-
 static struct platform_driver iTCO_wdt_driver = {
 	.probe          = iTCO_wdt_probe,
 	.driver         = {
 		.name   = DRV_NAME,
-		.pm     = ITCO_WDT_PM_OPS,
+		.pm     = &iTCO_wdt_pm,
 	},
 };
 
-- 
2.23.0

