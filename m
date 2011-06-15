Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59459 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab1FORLn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 15 Jun 2011 13:11:43 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so460822wya.19
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Jun 2011 10:11:42 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 5/5 v3] WATCHDOG: mtx1-wdt: remove unused variable 'tmp'
Date: Wed, 15 Jun 2011 19:15:58 +0200
Cc: linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Jamie Iles <jamie@jamieiles.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106151915.58905.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes in v1, v2 and v3

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 03cab33..ac37bb8 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -71,8 +71,6 @@ static struct {
 
 static void mtx1_wdt_trigger(unsigned long unused)
 {
-	u32 tmp;
-
 	spin_lock(&mtx1_wdt_device.lock);
 	if (mtx1_wdt_device.running)
 		ticks--;
-- 
1.7.4.1

