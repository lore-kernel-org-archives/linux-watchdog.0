Return-Path: <jdelvare@suse.de>
Return-path: <jdelvare@suse.de>
Date: Fri, 31 Aug 2018 15:06:10 +0200
From: Jean Delvare <jdelvare@suse.de>
To: linux-watchdog@vger.kernel.org
Cc: Martin Wilck <mwilck@suse.com>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/2] watchdog: iTCO_wdt: Drop option vendorsupport=2
Message-ID: <20180831150610.0d3c5d9c@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

iTCO_vendor_support's option vendorsupport=2 is a gross hack. It
claims to extend the existing iTCO_wdt driver, but in fact programs
a watchdog on a completely different device (Super-I/O) without
requesting its I/O ports and without checking the device ID. This is
an utterly dangerous thing to do.

It also turns out to be unnecessary, because as far as I can tell, the
code in question is basically duplicating what the clean w83627hf_wdt
driver is doing.

My guess is that on these SuperMicro boards which sparkled the
implementation of vendorsupport=2, the watchdog functionality of the
Intel south bridge is not used, and the watchdog feature of some
W83627HF-like Super-I/O chip is used instead. So we should point the
users to the w83627hf_wdt driver.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/iTCO_vendor_support.c |  158 +--------------------------------
 1 file changed, 8 insertions(+), 150 deletions(-)

--- linux-4.18.orig/drivers/watchdog/iTCO_vendor_support.c	2018-08-31 14:27:05.313880214 +0200
+++ linux-4.18/drivers/watchdog/iTCO_vendor_support.c	2018-08-31 14:27:06.438895718 +0200
@@ -38,7 +38,7 @@
 /* List of vendor support modes */
 /* SuperMicro Pentium 3 Era 370SSE+-OEM1/P3TSSE */
 #define SUPERMICRO_OLD_BOARD	1
-/* SuperMicro Pentium 4 / Xeon 4 / EMT64T Era Systems */
+/* SuperMicro Pentium 4 / Xeon 4 / EMT64T Era Systems - no longer supported */
 #define SUPERMICRO_NEW_BOARD	2
 /* Broken BIOS */
 #define BROKEN_BIOS		911
