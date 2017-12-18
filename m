Return-Path: <zboszor@pr.hu>
Return-path: <zboszor@pr.hu>
From: Zoltan Boszormenyi <zboszor@pr.hu>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: Paul Menzel <paulepanter@users.sourceforge.net>,
	Christian Fetzer <fetzer.ch@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Nehal Shah <nehal-bakulchandra.shah@amd.com>,
	Tim Small <tim@seoss.co.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@ekass.net,
	wim@iguana.be,
	jlayton@poochiereds.net,
	marc.2377@gmail.com,
	cshorler@googlemail.com,
	wsa@the-dreams.de,
	regressions@leemhuis.info,
	Alex Williamson <alex.williamson@redhat.com>,
	lyude@redhat.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jakub Sitnicki <jsitnicki@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Simon Guinot <simon.guinot@sequanux.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Mike Travis <travis@sgi.com>,
	Daeseok Youn <daeseok.youn@gmail.com>,
	Huang Rui <ray.huang@amd.com>,
	Andiry Xu <andiry.xu@amd.com>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	David Howells <dhowells@redhat.com>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Alexandre Desnoyers <alex@qtec.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Wan ZongShun <Vincent.Wan@amd.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Lucas Stach <dev@lynxeye.de>,
	Denis Turischev <denis.turischev@compulab.co.il>,
	=?UTF-8?q?B=C3=B6sz=C3=B6rm=C3=A9nyi=20Zolt=C3=A1n?= <zboszor@pr.hu>
Subject: [PATCH 4/5 v5] i2c: i2c-piix4: Use request_declared_muxed_region()
Date: Mon, 18 Dec 2017 09:48:40 +0100
Message-Id: <20171218084841.9979-4-zboszor@pr.hu>
In-Reply-To: <20171218084841.9979-1-zboszor@pr.hu>
References: <20171218084841.9979-1-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

From: Böszörményi Zoltán <zboszor@pr.hu>

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

v5: Rebased for 4.15-rc4
    Use struct i2c_algorithm pointer directly instead of
    a bool to select the proper algo.

Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
---
 drivers/i2c/busses/i2c-piix4.c | 51 +++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 462948e2c535..1846d9ea7d27 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -153,10 +153,11 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
 
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
 static u8 piix4_port_mask_sb800;
 static u8 piix4_port_shift_sb800;
@@ -169,7 +170,6 @@ struct i2c_piix4_adapdata {
 	unsigned short smba;
 
 	/* SB800 */
-	bool sb800_main;
 	bool notify_imc;
 	u8 port;		/* Port number, shifted */
 };
@@ -298,12 +298,12 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
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
@@ -373,7 +373,7 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 			break;
 		}
 	} else {
-		mutex_lock(&piix4_mutex_sb800);
+		request_declared_muxed_region(&sb800_res);
 		outb_p(SB800_PIIX4_PORT_IDX_SEL, SB800_PIIX4_SMB_IDX);
 		port_sel = inb_p(SB800_PIIX4_SMB_IDX + 1);
 		piix4_port_sel_sb800 = (port_sel & 0x01) ?
@@ -381,7 +381,7 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 				       SB800_PIIX4_PORT_IDX;
 		piix4_port_mask_sb800 = SB800_PIIX4_PORT_IDX_MASK;
 		piix4_port_shift_sb800 = SB800_PIIX4_PORT_IDX_SHIFT;
-		mutex_unlock(&piix4_mutex_sb800);
+		release_declared_region(&sb800_res);
 	}
 
 	dev_info(&PIIX4_dev->dev,
@@ -679,7 +679,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	u8 port;
 	int retval;
 
-	mutex_lock(&piix4_mutex_sb800);
+	request_declared_muxed_region(&sb800_res);
 
 	/* Request the SMBUS semaphore, avoid conflicts with the IMC */
 	smbslvcnt  = inb_p(SMBSLVCNT);
@@ -695,7 +695,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	} while (--retries);
 	/* SMBus is still owned by the IMC, we give up */
 	if (!retries) {
-		mutex_unlock(&piix4_mutex_sb800);
+		release_declared_region(&sb800_res);
 		return -EBUSY;
 	}
 
