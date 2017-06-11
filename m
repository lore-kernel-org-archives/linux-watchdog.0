Return-Path: <linux@roeck-us.net>
Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5/5] watchdog: it87: Add support for various Super-IO chips
Date: Sat, 10 Jun 2017 21:04:36 -0700
Message-Id: <1497153876-22921-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1497153876-22921-1-git-send-email-linux@roeck-us.net>
References: <1497153876-22921-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Add support for IT8607, IT8622, IT8625, IT8628, IT8655, IT8665,
and IT8686.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/Kconfig    |  7 ++++---
 drivers/watchdog/it87_wdt.c | 19 +++++++++++++++++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 793146be38e0..3b3a8f0e9b7b 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1039,9 +1039,10 @@ config IT87_WDT
 	depends on X86
 	select WATCHDOG_CORE
 	---help---
-	  This is the driver for the hardware watchdog on the ITE IT8620,
-	  IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726 and IT8728
-	  Super I/O chips.
+	  This is the driver for the hardware watchdog on the ITE IT8607,
+	  IT8620, IT8622, IT8625, IT8628, IT8655, IT8665, IT8686, IT8702,
+	  IT8712, IT8716, IT8718, IT8720, IT8721, IT8726, IT8728, and
+	  IT8783 Super I/O chips.
 
 	  This watchdog simply watches your kernel to make sure it doesn't
 	  freeze, and if it does, it reboots your computer after a certain
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index 07f4727eb7f4..dd1e7eaef50f 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -12,8 +12,9 @@
  *		    http://www.ite.com.tw/
  *
  *	Support of the watchdog timers, which are available on
- *	IT8620, IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726,
- *	IT8728 and IT8783.
+ *	IT8607, IT8620, IT8622, IT8625, IT8628, IT8655, IT8665, IT8686,
+ *	IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726, IT8728,
+ *	and IT8783.
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -57,7 +58,14 @@
 
 /* Chip Id numbers */
 #define NO_DEV_ID	0xffff
+#define IT8607_ID	0x8607
 #define IT8620_ID	0x8620
+#define IT8622_ID	0x8622
+#define IT8625_ID	0x8625
+#define IT8628_ID	0x8628
+#define IT8655_ID	0x8655
+#define IT8665_ID	0x8665
+#define IT8686_ID	0x8686
 #define IT8702_ID	0x8702
 #define IT8705_ID	0x8705
 #define IT8712_ID	0x8712
@@ -282,7 +290,14 @@ static int __init it87_wdt_init(void)
 	case IT8726_ID:
 		max_units = 65535;
 		break;
+	case IT8607_ID:
 	case IT8620_ID:
+	case IT8622_ID:
+	case IT8625_ID:
+	case IT8628_ID:
+	case IT8655_ID:
+	case IT8665_ID:
+	case IT8686_ID:
 	case IT8718_ID:
 	case IT8720_ID:
 	case IT8721_ID:
-- 
2.7.4
