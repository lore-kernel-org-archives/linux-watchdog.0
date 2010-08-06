Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16522 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528Ab0HFPla (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Aug 2010 11:41:30 -0400
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o76FfREI017484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-watchdog@vger.kernel.org>; Fri, 6 Aug 2010 11:41:27 -0400
Date: Fri, 6 Aug 2010 11:41:24 -0400
From: Prarit Bhargava <prarit@redhat.com>
To: linux-watchdog@vger.kernel.org, seth.heasley@intel.com,
	john.villalo@intel.com, wim@iguana.be
Cc: Prarit Bhargava <prarit@redhat.com>
Message-Id: <20100806154124.14863.63659.sendpatchset@prarit.bos.redhat.com>
Subject: [PATCH]: iTCO_wdt: Cleanup warning messages
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The current iTCO_wdt driver warnings are confusing.  Currently when the device
driver returns an error the console contains:

iTCO_vendor_support: vendor-support=0
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05
iTCO_wdt: failed to reset NO_REBOOT flag, reboot disabled by hardware
iTCO_wdt: No card detected

After the patch,

iTCO_vendor_support: vendor-support=0
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05
iTCO_wdt: failed to reset NO_REBOOT flag, device disabled by hardware/BIOS

Clean this up and use the word "device" to describe the device.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 69de871..e851a6c 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -374,7 +374,7 @@ static char expect_release;
 static struct {		/* this is private data for the iTCO_wdt device */
 	/* TCO version/generation */
 	unsigned int iTCO_version;
-	/* The cards ACPIBASE address (TCOBASE = ACPIBASE+0x60) */
+	/* The device's ACPIBASE address (TCOBASE = ACPIBASE+0x60) */
 	unsigned long ACPIBASE;
 	/* NO_REBOOT flag is Memory-Mapped GCS register bit 5 (TCO version 2)*/
 	unsigned long __iomem *gcs;
@@ -467,7 +467,7 @@ static int iTCO_wdt_start(void)
 	if (iTCO_wdt_unset_NO_REBOOT_bit()) {
 		spin_unlock(&iTCO_wdt_private.io_lock);
 		printk(KERN_ERR PFX "failed to reset NO_REBOOT flag, "
-					"reboot disabled by hardware\n");
+		       "reboot disabled by hardware/BIOS\n");
 		return -EIO;
 	}
 
@@ -781,7 +781,8 @@ static int __devinit iTCO_wdt_init(struct pci_dev *pdev,
 	base_address &= 0x0000ff80;
 	if (base_address == 0x00000000) {
 		/* Something's wrong here, ACPIBASE has to be set */
-		printk(KERN_ERR PFX "failed to get TCOBASE address\n");
+		printk(KERN_ERR PFX "failed to get TCOBASE address, "
+		       "device disabled by hardware/BIOS\n");
 		pci_dev_put(pdev);
 		return -ENODEV;
 	}
@@ -797,7 +798,8 @@ static int __devinit iTCO_wdt_init(struct pci_dev *pdev,
 	if (iTCO_wdt_private.iTCO_version == 2) {
 		pci_read_config_dword(pdev, 0xf0, &base_address);
 		if ((base_address & 1) == 0) {
-			printk(KERN_ERR PFX "RCBA is disabled by hardware\n");
+			printk(KERN_ERR PFX "RCBA is disabled by hardware"
+			       "/BIOS, device disabled\n");
 			ret = -ENODEV;
 			goto out;
 		}
@@ -808,7 +810,7 @@ static int __devinit iTCO_wdt_init(struct pci_dev *pdev,
 	/* Check chipset's NO_REBOOT bit */
 	if (iTCO_wdt_unset_NO_REBOOT_bit() && iTCO_vendor_check_noreboot_on()) {
 		printk(KERN_INFO PFX "unable to reset NO_REBOOT flag, "
-					"platform may have disabled it\n");
+		       "device disabled by hardware/BIOS\n");
 		ret = -ENODEV;	/* Cannot reset NO_REBOOT bit */
 		goto out_unmap;
 	}
@@ -819,7 +821,8 @@ static int __devinit iTCO_wdt_init(struct pci_dev *pdev,
 	/* The TCO logic uses the TCO_EN bit in the SMI_EN register */
 	if (!request_region(SMI_EN, 4, "iTCO_wdt")) {
 		printk(KERN_ERR PFX
-			"I/O address 0x%04lx already in use\n", SMI_EN);
+		       "I/O address 0x%04lx already in use, "
+		       "device disabled\n", SMI_EN);
 		ret = -EIO;
 		goto out_unmap;
 	}
@@ -831,8 +834,8 @@ static int __devinit iTCO_wdt_init(struct pci_dev *pdev,
 	/* The TCO I/O registers reside in a 32-byte range pointed to
 	   by the TCOBASE value */
 	if (!request_region(TCOBASE, 0x20, "iTCO_wdt")) {
-		printk(KERN_ERR PFX "I/O address 0x%04lx already in use\n",
-			TCOBASE);
+		printk(KERN_ERR PFX "I/O address 0x%04lx already in use "
+		       "device disabled\n", TCOBASE);
 		ret = -EIO;
 		goto unreg_smi_en;
 	}
@@ -913,15 +916,14 @@ static int __devinit iTCO_wdt_probe(struct platform_device *dev)
 	for_each_pci_dev(pdev) {
 		ent = pci_match_id(iTCO_wdt_pci_tbl, pdev);
 		if (ent) {
-			found++;
-			ret = iTCO_wdt_init(pdev, ent, dev);
-			if (!ret)
+			found = 1;
+			if (!iTCO_wdt_init(pdev, ent, dev))
 				break;
 		}
 	}
 
 	if (!found)
-		printk(KERN_INFO PFX "No card detected\n");
+		printk(KERN_INFO PFX "No device detected.\n");
 
 	return ret;
 }
