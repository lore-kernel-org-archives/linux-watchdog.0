Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754308AbcJULUC (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 21 Oct 2016 07:20:02 -0400
Date: Fri, 21 Oct 2016 12:19:27 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: fu.wei@linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org,
        linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rruigrok@codeaurora.org,
        harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org,
        graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com,
        wei@redhat.com, arnd@arndb.de, catalin.marinas@arm.com,
        will.deacon@arm.com, Suravee.Suthikulpanit@amd.com,
        leo.duran@amd.com, wim@iguana.be, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, tn@semihalf.com,
        christoffer.dall@linaro.org, julien.grall@arm.com
Subject: Re: [PATCH v14 6/9] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
Message-ID: <20161021111927.GB16630@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-7-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475086637-1914-7-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Sep 29, 2016 at 02:17:14AM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> On platforms booting with ACPI, architected memory-mapped timers'
> configuration data is provided by firmware through the ACPI GTDT
> static table.
> 
> The clocksource architected timer kernel driver requires a firmware
> interface to collect timer configuration and configure its driver.
> this infrastructure is present for device tree systems, but it is
> missing on systems booting with ACPI.
> 
> Implement the kernel infrastructure required to parse the static
> ACPI GTDT table so that the architected timer clocksource driver can
> make use of it on systems booting with ACPI, therefore enabling
> the corresponding timers configuration.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/arm64/gtdt.c            | 70 ++++++++++++++++++++++++++++++++++++
>  include/clocksource/arm_arch_timer.h | 15 ++++++++
>  include/linux/acpi.h                 |  1 +
>  3 files changed, 86 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index b24844d..b6021db 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -150,3 +150,73 @@ int __init acpi_gtdt_init(struct acpi_table_header *table)
>  
>  	return gtdt->platform_timer_count;
>  }
> +
> +static int __init gtdt_parse_gt_block(struct acpi_gtdt_timer_block *block,
> +				      struct gt_block_data *data)
> +{
> +	struct acpi_gtdt_timer_entry *frame;
> +	int i;
> +
> +	if (!block || !data)
> +		return -EINVAL;

As far as I can see, the !block case cannot happen; if it can, we'd
already have derferenced it with the is_timer_block() check in
gtdt_arch_timer_mem_init().

Why do we not handle the !data check in gtdt_arch_timer_mem_init()? It
seems fragile, given we add an index there...

> +
> +	if (!block->block_address || !block->timer_count)
> +		return -EINVAL;

Looking at Table 5-120 in the ACPI 6.1 spec, zero is not called out as
an invalid physical address for the block...

Surely if you don't have an MMIO timer, you don't have a GT Block
Structure, rather than an invalid one!?

The block->timer_count check should be more thorough, e.g.

	if (!block->timer_count) {
		pr_warn("GTDT present, but frame count is zero");
		return -ENODEV:
	}

	if (block->timer_count > 8) {
		pr_warn(FW_BUG "GTDT lists %d frames, ACPI spec only allows 8\n",
			block->timer_count);
	}

... note that without the latter we could go off the end of the array...


> +	data->cntctlbase_phy = (phys_addr_t)block->block_address;
> +	data->timer_count = block->timer_count;
> +
> +	frame = (void *)block + block->timer_offset;
> +	if (frame + block->timer_count != (void *)block + block->header.length)
> +		return -EINVAL;
> +
> +	/*
> +	 * Get the GT timer Frame data for every GT Block Timer
> +	 */
> +	for (i = 0; i < block->timer_count; i++, frame++) {
> +		if (!frame->base_address || !frame->timer_interrupt)
> +			return -EINVAL;
> +
> +		data->timer[i].irq = map_gt_gsi(frame->timer_interrupt,
> +						frame->timer_flags);
> +		if (data->timer[i].irq <= 0)
> +			return -EINVAL;

Can we please print something describing the failure, e.g.

	pr_warn("failed to map GTDT frame %d, physical timer interrupt\n",
		i);

> +
> +		if (frame->virtual_timer_interrupt) {

Same comment as previously about GSIV zero being valid; this is arguably
a spec bug that should be reported...

> +			data->timer[i].virtual_irq =
> +				map_gt_gsi(frame->virtual_timer_interrupt,
> +					   frame->virtual_timer_flags);
> +			if (data->timer[i].virtual_irq <= 0)
> +				return -EINVAL;

Likewise, a message here would be useful, e.g.

	pr_warn("failed to map GTDT frame %d, virtual timer interrupt\n",
		i);

> +		}
> +
> +		data->timer[i].frame_nr = frame->frame_number;
> +		data->timer[i].cntbase_phy = frame->base_address;

What about CntEL0BaseX?

> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Get the GT block info for memory-mapped timer from GTDT table.
> + */
> +int __init gtdt_arch_timer_mem_init(struct gt_block_data *data)
> +{
> +	void *platform_timer;
> +	int index = 0;
> +	int ret;
> +
> +	for_each_platform_timer(platform_timer) {
> +		if (!is_timer_block(platform_timer))
> +			continue;
> +		ret = gtdt_parse_gt_block(platform_timer, data + index);
> +		if (ret)
> +			return ret;
> +		index++;
> +	}
> +
> +	if (index)
> +		pr_info("found %d memory-mapped timer block(s).\n", index);
> +
> +	return index;
> +}
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index 16dcd10..94a5d14 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -56,6 +56,8 @@ enum spi_nr {
>  #define ARCH_TIMER_MEM_PHYS_ACCESS	2
>  #define ARCH_TIMER_MEM_VIRT_ACCESS	3
>  
> +#define ARCH_TIMER_MEM_MAX_FRAME	8

Nit: please call this ARCH_TIMER_MEM_MAX_FRAMES, so it's clear that the
maximum index is 7.

>  #define ARCH_TIMER_USR_PCT_ACCESS_EN	(1 << 0) /* physical counter */
>  #define ARCH_TIMER_USR_VCT_ACCESS_EN	(1 << 1) /* virtual counter */
>  #define ARCH_TIMER_VIRT_EVT_EN		(1 << 2)
> @@ -71,6 +73,19 @@ struct arch_timer_kvm_info {
>  	int virtual_irq;
>  };
>  
> +struct gt_timer_data {

s/gt_timer_data/arch_timer_mem_frame/

> +	int frame_nr;
> +	phys_addr_t cntbase_phy;

Please get rid of the '_phy' suffix; it clashes with other terminology,
'phys' is generally preferable, and given the name and type it's obvious
that it's a physical address anyhow.

Just call this 'cntbase'.

> +	int irq;
> +	int virtual_irq;

Call these phys_irq and virt_irq.

> +};
> +
> +struct gt_block_data {

s/gt_block_data/arch_timer_mem/

> +	phys_addr_t cntctlbase_phy;

Same comment w.r.t. the '_phy' suffix. Likewise, just call this
'cntctlbase_phy'

> +	int timer_count;

s/timer_count/num_frames/

> +	struct gt_timer_data timer[ARCH_TIMER_MEM_MAX_FRAME];
> +};

Please split this part out into a patch which moves the existing driver
over to this new abstraction, *then* introduce the ACPI parser for it in
a subsequent patch.

Thanks,
Mark.
