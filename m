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
Subject: [PATCH v4 1/5] platform/x86: intel_pmc_ipc: fix gcr offset
Date: Fri, 31 Mar 2017 16:27:48 -0700
Message-Id: <e537ff68732d86418982349624fd6de741bccc9b.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20170331133728.GA23725@rajaneesh-OptiPlex-9010>
References: <20170331133728.GA23725@rajaneesh-OptiPlex-9010>
List-ID: <linux-watchdog@vger.kernel.org>

According to Broxton APL PMC spec, gcr mem region starts
at offset 0x1000 from ipc mem base address. In this driver,
PLAT_RESOURCE_GCR_OFFSET macro defines the offset of GCR
memory region from IPC mem region. So we should use 0x1000(4K)
as GCR offset. But currently this driver uses 0x1008 as GCT
offset.This patch fixes this issue.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes since v3:
 * Updated the commit history

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 0651d47..0a33592 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -82,7 +82,7 @@
 /* exported resources from IFWI */
 #define PLAT_RESOURCE_IPC_INDEX		0
 #define PLAT_RESOURCE_IPC_SIZE		0x1000
-#define PLAT_RESOURCE_GCR_OFFSET	0x1008
+#define PLAT_RESOURCE_GCR_OFFSET	0x1000
 #define PLAT_RESOURCE_GCR_SIZE		0x1000
 #define PLAT_RESOURCE_BIOS_DATA_INDEX	1
 #define PLAT_RESOURCE_BIOS_IFACE_INDEX	2
-- 
2.7.4
