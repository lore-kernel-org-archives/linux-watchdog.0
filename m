Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vps-vb.mhejs.net ([37.28.154.113]:45275 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbcLOXRr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 15 Dec 2016 18:17:47 -0500
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] watchdog: it87_wdt: add IT8620E ID
Message-ID: <ad227ebe-5756-be5d-37d6-9898e088769a@maciej.szmigiero.name>
Date: Thu, 15 Dec 2016 23:52:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This adds IT8620E chip ID to it87_wdt driver.
Such chip is often found on current Gigabyte motherboards, it is allegedly
custom made for this manufacturer.

Upon testing it looks like it has a 16-bit timer and cannot be reset via
game port (only via CIR), so it is similar to IT87{18,20,21,28,83} chips.

Tested on GA-F2A88XM-HD3P board.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/watchdog/Kconfig    | 4 ++--
 drivers/watchdog/it87_wdt.c | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f1de1214f10f..acb00b53a520 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1008,8 +1008,8 @@ config IT87_WDT
 	tristate "IT87 Watchdog Timer"
 	depends on X86
 	---help---
-	  This is the driver for the hardware watchdog on the ITE IT8702,
-	  IT8712, IT8716, IT8718, IT8720, IT8721, IT8726 and IT8728
+	  This is the driver for the hardware watchdog on the ITE IT8620,
+	  IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726 and IT8728
 	  Super I/O chips.
 
 	  If the driver does not work, then make sure that the game port in
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index e54839b12650..b9878c41598f 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -12,7 +12,7 @@
  *		    http://www.ite.com.tw/
  *
  *	Support of the watchdog timers, which are available on
- *	IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726,
+ *	IT8620, IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726,
  *	IT8728 and IT8783.
  *
  *	This program is free software; you can redistribute it and/or
@@ -78,6 +78,7 @@
 
 /* Chip Id numbers */
 #define NO_DEV_ID	0xffff
+#define IT8620_ID	0x8620
 #define IT8702_ID	0x8702
 #define IT8705_ID	0x8705
 #define IT8712_ID	0x8712
@@ -630,6 +631,7 @@ static int __init it87_wdt_init(void)
 	case IT8726_ID:
 		max_units = 65535;
 		break;
+	case IT8620_ID:
 	case IT8718_ID:
 	case IT8720_ID:
 	case IT8721_ID:
