Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48130 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756058AbdDEW6d (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Apr 2017 18:58:33 -0400
From: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To: andy@infradead.org, qipeng.zha@intel.com, dvhart@infradead.org,
        linux@roeck-us.net
Cc: wim@iguana.be, sathyaosid@gmail.com, david.e.box@linux.intel.com,
        rajneesh.bhardwaj@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v6 5/6] platform/x86: intel_pmc_ipc: Fix iTCO_wdt GCS memory mapping failure
Date: Wed,  5 Apr 2017 15:54:23 -0700
Message-Id: <f5fbaf426ad657e1f8cb8a15619602afd4e12efe.1491428146.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <3e7ca77c-2be5-5f89-f51f-faaca9f2d9ac@linux.intel.com>
References: <3e7ca77c-2be5-5f89-f51f-faaca9f2d9ac@linux.intel.com>
In-Reply-To: <463a23bb1f44098dd0fe506346bae71282009e05.1491428146.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <463a23bb1f44098dd0fe506346bae71282009e05.1491428146.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

iTCO_wdt driver need access to PMC_CFG GCR register to modify the
noreboot setting. Currently, this is done by passing PMC_CFG reg
address as memory resource to watchdog driver and allowing it directly
modify the PMC_CFG register. But currently PMC driver also has
requirement to memory map the entire GCR register space in this driver.
This causes mem request failure in watchdog driver. So this patch fixes
this issue by adding API to update noreboot flag and passes them
to watchdog driver via platform data.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

Changes since v5:
 * Fixed some style issues in commit history.
 * removed unused variable gcr_size from intel_pmc_ipc_dev

Changes since v4:
 * Fixed some style issues in commit history.
 * Used macros instead of BIT() calls.

Changes since v3:
 * Rebased on top of latest changes.

Changes since v2: 
 * Added support for update_noreboot_bit api.

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index a0c773b..173940f 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -112,6 +112,13 @@
 #define TCO_PMC_OFFSET			0x8
 #define TCO_PMC_SIZE			0x4
 
+/* PMC register bit definitions */
+
+/* PMC_CFG_REG bit masks */
+#define PMC_CFG_NO_REBOOT_MASK		BIT(4)
+#define PMC_CFG_NO_REBOOT_ENABLE	BIT(4)
+#define PMC_CFG_NO_REBOOT_DISABLE	0
+
 static struct intel_pmc_ipc_dev {
 	struct device *dev;
 	void __iomem *ipc_base;
@@ -126,8 +133,6 @@ static struct intel_pmc_ipc_dev {
 	struct platform_device *tco_dev;
 
 	/* gcr */
-	resource_size_t gcr_base;
-	int gcr_size;
 	void __iomem *gcr_mem_base;
 	bool has_gcr_regs;
 
@@ -313,6 +318,18 @@ int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
 }
 EXPORT_SYMBOL_GPL(intel_pmc_gcr_update);
 
+static int update_no_reboot_bit(void *priv, bool set)
+{
+	if (set)
+		return intel_pmc_gcr_update(PMC_GCR_PMC_CFG_REG,
+					    PMC_CFG_NO_REBOOT_MASK,
+					    PMC_CFG_NO_REBOOT_ENABLE);
+
+	return intel_pmc_gcr_update(PMC_GCR_PMC_CFG_REG,
+				    PMC_CFG_NO_REBOOT_MASK,
+				    PMC_CFG_NO_REBOOT_DISABLE);
+}
+
 static int intel_pmc_ipc_check_status(void)
 {
 	int status;
@@ -630,15 +647,13 @@ static struct resource tco_res[] = {
 	{
 		.flags = IORESOURCE_IO,
 	},
-	/* GCS */
-	{
-		.flags = IORESOURCE_MEM,
-	},
 };
 
 static struct itco_wdt_platform_data tco_info = {
 	.name = "Apollo Lake SoC",
 	.version = 5,
+	.no_reboot_priv = &ipcdev,
+	.update_no_reboot_bit = update_no_reboot_bit,
 };
 
 #define TELEMETRY_RESOURCE_PUNIT_SSRAM	0
@@ -695,10 +710,6 @@ static int ipc_create_tco_device(void)
 	res->start = ipcdev.acpi_io_base + SMI_EN_OFFSET;
 	res->end = res->start + SMI_EN_SIZE - 1;
 
-	res = tco_res + TCO_RESOURCE_GCR_MEM;
-	res->start = ipcdev.gcr_base + TCO_PMC_OFFSET;
-	res->end = res->start + TCO_PMC_SIZE - 1;
-
 	pdev = platform_device_register_full(&pdevinfo);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
@@ -860,9 +871,7 @@ static int ipc_plat_get_res(struct platform_device *pdev)
 	}
 	ipcdev.ipc_base = addr;
 
-	ipcdev.gcr_base = res->start + PLAT_RESOURCE_GCR_OFFSET;
 	ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
-	ipcdev.gcr_size = PLAT_RESOURCE_GCR_SIZE;
 	dev_info(&pdev->dev, "ipc res: %pR\n", res);
 
 	ipcdev.telem_res_inval = 0;
-- 
2.7.4

