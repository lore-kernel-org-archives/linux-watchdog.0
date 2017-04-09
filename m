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
Subject: [PATCH v7 6/6] platform/x86: intel_pmc_ipc: use gcr mem base for S0ix counter read
Date: Sun,  9 Apr 2017 15:00:21 -0700
Message-Id: <12ac21f0dd3f117713c7d926e194d92839faa1ed.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aefdf4f6a7b0cf4af92d51ce2b9b73284cc03ffe.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <aefdf4f6a7b0cf4af92d51ce2b9b73284cc03ffe.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

Changes since v6:
 * None

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
index 0a39b0f..e4d4dfe 100644
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
@@ -202,7 +198,7 @@ static inline u32 ipc_data_readl(u32 offset)
 
 static inline u64 gcr_data_readq(u32 offset)
 {
-	return readq(ipcdev.ipc_base + offset);
+	return readq(ipcdev.gcr_mem_base + offset);
 }
 
 static inline int is_gcr_valid(u32 offset)
@@ -902,8 +898,8 @@ int intel_pmc_s0ix_counter_read(u64 *data)
 	if (!ipcdev.has_gcr_regs)
 		return -EACCES;
 
-	deep = gcr_data_readq(GCR_TELEM_DEEP_S0IX_OFFSET);
-	shlw = gcr_data_readq(GCR_TELEM_SHLW_S0IX_OFFSET);
+	deep = gcr_data_readq(PMC_GCR_TELEM_DEEP_S0IX_REG);
+	shlw = gcr_data_readq(PMC_GCR_TELEM_SHLW_S0IX_REG);
 
 	*data = S0IX_RESIDENCY_IN_USECS(deep, shlw);
 
-- 
2.7.4
