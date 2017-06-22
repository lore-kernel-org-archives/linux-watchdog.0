Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:53317 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752332AbdFVNWJ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 22 Jun 2017 09:22:09 -0400
From: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>
To: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Tim Small <tim@seoss.co.uk>,
        Guenter Roeck <linux@roeck-us.net>, kernel@ekass.net,
        wim@iguana.be, jlayton@poochiereds.net, marc.2377@gmail.com,
        cshorler@googlemail.com, wsa@the-dreams.de,
        regressions@leemhuis.info,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>
Subject: [PATCH 4/5 v4] i2c: i2c-piix4: Use request_declared_muxed_region()
Date: Thu, 22 Jun 2017 15:21:33 +0200
Message-Id: <20170622132134.7200-5-zboszor@pr.hu>
In-Reply-To: <20170622132134.7200-1-zboszor@pr.hu>
References: <20170621035349.4125-1-zboszor@pr.hu>
 <20170622132134.7200-1-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the new request_declared_muxed_region() macro to
synchronize access to the I/O port pair 0xcd6 / 0xcd7.

At the same time, remove the long lifetime request_region()
call to reserve these I/O ports, so the sp5100_tco watchdog
driver can also load.

This fixes an old regression in Linux 4.4-rc4, caused by
commit 2fee61d22e60 ("i2c: piix4: Add support for multiplexed
main adapter in SB800")

v1: Started with a common mutex in a C source file.

v2: Referenced to common mutex from drivers/usb/host/pci-quirks.c

v3: Switched to using the new request_declared_muxed_region
    macro.

v4: Fixed checkpatch.pl warnings and use the new
    release_declared_region() macro.

Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
---
 drivers/i2c/busses/i2c-piix4.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 0ecdb47..a204344 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -144,10 +144,11 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
 
 /*
  * SB800 globals
- * piix4_mutex_sb800 protects piix4_port_sel_sb800 and the pair
+ * request_declared_muxed_region() protects piix4_port_sel_sb800 and the pair
  * of I/O ports at SB800_PIIX4_SMB_IDX.
  */
-static DEFINE_MUTEX(piix4_mutex_sb800);
+static struct resource sb800_res = DEFINE_RES_IO_NAMED(SB800_PIIX4_SMB_IDX, 2,
+						 "i2c-piix4");
 static u8 piix4_port_sel_sb800;
 static const char *piix4_main_port_names_sb800[PIIX4_MAX_ADAPTERS] = {
 	" port 0", " port 2", " port 3", " port 4"
@@ -158,7 +159,6 @@ struct i2c_piix4_adapdata {
 	unsigned short smba;
 
 	/* SB800 */
-	bool sb800_main;
 	u8 port;		/* Port number, shifted */
 };
 
@@ -286,12 +286,12 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	else
 		smb_en = (aux) ? 0x28 : 0x2c;
 
-	mutex_lock(&piix4_mutex_sb800);
+	request_declared_muxed_region(&sb800_res);
 	outb_p(smb_en, SB800_PIIX4_SMB_IDX);
 	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
 	outb_p(smb_en + 1, SB800_PIIX4_SMB_IDX);
 	smba_en_hi = inb_p(SB800_PIIX4_SMB_IDX + 1);
-	mutex_unlock(&piix4_mutex_sb800);
+	release_declared_region(&sb800_res);
 
 	if (!smb_en) {
 		smb_en_status = smba_en_lo & 0x10;
@@ -349,13 +349,13 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD) {
 		piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_ALT;
 	} else {
-		mutex_lock(&piix4_mutex_sb800);
+		request_declared_muxed_region(&sb800_res);
 		outb_p(SB800_PIIX4_PORT_IDX_SEL, SB800_PIIX4_SMB_IDX);
 		port_sel = inb_p(SB800_PIIX4_SMB_IDX + 1);
 		piix4_port_sel_sb800 = (port_sel & 0x01) ?
 				       SB800_PIIX4_PORT_IDX_ALT :
 				       SB800_PIIX4_PORT_IDX;
-		mutex_unlock(&piix4_mutex_sb800);
+		release_declared_region(&sb800_res);
 	}
 
 	dev_info(&PIIX4_dev->dev,
@@ -592,7 +592,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	u8 port;
 	int retval;
 
-	mutex_lock(&piix4_mutex_sb800);
+	request_declared_muxed_region(&sb800_res);
 
 	/* Request the SMBUS semaphore, avoid conflicts with the IMC */
 	smbslvcnt  = inb_p(SMBSLVCNT);
@@ -608,7 +608,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	} while (--retries);
 	/* SMBus is still owned by the IMC, we give up */
 	if (!retries) {
-		mutex_unlock(&piix4_mutex_sb800);
+		release_declared_region(&sb800_res);
 		return -EBUSY;
 	}
 
@@ -628,7 +628,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	/* Release the semaphore */
 	outb_p(smbslvcnt | 0x20, SMBSLVCNT);
 
-	mutex_unlock(&piix4_mutex_sb800);
+	release_declared_region(&sb800_res);
 
 	return retval;
 }
@@ -705,7 +705,6 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	}
 
 	adapdata->smba = smba;
-	adapdata->sb800_main = sb800_main;
 	adapdata->port = port << 1;
 
 	/* set up the sysfs linkage to our parent device */
@@ -771,29 +770,18 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
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
@@ -841,11 +829,8 @@ static void piix4_adap_remove(struct i2c_adapter *adap)
 
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
2.9.4

