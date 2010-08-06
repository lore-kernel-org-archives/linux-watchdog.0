Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:47915 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751403Ab0HFVfw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Aug 2010 17:35:52 -0400
Date: Fri, 6 Aug 2010 23:35:51 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: dann frazier <dannf@hp.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>
Subject: watchdog: hpwdt (11/12): Use "decoding" instead of "sourcing"
Message-ID: <20100806213551.GJ31433@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit d13a35b25f9de70c019d2db8d56f4cec89ca43fa
Author: dann frazier <dannf@hp.com>
Date:   Tue Jul 27 17:51:01 2010 -0600

    watchdog: hpwdt (11/12): Use "decoding" instead of "sourcing"
    
    The term "decoding" more clearly explains what hpwdt is doing. It isn't
    just finding the source of the interrupt, but rather aids in decoding what
    the interrupt means.
    
    Signed-off-by: dann frazier <dannf@hp.com>
    Acked-by: Thomas Mingarelli <Thomas.Mingarelli@hp.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 5bade2d..56bd7e5 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -126,7 +126,7 @@ struct cmn_registers {
 	u32 reflags;
 }  __attribute__((packed));
 
-static unsigned int hpwdt_nmi_sourcing;
+static unsigned int hpwdt_nmi_decoding;
 static unsigned int allow_kdump;
 static unsigned int priority;		/* hpwdt at end of die_notify list */
 static DEFINE_SPINLOCK(rom_lock);
@@ -467,7 +467,7 @@ static int hpwdt_pretimeout(struct notifier_block *nb, unsigned long ulReason,
 	if (ulReason != DIE_NMI && ulReason != DIE_NMI_IPI)
 		goto out;
 
-	if (!hpwdt_nmi_sourcing)
+	if (!hpwdt_nmi_decoding)
 		goto out;
 
 	spin_lock_irqsave(&rom_lock, rom_pl);
@@ -634,23 +634,23 @@ static struct notifier_block die_notifier = {
  */
 
 #ifdef ARCH_HAS_NMI_WATCHDOG
-static void __devinit hpwdt_check_nmi_sourcing(struct pci_dev *dev)
+static void __devinit hpwdt_check_nmi_decoding(struct pci_dev *dev)
 {
 	/*
 	 * If nmi_watchdog is turned off then we can turn on
-	 * our nmi sourcing capability.
+	 * our nmi decoding capability.
 	 */
 	if (!nmi_watchdog_active())
-		hpwdt_nmi_sourcing = 1;
+		hpwdt_nmi_decoding = 1;
 	else
-		dev_warn(&dev->dev, "NMI sourcing is disabled. To enable this "
+		dev_warn(&dev->dev, "NMI decoding is disabled. To enable this "
 			"functionality you must reboot with nmi_watchdog=0 "
 			"and load the hpwdt driver with priority=1.\n");
 }
 #else
-static void __devinit hpwdt_check_nmi_sourcing(struct pci_dev *dev)
+static void __devinit hpwdt_check_nmi_decoding(struct pci_dev *dev)
 {
-	dev_warn(&dev->dev, "NMI sourcing is disabled. "
+	dev_warn(&dev->dev, "NMI decoding is disabled. "
 		"Your kernel does not support a NMI Watchdog.\n");
 }
 #endif
@@ -662,9 +662,9 @@ static int __devinit hpwdt_init_one(struct pci_dev *dev,
 	char *buf;
 
 	/*
-	 * Check if we can do NMI sourcing or not
+	 * Check if we can do NMI decoding or not
 	 */
-	hpwdt_check_nmi_sourcing(dev);
+	hpwdt_check_nmi_decoding(dev);
 
 	/*
 	 * First let's find out if we are on an iLO2+ server. We will
