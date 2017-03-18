Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:16485 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbdCRCOA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Mar 2017 22:14:00 -0400
From: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To: andy@infradead.org, qipeng.zha@intel.com, dvhart@infradead.org,
        linux@roeck-us.net
Cc: wim@iguana.be, sathyaosid@gmail.com, david.e.box@linux.intel.com,
        rajneesh.bhardwaj@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v3 5/5] platform/x86: intel_pmc_ipc: use gcr mem base for S0ix counter read
Date: Fri, 17 Mar 2017 19:06:22 -0700
Message-Id: <4967f29bb2746241a5c72443b94adebae3d0d45c.1489801590.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <1ee0cc63c5ad4d4581fa46ae5e72001f0ac341c0.1489801590.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <1ee0cc63c5ad4d4581fa46ae5e72001f0ac341c0.1489801590.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

To maintain the uniformity in accessing GCR registers, this patch
modifies the S0ix counter read function to use GCR address base
instead of ipc address base.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/intel_pmc_ipc.h |  2 ++
 drivers/platform/x86/intel_pmc_ipc.c | 10 +++-------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
index 8402efe..fac89eb 100644
--- a/arch/x86/include/asm/intel_pmc_ipc.h
+++ b/arch/x86/include/asm/intel_pmc_ipc.h
@@ -25,6 +25,8 @@
 
 /* GCR reg offsets from gcr base*/
 #define PMC_GCR_PMC_CFG_REG		0x08
+#define PMC_GCR_TELEM_DEEP_S0IX_REG	0x78
+#define PMC_GCR_TELEM_SHLW_S0IX_REG	0x80
 
 #if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
 
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 0c66c11..54d5254 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -57,10 +57,6 @@
 #define IPC_WRITE_BUFFER	0x80
 #define IPC_READ_BUFFER		0x90
 
-/* PMC Global Control Registers */
-#define GCR_TELEM_DEEP_S0IX_OFFSET	0x1078
-#define GCR_TELEM_SHLW_S0IX_OFFSET	0x1080
-
 /* Residency with clock rate at 19.2MHz to usecs */
 #define S0IX_RESIDENCY_IN_USECS(d, s)		\
 ({						\
@@ -196,7 +192,7 @@ static inline u32 ipc_data_readl(u32 offset)
 
 static inline u64 gcr_data_readq(u32 offset)
 {
-	return readq(ipcdev.ipc_base + offset);
+	return readq(ipcdev.gcr_mem_base + offset);
 }
 
 int intel_pmc_gcr_read(u32 offset, u32 *data)
@@ -838,8 +834,8 @@ int intel_pmc_s0ix_counter_read(u64 *data)
 	if (!ipcdev.has_gcr_regs)
 		return -EACCES;
 
-	deep = gcr_data_readq(GCR_TELEM_DEEP_S0IX_OFFSET);
-	shlw = gcr_data_readq(GCR_TELEM_SHLW_S0IX_OFFSET);
+	deep = gcr_data_readq(PMC_GCR_TELEM_DEEP_S0IX_REG);
+	shlw = gcr_data_readq(PMC_GCR_TELEM_SHLW_S0IX_REG);
 
 	*data = S0IX_RESIDENCY_IN_USECS(deep, shlw);
 
-- 
2.7.4

