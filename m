Return-path: <rajneesh.bhardwaj@intel.com>
Date: Fri, 17 Mar 2017 17:13:13 +0530
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: andy@infradead.org, qipeng.zha@intel.com, dvhart@infradead.org,
	david.e.box@linux.intel.com, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@roeck-us.net,
	linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH v2 3/4] watchdog: iTCO_wdt: Fix PMC GCR memory mapping
 failure
Message-ID: <20170317114313.GE24582@rajaneesh-OptiPlex-9010>
References: <b89221c652d06c3c07fdf2ec32fd4fc8930c64df.1489710235.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <2c41b3b6344f9cb455ac57e1e41aa229adb2867d.1489710235.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c41b3b6344f9cb455ac57e1e41aa229adb2867d.1489710235.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Mar 16, 2017 at 05:41:35PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Currently, iTCO watchdog driver uses memory map to access
> PMC_CFG GCR register. But the entire GCR address space is
> already mapped in intel_scu_ipc driver. So remapping the

intel_pmc_ipc driver.

> GCR register in this driver causes the mem request failure in
> iTCO_wdt probe function. This patch fixes this issue by
> using PMC GCR read/write API's to access PMC_CFG register.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/watchdog/iTCO_wdt.c | 31 +++++++------------------------
>  1 file changed, 7 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 3d0abc0..31abfc5 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -68,6 +68,8 @@
>  #include <linux/io.h>			/* For inb/outb/... */
>  #include <linux/platform_data/itco_wdt.h>
>  
> +#include <asm/intel_pmc_ipc.h>
> +
>  #include "iTCO_vendor.h"
>  
>  /* Address definitions for the TCO */
> @@ -94,12 +96,6 @@ struct iTCO_wdt_private {
>  	unsigned int iTCO_version;
>  	struct resource *tco_res;
>  	struct resource *smi_res;
> -	/*
> -	 * NO_REBOOT flag is Memory-Mapped GCS register bit 5 (TCO version 2),
> -	 * or memory-mapped PMC register bit 4 (TCO version 3).
> -	 */

Better to retain this comment elsewhere.

> -	struct resource *gcs_pmc_res;
> -	unsigned long __iomem *gcs_pmc;
>  	/* the lock for io operations */
>  	spinlock_t io_lock;
>  	/* the PCI-device */
> @@ -176,9 +172,9 @@ static void iTCO_wdt_set_NO_REBOOT_bit(struct iTCO_wdt_private *p)
>  
>  	/* Set the NO_REBOOT bit: this disables reboots */
>  	if (p->iTCO_version >= 2) {
> -		val32 = readl(p->gcs_pmc);
> +		val32 = intel_pmc_gcr_read(PMC_GCR_PMC_CFG_REG);

better to have protection and error handling, discussed in v2, 2/4.

compiled and tested this on APL and i see iTCO_WDT driver loads fine. Since
it impacts core WDT functionality, need to be thoroughly tested on various
platforms.

> -- 
> 2.7.4
> 

-- 
Best Regards,
Rajneesh
