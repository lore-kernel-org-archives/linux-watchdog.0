Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42854 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbdE2XVe (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 29 May 2017 19:21:34 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: w83627hf: Add support for NCT6793D and NCT6795D
Date: Mon, 29 May 2017 16:21:31 -0700
Message-Id: <1496100091-26006-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Both NCT6793D and NCT6795D are compatible to NCT6792D.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/w83627hf_wdt.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 98fd186c6878..d9ba0496713c 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -49,7 +49,8 @@ static int cr_wdt_csr;		/* WDT control & status register */
 
 enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
 	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
-	     w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792, nct6102 };
+	     w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792, nct6793,
+	     nct6795, nct6102 };
 
 static int timeout;			/* in seconds */
 module_param(timeout, int, 0);
@@ -97,6 +98,8 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 #define NCT6779_ID		0xc5
 #define NCT6791_ID		0xc8
 #define NCT6792_ID		0xc9
+#define NCT6793_ID		0xd1
+#define NCT6795_ID		0xd3
 
 #define W83627HF_WDT_TIMEOUT	0xf6
 #define W83697HF_WDT_TIMEOUT	0xf4
@@ -204,6 +207,8 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 	case nct6779:
 	case nct6791:
 	case nct6792:
+	case nct6793:
+	case nct6795:
 	case nct6102:
 		/*
 		 * These chips have a fixed WDTO# output pin (W83627UHG),
@@ -396,6 +401,12 @@ static int wdt_find(int addr)
 	case NCT6792_ID:
 		ret = nct6792;
 		break;
+	case NCT6793_ID:
+		ret = nct6793;
+		break;
+	case NCT6795_ID:
+		ret = nct6795;
+		break;
 	case NCT6102_ID:
 		ret = nct6102;
 		cr_wdt_timeout = NCT6102D_WDT_TIMEOUT;
@@ -437,6 +448,8 @@ static int __init wdt_init(void)
 		"NCT6779",
 		"NCT6791",
 		"NCT6792",
+		"NCT6793",
+		"NCT6795",
 		"NCT6102",
 	};
 
-- 
2.7.4

