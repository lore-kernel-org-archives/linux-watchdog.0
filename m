Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:60728 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752669AbdDALJG (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 1 Apr 2017 07:09:06 -0400
From: Zoltan Boszormenyi <zboszor@pr.hu>
To: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zoltan Boszormenyi <zboszor@pr.hu>
Subject: [PATCH 2/3] i2c: i2c-piix4: Synchronize I/O port accesses with the SB800 USB quirk
Date: Sat,  1 Apr 2017 13:08:47 +0200
Message-Id: <20170401110847.12857-1-zboszor@pr.hu>
In-Reply-To: <20170401100609.9054-1-zboszor@pr.hu>
References: <20170401100609.9054-1-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the new header and the common mutex in the i2c-piix4 driver.

At the same time, remove the request_region() call to reserve
these I/O ports, so the sp5100_tco watchdog driver is fixed.
The mutex is enough to protect the I/O port accesses. This is
an old regression in Linux 4.4-rc4, caused by:

commit 2fee61d22e606fc99ade9079fda15fdee83ec33e
Author: Christian Fetzer <fetzer.ch@gmail.com>
Date:   Thu Nov 19 20:13:48 2015 +0100

    i2c: piix4: Add support for multiplexed main adapter in SB800

Signed-off-by: Zoltan Boszormenyi <zboszor@pr.hu>
---
 drivers/i2c/busses/i2c-piix4.c | 59 ++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index c21ca7b..a4549e5 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -40,7 +40,7 @@
 #include <linux/dmi.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
-#include <linux/mutex.h>
+#include <linux/sb800.h>
 
 
 /* PIIX4 SMBus address offsets */
@@ -82,9 +82,6 @@
 /* Multi-port constants */
 #define PIIX4_MAX_ADAPTERS 4
 
-/* SB800 constants */
-#define SB800_PIIX4_SMB_IDX		0xcd6
-
 /*
  * SB800 port is selected by bits 2:1 of the smb_en register (0x2c)
  * or the smb_sel register (0x2e), depending on bit 0 of register 0x2f.
@@ -144,10 +141,9 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
 
 /*
  * SB800 globals
- * piix4_mutex_sb800 protects piix4_port_sel_sb800 and the pair
- * of I/O ports at SB800_PIIX4_SMB_IDX.
+ * sb800_mutex in drivers/usb/host/pci-quirks.c protects
+ * piix4_port_sel_sb800 and the pair of I/O ports at SB800_PIIX4_SMB_IDX.
  */
-static DEFINE_MUTEX(piix4_mutex_sb800);
 static u8 piix4_port_sel_sb800;
 static const char *piix4_main_port_names_sb800[PIIX4_MAX_ADAPTERS] = {
 	" port 0", " port 2", " port 3", " port 4"
@@ -157,8 +153,6 @@ static const char *piix4_aux_port_name_sb800 = " port 1";
 struct i2c_piix4_adapdata {
 	unsigned short smba;
 
-	/* SB800 */
-	bool sb800_main;
 	u8 port;		/* Port number, shifted */
 };
 
@@ -286,12 +280,12 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	else
 		smb_en = (aux) ? 0x28 : 0x2c;
 
-	mutex_lock(&piix4_mutex_sb800);
+	enter_sb800();
 	outb_p(smb_en, SB800_PIIX4_SMB_IDX);
-	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
+	smba_en_lo = inb_p(SB800_PIIX4_SMB_DATA);
 	outb_p(smb_en + 1, SB800_PIIX4_SMB_IDX);
-	smba_en_hi = inb_p(SB800_PIIX4_SMB_IDX + 1);
-	mutex_unlock(&piix4_mutex_sb800);
+	smba_en_hi = inb_p(SB800_PIIX4_SMB_DATA);
+	leave_sb800();
 
 	if (!smb_en) {
 		smb_en_status = smba_en_lo & 0x10;
@@ -349,13 +343,13 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD) {
 		piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_ALT;
 	} else {
-		mutex_lock(&piix4_mutex_sb800);
+		enter_sb800();
 		outb_p(SB800_PIIX4_PORT_IDX_SEL, SB800_PIIX4_SMB_IDX);
-		port_sel = inb_p(SB800_PIIX4_SMB_IDX + 1);
+		port_sel = inb_p(SB800_PIIX4_SMB_DATA);
 		piix4_port_sel_sb800 = (port_sel & 0x01) ?
 				       SB800_PIIX4_PORT_IDX_ALT :
 				       SB800_PIIX4_PORT_IDX;
-		mutex_unlock(&piix4_mutex_sb800);
+		leave_sb800();
 	}
 
 	dev_info(&PIIX4_dev->dev,
@@ -592,7 +586,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	u8 port;
 	int retval;
 
-	mutex_lock(&piix4_mutex_sb800);
+	enter_sb800();
 
 	/* Request the SMBUS semaphore, avoid conflicts with the IMC */
 	smbslvcnt  = inb_p(SMBSLVCNT);
@@ -608,27 +602,27 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	} while (--retries);
 	/* SMBus is still owned by the IMC, we give up */
 	if (!retries) {
-		mutex_unlock(&piix4_mutex_sb800);
+		leave_sb800();
 		return -EBUSY;
 	}
 
 	outb_p(piix4_port_sel_sb800, SB800_PIIX4_SMB_IDX);
-	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
+	smba_en_lo = inb_p(SB800_PIIX4_SMB_DATA);
 
 	port = adapdata->port;
 	if ((smba_en_lo & SB800_PIIX4_PORT_IDX_MASK) != port)
 		outb_p((smba_en_lo & ~SB800_PIIX4_PORT_IDX_MASK) | port,
-		       SB800_PIIX4_SMB_IDX + 1);
+		       SB800_PIIX4_SMB_DATA);
 
 	retval = piix4_access(adap, addr, flags, read_write,
 			      command, size, data);
 
-	outb_p(smba_en_lo, SB800_PIIX4_SMB_IDX + 1);
+	outb_p(smba_en_lo, SB800_PIIX4_SMB_DATA);
 
 	/* Release the semaphore */
 	outb_p(smbslvcnt | 0x20, SMBSLVCNT);
 
-	mutex_unlock(&piix4_mutex_sb800);
+	leave_sb800();
 
 	return retval;
 }
