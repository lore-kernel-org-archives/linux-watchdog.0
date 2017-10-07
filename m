Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14950 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753131AbdJGCeW (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 6 Oct 2017 22:34:22 -0400
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
Subject: [RFC v4 2/8] platform/x86: intel_pmc_ipc: Use spin_lock to protect GCR updates
Date: Fri,  6 Oct 2017 19:33:56 -0700
Message-Id: <c2932168ae25c83f2b2ee6a570274cd0670ba543.1507340643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1507340643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1507340643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently, update_no_reboot_bit() function implemented in this driver
uses mutex_lock() to protect its register updates. But this function is
called with in atomic context in iTCO_wdt_start() and iTCO_wdt_stop()
functions in iTCO_wdt.c driver, which in turn causes "sleeping into
atomic context" issue. This patch fixes this issue by replacing the
mutex_lock() with spin_lock() to protect the GCR read/write/update APIs.

Fixes: 9d855d4 ("platform/x86: intel_pmc_ipc: Fix iTCO_wdt GCS memory
mapping failure")
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index c85351e..c68f6a4 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -34,6 +34,7 @@
 #include <linux/acpi.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/mfd/core.h>
+#include <linux/spinlock.h>
 
 #include <asm/intel_pmc_ipc.h>
 
@@ -126,6 +127,7 @@ static struct intel_pmc_ipc_dev {
 	/* gcr */
 	void __iomem *gcr_mem_base;
 	bool has_gcr_regs;
+	spinlock_t gcr_lock;
 } ipcdev;
 
 static char *ipc_err_sources[] = {
@@ -209,17 +211,17 @@ int intel_pmc_gcr_read(u32 offset, u32 *data)
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
@@ -239,17 +241,17 @@ int intel_pmc_gcr_write(u32 offset, u32 data)
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
@@ -271,7 +273,7 @@ int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
 	u32 new_val;
 	int ret = 0;
 
-	mutex_lock(&ipclock);
+	spin_lock(&ipcdev.gcr_lock);
 
 	ret = is_gcr_valid(offset);
 	if (ret < 0)
@@ -293,7 +295,7 @@ int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
 	}
 
 gcr_ipc_unlock:
-	mutex_unlock(&ipclock);
+	spin_unlock(&ipcdev.gcr_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(intel_pmc_gcr_update);
@@ -471,6 +473,8 @@ static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (pmc->dev)
 		return -EBUSY;
 
+	spin_lock_init(&ipcdev.gcr_lock);
+
 	pmc->irq_mode = IPC_TRIGGER_MODE_IRQ;
 
 	ret = pcim_enable_device(pdev);
@@ -794,6 +798,7 @@ static int ipc_plat_probe(struct platform_device *pdev)
 	ipcdev.dev = &pdev->dev;
 	ipcdev.irq_mode = IPC_TRIGGER_MODE_IRQ;
 	init_completion(&ipcdev.cmd_complete);
+	spin_lock_init(&ipcdev.gcr_lock);
 
 	ipcdev.irq = platform_get_irq(pdev, 0);
 	if (ipcdev.irq < 0) {
-- 
2.7.4

