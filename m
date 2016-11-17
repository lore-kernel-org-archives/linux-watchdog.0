Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35221 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbcKQWnu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 17 Nov 2016 17:43:50 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so291273wme.2
        for <linux-watchdog@vger.kernel.org>; Thu, 17 Nov 2016 14:43:49 -0800 (PST)
From: Fernando Ramos <bocadillodeatun@gmail.com>
To: fernando@gluegarage.com
Cc: James Hogan <james.hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
        Jude Abraham <Jude.Abraham@imgtec.com>,
        linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 3/3] watchdog: imgpdc: Fix default heartbeat
Date: Thu, 17 Nov 2016 23:43:40 +0100
Message-Id: <20161117224340.7908-3-fernando@gluegarage.com>
In-Reply-To: <20161117224340.7908-1-fernando@gluegarage.com>
References: <20161117224340.7908-1-fernando@gluegarage.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: James Hogan <james.hogan@imgtec.com>

The IMG PDC watchdog driver heartbeat module parameter has no default so
it is initialised to zero. This results in the following warning during
probe:

imgpdc-wdt 2006000.wdt: Initial timeout out of range! setting max timeout

The module parameter description implies that the default value should
be PDC_WDT_DEF_TIMEOUT, which isn't yet used, so initialise it to that.

Also tweak the heartbeat module parameter description for consistency.

Fixes: 93937669e9b5 ("watchdog: ImgTec PDC Watchdog Timer Driver")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Cc: Jude Abraham <Jude.Abraham@imgtec.com>
Cc: linux-watchdog@vger.kernel.org
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
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
2.10.2

