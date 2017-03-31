Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:62910 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754597AbdCaOBn (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 31 Mar 2017 10:01:43 -0400
Date: Fri, 31 Mar 2017 19:31:37 +0530
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: andy@infradead.org, qipeng.zha@intel.com, dvhart@infradead.org,
        linux@roeck-us.net, wim@iguana.be, sathyaosid@gmail.com,
        david.e.box@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 4/5] platform/x86: intel_pmc_ipc: Fix iTCO GCS memory
 mapping failure
Message-ID: <20170331140137.GD23725@rajaneesh-OptiPlex-9010>
References: <1ee0cc63c5ad4d4581fa46ae5e72001f0ac341c0.1489801590.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <15953459bfebdfc73669789546cca132a9c4934f.1489801590.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15953459bfebdfc73669789546cca132a9c4934f.1489801590.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 17, 2017 at 07:06:21PM -0700, Kuppuswamy Sathyanarayanan wrote:
> iTCO watchdog driver need access to PMC_CFG GCR register to modify
> the no reboot setting. Currently, this is done by passing PMC_CFG reg
> address as memory resource to watchdog driver and allowing it directly
> modify the PMC_CFG register. But currently PMC driver also has
> requirement to memory map the entire GCR register space in this driver.
> This causes mem request failure in watchdog driver. So this patch fixes
> this issue by adding api to update noreboot flag and passes them
> to watchdog driver via platform data.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_ipc.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> Changes since v2: 
>  * Added support for update_noreboot_bit api.
> 
> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
> index ea5579e..0c66c11 100644
> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c
> @@ -126,7 +126,6 @@ static struct intel_pmc_ipc_dev {
>  	struct platform_device *tco_dev;
>  
>  	/* gcr */
> -	resource_size_t gcr_base;
>  	void __iomem *gcr_mem_base;
>  	int gcr_size;
>  	bool has_gcr_regs;
> @@ -254,6 +253,15 @@ int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
>  }
>  EXPORT_SYMBOL_GPL(intel_pmc_gcr_update);
>  
> +static int update_noreboot_bit(bool status)
> +{
> +	if (status)
> +		return intel_pmc_gcr_update(PMC_GCR_PMC_CFG_REG, BIT(4),
> +					    BIT(4));
> +	else
> +		return intel_pmc_gcr_update(PMC_GCR_PMC_CFG_REG, BIT(4), 0);
> +}
> +

I think bit 4 will hold good only when TCO version is 3. What about the
other cases? Tested it on APL and it worked fine.

>  static int intel_pmc_ipc_check_status(void)
>  {
>  	int status;
> @@ -571,15 +579,12 @@ static struct resource tco_res[] = {
>  	{
>  		.flags = IORESOURCE_IO,
>  	},
> -	/* GCS */
> -	{
> -		.flags = IORESOURCE_MEM,
> -	},
>  };
>  
>  static struct itco_wdt_platform_data tco_info = {
>  	.name = "Apollo Lake SoC",
>  	.version = 5,
> +	.update_noreboot_flag = update_noreboot_bit,
>  };
>  
>  #define TELEMETRY_RESOURCE_PUNIT_SSRAM	0
> @@ -636,10 +641,6 @@ static int ipc_create_tco_device(void)
>  	res->start = ipcdev.acpi_io_base + SMI_EN_OFFSET;
>  	res->end = res->start + SMI_EN_SIZE - 1;
>  
> -	res = tco_res + TCO_RESOURCE_GCR_MEM;
> -	res->start = ipcdev.gcr_base + TCO_PMC_OFFSET;
> -	res->end = res->start + TCO_PMC_SIZE - 1;
> -
>  	pdev = platform_device_register_full(&pdevinfo);
>  	if (IS_ERR(pdev))
>  		return PTR_ERR(pdev);
> @@ -801,7 +802,6 @@ static int ipc_plat_get_res(struct platform_device *pdev)
>  	}
>  	ipcdev.ipc_base = addr;
>  
> -	ipcdev.gcr_base = res->start + PLAT_RESOURCE_GCR_OFFSET;
>  	ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
>  	ipcdev.gcr_size = PLAT_RESOURCE_GCR_SIZE;
>  	dev_info(&pdev->dev, "ipc res: %pR\n", res);
> -- 
> 2.7.4
> 

-- 
Best Regards,
Rajneesh
