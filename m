Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:35155 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757334AbaDXNug (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 24 Apr 2014 09:50:36 -0400
Received: by mail-la0-f48.google.com with SMTP id gf5so1997631lab.7
        for <linux-watchdog@vger.kernel.org>; Thu, 24 Apr 2014 06:50:35 -0700 (PDT)
Message-ID: <5359165F.5040102@icomera.com>
Date: Thu, 24 Apr 2014 15:49:19 +0200
From: gundberg <per.gundberg@icomera.com>
MIME-Version: 1.0
To: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: kempld-wdt: Use the correct value when configuring
 the prescaler with the watchdog
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the prescaler index, rather than its value, to configure the watchdog.
This will prevent a mismatch with the prescaler used to calculate the cycles.

Signed-off-by: Per Gundberg <per.gundberg@icomera.com>
---
 drivers/watchdog/kempld_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- src/drivers/watchdog/kempld_wdt.c.orig	2014-04-24 07:32:08.463745055 +0000
+++ src/drivers/watchdog/kempld_wdt.c	2014-04-24 07:34:09.839739808 +0000
@@ -163,7 +163,7 @@ static int kempld_wdt_set_stage_timeout(
 	kempld_get_mutex(pld);
 	stage_cfg = kempld_read8(pld, KEMPLD_WDT_STAGE_CFG(stage->id));
 	stage_cfg &= ~STAGE_CFG_PRESCALER_MASK;
-	stage_cfg |= STAGE_CFG_SET_PRESCALER(prescaler);
+	stage_cfg |= STAGE_CFG_SET_PRESCALER(PRESCALER_21);
 	kempld_write8(pld, KEMPLD_WDT_STAGE_CFG(stage->id), stage_cfg);
 	kempld_write32(pld, KEMPLD_WDT_STAGE_TIMEOUT(stage->id),
 			stage_timeout);
