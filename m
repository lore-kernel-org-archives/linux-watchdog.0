Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:44283 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010AbbBTXp7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Feb 2015 18:45:59 -0500
Received: by mail-wg0-f51.google.com with SMTP id y19so15847624wgg.10
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Feb 2015 15:45:58 -0800 (PST)
From: James Hogan <james.hogan@imgtec.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: James Hogan <james@albanarts.com>,
	James Hogan <james.hogan@imgtec.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	Jude Abraham <Jude.Abraham@imgtec.com>
Subject: [PATCH 2/2] watchdog: imgpdc: Fix default heartbeat
Date: Fri, 20 Feb 2015 23:45:45 +0000
Message-Id: <1424475945-30009-3-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1424475945-30009-1-git-send-email-james.hogan@imgtec.com>
References: <1424475945-30009-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The IMG PDC watchdog driver heartbeat module parameter has no default so
it is initialised to zero. This results in the following warning during
probe:

imgpdc-wdt 2006000.wdt: Initial timeout out of range! setting max timeout

The module parameter description implies that the default value should
be PDC_WDT_DEF_TIMEOUT, which isn't yet used, so initialise it to that.

Also tweak the heartbeat module parameter description for consistency.

Fixes: 93937669e9b5 ("watchdog: ImgTec PDC Watchdog Timer Driver")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Cc: Jude Abraham <Jude.Abraham@imgtec.com>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/imgpdc_wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 32c35eb..0deaa4f 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -42,10 +42,10 @@
 #define PDC_WDT_MIN_TIMEOUT		1
 #define PDC_WDT_DEF_TIMEOUT		64
 
-static int heartbeat;
+static int heartbeat = PDC_WDT_DEF_TIMEOUT;
 module_param(heartbeat, int, 0);
-MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. "
-	"(default = " __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds "
+	"(default=" __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
-- 
2.0.5

