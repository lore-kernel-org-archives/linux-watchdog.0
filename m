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
Subject: [PATCH v6 1/6] platform/x86: intel_pmc_ipc: fix gcr offset
Date: Wed,  5 Apr 2017 15:54:19 -0700
Message-Id: <463a23bb1f44098dd0fe506346bae71282009e05.1491428146.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <3e7ca77c-2be5-5f89-f51f-faaca9f2d9ac@linux.intel.com>
References: <3e7ca77c-2be5-5f89-f51f-faaca9f2d9ac@linux.intel.com>
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

Changes since v5:
 *  None

Changes since v4:
 *  None

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
