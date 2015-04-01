Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yh0-f74.google.com ([209.85.213.74]:34014 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbbDARnT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 1 Apr 2015 13:43:19 -0400
Received: by yhl29 with SMTP id 29so2978670yhl.1
        for <linux-watchdog@vger.kernel.org>; Wed, 01 Apr 2015 10:43:19 -0700 (PDT)
From: Andrew Bresticker <abrestic@chromium.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Bresticker <abrestic@chromium.org>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	James Hogan <james.hogan@imgtec.com>
Subject: [PATCH V2 1/3] watchdog: imgpdc: Allow timeout to be set in device-tree
Date: Wed,  1 Apr 2015 10:43:14 -0700
Message-Id: <1427910196-28568-1-git-send-email-abrestic@chromium.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Since the heartbeat is statically initialized to its default value,
watchdog_init_timeout() will never look in the device-tree for a
timeout-sec value.  Instead of statically initializing heartbeat,
fall back to the default timeout value if watchdog_init_timeout()
fails.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
---
New for v2.
---
 drivers/watchdog/imgpdc_wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 0deaa4f..89b2abc 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -42,7 +42,7 @@
 #define PDC_WDT_MIN_TIMEOUT		1
 #define PDC_WDT_DEF_TIMEOUT		64
 
-static int heartbeat = PDC_WDT_DEF_TIMEOUT;
+static int heartbeat;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds "
 	"(default=" __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
@@ -195,9 +195,9 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 
 	ret = watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, &pdev->dev);
 	if (ret < 0) {
-		pdc_wdt->wdt_dev.timeout = pdc_wdt->wdt_dev.max_timeout;
+		pdc_wdt->wdt_dev.timeout = PDC_WDT_DEF_TIMEOUT;
 		dev_warn(&pdev->dev,
-			 "Initial timeout out of range! setting max timeout\n");
+			 "Initial timeout out of range! setting default timeout\n");
 	}
 
 	pdc_wdt_stop(&pdc_wdt->wdt_dev);
-- 
2.2.0.rc0.207.ga3a616c

