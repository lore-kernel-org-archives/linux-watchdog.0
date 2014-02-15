Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.176.135]:52508 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbaBOJVj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Feb 2014 04:21:39 -0500
Received: from smtp53.i.mail.ru (smtp53.i.mail.ru [94.100.177.113])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 427EFF8AE275
	for <linux-watchdog@vger.kernel.org>; Sat, 15 Feb 2014 13:21:35 +0400 (MSK)
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] watchdog: bcm63xx_wdt: Remove unused field from bcm63xx_wdt_device
Date: Sat, 15 Feb 2014 13:21:03 +0400
Message-Id: <1392456063-29918-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Field "default_ticks" is not used anywhere in the driver code.
This patch removes this field.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/watchdog/bcm63xx_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 4eb188b..d055e3c 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -45,7 +45,6 @@
 static struct {
 	void __iomem *regs;
 	struct timer_list timer;
-	int default_ticks;
 	unsigned long inuse;
 	atomic_t ticks;
 } bcm63xx_wdt_device;
-- 
1.8.3.2