@@ -705,7 +699,6 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	}
 
 	adapdata->smba = smba;
-	adapdata->sb800_main = sb800_main;
 	adapdata->port = port << 1;
 
 	/* set up the sysfs linkage to our parent device */
@@ -771,29 +764,18 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	    dev->vendor == PCI_VENDOR_ID_AMD) {
 		is_sb800 = true;
 
-		if (!request_region(SB800_PIIX4_SMB_IDX, 2, "smba_idx")) {
-			dev_err(&dev->dev,
-			"SMBus base address index region 0x%x already in use!\n",
-			SB800_PIIX4_SMB_IDX);
-			return -EBUSY;
-		}
-
 		/* base address location etc changed in SB800 */
 		retval = piix4_setup_sb800(dev, id, 0);
-		if (retval < 0) {
-			release_region(SB800_PIIX4_SMB_IDX, 2);
+		if (retval < 0)
 			return retval;
-		}
 
 		/*
 		 * Try to register multiplexed main SMBus adapter,
 		 * give up if we can't
 		 */
 		retval = piix4_add_adapters_sb800(dev, retval);
-		if (retval < 0) {
-			release_region(SB800_PIIX4_SMB_IDX, 2);
+		if (retval < 0)
 			return retval;
-		}
 	} else {
 		retval = piix4_setup(dev, id);
 		if (retval < 0)
@@ -841,11 +823,8 @@ static void piix4_adap_remove(struct i2c_adapter *adap)
 
 	if (adapdata->smba) {
 		i2c_del_adapter(adap);
-		if (adapdata->port == (0 << 1)) {
+		if (adapdata->port == (0 << 1))
 			release_region(adapdata->smba, SMBIOSIZE);
-			if (adapdata->sb800_main)
-				release_region(SB800_PIIX4_SMB_IDX, 2);
-		}
 		kfree(adapdata);
 		kfree(adap);
 	}
-- 
2.9.3

