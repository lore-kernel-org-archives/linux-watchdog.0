Return-path: <hanjun.guo@linaro.org>
Message-ID: <555F4D58.6040107@linaro.org>
Date: Fri, 22 May 2015 23:38:00 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
 linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
 al.stone@linaro.org, timur@codeaurora.org, ashwin.chaugule@linaro.org,
 arnd@arndb.de, linux@roeck-us.net, vgandhi@codeaurora.org,
 wim@iguana.be, jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
 mark.rutland@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 7/7] ACPI: import watchdog info of GTDT into platform
 device
References: <=fu.wei@linaro.org> <1432197156-16947-1-git-send-email-fu.wei@linaro.org> <1432197156-16947-8-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1432197156-16947-8-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

+CC Catalin and Will

On 2015年05月21日 16:32, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> Parse SBSA Generic Watchdog Structure in GTDT table of ACPI,
> and create a platform device with that information.
> This platform device can be used by the ARM SBSA Generic
> Watchdog driver.
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>   arch/arm64/kernel/acpi.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 136 insertions(+)
>
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 8b83955..1ed11fd 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -23,6 +23,7 @@
>   #include <linux/irqdomain.h>
>   #include <linux/memblock.h>
>   #include <linux/of_fdt.h>
> +#include <linux/platform_device.h>
>   #include <linux/smp.h>
>
>   #include <asm/cputype.h>
> @@ -343,3 +344,138 @@ void __init acpi_gic_init(void)
>
>   	early_acpi_os_unmap_memory((char *)table, tbl_size);
>   }
> +
> +static int __init acpi_gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
> +					     int index)
> +{
> +	struct platform_device *pdev;
> +	struct resource *res;
> +	u32 gsi, flags;
> +	int irq, trigger, polarity;
> +	resource_size_t rf_base_phy, cf_base_phy;	
> +	int err = -ENOMEM;
> +
> +	/*
> +	 * Get SBSA Generic Watchdog info
> +	 * from a Watchdog GT type structure in GTDT
> +	 */
> +	rf_base_phy = (resource_size_t)wd->refresh_frame_address;
> +	cf_base_phy = (resource_size_t)wd->control_frame_address;
> +	gsi = wd->timer_interrupt;
> +	flags = wd->timer_flags;
> +
> +	pr_info("GTDT: a Watchdog GT structure(0x%llx/0x%llx gsi:%u flags:0x%x)\n",
> +		rf_base_phy, cf_base_phy, gsi, flags);

Can we use pr_debug here? I don't think those information
worthy a pr_info.

> +
> +	if (!(rf_base_phy && cf_base_phy && gsi)) {
> +		pr_err("GTDT: failed geting the device info.\n");
> +		return -EINVAL;
> +	}
> +
> +	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
> +			: ACPI_LEVEL_SENSITIVE;
> +	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
> +			: ACPI_ACTIVE_HIGH;

I see places to duplicate this, I will look into this to see we can form
a function to handle it.

> +	irq = acpi_register_gsi(NULL, gsi, trigger, polarity);
> +	if (irq < 0) {
> +		pr_err("GTDT: failed to register GSI of the Watchdog GT.\n");
> +		return -EINVAL;
> +	}
> +
> +	pdev = platform_device_alloc("sbsa-gwdt", index);

Please put a comment before this function to explain
why we need a "sbsa-gwdt" name here.

> +	if (!pdev)
> +		goto err_unregister_gsi;
> +
> +	res = kcalloc(3, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		goto err_device_put;
> +
> +	res[0].start = rf_base_phy;
> +	res[0].end = rf_base_phy + SZ_4K - 1;
> +	res[0].name = "refresh";
> +	res[0].flags = IORESOURCE_MEM;
> +
> +	res[1].start = cf_base_phy;
> +	res[1].end = cf_base_phy + SZ_4K - 1;

So why SZ_4K? is it defined in SBSA spec? if so, please
comment on it too.

> +	res[1].name = "control";
> +	res[1].flags = IORESOURCE_MEM;
> +
> +	res[2].start = irq;
> +	res[2].end = res[2].start;
> +	res[2].name = "ws0";
> +	res[2].flags = IORESOURCE_IRQ;
> +
> +	err = platform_device_add_resources(pdev, res, 3);
> +	if (err)
> +		goto err_free_res;
> +
> +	err = platform_device_add(pdev);
> +	if (err)
> +		goto err_free_res;
> +
> +	return 0;
> +
> +err_free_res:
> +	kfree(res);
> +err_device_put:
> +	platform_device_put(pdev);
> +err_unregister_gsi:
> +	acpi_unregister_gsi(gsi);
> +
> +	return err;
> +}
> +
> +/* Initialize SBSA generic Watchdog platform device info from GTDT */
> +static int __init acpi_gtdt_sbsa_gwdt_init(struct acpi_table_header *table)
> +{
> +	struct acpi_table_gtdt *gtdt;
> +	struct acpi_gtdt_header *header;
> +	void *gtdt_subtable;
> +	int i, gwdt_index;
> +	int ret = 0;
> +
> +	if (table->revision < 2) {
> +		pr_info("GTDT: Revision:%d doesn't support Platform Timers.\n",
> +			table->revision);

pr_warn() would be good.

Thanks
Hanjun
