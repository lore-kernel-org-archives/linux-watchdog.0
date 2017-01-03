Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43507 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758370AbdACOjg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Jan 2017 09:39:36 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Fleming <matt.fleming@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/4] watchdog: iTCO_wdt: Use pdev for platform device and pci_dev for pci device
Date: Tue,  3 Jan 2017 06:39:23 -0800
Message-Id: <1483454364-28650-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1483454364-28650-1-git-send-email-linux@roeck-us.net>
References: <1483454364-28650-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use pdev for struct platform_device, pcidev for struct pci_dev, and dev
for struct device variables to improve consistency.

Remove 'struct platform_device *dev;' from struct iTCO_wdt_private since
it was unused.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/iTCO_wdt.c | 53 ++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index eed1dee6de19..ad29ae03a30b 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -102,9 +102,8 @@ struct iTCO_wdt_private {
 	unsigned long __iomem *gcs_pmc;
 	/* the lock for io operations */
 	spinlock_t io_lock;
-	struct platform_device *dev;
 	/* the PCI-device */
-	struct pci_dev *pdev;
+	struct pci_dev *pcidev;
 	/* whether or not the watchdog has been suspended */
 	bool suspended;
 };
@@ -181,9 +180,9 @@ static void iTCO_wdt_set_NO_REBOOT_bit(struct iTCO_wdt_private *p)
 		val32 |= no_reboot_bit(p);
 		writel(val32, p->gcs_pmc);
 	} else if (p->iTCO_version == 1) {
-		pci_read_config_dword(p->pdev, 0xd4, &val32);
+		pci_read_config_dword(p->pcidev, 0xd4, &val32);
 		val32 |= no_reboot_bit(p);
-		pci_write_config_dword(p->pdev, 0xd4, val32);
+		pci_write_config_dword(p->pcidev, 0xd4, val32);
 	}
 }
 
@@ -200,11 +199,11 @@ static int iTCO_wdt_unset_NO_REBOOT_bit(struct iTCO_wdt_private *p)
 
 		val32 = readl(p->gcs_pmc);
 	} else if (p->iTCO_version == 1) {
-		pci_read_config_dword(p->pdev, 0xd4, &val32);
+		pci_read_config_dword(p->pcidev, 0xd4, &val32);
 		val32 &= ~enable_bit;
-		pci_write_config_dword(p->pdev, 0xd4, val32);
+		pci_write_config_dword(p->pcidev, 0xd4, val32);
 
-		pci_read_config_dword(p->pdev, 0xd4, &val32);
+		pci_read_config_dword(p->pcidev, 0xd4, &val32);
 	}
 
 	if (val32 & enable_bit)
