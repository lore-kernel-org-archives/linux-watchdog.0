Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38858 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbdLXVE0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 24 Dec 2017 16:04:26 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 04/12] watchdog: sp5100_tco: Use standard error codes
Date: Sun, 24 Dec 2017 13:04:09 -0800
Message-Id: <1514149457-20273-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
References: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

By using standard error codes, we can identify and return more than one
error condition.

Cc: Zoltán Böszörményi <zboszor@pr.hu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sp5100_tco.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 11109ac959e2..0e816f2cdb07 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -345,12 +345,13 @@ static u8 sp5100_tco_read_pm_reg32(u8 index)
 /*
  * Init & exit routines
  */
-static unsigned char sp5100_tco_setupdevice(void)
+static int sp5100_tco_setupdevice(void)
 {
 	struct pci_dev *dev = NULL;
 	const char *dev_name = NULL;
 	u32 val;
 	u8 base_addr;
+	int ret;
 
 	/* Match the PCI device */
 	for_each_pci_dev(dev) {
@@ -361,7 +362,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 	}
 
 	if (!sp5100_tco_pci)
-		return 0;
+		return -ENODEV;
 
 	pr_info("PCI Vendor ID: 0x%x, Device ID: 0x%x, Revision ID: 0x%x\n",
 		sp5100_tco_pci->vendor, sp5100_tco_pci->device,
@@ -383,7 +384,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 				  SP5100_PM_IOPORTS_SIZE, dev_name)) {
 		pr_err("I/O address 0x%04x already in use\n",
 		       SP5100_IO_PM_INDEX_REG);
-		goto exit;
+		return -EBUSY;
 	}
 
 	/*
@@ -433,6 +434,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 		pr_debug("SBResource_MMIO is disabled(0x%04x)\n", val);
 
 	pr_notice("failed to find MMIO address, giving up.\n");
+	ret = -ENODEV;
 	goto  unreg_region;
 
 setup_wdt:
@@ -441,6 +443,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 	tcobase = ioremap(val, SP5100_WDT_MEM_MAP_SIZE);
 	if (!tcobase) {
 		pr_err("failed to get tcobase address\n");
+		ret = -ENOMEM;
 		goto unreg_mem_region;
 	}
 
@@ -470,14 +473,13 @@ static unsigned char sp5100_tco_setupdevice(void)
 
 	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
 	/* Done */
-	return 1;
+	return 0;
 
 unreg_mem_region:
 	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
 unreg_region:
 	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
-exit:
-	return 0;
+	return ret;
 }
 
 static int sp5100_tco_init(struct platform_device *dev)
@@ -488,8 +490,9 @@ static int sp5100_tco_init(struct platform_device *dev)
 	 * Check whether or not the hardware watchdog is there. If found, then
 	 * set it up.
 	 */
-	if (!sp5100_tco_setupdevice())
-		return -ENODEV;
+	ret = sp5100_tco_setupdevice();
+	if (ret)
+		return ret;
 
 	/* Check to see if last reboot was due to watchdog timeout */
 	pr_info("Last reboot was %striggered by watchdog.\n",
-- 
2.7.4

