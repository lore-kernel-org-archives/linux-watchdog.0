Return-path: <Ray.Huang@amd.com>
From: Huang Rui <ray.huang@amd.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Denis
 Turischev" <denis.turischev@compulab.co.il>, Borislav Petkov <bp@alien8.de>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>, Huang Rui
	<ray.huang@amd.com>
Subject: [PATCH 1/2] sp5100_tco: fix the device check for SB800 and later chipsets
Date: Mon, 23 Nov 2015 18:07:35 +0800
Message-ID: <1448273256-1793-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

For SB800 and later chipsets, the register definitions are the same
with SB800. And for SB700 and older chipsets, the definitions should
be same with SP5100/SB7x0.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Cc: Denis Turischev <denis.turischev@compulab.co.il>
---

Hi Guenter,

These two patches should be on top of "sp5100_tco: Add AMD Mullins
platform support". And are rebased at watchdog-next branch.

Thanks,
Rui

---
 drivers/watchdog/sp5100_tco.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index ef039f8..c9dd419 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -333,21 +333,24 @@ static unsigned char sp5100_tco_setupdevice(void)
 	if (!sp5100_tco_pci)
 		return 0;
 
-	pr_info("PCI Revision ID: 0x%x\n", sp5100_tco_pci->revision);
+	pr_info("PCI Vendor ID: 0x%x, Device ID: 0x%x, Revision ID: 0x%x\n",
+		sp5100_tco_pci->vendor, sp5100_tco_pci->device,
+		sp5100_tco_pci->revision);
 
 	/*
 	 * Determine type of southbridge chipset.
 	 */
-	if (sp5100_tco_pci->revision >= 0x40) {
-		dev_name = SB800_DEVNAME;
-		index_reg = SB800_IO_PM_INDEX_REG;
-		data_reg = SB800_IO_PM_DATA_REG;
-		base_addr = SB800_PM_WATCHDOG_BASE;
-	} else {
+	if (sp5100_tco_pci->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
+	    sp5100_tco_pci->revision < 0x40) {
 		dev_name = SP5100_DEVNAME;
 		index_reg = SP5100_IO_PM_INDEX_REG;
 		data_reg = SP5100_IO_PM_DATA_REG;
 		base_addr = SP5100_PM_WATCHDOG_BASE;
+	} else {
+		dev_name = SB800_DEVNAME;
+		index_reg = SB800_IO_PM_INDEX_REG;
+		data_reg = SB800_IO_PM_DATA_REG;
+		base_addr = SB800_PM_WATCHDOG_BASE;
 	}
 
 	/* Request the IO ports used by this driver */
@@ -383,7 +386,12 @@ static unsigned char sp5100_tco_setupdevice(void)
 	 * Secondly, Find the watchdog timer MMIO address
 	 * from SBResource_MMIO register.
 	 */
-	if (sp5100_tco_pci->revision >= 0x40) {
+	if (sp5100_tco_pci->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
+	    sp5100_tco_pci->revision < 0x40) {
+		/* Read SBResource_MMIO from PCI config(PCI_Reg: 9Ch) */
+		pci_read_config_dword(sp5100_tco_pci,
+				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
+	} else {
 		/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg: 24h) */
 		outb(SB800_PM_ACPI_MMIO_EN+3, SB800_IO_PM_INDEX_REG);
 		val = inb(SB800_IO_PM_DATA_REG);
@@ -393,10 +401,6 @@ static unsigned char sp5100_tco_setupdevice(void)
 		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
 		outb(SB800_PM_ACPI_MMIO_EN+0, SB800_IO_PM_INDEX_REG);
 		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
-	} else {
-		/* Read SBResource_MMIO from PCI config(PCI_Reg: 9Ch) */
-		pci_read_config_dword(sp5100_tco_pci,
-				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
 	}
 
 	/* The SBResource_MMIO is enabled and mapped memory space? */
-- 
1.9.1