@@ -401,9 +400,10 @@ static const struct watchdog_ops iTCO_wdt_ops = {
  *	Init & exit routines
  */
 
-static int iTCO_wdt_probe(struct platform_device *dev)
+static int iTCO_wdt_probe(struct platform_device *pdev)
 {
-	struct itco_wdt_platform_data *pdata = dev_get_platdata(&dev->dev);
+	struct device *dev = &pdev->dev;
+	struct itco_wdt_platform_data *pdata = dev_get_platdata(dev);
 	struct iTCO_wdt_private *p;
 	unsigned long val32;
 	int ret;
@@ -411,33 +411,32 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 	if (!pdata)
 		return -ENODEV;
 
-	p = devm_kzalloc(&dev->dev, sizeof(*p), GFP_KERNEL);
+	p = devm_kzalloc(dev, sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
 	spin_lock_init(&p->io_lock);
 
-	p->tco_res = platform_get_resource(dev, IORESOURCE_IO, ICH_RES_IO_TCO);
+	p->tco_res = platform_get_resource(pdev, IORESOURCE_IO, ICH_RES_IO_TCO);
 	if (!p->tco_res)
 		return -ENODEV;
 
-	p->smi_res = platform_get_resource(dev, IORESOURCE_IO, ICH_RES_IO_SMI);
+	p->smi_res = platform_get_resource(pdev, IORESOURCE_IO, ICH_RES_IO_SMI);
 	if (!p->smi_res)
 		return -ENODEV;
 
 	p->iTCO_version = pdata->version;
-	p->dev = dev;
-	p->pdev = to_pci_dev(dev->dev.parent);
+	p->pcidev = to_pci_dev(dev->parent);
 
 	/*
 	 * Get the Memory-Mapped GCS or PMC register, we need it for the
 	 * NO_REBOOT flag (TCO v2 and v3).
 	 */
 	if (p->iTCO_version >= 2) {
-		p->gcs_pmc_res = platform_get_resource(dev,
+		p->gcs_pmc_res = platform_get_resource(pdev,
 						       IORESOURCE_MEM,
 						       ICH_RES_MEM_GCS_PMC);
-		p->gcs_pmc = devm_ioremap_resource(&dev->dev, p->gcs_pmc_res);
+		p->gcs_pmc = devm_ioremap_resource(dev, p->gcs_pmc_res);
 		if (IS_ERR(p->gcs_pmc))
 			return PTR_ERR(p->gcs_pmc);
 	}
@@ -453,9 +452,9 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 	iTCO_wdt_set_NO_REBOOT_bit(p);
 
 	/* The TCO logic uses the TCO_EN bit in the SMI_EN register */
-	if (!devm_request_region(&dev->dev, p->smi_res->start,
+	if (!devm_request_region(dev, p->smi_res->start,
 				 resource_size(p->smi_res),
-				 dev->name)) {
+				 pdev->name)) {
 		pr_err("I/O address 0x%04llx already in use, device disabled\n",
 		       (u64)SMI_EN(p));
 		return -EBUSY;
@@ -470,9 +469,9 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 		outl(val32, SMI_EN(p));
 	}
 
-	if (!devm_request_region(&dev->dev, p->tco_res->start,
+	if (!devm_request_region(dev, p->tco_res->start,
 				 resource_size(p->tco_res),
-				 dev->name)) {
+				 pdev->name)) {
 		pr_err("I/O address 0x%04llx already in use, device disabled\n",
 		       (u64)TCOBASE(p));
 		return -EBUSY;
@@ -505,10 +504,10 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 	p->wddev.bootstatus = 0;
 	p->wddev.timeout = WATCHDOG_TIMEOUT;
 	watchdog_set_nowayout(&p->wddev, nowayout);
-	p->wddev.parent = &dev->dev;
+	p->wddev.parent = dev;
 
 	watchdog_set_drvdata(&p->wddev, p);
-	platform_set_drvdata(dev, p);
+	platform_set_drvdata(pdev, p);
 
 	/* Make sure the watchdog is not running */
 	iTCO_wdt_stop(&p->wddev);
@@ -521,7 +520,7 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 			WATCHDOG_TIMEOUT);
 	}
 
-	ret = devm_watchdog_register_device(&dev->dev, &p->wddev);
+	ret = devm_watchdog_register_device(dev, &p->wddev);
 	if (ret != 0) {
 		pr_err("cannot register watchdog device (err=%d)\n", ret);
 		return ret;
@@ -533,9 +532,9 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int iTCO_wdt_remove(struct platform_device *dev)
+static int iTCO_wdt_remove(struct platform_device *pdev)
 {
-	struct iTCO_wdt_private *p = platform_get_drvdata(dev);
+	struct iTCO_wdt_private *p = platform_get_drvdata(pdev);
 
 	/* Stop the timer before we leave */
 	if (!nowayout)
@@ -544,9 +543,9 @@ static int iTCO_wdt_remove(struct platform_device *dev)
 	return 0;
 }
 
-static void iTCO_wdt_shutdown(struct platform_device *dev)
+static void iTCO_wdt_shutdown(struct platform_device *pdev)
 {
-	struct iTCO_wdt_private *p = platform_get_drvdata(dev);
+	struct iTCO_wdt_private *p = platform_get_drvdata(pdev);
 
 	iTCO_wdt_stop(&p->wddev);
 }
-- 
2.7.4

