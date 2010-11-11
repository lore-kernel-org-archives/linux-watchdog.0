Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from webmail-out2.one.com ([91.198.169.17]:58139 "EHLO
	webmail-out2.b-one.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab0KKPOg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Nov 2010 10:14:36 -0500
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
From: "=?iso-8859-1?Q?Benny=20L=F8nstrup=20Amm?==?iso-8859-1?Q?itzb=F8ll?="
	<benny@ammitzboell-consult.dk>
To: linux-watchdog@vger.kernel.org
CC: wim@iguana.be
Subject: [PATCH] Add watchdog support for W83627DHG chip
Date: Thu, 11 Nov 2010 16:08:41 +0100
Reply-To: benny@ammitzboell-consult.dk
Message-Id: <20101111150841.A67A6C40C6062@bmail03.one.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The following adds watchdog support for the Winbond W83627DHG chip. I have tested it on a PQ7-M102XL (Intel Atom) board.

diff -u linux-2.6.36.orig/drivers/watchdog/Kconfig linux-2.6.36/drivers/watchdog/Kconfig
--- linux-2.6.36.orig/drivers/watchdog/Kconfig  2010-11-11 12:30:48.000000000 +0100
+++ linux-2.6.36/drivers/watchdog/Kconfig       2010-11-11 12:32:01.000000000 +0100
@@ -718,14 +718,15 @@
          Most people will say N.
 
 config W83627HF_WDT
-       tristate "W83627HF Watchdog Timer"
+       tristate "W83627HF/W83627DHG Watchdog Timer"
        depends on X86
        ---help---
          This is the driver for the hardware watchdog on the W83627HF chipset
          as used in Advantech PC-9578 and Tyan S2721-533 motherboards
-         (and likely others).  This watchdog simply watches your kernel to
-         make sure it doesn't freeze, and if it does, it reboots your computer
-         after a certain amount of time.
+         (and likely others). The driver also supports the W83627DHG chip.
+         This watchdog simply watches your kernel to make sure it doesn't
+         freeze, and if it does, it reboots your computer after a certain
+         amount of time.
 
          To compile this driver as a module, choose M here: the
          module will be called w83627hf_wdt.
Only in linux-2.6.36.orig/drivers/watchdog/: .#Kconfig
Only in linux-2.6.36.orig/drivers/watchdog/: #Kconfig#
diff -u linux-2.6.36.orig/drivers/watchdog/w83627hf_wdt.c linux-2.6.36/drivers/watchdog/w83627hf_wdt.c
--- linux-2.6.36.orig/drivers/watchdog/w83627hf_wdt.c   2010-11-11 12:30:48.000000000 +0100
+++ linux-2.6.36/drivers/watchdog/w83627hf_wdt.c        2010-11-11 14:25:00.000000000 +0100
@@ -42,7 +42,7 @@
 
 #include <asm/system.h>
 
-#define WATCHDOG_NAME "w83627hf/thf/hg WDT"
+#define WATCHDOG_NAME "w83627hf/thf/hg/dhg WDT"
 #define PFX WATCHDOG_NAME ": "
 #define WATCHDOG_TIMEOUT 60            /* 60 sec default timeout */
 
@@ -89,7 +89,7 @@
                c = ((inb_p(WDT_EFDR) & 0xf7) | 0x04); /* select WDT0 */
                outb_p(0x2b, WDT_EFER);
                outb_p(c, WDT_EFDR);    /* set GPIO3 to WDT0 */
-       } else if (c == 0x88) { /* W83627EHF */
+       } else if (c == 0x88 || c == 0xa0) {    /* W83627EHF / W83627DHG */
                outb_p(0x2d, WDT_EFER); /* select GPIO5 */
                c = inb_p(WDT_EFDR) & ~0x01; /* PIN77 -> WDT0# */
                outb_p(0x2d, WDT_EFER);
@@ -321,7 +321,7 @@
 {
        int ret;
 
-       printk(KERN_INFO "WDT driver for the Winbond(TM) W83627HF/THF/HG Super I/O chip initialising.\n");
+       printk(KERN_INFO "WDT driver for the Winbond(TM) W83627HF/THF/HG/DHG Super I/O chip initialising.\n");
 
        if (wdt_set_heartbeat(timeout)) {
                wdt_set_heartbeat(WATCHDOG_TIMEOUT);
