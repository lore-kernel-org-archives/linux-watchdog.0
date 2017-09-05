Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3891 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751126AbdIEFiO (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 5 Sep 2017 01:38:14 -0400
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
Subject: [RFC v3 1/7] platform/x86: intel_pmc_ipc: Use devm_* calls in driver probe function
Date: Mon,  4 Sep 2017 22:37:21 -0700
Message-Id: <eada94e0dfe0302b22c16c22ba2ea806e096144a.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

This patch cleans up unnecessary free/alloc calls in ipc_plat_probe(),
ipc_pci_probe() and ipc_plat_get_res() functions by using devm_*
calls.

This patch also adds proper error handling for failure cases in
ipc_pci_probe() function.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 104 ++++++++++++-----------------------
 1 file changed, 34 insertions(+), 70 deletions(-)

Changes since v2:
 * Used pcim_* device managed functions.

Changes since v1:
 * Merged devm_* related changes into a single function.
 * Instead of removing free_irq, use devm_free_irq function.

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index bb792a5..5eef649 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -480,52 +480,39 @@ static irqreturn_t ioc(int irq, void *dev_id)
 
 static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	resource_size_t pci_resource;
 	int ret;
-	int len;
+	struct intel_pmc_ipc_dev *pmc = &ipcdev;
 
-	ipcdev.dev = &pci_dev_get(pdev)->dev;
-	ipcdev.irq_mode = IPC_TRIGGER_MODE_IRQ;
+	/* Only one PMC is supported */
+	if (pmc->dev)
+		return -EBUSY;
 
-	ret = pci_enable_device(pdev);
+	pmc->irq_mode = IPC_TRIGGER_MODE_IRQ;
+
+	ret = pcim_enable_device(pdev);
 	if (ret)
 		return ret;
 
-	ret = pci_request_regions(pdev, "intel_pmc_ipc");
+	ret = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
 	if (ret)
 		return ret;
 
-	pci_resource = pci_resource_start(pdev, 0);
-	len = pci_resource_len(pdev, 0);
-	if (!pci_resource || !len) {
-		dev_err(&pdev->dev, "Failed to get resource\n");
-		return -ENOMEM;
-	}
+	init_completion(&pmc->cmd_complete);
 
-	init_completion(&ipcdev.cmd_complete);
+	pmc->ipc_base =  pcim_iomap_table(pdev)[0];
 
-	if (request_irq(pdev->irq, ioc, 0, "intel_pmc_ipc", &ipcdev)) {
+	ret = devm_request_irq(&pdev->dev, pdev->irq, ioc, 0, "intel_pmc_ipc",
+				pmc);
+	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq\n");
-		return -EBUSY;
+		return ret;
 	}
 
-	ipcdev.ipc_base = ioremap_nocache(pci_resource, len);
-	if (!ipcdev.ipc_base) {
-		dev_err(&pdev->dev, "Failed to ioremap ipc base\n");
-		free_irq(pdev->irq, &ipcdev);
-		ret = -ENOMEM;
-	}
+	pmc->dev = &pdev->dev;
 
-	return ret;
-}
+	pci_set_drvdata(pdev, pmc);
 
-static void ipc_pci_remove(struct pci_dev *pdev)
-{
-	free_irq(pdev->irq, &ipcdev);
-	pci_release_regions(pdev);
-	pci_dev_put(pdev);
-	iounmap(ipcdev.ipc_base);
-	ipcdev.dev = NULL;
+	return 0;
 }
 
 static const struct pci_device_id ipc_pci_ids[] = {
@@ -540,7 +527,6 @@ static struct pci_driver ipc_pci_driver = {
 	.name = "intel_pmc_ipc",
 	.id_table = ipc_pci_ids,
 	.probe = ipc_pci_probe,
-	.remove = ipc_pci_remove,
 };
 
 static ssize_t intel_pmc_ipc_simple_cmd_store(struct device *dev,
@@ -849,18 +835,16 @@ static int ipc_plat_get_res(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to get ipc resource\n");
 		return -ENXIO;
 	}
-	size = PLAT_RESOURCE_IPC_SIZE + PLAT_RESOURCE_GCR_SIZE;
+	res->end = (res->start + PLAT_RESOURCE_IPC_SIZE +
+		    PLAT_RESOURCE_GCR_SIZE - 1);
 
-	if (!request_mem_region(res->start, size, pdev->name)) {
-		dev_err(&pdev->dev, "Failed to request ipc resource\n");
-		return -EBUSY;
-	}
-	addr = ioremap_nocache(res->start, size);
-	if (!addr) {
-		dev_err(&pdev->dev, "I/O memory remapping failed\n");
-		release_mem_region(res->start, size);
-		return -ENOMEM;
+	addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(addr)) {
+		dev_err(&pdev->dev,
+			"PMC I/O memory remapping failed\n");
+		return PTR_ERR(addr);
 	}
+
 	ipcdev.ipc_base = addr;
 
 	ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
@@ -917,7 +901,6 @@ MODULE_DEVICE_TABLE(acpi, ipc_acpi_ids);
 
 static int ipc_plat_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	int ret;
 
 	ipcdev.dev = &pdev->dev;
@@ -939,61 +922,42 @@ static int ipc_plat_probe(struct platform_device *pdev)
 	ret = ipc_create_pmc_devices();
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to create pmc devices\n");
-		goto err_device;
+		return ret;
 	}
 
-	if (request_irq(ipcdev.irq, ioc, IRQF_NO_SUSPEND,
-			"intel_pmc_ipc", &ipcdev)) {
+	if (devm_request_irq(&pdev->dev, ipcdev.irq, ioc, IRQF_NO_SUSPEND,
+			     "intel_pmc_ipc", &ipcdev)) {
 		dev_err(&pdev->dev, "Failed to request irq\n");
 		ret = -EBUSY;
-		goto err_irq;
+		goto unregister_devices;
 	}
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &intel_ipc_group);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to create sysfs group %d\n",
 			ret);
-		goto err_sys;
+		goto unregister_devices;
 	}
 
 	ipcdev.has_gcr_regs = true;
 
 	return 0;
-err_sys:
-	free_irq(ipcdev.irq, &ipcdev);
-err_irq:
+
+unregister_devices:
 	platform_device_unregister(ipcdev.tco_dev);
 	platform_device_unregister(ipcdev.punit_dev);
 	platform_device_unregister(ipcdev.telemetry_dev);
-err_device:
-	iounmap(ipcdev.ipc_base);
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_IPC_INDEX);
-	if (res) {
-		release_mem_region(res->start,
-				   PLAT_RESOURCE_IPC_SIZE +
-				   PLAT_RESOURCE_GCR_SIZE);
-	}
+
 	return ret;
 }
 
 static int ipc_plat_remove(struct platform_device *pdev)
 {
-	struct resource *res;
-
 	sysfs_remove_group(&pdev->dev.kobj, &intel_ipc_group);
-	free_irq(ipcdev.irq, &ipcdev);
+	devm_free_irq(&pdev->dev, ipcdev.irq, &ipcdev);
 	platform_device_unregister(ipcdev.tco_dev);
 	platform_device_unregister(ipcdev.punit_dev);
 	platform_device_unregister(ipcdev.telemetry_dev);
-	iounmap(ipcdev.ipc_base);
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_IPC_INDEX);
-	if (res) {
-		release_mem_region(res->start,
-				   PLAT_RESOURCE_IPC_SIZE +
-				   PLAT_RESOURCE_GCR_SIZE);
-	}
 	ipcdev.dev = NULL;
 	return 0;
 }
-- 
2.7.4

