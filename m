Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.176.135]:52614 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbaBOJWR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Feb 2014 04:22:17 -0500
Received: from smtp3.mail.ru (smtp3.mail.ru [94.100.176.131])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 156E3F8AE278
	for <linux-watchdog@vger.kernel.org>; Sat, 15 Feb 2014 13:22:16 +0400 (MSK)
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] watchdog: indydog: Simplify indydog_{start,stop}
Date: Sat, 15 Feb 2014 13:21:51 +0400
Message-Id: <1392456111-29962-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch simplify functions indydog_start() and indydog_stop()
a bit and removes excess intermediate variable.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/watchdog/indydog.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/indydog.c b/drivers/watchdog/indydog.c
index 1b5c25a..5d20cdd 100644
--- a/drivers/watchdog/indydog.c
+++ b/drivers/watchdog/indydog.c
@@ -41,24 +41,15 @@ MODULE_PARM_DESC(nowayout,
 
 static void indydog_start(void)
 {
-	u32 mc_ctrl0;
-
 	spin_lock(&indydog_lock);
-	mc_ctrl0 = sgimc->cpuctrl0;
-	mc_ctrl0 = sgimc->cpuctrl0 | SGIMC_CCTRL0_WDOG;
-	sgimc->cpuctrl0 = mc_ctrl0;
+	sgimc->cpuctrl0 |= SGIMC_CCTRL0_WDOG;
 	spin_unlock(&indydog_lock);
 }
 
 static void indydog_stop(void)
 {
-	u32 mc_ctrl0;
-
 	spin_lock(&indydog_lock);
-
-	mc_ctrl0 = sgimc->cpuctrl0;
-	mc_ctrl0 &= ~SGIMC_CCTRL0_WDOG;
-	sgimc->cpuctrl0 = mc_ctrl0;
+	sgimc->cpuctrl0 &= ~SGIMC_CCTRL0_WDOG;
 	spin_unlock(&indydog_lock);
 
 	pr_info("Stopped watchdog timer\n");
-- 
1.8.3.2

