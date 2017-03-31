Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:16406 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754661AbdCaNhi (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 31 Mar 2017 09:37:38 -0400
Date: Fri, 31 Mar 2017 19:07:32 +0530
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: andy@infradead.org, qipeng.zha@intel.com, dvhart@infradead.org,
        linux@roeck-us.net, wim@iguana.be, sathyaosid@gmail.com,
        david.e.box@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 1/5] platform/x86: intel_pmc_ipc: fix gcr offset
Message-ID: <20170331133728.GA23725@rajaneesh-OptiPlex-9010>
References: <1ee0cc63c5ad4d4581fa46ae5e72001f0ac341c0.1489801590.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee0cc63c5ad4d4581fa46ae5e72001f0ac341c0.1489801590.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 17, 2017 at 07:06:18PM -0700, Kuppuswamy Sathyanarayanan wrote:
> According to the PMC spec, gcr offset from ipc mem

Which spec? We can just use generic terms for BXT/APL PMC.

> region is 0x1000(4K). But currently this driver uses
> 0x1008 as gcr offset. This patch fixes this issue.
>

Patch is good but i feel it's better to have little more explanation in the
commit message since the subject looks very similar to one old patch that
seems to have created the issue being fixed by this one.

Have a look at:
intel_pmc_ipc: Fix GCR register base address and length
 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_ipc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
