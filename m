Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:4209 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753045AbdDFPSu (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Apr 2017 11:18:50 -0400
Date: Thu, 6 Apr 2017 20:46:44 +0530
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: andy@infradead.org, qipeng.zha@intel.com, dvhart@infradead.org,
        linux@roeck-us.net, wim@iguana.be, sathyaosid@gmail.com,
        david.e.box@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v6 1/6] platform/x86: intel_pmc_ipc: fix gcr offset
Message-ID: <20170406151644.GA21709@rajaneesh-OptiPlex-9010>
References: <3e7ca77c-2be5-5f89-f51f-faaca9f2d9ac@linux.intel.com>
 <463a23bb1f44098dd0fe506346bae71282009e05.1491428146.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <463a23bb1f44098dd0fe506346bae71282009e05.1491428146.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Apr 05, 2017 at 03:54:19PM -0700, Kuppuswamy Sathyanarayanan wrote:
> According to Broxton APL PMC spec, gcr mem region starts
> at offset 0x1000 from ipc mem base address. In this driver,
> PLAT_RESOURCE_GCR_OFFSET macro defines the offset of GCR
> memory region from IPC mem region. So we should use 0x1000(4K)
> as GCR offset. But currently this driver uses 0x1008 as GCT

Typo, GCT -> GCR. I think we still need to maintain consistency in the
commit message. Consider the below message and update if you'd like to.

On BXT SoC the PMC MMIO resources for the Global Control Registers (GCR) are
located at 4k offset from the IPC1 base. The PLAT_RESOURCE_GCR_OFFSET macro
used in this driver is misleading as 0x1008 is the location for PMC_CFG
register and not the GCR Base itself. 

GCR Base = IPC1 Base + 0x1000.

This patch updates the GCR Base address correctly.

> offset.This patch fixes this issue.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_ipc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Changes since v5:
>  *  None
> 
> Changes since v4:
>  *  None
> 
> Changes since v3:
>  * Updated the commit history
> 
> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
> index 0651d47..0a33592 100644
> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c
> @@ -82,7 +82,7 @@
>  /* exported resources from IFWI */
>  #define PLAT_RESOURCE_IPC_INDEX		0
>  #define PLAT_RESOURCE_IPC_SIZE		0x1000
> -#define PLAT_RESOURCE_GCR_OFFSET	0x1008
> +#define PLAT_RESOURCE_GCR_OFFSET	0x1000
>  #define PLAT_RESOURCE_GCR_SIZE		0x1000
>  #define PLAT_RESOURCE_BIOS_DATA_INDEX	1
>  #define PLAT_RESOURCE_BIOS_IFACE_INDEX	2
> -- 
> 2.7.4
> 

-- 
Best Regards,
Rajneesh
