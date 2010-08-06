Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:59347 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964821Ab0HFVap (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Aug 2010 17:30:45 -0400
Date: Fri, 6 Aug 2010 23:30:43 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: dann frazier <dannf@hp.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>
Subject: watchdog: hpwdt (3/12): Group NMI sourcing specific items together
Message-ID: <20100806213043.GB31433@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit 0ec0e34cff9871fbeafa40a56f93bfe464494590
Author: dann frazier <dannf@hp.com>
Date:   Tue Jul 27 17:50:54 2010 -0600

    watchdog: hpwdt (3/12): Group NMI sourcing specific items together
    
    * Group together includes specific to NMI sourcing
    * Group defines only used by NMI sourcing together
    * Group declarations specific to NMI sourcing together
    
    This gives a clean seperation of watchdog specific items and
    NMI sourcing specific items (which is needed for making it
    possible to build hpwdt without the NMI functionality).
    
    Signed-off-by: dann frazier <dannf@hp.com>
    Acked-by: Thomas Mingarelli <Thomas.Mingarelli@hp.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 0ad9af2..f0ecb14 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -17,14 +17,11 @@
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/nmi.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
-#include <linux/kdebug.h>
 #include <linux/moduleparam.h>
-#include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/types.h>
@@ -32,14 +29,36 @@
 #include <linux/watchdog.h>
 #include <linux/dmi.h>
 #include <linux/spinlock.h>
+#include <linux/nmi.h>
+#include <linux/kdebug.h>
+#include <linux/notifier.h>
 #include <asm/cacheflush.h>
 
+#define HPWDT_VERSION			"1.1.1"
+#define DEFAULT_MARGIN			30
+
+static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
+static unsigned int reload;			/* the computed soft_margin */
+static int nowayout = WATCHDOG_NOWAYOUT;
+static char expect_release;
+static unsigned long hpwdt_is_open;
+
+static void __iomem *pci_mem_addr;		/* the PCI-memory address */
+static unsigned long __iomem *hpwdt_timer_reg;
+static unsigned long __iomem *hpwdt_timer_con;
+
+static struct pci_device_id hpwdt_devices[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_COMPAQ, 0xB203) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HP, 0x3306) },
+	{0},			/* terminate list */
+};
+MODULE_DEVICE_TABLE(pci, hpwdt_devices);
+
 #define PCI_BIOS32_SD_VALUE		0x5F32335F	/* "_32_" */
 #define CRU_BIOS_SIGNATURE_VALUE	0x55524324
 #define PCI_BIOS32_PARAGRAPH_LEN	16
 #define PCI_ROM_BASE1			0x000F0000
 #define ROM_SIZE			0x10000
-#define HPWDT_VERSION			"1.1.1"
 
 struct bios32_service_dir {
 	u32 signature;
@@ -104,33 +123,13 @@ struct cmn_registers {
 	u32 reflags;
 }  __attribute__((packed));
 
-#define DEFAULT_MARGIN	30
-static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
-static unsigned int reload;			/* the computed soft_margin */
-static int nowayout = WATCHDOG_NOWAYOUT;
-static char expect_release;
-static unsigned long hpwdt_is_open;
-static unsigned int allow_kdump;
 static unsigned int hpwdt_nmi_sourcing;
+static unsigned int allow_kdump;
 static unsigned int priority;		/* hpwdt at end of die_notify list */
-
-static void __iomem *pci_mem_addr;		/* the PCI-memory address */
-static unsigned long __iomem *hpwdt_timer_reg;
-static unsigned long __iomem *hpwdt_timer_con;
-
 static DEFINE_SPINLOCK(rom_lock);
-
 static void *cru_rom_addr;
-
 static struct cmn_registers cmn_regs;
 
-static struct pci_device_id hpwdt_devices[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_COMPAQ, 0xB203) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_HP, 0x3306) },
-	{0},			/* terminate list */
-};
-MODULE_DEVICE_TABLE(pci, hpwdt_devices);
-
 extern asmlinkage void asminline_call(struct cmn_registers *pi86Regs,
 						unsigned long *pRomEntry);
 
