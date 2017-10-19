Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25503 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751349AbdJSAXn (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 18 Oct 2017 20:23:43 -0400
From: sathyanarayanan.kuppuswamy@linux.intel.com
To: a.zummo@towertech.it, x86@kernel.org, wim@iguana.be,
        mingo@redhat.com, alexandre.belloni@free-electrons.com,
        qipeng.zha@intel.com, hpa@zytor.com, dvhart@infradead.org,
        tglx@linutronix.de, lee.jones@linaro.org, andy@infradead.org,
        souvik.k.chakravarty@intel.com
Cc: linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sathyaosid@gmail.com,
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v6 4/9] platform/x86: intel_pmc_ipc: Use MFD framework to create dependent devices
Date: Wed, 18 Oct 2017 17:23:07 -0700
Message-Id: <31869190769e357ae56dd345dce5862bab4eff4a.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently, we have lot of repetitive code in dependent device resource
allocation and device creation handling code. This logic can be improved if
we use MFD framework for dependent device creation. This patch adds this
support.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 394 ++++++++++++-----------------------
 1 file changed, 137 insertions(+), 257 deletions(-)

Changes since v5:
 * Changed the order of patches in this patchlist.

Changes since v4:
 * Changed the order of patches in this patchlist.

Changes since v3:
 * Changed PLATFORM_DEVID_AUTO to PLATFORM_DEVID_NONE in mfd device creation.
 * Fixed error in resource initalization logic in ipc_create_punit_device.
 * Removed mfd cell id initialization.

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index eadd1a1..aeb6dff 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -34,6 +34,7 @@
 #include <linux/acpi.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/spinlock.h>
+#include <linux/mfd/core.h>
 
 #include <asm/intel_pmc_ipc.h>
 
@@ -88,6 +89,7 @@
 #define PLAT_RESOURCE_ISP_IFACE_INDEX	5
 #define PLAT_RESOURCE_GTD_DATA_INDEX	6
 #define PLAT_RESOURCE_GTD_IFACE_INDEX	7
+#define PLAT_RESOURCE_MEM_MAX_INDEX	8
 #define PLAT_RESOURCE_ACPI_IO_INDEX	0
 
 /*
@@ -106,8 +108,6 @@
 #define TELEM_SSRAM_SIZE		240
 #define TELEM_PMC_SSRAM_OFFSET		0x1B00
 #define TELEM_PUNIT_SSRAM_OFFSET	0x1A00
-#define TCO_PMC_OFFSET			0x8
-#define TCO_PMC_SIZE			0x4
 
 /* PMC register bit definitions */
 
