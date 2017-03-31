Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51998 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932942AbdCaNrh (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 31 Mar 2017 09:47:37 -0400
Date: Fri, 31 Mar 2017 19:17:32 +0530
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: andy@infradead.org, qipeng.zha@intel.com, dvhart@infradead.org,
        linux@roeck-us.net, wim@iguana.be, sathyaosid@gmail.com,
        david.e.box@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 2/5] platform/x86: intel_pmc_ipc: Add pmc gcr
 read/write/update api's
Message-ID: <20170331134732.GB23725@rajaneesh-OptiPlex-9010>
References: <1ee0cc63c5ad4d4581fa46ae5e72001f0ac341c0.1489801590.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <e305dc8463b2407e5152ff0e3cf0c84063e15a92.1489801590.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e305dc8463b2407e5152ff0e3cf0c84063e15a92.1489801590.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 17, 2017 at 07:06:19PM -0700, Kuppuswamy Sathyanarayanan wrote:
> This patch adds API's to read/write/update PMC GC registers.
> PMC dependent devices like iTCO_WDT, Telemetry has requirement
> to acces GCR registers. These API's can be used for this
> purpose.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_pmc_ipc.h | 21 ++++++++++++++
>  drivers/platform/x86/intel_pmc_ipc.c | 56 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
> 
> Changes since v2:
>  * Removed unused reg offset from header file.
>  * Modified read/write api's signatures for better error handling
>  * Added function for bit level update of gcr register.
> 
> diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
> index 4291b6a..8402efe 100644
> --- a/arch/x86/include/asm/intel_pmc_ipc.h
> +++ b/arch/x86/include/asm/intel_pmc_ipc.h
> @@ -23,6 +23,9 @@
>  #define IPC_ERR_EMSECURITY		6
>  #define IPC_ERR_UNSIGNEDKERNEL		7
>  
> +/* GCR reg offsets from gcr base*/
> +#define PMC_GCR_PMC_CFG_REG		0x08
> +
>  #if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
>  
>  int intel_pmc_ipc_simple_command(int cmd, int sub);
> @@ -31,6 +34,9 @@ int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen,
>  int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
>  		u32 *out, u32 outlen);
>  int intel_pmc_s0ix_counter_read(u64 *data);
> +int intel_pmc_gcr_read(u32 offset, u32 *data);
> +int intel_pmc_gcr_write(u32 offset, u32 data);
> +int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val);
>  
>  #else
>  
> @@ -56,6 +62,21 @@ static inline int intel_pmc_s0ix_counter_read(u64 *data)
>  	return -EINVAL;
>  }
>  
> +static inline int intel_pmc_gcr_read(u32 offset, u32 *data)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int intel_pmc_gcr_write(u32 offset, u32 data)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
> +{
> +	return -EINVAL;
> +}
> +
>  #endif /*CONFIG_INTEL_PMC_IPC*/
>  
>  #endif
> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
> index 0a33592..ea5579e 100644
> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c
> @@ -127,6 +127,7 @@ static struct intel_pmc_ipc_dev {
>  
>  	/* gcr */
>  	resource_size_t gcr_base;
> +	void __iomem *gcr_mem_base;
>  	int gcr_size;
>  	bool has_gcr_regs;
>  
> @@ -199,6 +200,60 @@ static inline u64 gcr_data_readq(u32 offset)
>  	return readq(ipcdev.ipc_base + offset);
>  }
>  
> +int intel_pmc_gcr_read(u32 offset, u32 *data)
> +{
> +	if (!ipcdev.has_gcr_regs)
> +		return -EACCES;
> +
> +	if (offset > PLAT_RESOURCE_GCR_SIZE)
> +		return -EINVAL;
> +

we can have one function that checks the above conditions and to avoid
repetitions.

> +	*data = readl(ipcdev.gcr_mem_base + offset);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(intel_pmc_gcr_read);
> +
> +int intel_pmc_gcr_write(u32 offset, u32 data)
> +{
> +	if (!ipcdev.has_gcr_regs)
> +		return -EACCES;
> +
> +	if (offset > PLAT_RESOURCE_GCR_SIZE)
> +		return -EINVAL;
> +
> +	writel(data, ipcdev.gcr_mem_base + offset);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(intel_pmc_gcr_write);
> +
> +int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)

please add kernel-doc comments for this function that describes its intended
use case.

> +{
> +	u32 orig, tmp;
> +
> +	if (!ipcdev.has_gcr_regs)
> +		return -EACCES;
> +
> +	if (offset > PLAT_RESOURCE_GCR_SIZE)
> +		return -EINVAL;
> +
> +	orig = readl(ipcdev.gcr_mem_base + offset);
> +
> +	tmp = orig & ~mask;
> +	tmp |= val & mask;
> +
> +	writel(tmp, ipcdev.gcr_mem_base + offset);
> +
> +	tmp = readl(ipcdev.gcr_mem_base + offset);
> +
> +	if ((tmp & mask) != (val & mask))
> +		return -EIO;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(intel_pmc_gcr_update);
> +
>  static int intel_pmc_ipc_check_status(void)
>  {
>  	int status;
> @@ -747,6 +802,7 @@ static int ipc_plat_get_res(struct platform_device *pdev)
>  	ipcdev.ipc_base = addr;
>  
>  	ipcdev.gcr_base = res->start + PLAT_RESOURCE_GCR_OFFSET;
> +	ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
>  	ipcdev.gcr_size = PLAT_RESOURCE_GCR_SIZE;
>  	dev_info(&pdev->dev, "ipc res: %pR\n", res);
>  
> -- 
> 2.7.4
> 

-- 
Best Regards,
Rajneesh