@@ -46,8 +46,7 @@
 static int vendorsupport;
 module_param(vendorsupport, int, 0);
 MODULE_PARM_DESC(vendorsupport, "iTCO vendor specific support mode, default="
-			"0 (none), 1=SuperMicro Pent3, 2=SuperMicro Pent4+, "
-							"911=Broken SMI BIOS");
+			"0 (none), 1=SuperMicro Pent3, 911=Broken SMI BIOS");
 
 /*
  *	Vendor Specific Support
@@ -98,143 +97,6 @@ static void supermicro_old_pre_stop(stru
 }
 
 /*
- *	Vendor Support: 2
- *	Board: Super Micro Computer Inc. P4SBx, P4DPx
- *	iTCO chipset: ICH4
- *
- *	Code contributed by: R. Seretny <lkpatches@paypc.com>
- *	Documentation obtained by R. Seretny from SuperMicro Technical Support
- *
- *	To enable Watchdog function:
- *	 1. BIOS
- *	  For P4SBx:
- *	  BIOS setup -> Advanced -> Integrated Peripherals -> Watch Dog Feature
- *	  For P4DPx:
- *	  BIOS setup -> Advanced -> I/O Device Configuration -> Watch Dog
- *	 This setting enables or disables Watchdog function. When enabled, the
- *	 default watchdog timer is set to be 5 minutes (about 4m35s). It is
- *	 enough to load and run the OS. The application (service or driver) has
- *	 to take over the control once OS is running up and before watchdog
- *	 expires.
- *
- *	 2. JUMPER
- *	  For P4SBx: JP39
- *	  For P4DPx: JP37
- *	  This jumper is used for safety.  Closed is enabled. This jumper
- *	  prevents user enables watchdog in BIOS by accident.
- *
- *	 To enable Watch Dog function, both BIOS and JUMPER must be enabled.
- *
- *	The documentation lists motherboards P4SBx and P4DPx series as of
- *	20-March-2002. However, this code works flawlessly with much newer
- *	motherboards, such as my X6DHR-8G2 (SuperServer 6014H-82).
- *
- *	The original iTCO driver as written does not actually reset the
- *	watchdog timer on these machines, as a result they reboot after five
- *	minutes.
- *
- *	NOTE: You may leave the Watchdog function disabled in the SuperMicro
- *	BIOS to avoid a "boot-race"... This driver will enable watchdog
- *	functionality even if it's disabled in the BIOS once the /dev/watchdog
- *	file is opened.
- */
-
-/* I/O Port's */
-#define SM_REGINDEX	0x2e	/* SuperMicro ICH4+ Register Index */
-#define SM_DATAIO	0x2f	/* SuperMicro ICH4+ Register Data I/O */
-
-/* Control Register's */
-#define SM_CTLPAGESW	0x07	/* SuperMicro ICH4+ Control Page Switch */
-#define SM_CTLPAGE	0x08	/* SuperMicro ICH4+ Control Page Num */
-
-#define SM_WATCHENABLE	0x30	/* Watchdog enable: Bit 0: 0=off, 1=on */
-
-#define SM_WATCHPAGE	0x87	/* Watchdog unlock control page */
-
-#define SM_ENDWATCH	0xAA	/* Watchdog lock control page */
-
-#define SM_COUNTMODE	0xf5	/* Watchdog count mode select */
-				/* (Bit 3: 0 = seconds, 1 = minutes */
-
-#define SM_WATCHTIMER	0xf6	/* 8-bits, Watchdog timer counter (RW) */
-
-#define SM_RESETCONTROL	0xf7	/* Watchdog reset control */
-				/* Bit 6: timer is reset by kbd interrupt */
-				/* Bit 7: timer is reset by mouse interrupt */
-
-static void supermicro_new_unlock_watchdog(void)
-{
-	/* Write 0x87 to port 0x2e twice */
-	outb(SM_WATCHPAGE, SM_REGINDEX);
-	outb(SM_WATCHPAGE, SM_REGINDEX);
-	/* Switch to watchdog control page */
-	outb(SM_CTLPAGESW, SM_REGINDEX);
-	outb(SM_CTLPAGE, SM_DATAIO);
-}
-
-static void supermicro_new_lock_watchdog(void)
-{
-	outb(SM_ENDWATCH, SM_REGINDEX);
-}
-
-static void supermicro_new_pre_start(unsigned int heartbeat)
-{
-	unsigned int val;
-
-	supermicro_new_unlock_watchdog();
-
-	/* Watchdog timer setting needs to be in seconds*/
-	outb(SM_COUNTMODE, SM_REGINDEX);
-	val = inb(SM_DATAIO);
-	val &= 0xF7;
-	outb(val, SM_DATAIO);
-
-	/* Write heartbeat interval to WDOG */
-	outb(SM_WATCHTIMER, SM_REGINDEX);
-	outb((heartbeat & 255), SM_DATAIO);
-
-	/* Make sure keyboard/mouse interrupts don't interfere */
-	outb(SM_RESETCONTROL, SM_REGINDEX);
-	val = inb(SM_DATAIO);
-	val &= 0x3f;
-	outb(val, SM_DATAIO);
-
-	/* enable watchdog by setting bit 0 of Watchdog Enable to 1 */
-	outb(SM_WATCHENABLE, SM_REGINDEX);
-	val = inb(SM_DATAIO);
-	val |= 0x01;
-	outb(val, SM_DATAIO);
-
-	supermicro_new_lock_watchdog();
-}
-
-static void supermicro_new_pre_stop(void)
-{
-	unsigned int val;
-
-	supermicro_new_unlock_watchdog();
-
-	/* disable watchdog by setting bit 0 of Watchdog Enable to 0 */
-	outb(SM_WATCHENABLE, SM_REGINDEX);
-	val = inb(SM_DATAIO);
-	val &= 0xFE;
-	outb(val, SM_DATAIO);
-
-	supermicro_new_lock_watchdog();
-}
-
-static void supermicro_new_pre_set_heartbeat(unsigned int heartbeat)
-{
-	supermicro_new_unlock_watchdog();
-
-	/* reset watchdog timeout to heartveat value */
-	outb(SM_WATCHTIMER, SM_REGINDEX);
-	outb((heartbeat & 255), SM_DATAIO);
-
-	supermicro_new_lock_watchdog();
-}
-
-/*
  *	Vendor Support: 911
  *	Board: Some Intel ICHx based motherboards
  *	iTCO chipset: ICH7+
@@ -298,9 +160,6 @@ void iTCO_vendor_pre_start(struct resour
 	case SUPERMICRO_OLD_BOARD:
 		supermicro_old_pre_start(smires);
 		break;
-	case SUPERMICRO_NEW_BOARD:
-		supermicro_new_pre_start(heartbeat);
-		break;
 	case BROKEN_BIOS:
 		broken_bios_start(smires);
 		break;
@@ -314,9 +173,6 @@ void iTCO_vendor_pre_stop(struct resourc
 	case SUPERMICRO_OLD_BOARD:
 		supermicro_old_pre_stop(smires);
 		break;
-	case SUPERMICRO_NEW_BOARD:
-		supermicro_new_pre_stop();
-		break;
 	case BROKEN_BIOS:
 		broken_bios_stop(smires);
 		break;
@@ -326,15 +182,11 @@ EXPORT_SYMBOL(iTCO_vendor_pre_stop);
 
 void iTCO_vendor_pre_keepalive(struct resource *smires, unsigned int heartbeat)
 {
-	if (vendorsupport == SUPERMICRO_NEW_BOARD)
-		supermicro_new_pre_set_heartbeat(heartbeat);
 }
 EXPORT_SYMBOL(iTCO_vendor_pre_keepalive);
 
 void iTCO_vendor_pre_set_heartbeat(unsigned int heartbeat)
 {
-	if (vendorsupport == SUPERMICRO_NEW_BOARD)
-		supermicro_new_pre_set_heartbeat(heartbeat);
 }
 EXPORT_SYMBOL(iTCO_vendor_pre_set_heartbeat);
 
@@ -351,6 +203,12 @@ EXPORT_SYMBOL(iTCO_vendor_check_noreboot
 
 static int __init iTCO_vendor_init_module(void)
 {
+	if (vendorsupport == SUPERMICRO_NEW_BOARD) {
+		pr_warn("Option vendorsupport=%d is no longer supported, "
+			"please use the w83627hf_wdt driver instead\n",
+			SUPERMICRO_NEW_BOARD);
+		return -EINVAL;
+	}
 	pr_info("vendor-support=%d\n", vendorsupport);
 	return 0;
 }


-- 
Jean Delvare
SUSE L3 Support
