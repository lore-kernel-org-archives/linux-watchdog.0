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
Subject: [PATCH v4 4/5] platform/x86: intel_pmc_ipc: Fix iTCO GCS memory mapping failure
Date: Fri, 31 Mar 2017 16:27:51 -0700
Message-Id: <4e66c12e4576c56c675d049af8b063d3ccd65d17.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20170331133728.GA23725@rajaneesh-OptiPlex-9010>
References: <20170331133728.GA23725@rajaneesh-OptiPlex-9010>
In-Reply-To: <e537ff68732d86418982349624fd6de741bccc9b.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <e537ff68732d86418982349624fd6de741bccc9b.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-watchdog@vger.kernel.org>

iTCO watchdog driver need access to PMC_CFG GCR register to modify
the no reboot setting. Currently, this is done by passing PMC_CFG reg
address as memory resource to watchdog driver and allowing it directly
modify the PMC_CFG register. But currently PMC driver also has
requirement to memory map the entire GCR register space in this driver.
This causes mem request failure in watchdog driver. So this patch fixes
this issue by adding api to update noreboot flag and passes them
to watchdog driver via platform data.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Changes since v3:
 * Rebased on top of latest changes.

Changes since v2: 
 * Added support for update_noreboot_bit api.

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index bc95bf2..3f3ee50 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -126,7 +126,6 @@ static struct intel_pmc_ipc_dev {
 	struct platform_device *tco_dev;
 
 	/* gcr */
-	resource_size_t gcr_base;
 	void __iomem *gcr_mem_base;
 	int gcr_size;
 	bool has_gcr_regs;
@@ -293,6 +292,15 @@ int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
 }
 EXPORT_SYMBOL_GPL(intel_pmc_gcr_update);
 
+static int update_noreboot_bit(bool status)
+{
+	if (status)
+		return intel_pmc_gcr_update(PMC_GCR_PMC_CFG_REG, BIT(4),
+					    BIT(4));
+	else
+		return intel_pmc_gcr_update(PMC_GCR_PMC_CFG_REG, BIT(4), 0);
+}
+
 static int intel_pmc_ipc_check_status(void)
 {
 	int status;
@@ -610,15 +618,12 @@ static struct resource tco_res[] = {
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
@@ -675,10 +680,6 @@ static int ipc_create_tco_device(void)
 	res->start = ipcdev.acpi_io_base + SMI_EN_OFFSET;
 	res->end = res->start + SMI_EN_SIZE - 1;
 
-	res = tco_res + TCO_RESOURCE_GCR_MEM;
-	res->start = ipcdev.gcr_base + TCO_PMC_OFFSET;
-	res->end = res->start + TCO_PMC_SIZE - 1;
-
 	pdev = platform_device_register_full(&pdevinfo);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
@@ -840,7 +841,6 @@ static int ipc_plat_get_res(struct platform_device *pdev)
 	}
 	ipcdev.ipc_base = addr;
 
-	ipcdev.gcr_base = res->start + PLAT_RESOURCE_GCR_OFFSET;
 	ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
 	ipcdev.gcr_size = PLAT_RESOURCE_GCR_SIZE;
 	dev_info(&pdev->dev, "ipc res: %pR\n", res);
-- 
2.7.4