@@ -753,7 +753,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	if ((size == I2C_SMBUS_BLOCK_DATA) && adapdata->notify_imc)
 		piix4_imc_wakeup();
 
-	mutex_unlock(&piix4_mutex_sb800);
+	release_declared_region(&sb800_res);
 
 	return retval;
 }
@@ -804,7 +804,8 @@ static struct i2c_adapter *piix4_main_adapters[PIIX4_MAX_ADAPTERS];
 static struct i2c_adapter *piix4_aux_adapter;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
-			     bool sb800_main, u8 port, bool notify_imc,
+			     struct i2c_algorithm *algo,
+			     u8 port, bool notify_imc,
 			     const char *name, struct i2c_adapter **padap)
 {
 	struct i2c_adapter *adap;
@@ -819,8 +820,7 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
-	adap->algo = sb800_main ? &piix4_smbus_algorithm_sb800
-				: &smbus_algorithm;
+	adap->algo = algo;
 
 	adapdata = kzalloc(sizeof(*adapdata), GFP_KERNEL);
 	if (adapdata == NULL) {
@@ -830,7 +830,6 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	}
 
 	adapdata->smba = smba;
-	adapdata->sb800_main = sb800_main;
 	adapdata->port = port << piix4_port_shift_sb800;
 	adapdata->notify_imc = notify_imc;
 
@@ -862,7 +861,9 @@ static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short smba,
 	int retval;
 
 	for (port = 0; port < PIIX4_MAX_ADAPTERS; port++) {
-		retval = piix4_add_adapter(dev, smba, true, port, notify_imc,
+		retval = piix4_add_adapter(dev, smba,
+					   &piix4_smbus_algorithm_sb800,
+					   port, notify_imc,
 					   piix4_main_port_names_sb800[port],
 					   &piix4_main_adapters[port]);
 		if (retval < 0)
@@ -899,13 +900,6 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		bool notify_imc = false;
 		is_sb800 = true;
 
-		if (!request_region(SB800_PIIX4_SMB_IDX, 2, "smba_idx")) {
-			dev_err(&dev->dev,
-			"SMBus base address index region 0x%x already in use!\n",
-			SB800_PIIX4_SMB_IDX);
-			return -EBUSY;
-		}
-
 		if (dev->vendor == PCI_VENDOR_ID_AMD &&
 		    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
 			u8 imc;
@@ -922,27 +916,24 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
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
 		retval = piix4_add_adapters_sb800(dev, retval, notify_imc);
-		if (retval < 0) {
-			release_region(SB800_PIIX4_SMB_IDX, 2);
+		if (retval < 0)
 			return retval;
-		}
 	} else {
 		retval = piix4_setup(dev, id);
 		if (retval < 0)
 			return retval;
 
 		/* Try to register main SMBus adapter, give up if we can't */
-		retval = piix4_add_adapter(dev, retval, false, 0, false, "",
+		retval = piix4_add_adapter(dev, retval,
+					   &smbus_algorithm, 0, false, "",
 					   &piix4_main_adapters[0]);
 		if (retval < 0)
 			return retval;
@@ -983,11 +974,8 @@ static void piix4_adap_remove(struct i2c_adapter *adap)
 
 	if (adapdata->smba) {
 		i2c_del_adapter(adap);
-		if (adapdata->port == (0 << piix4_port_shift_sb800)) {
+		if (adapdata->port == (0 << piix4_port_shift_sb800))
 			release_region(adapdata->smba, SMBIOSIZE);
-			if (adapdata->sb800_main)
-				release_region(SB800_PIIX4_SMB_IDX, 2);
-		}
 		kfree(adapdata);
 		kfree(adap);
 	}
-- 
2.13.6
