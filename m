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
Subject: [PATCH v5 5/6] platform/x86: intel_pmc_ipc: Fix iTCO_wdt GCS memory mapping failure
Date: Mon,  3 Apr 2017 17:24:33 -0700
Message-Id: <d127f32d6fce493941edeb3d5b12ebd6f8fbfeb5.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAENHMvOyzbhDQzvpYFcxC9mvsfDGrco9RMy+rU=faT6RN_uW3A@mail.gmail.com>
References: <CAENHMvOyzbhDQzvpYFcxC9mvsfDGrco9RMy+rU=faT6RN_uW3A@mail.gmail.com>
In-Reply-To: <bf5a86829e9403d93e85270b2898b3c548417a05.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <bf5a86829e9403d93e85270b2898b3c548417a05.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-watchdog@vger.kernel.org>

iTCO_wdt driver need access to PMC_CFG GCR register to modify the
noreboot setting. Currently, this is done by passing PMC_CFG reg
address as memory resource to watchdog driver and allowing it directly
modify the PMC_CFG register. But currently PMC driver also has
requirement to memory map the entire GCR register space in this driver.
This causes mem request failure in watchdog driver. So this patch fixes
this issue by adding api to update noreboot flag and passes them
to watchdog driver via platform data.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

Changes since v4:
 * Fixed some style issues in commit history.
 * Used macros instead of BIT() calls.

Changes since v3:
 * Rebased on top of latest changes.

Changes since v2: 
 * Added support for update_noreboot_bit api.

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 8b7fef0..3d0d6f17 100644
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
@@ -126,7 +133,6 @@ static struct intel_pmc_ipc_dev {
 	struct platform_device *tco_dev;
 
 	/* gcr */
-	resource_size_t gcr_base;
 	void __iomem *gcr_mem_base;
 	int gcr_size;
 	bool has_gcr_regs;
@@ -312,6 +318,18 @@ int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
 }
 EXPORT_SYMBOL_GPL(intel_pmc_gcr_update);
 
+static int update_noreboot_bit(bool status)
+{
+	if (status)
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
@@ -629,15 +647,12 @@ static struct resource tco_res[] = {
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
+	.update_noreboot_flag = update_noreboot_bit,
 };
 
 #define TELEMETRY_RESOURCE_PUNIT_SSRAM	0
@@ -694,10 +709,6 @@ static int ipc_create_tco_device(void)
 	res->start = ipcdev.acpi_io_base + SMI_EN_OFFSET;
 	res->end = res->start + SMI_EN_SIZE - 1;
 
-	res = tco_res + TCO_RESOURCE_GCR_MEM;
-	res->start = ipcdev.gcr_base + TCO_PMC_OFFSET;
-	res->end = res->start + TCO_PMC_SIZE - 1;
-
 	pdev = platform_device_register_full(&pdevinfo);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
@@ -859,7 +870,6 @@ static int ipc_plat_get_res(struct platform_device *pdev)
 	}
 	ipcdev.ipc_base = addr;
 
-	ipcdev.gcr_base = res->start + PLAT_RESOURCE_GCR_OFFSET;
 	ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
 	ipcdev.gcr_size = PLAT_RESOURCE_GCR_SIZE;
 	dev_info(&pdev->dev, "ipc res: %pR\n", res);
-- 
2.7.4
