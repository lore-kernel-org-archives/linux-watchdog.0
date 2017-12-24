Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36134 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbdLXVE0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 24 Dec 2017 16:04:26 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 05/12] watchdog: sp5100_tco: Clean up sp5100_tco_setupdevice
Date: Sun, 24 Dec 2017 13:04:10 -0800
Message-Id: <1514149457-20273-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
References: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

There are too many unnecessary goto statements in sp5100_tco_setupdevice().
Rearrange the code and limit goto statements to error handling.

Cc: Zoltán Böszörményi <zboszor@pr.hu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sp5100_tco.c | 62 ++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 0e816f2cdb07..5a13ab483c50 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -396,48 +396,44 @@ static int sp5100_tco_setupdevice(void)
 	pr_debug("Got 0x%04x from indirect I/O\n", val);
 
 	/* Check MMIO address conflict */
-	if (request_mem_region_exclusive(val, SP5100_WDT_MEM_MAP_SIZE,
-								dev_name))
-		goto setup_wdt;
-	else
+	if (!request_mem_region_exclusive(val, SP5100_WDT_MEM_MAP_SIZE,
+					  dev_name)) {
 		pr_debug("MMIO address 0x%04x already in use\n", val);
+		/*
+		 * Secondly, Find the watchdog timer MMIO address
+		 * from SBResource_MMIO register.
+		 */
+		if (tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
+			/* Read SBResource_MMIO from PCI config(PCI_Reg: 9Ch) */
+			pci_read_config_dword(sp5100_tco_pci,
+					      SP5100_SB_RESOURCE_MMIO_BASE,
+					      &val);
+		} else {
+			/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg: 24h) */
+			val = sp5100_tco_read_pm_reg32(SB800_PM_ACPI_MMIO_EN);
+		}
 
-	/*
-	 * Secondly, Find the watchdog timer MMIO address
-	 * from SBResource_MMIO register.
-	 */
-	if (tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
-		/* Read SBResource_MMIO from PCI config(PCI_Reg: 9Ch) */
-		pci_read_config_dword(sp5100_tco_pci,
-				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
-	} else {
-		/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg: 24h) */
-		val = sp5100_tco_read_pm_reg32(SB800_PM_ACPI_MMIO_EN);
-	}
-
-	/* The SBResource_MMIO is enabled and mapped memory space? */
-	if ((val & (SB800_ACPI_MMIO_DECODE_EN | SB800_ACPI_MMIO_SEL)) ==
+		/* The SBResource_MMIO is enabled and mapped memory space? */
+		if ((val & (SB800_ACPI_MMIO_DECODE_EN | SB800_ACPI_MMIO_SEL)) !=
 						  SB800_ACPI_MMIO_DECODE_EN) {
+			pr_notice("failed to find MMIO address, giving up.\n");
+			ret = -ENODEV;
+			goto unreg_region;
+		}
 		/* Clear unnecessary the low twelve bits */
 		val &= ~0xFFF;
 		/* Add the Watchdog Timer offset to base address. */
 		val += SB800_PM_WDT_MMIO_OFFSET;
 		/* Check MMIO address conflict */
-		if (request_mem_region_exclusive(val, SP5100_WDT_MEM_MAP_SIZE,
-								   dev_name)) {
-			pr_debug("Got 0x%04x from SBResource_MMIO register\n",
-				val);
-			goto setup_wdt;
-		} else
+		if (!request_mem_region_exclusive(val, SP5100_WDT_MEM_MAP_SIZE,
+						  dev_name)) {
 			pr_debug("MMIO address 0x%04x already in use\n", val);
-	} else
-		pr_debug("SBResource_MMIO is disabled(0x%04x)\n", val);
-
-	pr_notice("failed to find MMIO address, giving up.\n");
-	ret = -ENODEV;
-	goto  unreg_region;
+			ret = -EBUSY;
+			goto unreg_region;
+		}
+		pr_debug("Got 0x%04x from SBResource_MMIO register\n", val);
+	}
 
-setup_wdt:
 	tcobase_phys = val;
 
 	tcobase = ioremap(val, SP5100_WDT_MEM_MAP_SIZE);
@@ -472,7 +468,7 @@ static int sp5100_tco_setupdevice(void)
 	tco_timer_stop();
 
 	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
-	/* Done */
+
 	return 0;
 
 unreg_mem_region:
-- 
2.7.4

