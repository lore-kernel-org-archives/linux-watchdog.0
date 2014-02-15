Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.176.59]:54267 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbaBOJWo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Feb 2014 04:22:44 -0500
Received: from smtp47.i.mail.ru (smtp47.i.mail.ru [94.100.177.107])
	by fallback5.mail.ru (mPOP.Fallback_MX) with ESMTP id CCBA210D1AA07
	for <linux-watchdog@vger.kernel.org>; Sat, 15 Feb 2014 13:22:40 +0400 (MSK)
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] watchdog: intel_scu_watchdog: Remove unused variable
Date: Sat, 15 Feb 2014 13:22:18 +0400
Message-Id: <1392456138-30003-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Variable "hw_pre_value" is not used anywhere in the
function intel_scu_set_heartbeat().
This patch removes this variable.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/watchdog/intel_scu_watchdog.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/intel_scu_watchdog.c b/drivers/watchdog/intel_scu_watchdog.c
index e13e65e..0caab62 100644
--- a/drivers/watchdog/intel_scu_watchdog.c
+++ b/drivers/watchdog/intel_scu_watchdog.c
@@ -211,7 +211,6 @@ static int intel_scu_set_heartbeat(u32 t)
 	int			 ipc_ret;
 	int			 retry_count;
 	u32			 soft_value;
-	u32			 hw_pre_value;
 	u32			 hw_value;
 
 	watchdog_device.timer_set = t;
@@ -273,8 +272,7 @@ static int intel_scu_set_heartbeat(u32 t)
 			watchdog_device.timer_load_count_addr);
 
 		/* read count value before starting timer */
-		hw_pre_value = ioread32(watchdog_device.timer_load_count_addr);
-		hw_pre_value = hw_pre_value & 0xFFFF0000;
+		ioread32(watchdog_device.timer_load_count_addr);
 
 		/* Start the timer */
 		iowrite32(0x00000003, watchdog_device.timer_control_addr);
-- 
1.8.3.2

