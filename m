Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36756 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbdLXVE2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 24 Dec 2017 16:04:28 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 06/12] watchdog: sp5100_tco: Match PCI device early
Date: Sun, 24 Dec 2017 13:04:11 -0800
Message-Id: <1514149457-20273-7-git-send-email-linux@roeck-us.net>
In-Reply-To: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
References: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Match PCI device in module init function, not in the probe function.
It is pointless trying to probe if we can determine early that the device
is not supported.

Cc: Zoltán Böszörményi <zboszor@pr.hu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sp5100_tco.c | 66 ++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 5a13ab483c50..5868c6b6bf17 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -312,25 +312,6 @@ static struct miscdevice sp5100_tco_miscdev = {
 	.fops =		&sp5100_tco_fops,
 };
 
-/*
- * Data for PCI driver interface
- *
- * This data only exists for exporting the supported
- * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
- * register a pci_driver, because someone else might
- * want to register another driver on the same PCI id.
- */
-static const struct pci_device_id sp5100_tco_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS, PCI_ANY_ID,
-	  PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, PCI_ANY_ID,
-	  PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
-	  PCI_ANY_ID, },
-	{ 0, },			/* End of list */
-};
-MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
-
 static u8 sp5100_tco_read_pm_reg32(u8 index)
 {
 	u32 val = 0;
@@ -347,27 +328,11 @@ static u8 sp5100_tco_read_pm_reg32(u8 index)
  */
 static int sp5100_tco_setupdevice(void)
 {
-	struct pci_dev *dev = NULL;
 	const char *dev_name = NULL;
 	u32 val;
 	u8 base_addr;
 	int ret;
 
-	/* Match the PCI device */
-	for_each_pci_dev(dev) {
-		if (pci_match_id(sp5100_tco_pci_tbl, dev) != NULL) {
-			sp5100_tco_pci = dev;
-			break;
-		}
-	}
-
-	if (!sp5100_tco_pci)
-		return -ENODEV;
-
-	pr_info("PCI Vendor ID: 0x%x, Device ID: 0x%x, Revision ID: 0x%x\n",
-		sp5100_tco_pci->vendor, sp5100_tco_pci->device,
-		sp5100_tco_pci->revision);
-
 	/*
 	 * Determine type of southbridge chipset.
 	 */
@@ -557,10 +522,41 @@ static struct platform_driver sp5100_tco_driver = {
 	},
 };
 
+/*
+ * Data for PCI driver interface
+ *
+ * This data only exists for exporting the supported
+ * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
+ * register a pci_driver, because someone else might
+ * want to register another driver on the same PCI id.
+ */
+static const struct pci_device_id sp5100_tco_pci_tbl[] = {
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS, PCI_ANY_ID,
+	  PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, PCI_ANY_ID,
+	  PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
+	  PCI_ANY_ID, },
+	{ 0, },			/* End of list */
+};
+MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
+
 static int __init sp5100_tco_init_module(void)
 {
+	struct pci_dev *dev = NULL;
 	int err;
 
+	/* Match the PCI device */
+	for_each_pci_dev(dev) {
+		if (pci_match_id(sp5100_tco_pci_tbl, dev) != NULL) {
+			sp5100_tco_pci = dev;
+			break;
+		}
+	}
+
+	if (!sp5100_tco_pci)
+		return -ENODEV;
+
 	pr_info("SP5100/SB800 TCO WatchDog Timer Driver v%s\n", TCO_VERSION);
 
 	err = platform_driver_register(&sp5100_tco_driver);
-- 
2.7.4

