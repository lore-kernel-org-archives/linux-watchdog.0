Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:48791 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752652AbdDIWED (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 9 Apr 2017 18:04:03 -0400
From: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To: andy@infradead.org, qipeng.zha@intel.com, dvhart@infradead.org,
        linux@roeck-us.net
Cc: wim@iguana.be, sathyaosid@gmail.com, david.e.box@linux.intel.com,
        rajneesh.bhardwaj@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v7 3/6] watchdog: iTCO_wdt: cleanup set/unset no_reboot_bit functions
Date: Sun,  9 Apr 2017 15:00:18 -0700
Message-Id: <ce8f66b252cbf7a3eef43c7ff3be1c21fb1f2393.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aefdf4f6a7b0cf4af92d51ce2b9b73284cc03ffe.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <aefdf4f6a7b0cf4af92d51ce2b9b73284cc03ffe.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

iTCO_wdt no_reboot_bit set/unset functions has lot of common code between
them. So merging these two functions into a single update function would
remove these unnecessary code duplications. This patch fixes this issue
by creating a no_reboot_bit update function to handle both set/unset
functions.

Also checking for iTCO version every time you make no_reboot_bit set/unset
call is inefficient and makes the code look complex. This can be improved
by performing this check once during device probe and selecting the
appropriate no_reboot_bit update function. This patch fixes this issue
by splitting the update function into multiple helper functions.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/watchdog/iTCO_wdt.c | 83 +++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 33 deletions(-)

Changes since v6:
 * make iTCO_wdt_no_reboot_bit_setup() static
 * remove inline specifier for update_no_reboot_bit helper functions.

Changes since v5:
 * Changed update function argument name from "status" to "set".
 * Fixed commit history.
 * Changed update function name to use "bit" instead of "flag"
 * Addressed Andy's comment on creating multiple helper functions.

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 3d0abc0..a629933 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -106,6 +106,8 @@ struct iTCO_wdt_private {
 	struct pci_dev *pci_dev;
 	/* whether or not the watchdog has been suspended */
 	bool suspended;
+	/* no reboot update function pointer */
+	int (*update_no_reboot_bit)(void *p, bool set);
 };
 
 /* module parameters */
@@ -170,48 +172,61 @@ static inline u32 no_reboot_bit(struct iTCO_wdt_private *p)
 	return enable_bit;
 }
 
-static void iTCO_wdt_set_NO_REBOOT_bit(struct iTCO_wdt_private *p)
+static int update_no_reboot_bit_def(void *priv, bool set)
 {
-	u32 val32;
-
-	/* Set the NO_REBOOT bit: this disables reboots */
-	if (p->iTCO_version >= 2) {
-		val32 = readl(p->gcs_pmc);
-		val32 |= no_reboot_bit(p);
-		writel(val32, p->gcs_pmc);
-	} else if (p->iTCO_version == 1) {
-		pci_read_config_dword(p->pci_dev, 0xd4, &val32);
-		val32 |= no_reboot_bit(p);
-		pci_write_config_dword(p->pci_dev, 0xd4, val32);
-	}
+	return 0;
 }
 