@@ -124,26 +124,10 @@ static struct intel_pmc_ipc_dev {
 	int cmd;
 	struct completion cmd_complete;
 
-	/* The following PMC BARs share the same ACPI device with the IPC */
-	resource_size_t acpi_io_base;
-	int acpi_io_size;
-	struct platform_device *tco_dev;
-
 	/* gcr */
 	void __iomem *gcr_mem_base;
 	bool has_gcr_regs;
 	spinlock_t gcr_lock;
-
-	/* punit */
-	struct platform_device *punit_dev;
-
-	/* Telemetry */
-	resource_size_t telem_pmc_ssram_base;
-	resource_size_t telem_punit_ssram_base;
-	int telem_pmc_ssram_size;
-	int telem_punit_ssram_size;
-	u8 telem_res_inval;
-	struct platform_device *telemetry_dev;
 } ipcdev;
 
 static char *ipc_err_sources[] = {
@@ -593,44 +577,6 @@ static const struct attribute_group intel_ipc_group = {
 	.attrs = intel_ipc_attrs,
 };
 
-static struct resource punit_res_array[] = {
-	/* Punit BIOS */
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	/* Punit ISP */
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	/* Punit GTD */
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-#define TCO_RESOURCE_ACPI_IO		0
-#define TCO_RESOURCE_SMI_EN_IO		1
-#define TCO_RESOURCE_GCR_MEM		2
-static struct resource tco_res[] = {
-	/* ACPI - TCO */
-	{
-		.flags = IORESOURCE_IO,
-	},
-	/* ACPI - SMI */
-	{
-		.flags = IORESOURCE_IO,
-	},
-};
-
 static struct itco_wdt_platform_data tco_info = {
 	.name = "Apollo Lake SoC",
 	.version = 5,
@@ -638,234 +584,179 @@ static struct itco_wdt_platform_data tco_info = {
 	.update_no_reboot_bit = update_no_reboot_bit,
 };
 
-#define TELEMETRY_RESOURCE_PUNIT_SSRAM	0
-#define TELEMETRY_RESOURCE_PMC_SSRAM	1
-static struct resource telemetry_res[] = {
-	/*Telemetry*/
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-static int ipc_create_punit_device(void)
+static int ipc_create_punit_device(struct platform_device *pdev)
 {
-	struct platform_device *pdev;
-	const struct platform_device_info pdevinfo = {
-		.parent = ipcdev.dev,
-		.name = PUNIT_DEVICE_NAME,
-		.id = -1,
-		.res = punit_res_array,
-		.num_res = ARRAY_SIZE(punit_res_array),
+	struct resource *res;
+	static struct resource punit_res[PLAT_RESOURCE_MEM_MAX_INDEX];
+	static struct mfd_cell punit_cell;
+	int mindex, pindex = 0;
+
+	for (mindex = 0; mindex <= PLAT_RESOURCE_MEM_MAX_INDEX; mindex++) {
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, mindex);
+
+		switch (mindex) {
+		/* Get PUNIT resources */
+		case PLAT_RESOURCE_BIOS_DATA_INDEX:
+		case PLAT_RESOURCE_BIOS_IFACE_INDEX:
+			/* BIOS resources are required, so return error if not
+			 * available */
+			if (!res) {
+				dev_err(&pdev->dev,
+					"Failed to get punit mem resource %d\n",
+					pindex);
+				return -ENXIO;
+			}
+		case PLAT_RESOURCE_ISP_DATA_INDEX:
+		case PLAT_RESOURCE_ISP_IFACE_INDEX:
+		case PLAT_RESOURCE_GTD_DATA_INDEX:
+		case PLAT_RESOURCE_GTD_IFACE_INDEX:
+			/* if valid resource found, copy the resource to PUNIT
+			 * resource */
+			if (res)
+				memcpy(&punit_res[pindex], res, sizeof(*res));
+			punit_res[pindex].flags = IORESOURCE_MEM;
+			dev_dbg(&pdev->dev, "PUNIT memory res: %pR\n",
+					&punit_res[pindex]);
+			pindex++;
+			break;
 		};
+	}
 
-	pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	ipcdev.punit_dev = pdev;
+	/* Create PUNIT IPC MFD cell */
+	punit_cell.name = PUNIT_DEVICE_NAME;
+	punit_cell.num_resources = ARRAY_SIZE(punit_res);
+	punit_cell.resources = punit_res;
+	punit_cell.ignore_resource_conflicts = 1;
 
-	return 0;
+	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+			&punit_cell, 1, NULL, 0, NULL);
 }
 
-static int ipc_create_tco_device(void)
+static int ipc_create_wdt_device(struct platform_device *pdev)
 {
-	struct platform_device *pdev;
+	static struct resource wdt_ipc_res[2];
 	struct resource *res;
-	const struct platform_device_info pdevinfo = {
-		.parent = ipcdev.dev,
-		.name = TCO_DEVICE_NAME,
-		.id = -1,
-		.res = tco_res,
-		.num_res = ARRAY_SIZE(tco_res),
-		.data = &tco_info,
-		.size_data = sizeof(tco_info),
-		};
+	static struct mfd_cell wdt_cell;
 
-	res = tco_res + TCO_RESOURCE_ACPI_IO;
-	res->start = ipcdev.acpi_io_base + TCO_BASE_OFFSET;
-	res->end = res->start + TCO_REGS_SIZE - 1;
+	/* If we have ACPI based watchdog use that instead, othewise create
+	 * a MFD cell for iTCO watchdog*/
+	if (acpi_has_watchdog())
+		return 0;
 
-	res = tco_res + TCO_RESOURCE_SMI_EN_IO;
-	res->start = ipcdev.acpi_io_base + SMI_EN_OFFSET;
-	res->end = res->start + SMI_EN_SIZE - 1;
-
-	pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	ipcdev.tco_dev = pdev;
+	/* Get iTCO watchdog resources */
+	res = platform_get_resource(pdev, IORESOURCE_IO,
+				    PLAT_RESOURCE_ACPI_IO_INDEX);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get wdt resource\n");
+		return -ENXIO;
+	}
 
-	return 0;
+	wdt_ipc_res[0].start = res->start + TCO_BASE_OFFSET;
+	wdt_ipc_res[0].end = res->start + TCO_BASE_OFFSET +
+		TCO_REGS_SIZE - 1;
+	wdt_ipc_res[0].flags = IORESOURCE_IO;
+	wdt_ipc_res[1].start = res->start + SMI_EN_OFFSET;
+	wdt_ipc_res[1].end = res->start +
+		SMI_EN_OFFSET + SMI_EN_SIZE - 1;
+	wdt_ipc_res[1].flags = IORESOURCE_IO;
+
+	dev_dbg(&pdev->dev, "watchdog res 0: %pR\n",
+			&wdt_ipc_res[0]);
+	dev_dbg(&pdev->dev, "watchdog res 1: %pR\n",
+			&wdt_ipc_res[1]);
+
+	wdt_cell.name = TCO_DEVICE_NAME;
+	wdt_cell.platform_data = &tco_info;
+	wdt_cell.pdata_size = sizeof(tco_info);
+	wdt_cell.num_resources = ARRAY_SIZE(wdt_ipc_res);
+	wdt_cell.resources = wdt_ipc_res;
+	wdt_cell.ignore_resource_conflicts = 1;
+
+	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+			&wdt_cell, 1, NULL, 0, NULL);
 }
 
-static int ipc_create_telemetry_device(void)
+static int ipc_create_telemetry_device(struct platform_device *pdev)
 {
-	struct platform_device *pdev;
+	static struct resource telemetry_ipc_res[2];
 	struct resource *res;
-	const struct platform_device_info pdevinfo = {
-		.parent = ipcdev.dev,
-		.name = TELEMETRY_DEVICE_NAME,
-		.id = -1,
-		.res = telemetry_res,
-		.num_res = ARRAY_SIZE(telemetry_res),
-		};
-
-	res = telemetry_res + TELEMETRY_RESOURCE_PUNIT_SSRAM;
-	res->start = ipcdev.telem_punit_ssram_base;
-	res->end = res->start + ipcdev.telem_punit_ssram_size - 1;
-
-	res = telemetry_res + TELEMETRY_RESOURCE_PMC_SSRAM;
-	res->start = ipcdev.telem_pmc_ssram_base;
-	res->end = res->start + ipcdev.telem_pmc_ssram_size - 1;
-
-	pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	static struct mfd_cell telemetry_cell;
 
-	ipcdev.telemetry_dev = pdev;
+	/* Get telemetry resources */
+	res = platform_get_resource(pdev, IORESOURCE_MEM,
+				    PLAT_RESOURCE_TELEM_SSRAM_INDEX);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get telemetry resource\n");
+		return -ENXIO;
+	}
 
-	return 0;
+	telemetry_ipc_res[0].start = res->start +
+		TELEM_PUNIT_SSRAM_OFFSET;
+	telemetry_ipc_res[0].end = res->start +
+		TELEM_PUNIT_SSRAM_OFFSET + TELEM_SSRAM_SIZE - 1;
+	telemetry_ipc_res[0].flags = IORESOURCE_MEM;
+	telemetry_ipc_res[1].start = res->start + TELEM_PMC_SSRAM_OFFSET;
+	telemetry_ipc_res[1].end = res->start +
+		TELEM_PMC_SSRAM_OFFSET + TELEM_SSRAM_SIZE - 1;
+	telemetry_ipc_res[1].flags = IORESOURCE_MEM;
+
+	dev_dbg(&pdev->dev, "Telemetry res 0: %pR\n",
+			&telemetry_ipc_res[0]);
+	dev_dbg(&pdev->dev, "Telemetry res 1: %pR\n",
+			&telemetry_ipc_res[1]);
+
+	telemetry_cell.name = TELEMETRY_DEVICE_NAME;
+	telemetry_cell.num_resources = ARRAY_SIZE(telemetry_ipc_res);
+	telemetry_cell.resources = telemetry_ipc_res;
+	telemetry_cell.ignore_resource_conflicts = 1;
+
+	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+			&telemetry_cell, 1, NULL, 0, NULL);
 }
 
