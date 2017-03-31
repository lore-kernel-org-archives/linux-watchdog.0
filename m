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
Subject: [PATCH v4 5/5] platform/x86: intel_pmc_ipc: use gcr mem base for S0ix counter read
Date: Fri, 31 Mar 2017 16:27:52 -0700
Message-Id: <f0b0c47437ddd0c96e7d3326dce838d8a0d4cfff.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20170331133728.GA23725@rajaneesh-OptiPlex-9010>
References: <20170331133728.GA23725@rajaneesh-OptiPlex-9010>
In-Reply-To: <e537ff68732d86418982349624fd6de741bccc9b.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <e537ff68732d86418982349624fd6de741bccc9b.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-watchdog@vger.kernel.org>

To maintain the uniformity in accessing GCR registers, this patch
modifies the S0ix counter read function to use GCR address base
instead of ipc address base.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Tested-by: Shanth Murthy <shanth.murthy@intel.com>
---
 arch/x86/include/asm/intel_pmc_ipc.h |  2 ++
 drivers/platform/x86/intel_pmc_ipc.c | 10 +++-------
 2 files changed, 5 insertions(+), 7 deletions(-)

Changes since v3:
 * Rebased on top of latest changes.

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
index 3f3ee50..c7b5517 100644
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
 
 static inline int is_gcr_valid(u32 offset)
@@ -877,8 +873,8 @@ int intel_pmc_s0ix_counter_read(u64 *data)
 	if (!ipcdev.has_gcr_regs)
 		return -EACCES;
 
-	deep = gcr_data_readq(GCR_TELEM_DEEP_S0IX_OFFSET);
-	shlw = gcr_data_readq(GCR_TELEM_SHLW_S0IX_OFFSET);
+	deep = gcr_data_readq(PMC_GCR_TELEM_DEEP_S0IX_REG);
+	shlw = gcr_data_readq(PMC_GCR_TELEM_SHLW_S0IX_REG);
 
 	*data = S0IX_RESIDENCY_IN_USECS(deep, shlw);
 
-- 
2.7.4
