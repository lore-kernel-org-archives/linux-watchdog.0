Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from fallback1.mail.ru ([94.100.176.18]:42497 "EHLO
	fallback1.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbaBOJXL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Feb 2014 04:23:11 -0500
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [94.100.177.99])
	by fallback1.mail.ru (mPOP.Fallback_MX) with ESMTP id 280B833F1896
	for <linux-watchdog@vger.kernel.org>; Sat, 15 Feb 2014 13:23:09 +0400 (MSK)
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] watchdog: sc520_wdt: Remove unused variable
Date: Sat, 15 Feb 2014 13:22:49 +0400
Message-Id: <1392456169-30042-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Variable "dummy" is not used anywhere in the function wdt_config().
This patch removes this variable.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/watchdog/sc520_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/sc520_wdt.c b/drivers/watchdog/sc520_wdt.c
index f353e18..1cfd3f6 100644
--- a/drivers/watchdog/sc520_wdt.c
+++ b/drivers/watchdog/sc520_wdt.c
@@ -158,12 +158,11 @@ static void wdt_timer_ping(unsigned long data)
 
 static void wdt_config(int writeval)
 {
-	__u16 dummy;
 	unsigned long flags;
 
 	/* buy some time (ping) */
 	spin_lock_irqsave(&wdt_spinlock, flags);
-	dummy = readw(wdtmrctl);	/* ensure write synchronization */
+	readw(wdtmrctl);	/* ensure write synchronization */
 	writew(0xAAAA, wdtmrctl);
 	writew(0x5555, wdtmrctl);
 	/* unlock WDT = make WDT configuration register writable one time */
-- 
1.8.3.2