-static int ipc_create_pmc_devices(void)
+static int ipc_create_pmc_devices(struct platform_device *pdev)
 {
 	int ret;
 
-	/* If we have ACPI based watchdog use that instead */
-	if (!acpi_has_watchdog()) {
-		ret = ipc_create_tco_device();
-		if (ret) {
-			dev_err(ipcdev.dev, "Failed to add tco platform device\n");
-			return ret;
-		}
-	}
+	ret = ipc_create_punit_device(pdev);
+	if (ret < 0)
+		return ret;
 
-	ret = ipc_create_punit_device();
-	if (ret) {
-		dev_err(ipcdev.dev, "Failed to add punit platform device\n");
-		platform_device_unregister(ipcdev.tco_dev);
-	}
+	ret = ipc_create_wdt_device(pdev);
+	if (ret < 0)
+		return ret;
 
-	if (!ipcdev.telem_res_inval) {
-		ret = ipc_create_telemetry_device();
-		if (ret)
-			dev_warn(ipcdev.dev,
-				"Failed to add telemetry platform device\n");
-	}
+	ret = ipc_create_telemetry_device(pdev);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	return 0;
 }
 
 static int ipc_plat_get_res(struct platform_device *pdev)
 {
-	struct resource *res, *punit_res;
+	struct resource *res;
 	void __iomem *addr;
-	int size;
-
-	res = platform_get_resource(pdev, IORESOURCE_IO,
-				    PLAT_RESOURCE_ACPI_IO_INDEX);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get io resource\n");
-		return -ENXIO;
-	}
-	size = resource_size(res);
-	ipcdev.acpi_io_base = res->start;
-	ipcdev.acpi_io_size = size;
-	dev_info(&pdev->dev, "io res: %pR\n", res);
-
-	punit_res = punit_res_array;
-	/* This is index 0 to cover BIOS data register */
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_BIOS_DATA_INDEX);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get res of punit BIOS data\n");
-		return -ENXIO;
-	}
-	*punit_res = *res;
-	dev_info(&pdev->dev, "punit BIOS data res: %pR\n", res);
 
