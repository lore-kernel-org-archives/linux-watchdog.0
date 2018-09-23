Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41364 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeIWTvr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 23 Sep 2018 15:51:47 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: w83627hf_wdt: Support NCT6796D, NCT6797D, NCT6798D
Date: Sun, 23 Sep 2018 06:54:11 -0700
Message-Id: <1537710851-11017-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog controller on NCT6796D, NCT6797D, and NCT6798D is compatible
with the wtachdog controller on other Nuvoton chips.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/w83627hf_wdt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 7817836bff55..4b9365d4de7a 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -50,7 +50,7 @@ static int cr_wdt_csr;		/* WDT control & status register */
 enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
 	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
 	     w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792, nct6793,
-	     nct6795, nct6102 };
+	     nct6795, nct6796, nct6102 };
 
 static int timeout;			/* in seconds */
 module_param(timeout, int, 0);
@@ -100,6 +100,7 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 #define NCT6792_ID		0xc9
 #define NCT6793_ID		0xd1
 #define NCT6795_ID		0xd3
+#define NCT6796_ID		0xd4	/* also NCT9697D, NCT9698D */
 
 #define W83627HF_WDT_TIMEOUT	0xf6
 #define W83697HF_WDT_TIMEOUT	0xf4
@@ -209,6 +210,7 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 	case nct6792:
 	case nct6793:
 	case nct6795:
+	case nct6796:
 	case nct6102:
 		/*
 		 * These chips have a fixed WDTO# output pin (W83627UHG),
@@ -407,6 +409,9 @@ static int wdt_find(int addr)
 	case NCT6795_ID:
 		ret = nct6795;
 		break;
+	case NCT6796_ID:
+		ret = nct6796;
+		break;
 	case NCT6102_ID:
 		ret = nct6102;
 		cr_wdt_timeout = NCT6102D_WDT_TIMEOUT;
@@ -450,6 +455,7 @@ static int __init wdt_init(void)
 		"NCT6792",
 		"NCT6793",
 		"NCT6795",
+		"NCT6796",
 		"NCT6102",
 	};
 
-- 
2.7.4
