Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:53227 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759331Ab0HFVbU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Aug 2010 17:31:20 -0400
Date: Fri, 6 Aug 2010 23:31:18 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: dann frazier <dannf@hp.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>
Subject: watchdog: hpwdt (4/12): Despecificate driver from iLO2
Message-ID: <20100806213118.GC31433@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit 2cf7d4ea603dd9ef704c3e3b939a7a3e4446ecd8
Author: dann frazier <dannf@hp.com>
Date:   Tue Jul 27 17:50:57 2010 -0600

    watchdog: hpwdt (4/12): Despecificate driver from iLO2
    
    This driver supports both iLO2 and iLO3, but our user-visible strings
    currently only reference iLO2. Let's just call it "iLO2+" to avoid having
    to update strings for each iLO generation. This driver doesn't support
    iLO ASICs prior to iLO2, but that is sufficiently explained in Kconfig.
    
    Signed-off-by: dann frazier <dannf@hp.com>
    Acked-by: Thomas Mingarelli <Thomas.Mingarelli@hp.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f7fa16b..ca1de0e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -574,11 +574,11 @@ config IT87_WDT
 	  be called it87_wdt.
 
 config HP_WATCHDOG
-	tristate "HP Proliant iLO 2 Hardware Watchdog Timer"
+	tristate "HP Proliant iLO2+ Hardware Watchdog Timer"
 	depends on X86
 	help
 	  A software monitoring watchdog and NMI sourcing driver. This driver
-	  will detect lockups and provide stack trace. Also, when an NMI
+	  will detect lockups and provide a stack trace. Also, when an NMI
 	  occurs this driver will make the necessary BIOS calls to log
 	  the cause of the NMI. This is a driver that will only load on a
 	  HP ProLiant system with a minimum of iLO2 support.
diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index f0ecb14..e18f6b9 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -48,8 +48,8 @@ static unsigned long __iomem *hpwdt_timer_reg;
 static unsigned long __iomem *hpwdt_timer_con;
 
 static struct pci_device_id hpwdt_devices[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_COMPAQ, 0xB203) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_HP, 0x3306) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_COMPAQ, 0xB203) },	/* iLO2 */
+	{ PCI_DEVICE(PCI_VENDOR_ID_HP, 0x3306) },	/* iLO3 */
 	{0},			/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, hpwdt_devices);
@@ -548,7 +548,7 @@ static const struct watchdog_info ident = {
 	.options = WDIOF_SETTIMEOUT |
 		   WDIOF_KEEPALIVEPING |
 		   WDIOF_MAGICCLOSE,
-	.identity = "HP iLO2 HW Watchdog Timer",
+	.identity = "HP iLO2+ HW Watchdog Timer",
 };
 
 static long hpwdt_ioctl(struct file *file, unsigned int cmd,
@@ -654,13 +654,13 @@ static int __devinit hpwdt_init_one(struct pci_dev *dev,
 	hpwdt_check_nmi_sourcing(dev);
 
 	/*
-	 * First let's find out if we are on an iLO2 server. We will
+	 * First let's find out if we are on an iLO2+ server. We will
 	 * not run on a legacy ASM box.
 	 * So we only support the G5 ProLiant servers and higher.
 	 */
 	if (dev->subsystem_vendor != PCI_VENDOR_ID_HP) {
 		dev_warn(&dev->dev,
-			"This server does not have an iLO2 ASIC.\n");
+			"This server does not have an iLO2+ ASIC.\n");
 		return -ENODEV;
 	}
 
@@ -674,7 +674,7 @@ static int __devinit hpwdt_init_one(struct pci_dev *dev,
 	pci_mem_addr = pci_iomap(dev, 1, 0x80);
 	if (!pci_mem_addr) {
 		dev_warn(&dev->dev,
-			"Unable to detect the iLO2 server memory.\n");
+			"Unable to detect the iLO2+ server memory.\n");
 		retval = -ENOMEM;
 		goto error_pci_iomap;
 	}
