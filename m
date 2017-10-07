Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:9740 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753214AbdJGWUW (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 7 Oct 2017 18:20:22 -0400
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
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kupuswamy@linux.intel.com>
Subject: [RFC v5 1/8] platform/x86: intel_pmc_ipc: Use spin_lock to protect GCR updates
Date: Sat,  7 Oct 2017 15:19:51 -0700
Message-Id: <e70046c8d49173840f8ee7218e8b2288301f8e67.1507414288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1507414288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1507414288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently, update_no_reboot_bit() function implemented in this driver
uses mutex_lock() to protect its register updates. But this function is
called with in atomic context in iTCO_wdt_start() and iTCO_wdt_stop()
functions in iTCO_wdt.c driver, which in turn causes "sleeping into
atomic context" issue. This patch fixes this issue by replacing the
mutex_lock() with spin_lock() to protect the GCR read/write/update APIs.

Fixes: 9d855d4 ("platform/x86: intel_pmc_ipc: Fix iTCO_wdt GCS memory mapping failure")
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kupuswamy@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

Changes since v4:
 * Fixed style issues in commit header.
 * Rebased this patch on top of Andy's review branch.

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 751b121..e03fa314 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -33,6 +33,7 @@
 #include <linux/suspend.h>
 #include <linux/acpi.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/spinlock.h>
 
 #include <asm/intel_pmc_ipc.h>
 
@@ -131,6 +132,7 @@ static struct intel_pmc_ipc_dev {
 	/* gcr */
 	void __iomem *gcr_mem_base;
 	bool has_gcr_regs;
+	spinlock_t gcr_lock;
 
 	/* punit */
 	struct platform_device *punit_dev;
@@ -225,17 +227,17 @@ int intel_pmc_gcr_read(u32 offset, u32 *data)
 {
 	int ret;
 
-	mutex_lock(&ipclock);
+	spin_lock(&ipcdev.gcr_lock);
 
 	ret = is_gcr_valid(offset);
 	if (ret < 0) {
-		mutex_unlock(&ipclock);
+		spin_unlock(&ipcdev.gcr_lock);
 		return ret;
 	}
 
 	*data = readl(ipcdev.gcr_mem_base + offset);
 
-	mutex_unlock(&ipclock);
+	spin_unlock(&ipcdev.gcr_lock);
 
 	return 0;
 }
@@ -255,17 +257,17 @@ int intel_pmc_gcr_write(u32 offset, u32 data)
 {
 	int ret;
 
-	mutex_lock(&ipclock);
+	spin_lock(&ipcdev.gcr_lock);
 
 	ret = is_gcr_valid(offset);
 	if (ret < 0) {
-		mutex_unlock(&ipclock);
+		spin_unlock(&ipcdev.gcr_lock);
 		return ret;
 	}
 
 	writel(data, ipcdev.gcr_mem_base + offset);
 
-	mutex_unlock(&ipclock);
+	spin_unlock(&ipcdev.gcr_lock);
 
 	return 0;
 }
@@ -287,7 +289,7 @@ int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
 	u32 new_val;
 	int ret = 0;
 
-	mutex_lock(&ipclock);
+	spin_lock(&ipcdev.gcr_lock);
 
 	ret = is_gcr_valid(offset);
 	if (ret < 0)
@@ -309,7 +311,7 @@ int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
 	}
 
 gcr_ipc_unlock:
-	mutex_unlock(&ipclock);
+	spin_unlock(&ipcdev.gcr_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(intel_pmc_gcr_update);
@@ -489,6 +491,8 @@ static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pmc->irq_mode = IPC_TRIGGER_MODE_IRQ;
 
+	spin_lock_init(&ipcdev.gcr_lock);
+
 	ret = pcim_enable_device(pdev);
 	if (ret)
 		return ret;
@@ -903,6 +907,7 @@ static int ipc_plat_probe(struct platform_device *pdev)
 	ipcdev.dev = &pdev->dev;
 	ipcdev.irq_mode = IPC_TRIGGER_MODE_IRQ;
 	init_completion(&ipcdev.cmd_complete);
+	spin_lock_init(&ipcdev.gcr_lock);
 
 	ipcdev.irq = platform_get_irq(pdev, 0);
 	if (ipcdev.irq < 0) {
-- 
2.7.4