-static int iTCO_wdt_unset_NO_REBOOT_bit(struct iTCO_wdt_private *p)
+static int update_no_reboot_bit_pci(void *priv, bool set)
 {
-	u32 enable_bit = no_reboot_bit(p);
-	u32 val32 = 0;
+	struct iTCO_wdt_private *p = priv;
+	u32 val32 = 0, newval32 = 0;
 
-	/* Unset the NO_REBOOT bit: this enables reboots */
-	if (p->iTCO_version >= 2) {
-		val32 = readl(p->gcs_pmc);
-		val32 &= ~enable_bit;
-		writel(val32, p->gcs_pmc);
+	pci_read_config_dword(p->pci_dev, 0xd4, &val32);
+	if (set)
+		val32 |= no_reboot_bit(p);
+	else
+		val32 &= ~no_reboot_bit(p);
+	pci_write_config_dword(p->pci_dev, 0xd4, val32);
+	pci_read_config_dword(p->pci_dev, 0xd4, &newval32);
 
-		val32 = readl(p->gcs_pmc);
-	} else if (p->iTCO_version == 1) {
-		pci_read_config_dword(p->pci_dev, 0xd4, &val32);
-		val32 &= ~enable_bit;
-		pci_write_config_dword(p->pci_dev, 0xd4, val32);
+	/* make sure the update is successful */
+	if (val32 != newval32)
+		return -EIO;
 
-		pci_read_config_dword(p->pci_dev, 0xd4, &val32);
-	}
+	return 0;
+}
+
+static int update_no_reboot_bit_mem(void *priv, bool set)
+{
+	struct iTCO_wdt_private *p = priv;
+	u32 val32 = 0, newval32 = 0;
+
+	val32 = readl(p->gcs_pmc);
+	if (set)
+		val32 |= no_reboot_bit(p);
+	else
+		val32 &= ~no_reboot_bit(p);
+	writel(val32, p->gcs_pmc);
+	newval32 = readl(p->gcs_pmc);
 
-	if (val32 & enable_bit)
+	/* make sure the update is successful */
+	if (val32 != newval32)
 		return -EIO;
 
 	return 0;
 }
 
+static void iTCO_wdt_no_reboot_bit_setup(struct iTCO_wdt_private *p)
+{
+	if (p->iTCO_version >= 2)
+		p->update_no_reboot_bit = update_no_reboot_bit_mem;
+	else if (p->iTCO_version == 1)
+		p->update_no_reboot_bit = update_no_reboot_bit_pci;
+	else
+		p->update_no_reboot_bit = update_no_reboot_bit_def;
+}
+
 static int iTCO_wdt_start(struct watchdog_device *wd_dev)
 {
 	struct iTCO_wdt_private *p = watchdog_get_drvdata(wd_dev);
@@ -222,7 +237,7 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
 	iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout);
 
 	/* disable chipset's NO_REBOOT bit */
-	if (iTCO_wdt_unset_NO_REBOOT_bit(p)) {
+	if (p->update_no_reboot_bit(p, false)) {
 		spin_unlock(&p->io_lock);
 		pr_err("failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS\n");
 		return -EIO;
@@ -263,7 +278,7 @@ static int iTCO_wdt_stop(struct watchdog_device *wd_dev)
 	val = inw(TCO1_CNT(p));
 
 	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
-	iTCO_wdt_set_NO_REBOOT_bit(p);
+	p->update_no_reboot_bit(p, true);
 
 	spin_unlock(&p->io_lock);
 
@@ -428,6 +443,8 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	p->iTCO_version = pdata->version;
 	p->pci_dev = to_pci_dev(dev->parent);
 
+	iTCO_wdt_no_reboot_bit_setup(p);
+
 	/*
 	 * Get the Memory-Mapped GCS or PMC register, we need it for the
 	 * NO_REBOOT flag (TCO v2 and v3).
@@ -442,14 +459,14 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	}
 
 	/* Check chipset's NO_REBOOT bit */
-	if (iTCO_wdt_unset_NO_REBOOT_bit(p) &&
+	if (p->update_no_reboot_bit(p, false) &&
 	    iTCO_vendor_check_noreboot_on()) {
 		pr_info("unable to reset NO_REBOOT flag, device disabled by hardware/BIOS\n");
 		return -ENODEV;	/* Cannot reset NO_REBOOT bit */
 	}
 
 	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
-	iTCO_wdt_set_NO_REBOOT_bit(p);
+	p->update_no_reboot_bit(p, true);
 
 	/* The TCO logic uses the TCO_EN bit in the SMI_EN register */
 	if (!devm_request_region(dev, p->smi_res->start,
-- 
2.7.4

