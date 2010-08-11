Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:4054 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751797Ab0HKMwh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 11 Aug 2010 08:52:37 -0400
Date: Wed, 11 Aug 2010 14:52:35 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: dann frazier <dannf@hp.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>
Subject: watchdog: hpwdt (12/12): Make NMI decoding a compile-time option
Message-ID: <20100811125235.GK4288@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit 8f57282a38260887ac6846ca0fc39870b0d08221
Author: dann frazier <dannf@hp.com>
Date:   Tue Jul 27 17:51:02 2010 -0600

    watchdog: hpwdt (12/12): Make NMI decoding a compile-time option
    
    hpwdt is quite functional without the NMI decoding feature.
    This change lets users disable the NMI portion at compile-time
    via the new HPWDT_NMI_DECODING config option.
    
    Signed-off-by: dann frazier <dannf@hp.com>
    Acked-by: Thomas Mingarelli <Thomas.Mingarelli@hp.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index cee25e4..b036677 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -578,12 +578,17 @@ config HP_WATCHDOG
 	depends on X86
 	help
 	  A software monitoring watchdog and NMI sourcing driver. This driver
-	  will detect lockups and provide a stack trace. Also, when an NMI
-	  occurs this driver will make the necessary BIOS calls to log
-	  the cause of the NMI. This is a driver that will only load on a
-	  HP ProLiant system with a minimum of iLO2 support.
-	  To compile this driver as a module, choose M here: the
-	  module will be called hpwdt.
+	  will detect lockups and provide a stack trace. This is a driver that
+	  will only load on a HP ProLiant system with a minimum of iLO2 support.
+	  To compile this driver as a module, choose M here: the module will be
+	  called hpwdt.
+
+config HPWDT_NMI_DECODING
+	bool "NMI decoding support for the HP ProLiant iLO2+ Hardware Watchdog Timer"
+	depends on HP_WATCHDOG
+	help
+	  When an NMI occurs this feature will make the necessary BIOS calls to
+	  log the cause of the NMI.
 
 config SC1200_WDT
 	tristate "National Semiconductor PC87307/PC97307 (ala SC1200) Watchdog"
diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 850f178..3d77116 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -27,14 +27,16 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
+#ifdef CONFIG_HPWDT_NMI_DECODING
 #include <linux/dmi.h>
 #include <linux/spinlock.h>
 #include <linux/nmi.h>
 #include <linux/kdebug.h>
 #include <linux/notifier.h>
 #include <asm/cacheflush.h>
+#endif /* CONFIG_HPWDT_NMI_DECODING */
 
-#define HPWDT_VERSION			"1.1.1"
+#define HPWDT_VERSION			"1.2.0"
 #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
 #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
 #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
@@ -57,6 +59,7 @@ static struct pci_device_id hpwdt_devices[] = {
 };
 MODULE_DEVICE_TABLE(pci, hpwdt_devices);
 
+#ifdef CONFIG_HPWDT_NMI_DECODING
 #define PCI_BIOS32_SD_VALUE		0x5F32335F	/* "_32_" */
 #define CRU_BIOS_SIGNATURE_VALUE	0x55524324
 #define PCI_BIOS32_PARAGRAPH_LEN	16
@@ -407,6 +410,7 @@ static int __devinit detect_cru_service(void)
 }
 /* ------------------------------------------------------------------------- */
 #endif /* CONFIG_X86_64 */
+#endif /* CONFIG_HPWDT_NMI_DECODING */
 
 /*
  *	Watchdog operations
@@ -455,6 +459,7 @@ static int hpwdt_time_left(void)
 	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
 }
 
+#ifdef CONFIG_HPWDT_NMI_DECODING
 /*
  *	NMI Handler
  */
@@ -487,6 +492,7 @@ static int hpwdt_pretimeout(struct notifier_block *nb, unsigned long ulReason,
 out:
 	return NOTIFY_OK;
 }
+#endif /* CONFIG_HPWDT_NMI_DECODING */
 
 /*
  *	/dev/watchdog handling
@@ -624,15 +630,18 @@ static struct miscdevice hpwdt_miscdev = {
 	.fops = &hpwdt_fops,
 };
 
+#ifdef CONFIG_HPWDT_NMI_DECODING
 static struct notifier_block die_notifier = {
 	.notifier_call = hpwdt_pretimeout,
 	.priority = 0,
 };
+#endif /* CONFIG_HPWDT_NMI_DECODING */
 
 /*
  *	Init & Exit
  */
 
+#ifdef CONFIG_HPWDT_NMI_DECODING
 #ifdef ARCH_HAS_NMI_WATCHDOG
 static void __devinit hpwdt_check_nmi_decoding(struct pci_dev *dev)
 {
@@ -712,6 +721,20 @@ static void __devexit hpwdt_exit_nmi_decoding(void)
 	if (cru_rom_addr)
 		iounmap(cru_rom_addr);
 }
+#else /* !CONFIG_HPWDT_NMI_DECODING */
+static void __devinit hpwdt_check_nmi_decoding(struct pci_dev *dev)
+{
+}
+
+static int __devinit hpwdt_init_nmi_decoding(struct pci_dev *dev)
+{
+	return 0;
+}
+
+static void __devexit hpwdt_exit_nmi_decoding(void)
+{
+}
+#endif /* CONFIG_HPWDT_NMI_DECODING */
 
 static int __devinit hpwdt_init_one(struct pci_dev *dev,
 					const struct pci_device_id *ent)
@@ -823,12 +846,14 @@ module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+#ifdef CONFIG_HPWDT_NMI_DECODING
 module_param(allow_kdump, int, 0);
 MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
 
 module_param(priority, int, 0);
 MODULE_PARM_DESC(priority, "The hpwdt driver handles NMIs first or last"
 		" (default = 0/Last)\n");
+#endif /* !CONFIG_HPWDT_NMI_DECODING */
 
 module_init(hpwdt_init);
 module_exit(hpwdt_cleanup);
