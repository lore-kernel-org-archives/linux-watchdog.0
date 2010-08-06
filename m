Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:41306 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751403Ab0HFV2n (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Aug 2010 17:28:43 -0400
Date: Fri, 6 Aug 2010 23:28:41 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: dann frazier <dannf@hp.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>
Subject: watchdog: hpwdt (1/12): clean-up include-files.
Message-ID: <20100806212841.GA31417@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit c35f4e6b480d8df46a8f37420da6ed3758040fa2
Author: dann frazier <dannf@hp.com>
Date:   Tue Jul 27 17:50:50 2010 -0600

    watchdog: hpwdt (1/12): clean-up include-files.
    
    * remove unnecessary includes
    * We use a spinlock, but lacked the include
    * We need bitops.h for test_and_set_bit/clear_bit
    
    Signed-off-by: dann frazier <dannf@hp.com>
    Acked-by: Thomas Mingarelli <Thomas.Mingarelli@hp.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index fd312fc..183b7a4 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -16,30 +16,22 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/nmi.h>
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
-#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/kdebug.h>
 #include <linux/moduleparam.h>
 #include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
-#include <linux/reboot.h>
-#include <linux/sched.h>
-#include <linux/timer.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
 #include <linux/dmi.h>
-#include <linux/efi.h>
-#include <linux/string.h>
-#include <linux/bootmem.h>
-#include <asm/desc.h>
+#include <linux/spinlock.h>
 #include <asm/cacheflush.h>
 
 #define PCI_BIOS32_SD_VALUE		0x5F32335F	/* "_32_" */
