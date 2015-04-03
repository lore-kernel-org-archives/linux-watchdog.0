Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qg0-f73.google.com ([209.85.192.73]:34431 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515AbbDCRMl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 Apr 2015 13:12:41 -0400
Received: by qgdq107 with SMTP id q107so2087081qgd.1
        for <linux-watchdog@vger.kernel.org>; Fri, 03 Apr 2015 10:12:40 -0700 (PDT)
From: Andrew Bresticker <abrestic@chromium.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Bresticker <abrestic@chromium.org>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	James Hogan <james.hogan@imgtec.com>
Subject: [PATCH V3 1/3] watchdog: imgpdc: Allow timeout to be set in device-tree
Date: Fri,  3 Apr 2015 10:05:20 -0700
Message-Id: <1428080722-29683-1-git-send-email-abrestic@chromium.org>
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
Changes from v2:
 - Set timeout before calling watchdog_init_timeout
 - Don't print an error on watchdog_init_timeout failure
New for v2.
---
 drivers/watchdog/imgpdc_wdt.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 0deaa4f..d6826a6 100644
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
@@ -190,15 +190,11 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	pdc_wdt->wdt_dev.info = &pdc_wdt_info;
 	pdc_wdt->wdt_dev.ops = &pdc_wdt_ops;
 	pdc_wdt->wdt_dev.max_timeout = 1 << PDC_WDT_CONFIG_DELAY_MASK;
+	pdc_wdt->wdt_dev.timeout = PDC_WDT_DEF_TIMEOUT;
 	pdc_wdt->wdt_dev.parent = &pdev->dev;
 	watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
 
-	ret = watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, &pdev->dev);
-	if (ret < 0) {
-		pdc_wdt->wdt_dev.timeout = pdc_wdt->wdt_dev.max_timeout;
-		dev_warn(&pdev->dev,
-			 "Initial timeout out of range! setting max timeout\n");
-	}
+	watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, &pdev->dev);
 
 	pdc_wdt_stop(&pdc_wdt->wdt_dev);
 
-- 
2.2.0.rc0.207.ga3a616c

