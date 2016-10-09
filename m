Return-path: <lqs@lqs.me>
Subject: Re: [PATCH] watchdog: it87_wdt: add IT8782_ID
To: Guenter Roeck <linux@roeck-us.net>, wim@iguana.be
References: <d9c1af52-1817-d356-0aeb-a5d7a1093fd9@lqs.me>
 <bb6ad10b-85f4-7d3c-8c22-ba3731480ac5@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
From: Liu Qishuai <lqs@lqs.me>
Message-ID: <22e78325-e0ca-f323-9150-7b180a12a328@lqs.me>
Date: Sun, 9 Oct 2016 21:03:12 +0800
MIME-Version: 1.0
In-Reply-To: <bb6ad10b-85f4-7d3c-8c22-ba3731480ac5@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Updated patch to disabled CIR probing on IT878x chips. (IT8783 has this issue too)

Signed-off-by: Liu Qishuai <lqs@lqs.me>


diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index e54839b..a911cae 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -13,7 +13,7 @@
  *
  *	Support of the watchdog timers, which are available on
  *	IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726,
- *	IT8728 and IT8783.
+ *	IT8728, IT8782 and IT8783.
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -87,6 +87,7 @@
 #define IT8721_ID	0x8721
 #define IT8726_ID	0x8726	/* the data sheet suggest wrongly 0x8716 */
 #define IT8728_ID	0x8728
+#define IT8782_ID	0x8782
 #define IT8783_ID	0x8783

 /* GPIO Configuration Registers LDN=0x07 */
@@ -606,6 +607,7 @@ static int __init it87_wdt_init(void)
 {
 	int rc = 0;
 	int try_gameport = !nogameport;
+	int try_cir = !nocir;
 	u8  chip_rev;
 	int gp_rreq_fail = 0;

@@ -634,9 +636,14 @@ static int __init it87_wdt_init(void)
 	case IT8720_ID:
 	case IT8721_ID:
 	case IT8728_ID:
+		max_units = 65535;
+		try_gameport = 0;
+		break;
+	case IT8782_ID:
 	case IT8783_ID:
 		max_units = 65535;
 		try_gameport = 0;
+		try_cir = 0;
 		break;
 	case IT8705_ID:
 		pr_err("Unsupported Chip found, Chip %04x Revision %02x\n",
@@ -676,7 +683,7 @@ static int __init it87_wdt_init(void)
 	}

 	/* If we haven't Gameport support, try to get CIR support */
-	if (!nocir && !test_bit(WDTS_USE_GP, &wdt_status)) {
+	if (try_cir && !test_bit(WDTS_USE_GP, &wdt_status)) {
 		if (!request_region(CIR_BASE, 8, WATCHDOG_NAME)) {
 			if (gp_rreq_fail)
 				pr_err("I/O Address 0x%04x and 0x%04x already in use\n",
