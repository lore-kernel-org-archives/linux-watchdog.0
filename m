Return-path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: andy@infradead.org,
	qipeng.zha@intel.com,
	dvhart@infradead.org,
	linux@roeck-us.net
Cc: wim@iguana.be,
	sathyaosid@gmail.com,
	david.e.box@linux.intel.com,
	rajneesh.bhardwaj@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v7 5/6] platform/x86: intel_pmc_ipc: Fix iTCO_wdt GCS memory mapping failure
Date: Sun,  9 Apr 2017 15:00:20 -0700
Message-Id: <7b0174a3a68ac72bebe27a307f0326eb767ccadf.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aefdf4f6a7b0cf4af92d51ce2b9b73284cc03ffe.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <aefdf4f6a7b0cf4af92d51ce2b9b73284cc03ffe.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-watchdog@vger.kernel.org>

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
 drivers/platform/x86/intel_pmc_ipc.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

Changes since v6:
 * Replace BIT(4) with (1 << 4)
 * Optimized update_no_reboot_bit implementation.

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
index a0c773b..0a39b0f 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -112,6 +112,13 @@
 #define TCO_PMC_OFFSET			0x8
 #define TCO_PMC_SIZE			0x4
 
+/* PMC register bit definitions */
+
+/* PMC_CFG_REG bit masks */
+#define PMC_CFG_NO_REBOOT_MASK		(1 << 4)
+#define PMC_CFG_NO_REBOOT_EN		(1 << 4)
+#define PMC_CFG_NO_REBOOT_DIS		(0 << 4)
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
 
@@ -313,6 +318,14 @@ int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
 }
 EXPORT_SYMBOL_GPL(intel_pmc_gcr_update);
 
+static int update_no_reboot_bit(void *priv, bool set)
+{
+	u32 value = set ? PMC_CFG_NO_REBOOT_EN : PMC_CFG_NO_REBOOT_DIS;
+
+	return intel_pmc_gcr_update(PMC_GCR_PMC_CFG_REG,
+				    PMC_CFG_NO_REBOOT_MASK, value);
+}
+
 static int intel_pmc_ipc_check_status(void)
 {
 	int status;
@@ -630,15 +643,13 @@ static struct resource tco_res[] = {
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
@@ -695,10 +706,6 @@ static int ipc_create_tco_device(void)
 	res->start = ipcdev.acpi_io_base + SMI_EN_OFFSET;
 	res->end = res->start + SMI_EN_SIZE - 1;
 
-	res = tco_res + TCO_RESOURCE_GCR_MEM;
-	res->start = ipcdev.gcr_base + TCO_PMC_OFFSET;
-	res->end = res->start + TCO_PMC_SIZE - 1;
-
 	pdev = platform_device_register_full(&pdevinfo);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
@@ -860,9 +867,7 @@ static int ipc_plat_get_res(struct platform_device *pdev)
 	}
 	ipcdev.ipc_base = addr;
 
-	ipcdev.gcr_base = res->start + PLAT_RESOURCE_GCR_OFFSET;
 	ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
-	ipcdev.gcr_size = PLAT_RESOURCE_GCR_SIZE;
 	dev_info(&pdev->dev, "ipc res: %pR\n", res);
 
 	ipcdev.telem_res_inval = 0;
-- 
2.7.4