-	/* This is index 1 to cover BIOS interface register */
+	/* Get IPC resources */
 	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_BIOS_IFACE_INDEX);
+			PLAT_RESOURCE_IPC_INDEX);
 	if (!res) {
-		dev_err(&pdev->dev, "Failed to get res of punit BIOS iface\n");
+		dev_err(&pdev->dev, "Failed to get IPC resources\n");
 		return -ENXIO;
 	}
-	*++punit_res = *res;
-	dev_info(&pdev->dev, "punit BIOS interface res: %pR\n", res);
-
-	/* This is index 2 to cover ISP data register, optional */
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_ISP_DATA_INDEX);
-	++punit_res;
-	if (res) {
-		*punit_res = *res;
-		dev_info(&pdev->dev, "punit ISP data res: %pR\n", res);
-	}
 
-	/* This is index 3 to cover ISP interface register, optional */
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_ISP_IFACE_INDEX);
-	++punit_res;
-	if (res) {
-		*punit_res = *res;
-		dev_info(&pdev->dev, "punit ISP interface res: %pR\n", res);
-	}
-
-	/* This is index 4 to cover GTD data register, optional */
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_GTD_DATA_INDEX);
-	++punit_res;
-	if (res) {
-		*punit_res = *res;
-		dev_info(&pdev->dev, "punit GTD data res: %pR\n", res);
-	}
-
-	/* This is index 5 to cover GTD interface register, optional */
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_GTD_IFACE_INDEX);
-	++punit_res;
-	if (res) {
-		*punit_res = *res;
-		dev_info(&pdev->dev, "punit GTD interface res: %pR\n", res);
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_IPC_INDEX);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get ipc resource\n");
-		return -ENXIO;
-	}
-	size = PLAT_RESOURCE_IPC_SIZE + PLAT_RESOURCE_GCR_SIZE;
-	res->end = res->start + size - 1;
+	res->end = (res->start + PLAT_RESOURCE_IPC_SIZE +
+			PLAT_RESOURCE_GCR_SIZE - 1);
 
 	addr = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
 
 	ipcdev.ipc_base = addr;
