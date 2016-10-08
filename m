Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33512 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752220AbcJHNJs (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 8 Oct 2016 09:09:48 -0400
Received: by mail-pf0-f193.google.com with SMTP id i85so4412849pfa.0
        for <linux-watchdog@vger.kernel.org>; Sat, 08 Oct 2016 06:07:58 -0700 (PDT)
From: Liu Qishuai <lqs@lqs.me>
Subject: [PATCH] watchdog: it87_wdt: add IT8782_ID
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org
Message-ID: <d9c1af52-1817-d356-0aeb-a5d7a1093fd9@lqs.me>
Date: Sat, 8 Oct 2016 21:07:43 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add watchdog support for IT8782 chip.

Tested on SV3-26026 mainboard.

Signed-off-by: Liu Qishuai <lqs@lqs.me>


diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index e54839b..c9b2b80 100644
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
@@ -634,6 +635,7 @@ static int __init it87_wdt_init(void)
 	case IT8720_ID:
 	case IT8721_ID:
 	case IT8728_ID:
+	case IT8782_ID:
 	case IT8783_ID:
 		max_units = 65535;
 		try_gameport = 0;
