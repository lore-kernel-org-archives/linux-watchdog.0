Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:47304 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751797Ab0HKMvU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 11 Aug 2010 08:51:20 -0400
Date: Wed, 11 Aug 2010 14:51:18 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: dann frazier <dannf@hp.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>
Subject: watchdog: hpwdt (11/12): move NMI-decoding init and exit to
	seperate functions
Message-ID: <20100811125118.GJ4288@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit 3e31f7a85153aa21ec633d92bd1d43a1c771ef86
Author: dann frazier <dannf@hp.com>
Date:   Wed Jul 28 12:38:43 2010 -0600

    watchdog: hpwdt (11/12): move NMI-decoding init and exit to seperate functions
    
    Move NMI-decoding initialisation and exit code to seperate functions so that
    we can ifdef-out parts of it in the future.
    
    Also, this is for a device, so let's use dev_info instead of printk.
    
    Signed-off-by: dann frazier <dannf@hp.com>
    Acked-by: Thomas Mingarelli <Thomas.Mingarelli@hp.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 99aa76c..850f178 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -653,7 +653,65 @@ static void __devinit hpwdt_check_nmi_decoding(struct pci_dev *dev)
 	dev_warn(&dev->dev, "NMI decoding is disabled. "
 		"Your kernel does not support a NMI Watchdog.\n");
 }
-#endif
+#endif /* ARCH_HAS_NMI_WATCHDOG */
+
+static int __devinit hpwdt_init_nmi_decoding(struct pci_dev *dev)
+{
+	int retval;
+
+	/*
+	 * We need to map the ROM to get the CRU service.
+	 * For 32 bit Operating Systems we need to go through the 32 Bit
+	 * BIOS Service Directory
+	 * For 64 bit Operating Systems we get that service through SMBIOS.
+	 */
+	retval = detect_cru_service();
+	if (retval < 0) {
+		dev_warn(&dev->dev,
+			"Unable to detect the %d Bit CRU Service.\n",
+			HPWDT_ARCH);
+		return retval;
+	}
+
+	/*
+	 * We know this is the only CRU call we need to make so lets keep as
+	 * few instructions as possible once the NMI comes in.
+	 */
+	cmn_regs.u1.rah = 0x0D;
+	cmn_regs.u1.ral = 0x02;
+
+	/*
+	 * If the priority is set to 1, then we will be put first on the
+	 * die notify list to handle a critical NMI. The default is to
+	 * be last so other users of the NMI signal can function.
+	 */
+	if (priority)
+		die_notifier.priority = 0x7FFFFFFF;
+
+	retval = register_die_notifier(&die_notifier);
+	if (retval != 0) {
+		dev_warn(&dev->dev,
+			"Unable to register a die notifier (err=%d).\n",
+			retval);
+		if (cru_rom_addr)
+			iounmap(cru_rom_addr);
+	}
+
+	dev_info(&dev->dev,
+			"HP Watchdog Timer Driver: NMI decoding initialized"
+			", allow kernel dump: %s (default = 0/OFF)"
+			", priority: %s (default = 0/LAST).\n",
+			(allow_kdump == 0) ? "OFF" : "ON",
+			(priority == 0) ? "LAST" : "FIRST");
+	return 0;
+}
+
+static void __devexit hpwdt_exit_nmi_decoding(void)
+{
+	unregister_die_notifier(&die_notifier);
+	if (cru_rom_addr)
+		iounmap(cru_rom_addr);
+}
 
 static int __devinit hpwdt_init_one(struct pci_dev *dev,
 					const struct pci_device_id *ent)
@@ -697,42 +755,10 @@ static int __devinit hpwdt_init_one(struct pci_dev *dev,
 	if (hpwdt_change_timer(soft_margin))
 		hpwdt_change_timer(DEFAULT_MARGIN);
 
-	/*
-	 * We need to map the ROM to get the CRU service.
-	 * For 32 bit Operating Systems we need to go through the 32 Bit
-	 * BIOS Service Directory
-	 * For 64 bit Operating Systems we get that service through SMBIOS.
-	 */
-	retval = detect_cru_service();
-	if (retval < 0) {
-		dev_warn(&dev->dev,
-			"Unable to detect the %d Bit CRU Service.\n",
-			HPWDT_ARCH);
-		goto error_get_cru;
-	}
-
-	/*
-	 * We know this is the only CRU call we need to make so lets keep as
-	 * few instructions as possible once the NMI comes in.
-	 */
-	cmn_regs.u1.rah = 0x0D;
-	cmn_regs.u1.ral = 0x02;
-
-	/*
-	 * If the priority is set to 1, then we will be put first on the
-	 * die notify list to handle a critical NMI. The default is to
-	 * be last so other users of the NMI signal can function.
-	 */
-	if (priority)
-		die_notifier.priority = 0x7FFFFFFF;
-
-	retval = register_die_notifier(&die_notifier);
-	if (retval != 0) {
-		dev_warn(&dev->dev,
-			"Unable to register a die notifier (err=%d).\n",
-			retval);
-		goto error_die_notifier;
-	}
+	/* Initialize NMI Decoding functionality */
+	retval = hpwdt_init_nmi_decoding(dev);
+	if (retval != 0)
+		goto error_init_nmi_decoding;
 
 	retval = misc_register(&hpwdt_miscdev);
 	if (retval < 0) {
@@ -742,23 +768,14 @@ static int __devinit hpwdt_init_one(struct pci_dev *dev,
 		goto error_misc_register;
 	}
 
-	printk(KERN_INFO
-		"hp Watchdog Timer Driver: %s"
-		", timer margin: %d seconds (nowayout=%d)"
-		", allow kernel dump: %s (default = 0/OFF)"
-		", priority: %s (default = 0/LAST).\n",
-		HPWDT_VERSION, soft_margin, nowayout,
-		(allow_kdump == 0) ? "OFF" : "ON",
-		(priority == 0) ? "LAST" : "FIRST");
-
+	dev_info(&dev->dev, "HP Watchdog Timer Driver: %s"
+			", timer margin: %d seconds (nowayout=%d).\n",
+			HPWDT_VERSION, soft_margin, nowayout);
 	return 0;
 
 error_misc_register:
-	unregister_die_notifier(&die_notifier);
-error_die_notifier:
-	if (cru_rom_addr)
-		iounmap(cru_rom_addr);
-error_get_cru:
+	hpwdt_exit_nmi_decoding();
+error_init_nmi_decoding:
 	pci_iounmap(dev, pci_mem_addr);
 error_pci_iomap:
 	pci_disable_device(dev);
@@ -771,10 +788,7 @@ static void __devexit hpwdt_exit(struct pci_dev *dev)
 		hpwdt_stop();
 
 	misc_deregister(&hpwdt_miscdev);
-	unregister_die_notifier(&die_notifier);
-
-	if (cru_rom_addr)
-		iounmap(cru_rom_addr);
+	hpwdt_exit_nmi_decoding();
 	pci_iounmap(dev, pci_mem_addr);
 	pci_disable_device(dev);
 }
