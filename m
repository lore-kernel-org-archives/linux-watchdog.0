Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25503 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751046AbdJSAXm (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 18 Oct 2017 20:23:42 -0400
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
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [RFC v6 2/9] platform/x86: intel_pmc_ipc: Use devm_* calls in driver probe function
Date: Wed, 18 Oct 2017 17:23:05 -0700
Message-Id: <6896e711ea8ffe8d4e636a0d014f5f53b2813c8c.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

This patch cleans up unnecessary free/alloc calls in ipc_plat_probe(),
ipc_pci_probe() and ipc_plat_get_res() functions by using devm_*
calls.

This patch also adds proper error handling for failure cases in
ipc_pci_probe() function.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
[andy: fixed style issues, missed devm_free_irq(), removed unnecessary log message]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 96 +++++++++++-------------------------
 1 file changed, 29 insertions(+), 67 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index af88221..eadd1a1 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -482,54 +482,41 @@ static irqreturn_t ioc(int irq, void *dev_id)
 
 static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	resource_size_t pci_resource;
+	struct intel_pmc_ipc_dev *pmc = &ipcdev;
 	int ret;
-	int len;
 
-	ipcdev.dev = &pci_dev_get(pdev)->dev;
-	ipcdev.irq_mode = IPC_TRIGGER_MODE_IRQ;
+	/* Only one PMC is supported */
+	if (pmc->dev)
+		return -EBUSY;
 
-	spin_lock_init(&ipcdev.gcr_lock);
+	spin_lock_init(&pmc->gcr_lock);
+
+	pmc->irq_mode = IPC_TRIGGER_MODE_IRQ;
 
-	ret = pci_enable_device(pdev);
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
+	pmc->ipc_base = pcim_iomap_table(pdev)[0];
 
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
@@ -544,7 +531,6 @@ static struct pci_driver ipc_pci_driver = {
 	.name = "intel_pmc_ipc",
 	.id_table = ipc_pci_ids,
 	.probe = ipc_pci_probe,
-	.remove = ipc_pci_remove,
 };
 
 static ssize_t intel_pmc_ipc_simple_cmd_store(struct device *dev,
@@ -854,17 +840,12 @@ static int ipc_plat_get_res(struct platform_device *pdev)
 		return -ENXIO;
 	}
 	size = PLAT_RESOURCE_IPC_SIZE + PLAT_RESOURCE_GCR_SIZE;
+	res->end = res->start + size - 1;
+
+	addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
 
-	if (!request_mem_region(res->start, size, pdev->name)) {
-		dev_err(&pdev->dev, "Failed to request ipc resource\n");
-		return -EBUSY;
-	}
-	addr = ioremap_nocache(res->start, size);
-	if (!addr) {
-		dev_err(&pdev->dev, "I/O memory remapping failed\n");
-		release_mem_region(res->start, size);
-		return -ENOMEM;
-	}
 	ipcdev.ipc_base = addr;
 
 	ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
@@ -921,7 +902,6 @@ MODULE_DEVICE_TABLE(acpi, ipc_acpi_ids);
 
 static int ipc_plat_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	int ret;
 
 	ipcdev.dev = &pdev->dev;
@@ -945,11 +925,11 @@ static int ipc_plat_probe(struct platform_device *pdev)
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
 		goto err_irq;
@@ -966,40 +946,22 @@ static int ipc_plat_probe(struct platform_device *pdev)
 
 	return 0;
 err_sys:
-	free_irq(ipcdev.irq, &ipcdev);
+	devm_free_irq(&pdev->dev, ipcdev.irq, &ipcdev);
 err_irq:
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

