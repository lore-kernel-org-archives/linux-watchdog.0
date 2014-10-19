Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:50680 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbaJSTjr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 19 Oct 2014 15:39:47 -0400
Received: by mail-wg0-f50.google.com with SMTP id a1so4005291wgh.33
        for <linux-watchdog@vger.kernel.org>; Sun, 19 Oct 2014 12:39:46 -0700 (PDT)
From: Paolo Teti <paolo.teti@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: Paolo Teti <paolo.teti@gmail.com>
Subject: [PATCH 1/1] WD: add IT8783 ID
Date: Sun, 19 Oct 2014 21:39:33 +0200
Message-Id: <1413747573-8777-1-git-send-email-paolo.teti@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

IT8783 watchdog works as in IT872x

Tested on Adlink cPCI-6520 boards

Signed-off-by: Paolo Teti <paolo.teti@gmail.com>
---
 drivers/watchdog/it87_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index 0b93739..e54839b 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -12,8 +12,8 @@
  *		    http://www.ite.com.tw/
  *
  *	Support of the watchdog timers, which are available on
- *	IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726
- *	and IT8728.
+ *	IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726,
+ *	IT8728 and IT8783.
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -87,6 +87,7 @@
 #define IT8721_ID	0x8721
 #define IT8726_ID	0x8726	/* the data sheet suggest wrongly 0x8716 */
 #define IT8728_ID	0x8728
+#define IT8783_ID	0x8783
 
 /* GPIO Configuration Registers LDN=0x07 */
 #define WDTCTRL		0x71
@@ -633,6 +634,7 @@ static int __init it87_wdt_init(void)
 	case IT8720_ID:
 	case IT8721_ID:
 	case IT8728_ID:
+	case IT8783_ID:
 		max_units = 65535;
 		try_gameport = 0;
 		break;
-- 
1.9.1

