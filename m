Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:11489 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752699AbdDIWEE (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 9 Apr 2017 18:04:04 -0400
From: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To: andy@infradead.org, qipeng.zha@intel.com, dvhart@infradead.org,
        linux@roeck-us.net
Cc: wim@iguana.be, sathyaosid@gmail.com, david.e.box@linux.intel.com,
        rajneesh.bhardwaj@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v7 4/6] watchdog: iTCO_wdt: Add PMC specific noreboot update api
Date: Sun,  9 Apr 2017 15:00:19 -0700
Message-Id: <8b609446db874f89df30c4d949e8ef6e3df4e3f7.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aefdf4f6a7b0cf4af92d51ce2b9b73284cc03ffe.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <aefdf4f6a7b0cf4af92d51ce2b9b73284cc03ffe.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In some SoCs, setting noreboot bit needs modification to
PMC GC registers. But not all PMC drivers allow other drivers
to memory map their GC region. This could create mem request
conflict in watchdog driver. So this patch adds facility to allow
PMC drivers to pass noreboot update function to watchdog
drivers via platform data.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/iTCO_wdt.c            | 25 ++++++++++++++++++-------
 include/linux/platform_data/itco_wdt.h |  4 ++++
 2 files changed, 22 insertions(+), 7 deletions(-)

Changes since v6:
 * Moved pdata no_reboot_bit initialization to iTCO_wdt_no_reboot_bit_setup

Changes since v5:
 * Added priv_data to pass private data to no_reboot_bit update function.
 * Changed update_noreboot_flag() to update_no_reboot_bit

Changes since v4:
 * Fixed some style issues.
 * used false for 0 and true for 1 in update_noreboot_flag function.

Changes since v3:
 * Rebased on top of latest.

Changes since v2: 
 * Removed use of PMC API's directly in watchdog driver.
 * Added update_noreboot_flag to handle no IPC PMC compatibility
   issue mentioned by Guenter.

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index a629933..347f038 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -106,6 +106,8 @@ struct iTCO_wdt_private {
 	struct pci_dev *pci_dev;
 	/* whether or not the watchdog has been suspended */
 	bool suspended;
+	/* no reboot API private data */
+	void *no_reboot_priv;
 	/* no reboot update function pointer */
 	int (*update_no_reboot_bit)(void *p, bool set);
 };
@@ -217,14 +219,23 @@ static int update_no_reboot_bit_mem(void *priv, bool set)
 	return 0;
 }
 
-static void iTCO_wdt_no_reboot_bit_setup(struct iTCO_wdt_private *p)
+static void iTCO_wdt_no_reboot_bit_setup(struct iTCO_wdt_private *p,
+		struct itco_wdt_platform_data *pdata)
 {
+	if (pdata->update_no_reboot_bit) {
+		p->update_no_reboot_bit = pdata->update_no_reboot_bit;
+		p->no_reboot_priv = pdata->no_reboot_priv;
+		return;
+	}
+
 	if (p->iTCO_version >= 2)
 		p->update_no_reboot_bit = update_no_reboot_bit_mem;
 	else if (p->iTCO_version == 1)
 		p->update_no_reboot_bit = update_no_reboot_bit_pci;
 	else
 		p->update_no_reboot_bit = update_no_reboot_bit_def;
+
+	p->no_reboot_priv = p;
 }
 
 static int iTCO_wdt_start(struct watchdog_device *wd_dev)
@@ -237,7 +248,7 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
 	iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout);
 
 	/* disable chipset's NO_REBOOT bit */
-	if (p->update_no_reboot_bit(p, false)) {
+	if (p->update_no_reboot_bit(p->no_reboot_priv, false)) {
 		spin_unlock(&p->io_lock);
 		pr_err("failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS\n");
 		return -EIO;
@@ -278,7 +289,7 @@ static int iTCO_wdt_stop(struct watchdog_device *wd_dev)
 	val = inw(TCO1_CNT(p));
 
 	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
-	p->update_no_reboot_bit(p, true);
+	p->update_no_reboot_bit(p->no_reboot_priv, true);
 
 	spin_unlock(&p->io_lock);
 
@@ -443,13 +454,13 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	p->iTCO_version = pdata->version;
 	p->pci_dev = to_pci_dev(dev->parent);
 
-	iTCO_wdt_no_reboot_bit_setup(p);
+	iTCO_wdt_no_reboot_bit_setup(p, pdata);
 
 	/*
 	 * Get the Memory-Mapped GCS or PMC register, we need it for the
 	 * NO_REBOOT flag (TCO v2 and v3).
 	 */
-	if (p->iTCO_version >= 2) {
+	if (p->iTCO_version >= 2 && !pdata->update_no_reboot_bit) {
 		p->gcs_pmc_res = platform_get_resource(pdev,
 						       IORESOURCE_MEM,
 						       ICH_RES_MEM_GCS_PMC);
@@ -459,14 +470,14 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	}
 
 	/* Check chipset's NO_REBOOT bit */
-	if (p->update_no_reboot_bit(p, false) &&
+	if (p->update_no_reboot_bit(p->no_reboot_priv, false) &&
 	    iTCO_vendor_check_noreboot_on()) {
 		pr_info("unable to reset NO_REBOOT flag, device disabled by hardware/BIOS\n");
 		return -ENODEV;	/* Cannot reset NO_REBOOT bit */
 	}
 
 	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
-	p->update_no_reboot_bit(p, true);
+	p->update_no_reboot_bit(p->no_reboot_priv, true);
 
 	/* The TCO logic uses the TCO_EN bit in the SMI_EN register */
 	if (!devm_request_region(dev, p->smi_res->start,
diff --git a/include/linux/platform_data/itco_wdt.h b/include/linux/platform_data/itco_wdt.h
index f16542c..0e95527 100644
--- a/include/linux/platform_data/itco_wdt.h
+++ b/include/linux/platform_data/itco_wdt.h
@@ -14,6 +14,10 @@
 struct itco_wdt_platform_data {
 	char name[32];
 	unsigned int version;
+	/* private data to be passed to update_no_reboot_bit API */
+	void *no_reboot_priv;
+	/* pointer for platform specific no reboot update function */
+	int (*update_no_reboot_bit)(void *priv, bool set);
 };
 
 #endif /* _ITCO_WDT_H_ */
-- 
2.7.4

