Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from 8.mo6.mail-out.ovh.net ([178.33.42.204]:37019 "EHLO
	mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754027Ab3KCRwv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 3 Nov 2013 12:52:51 -0500
Received: from mail425.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo6.mail-out.ovh.net (Postfix) with SMTP id 4E372FFA761
	for <linux-watchdog@vger.kernel.org>; Sun,  3 Nov 2013 18:53:36 +0100 (CET)
From: Boris BREZILLON <b.brezillon@overkiz.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Fabio Porcedda <fabio.porcedda@gmail.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Guenter Roeck <groeck7@gmail.com>,
	Yang Wenyou <wenyou.yang@atmel.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Boris BREZILLON <b.brezillon@overkiz.com>
Subject: [PATCH 1/3] watchdog: at91sam9_wdt: fix secs_to_ticks
Date: Sun,  3 Nov 2013 18:52:42 +0100
Message-Id: <1383501164-8111-2-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1383501164-8111-1-git-send-email-b.brezillon@overkiz.com>
References: <1383501164-8111-1-git-send-email-b.brezillon@overkiz.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix the secs_to_ticks macro in case 0 is passed as an argument.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/watchdog/at91sam9_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 9bd089e..65f4691 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -51,7 +51,7 @@
 #define ticks_to_hz_rounddown(t)	((((t) + 1) * HZ) >> 8)
 #define ticks_to_hz_roundup(t)		(((((t) + 1) * HZ) + 255) >> 8)
 #define ticks_to_secs(t)		(((t) + 1) >> 8)
-#define secs_to_ticks(s)		(((s) << 8) - 1)
+#define secs_to_ticks(s)		((s) ? (((s) << 8) - 1) : 0)
 
 #define WDT_MR_RESET	0x3FFF2FFF
 
-- 
1.7.9.5