-
 	ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
-	dev_info(&pdev->dev, "ipc res: %pR\n", res);
-
-	ipcdev.telem_res_inval = 0;
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_TELEM_SSRAM_INDEX);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get telemetry ssram resource\n");
-		ipcdev.telem_res_inval = 1;
-	} else {
-		ipcdev.telem_punit_ssram_base = res->start +
-						TELEM_PUNIT_SSRAM_OFFSET;
-		ipcdev.telem_punit_ssram_size = TELEM_SSRAM_SIZE;
-		ipcdev.telem_pmc_ssram_base = res->start +
-						TELEM_PMC_SSRAM_OFFSET;
-		ipcdev.telem_pmc_ssram_size = TELEM_SSRAM_SIZE;
-		dev_info(&pdev->dev, "telemetry ssram res: %pR\n", res);
-	}
+	dev_dbg(&pdev->dev, "PMC IPC resource %pR\n", res);
 
 	return 0;
 }
@@ -922,7 +813,7 @@ static int ipc_plat_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = ipc_create_pmc_devices();
+	ret = ipc_create_pmc_devices(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to create pmc devices\n");
 		return ret;
@@ -931,38 +822,27 @@ static int ipc_plat_probe(struct platform_device *pdev)
 	if (devm_request_irq(&pdev->dev, ipcdev.irq, ioc, IRQF_NO_SUSPEND,
 			     "intel_pmc_ipc", &ipcdev)) {
 		dev_err(&pdev->dev, "Failed to request irq\n");
-		ret = -EBUSY;
-		goto err_irq;
+		return -EBUSY;
 	}
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &intel_ipc_group);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to create sysfs group %d\n",
 			ret);
-		goto err_sys;
+		devm_free_irq(&pdev->dev, ipcdev.irq, &ipcdev);
+		return ret;
 	}
 
 	ipcdev.has_gcr_regs = true;
 
 	return 0;
-err_sys:
-	devm_free_irq(&pdev->dev, ipcdev.irq, &ipcdev);
-err_irq:
-	platform_device_unregister(ipcdev.tco_dev);
-	platform_device_unregister(ipcdev.punit_dev);
-	platform_device_unregister(ipcdev.telemetry_dev);
-
-	return ret;
 }
 
 static int ipc_plat_remove(struct platform_device *pdev)
 {
 	sysfs_remove_group(&pdev->dev.kobj, &intel_ipc_group);
-	devm_free_irq(&pdev->dev, ipcdev.irq, &ipcdev);
-	platform_device_unregister(ipcdev.tco_dev);
-	platform_device_unregister(ipcdev.punit_dev);
-	platform_device_unregister(ipcdev.telemetry_dev);
 	ipcdev.dev = NULL;
+
 	return 0;
 }
 
-- 
2.7.4

