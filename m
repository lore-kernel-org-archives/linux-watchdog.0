Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46782 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932456AbdJZQK2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 26 Oct 2017 12:10:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id m72so9010190wmc.1
        for <linux-watchdog@vger.kernel.org>; Thu, 26 Oct 2017 09:10:27 -0700 (PDT)
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: [PATCH v3 3/4] watchdog: i6300esb: do not hardcode heartbeat limits
Date: Thu, 26 Oct 2017 17:10:15 +0100
Message-Id: <20171026161016.3198-3-rrendec@arista.com>
In-Reply-To: <2edc54c2-f3d9-6b54-7ff9-79365b03946c@roeck-us.net>
References: <2edc54c2-f3d9-6b54-7ff9-79365b03946c@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The minimum, maximum and default values for the watchdog heartbeat
(timeout) were hardcoded in several places (including module parameter
description and warning message for invalid module parameter value).

This patch adds macros for the aforementioned values and replaces all
occurences of hardcoded values by these macros.

Signed-off-by: Radu Rendec <rrendec@arista.com>
---
 drivers/watchdog/i6300esb.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index 147462f431de..4d92925cdc1e 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -81,12 +81,16 @@ static int cards_found;
 
 /* module parameters */
 /* 30 sec default heartbeat (1 < heartbeat < 2*1023) */
-#define WATCHDOG_HEARTBEAT 30
+#define ESB_HEARTBEAT_MIN	1
+#define ESB_HEARTBEAT_MAX	2046
+#define ESB_HEARTBEAT_DEFAULT	30
+#define ESB_HEARTBEAT_RANGE __MODULE_STRING(ESB_HEARTBEAT_MIN) \
+	"<heartbeat<" __MODULE_STRING(ESB_HEARTBEAT_MAX)
 static int heartbeat; /* in seconds */
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat,
-		"Watchdog heartbeat in seconds. (1<heartbeat<2046, default="
-				__MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
+	"Watchdog heartbeat in seconds. (" ESB_HEARTBEAT_RANGE
+	", default=" __MODULE_STRING(ESB_HEARTBEAT_DEFAULT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
@@ -315,13 +319,13 @@ static int esb_probe(struct pci_dev *pdev,
 	/* Initialize the watchdog and make sure it does not run */
 	edev->wdd.info = &esb_info;
 	edev->wdd.ops = &esb_ops;
-	edev->wdd.min_timeout = 1;
-	edev->wdd.max_timeout = 2 * 0x03ff;
-	edev->wdd.timeout = WATCHDOG_HEARTBEAT;
+	edev->wdd.min_timeout = ESB_HEARTBEAT_MIN;
+	edev->wdd.max_timeout = ESB_HEARTBEAT_MAX;
+	edev->wdd.timeout = ESB_HEARTBEAT_DEFAULT;
 	if (watchdog_init_timeout(&edev->wdd, heartbeat, NULL))
 		dev_info(&pdev->dev,
-			"heartbeat value must be 1<heartbeat<2046, using %u\n",
-			edev->wdd.timeout);
+			"heartbeat value must be " ESB_HEARTBEAT_RANGE
+			", using %u\n", edev->wdd.timeout);
 	watchdog_set_nowayout(&edev->wdd, nowayout);
 	watchdog_stop_on_reboot(&edev->wdd);
 	watchdog_stop_on_unregister(&edev->wdd);
-- 
2.13.6

