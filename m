Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754095AbdDESie (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Apr 2017 14:38:34 -0400
Date: Wed, 5 Apr 2017 19:38:09 +0100
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
Subject: Re: [PATCH v23 09/11] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
Message-ID: <20170405183808.GB27550@leverpostej>
References: <20170331175105.8370-1-fu.wei@linaro.org>
 <20170331175105.8370-10-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331175105.8370-10-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

I tried to fix the issue that Lornzo raised, such that I could queue
these patches. From looking at this patch in more detail however, I
think there are further issues that need to be addressed.

On Sat, Apr 01, 2017 at 01:51:03AM +0800, fu.wei@linaro.org wrote:
> +	/*
> +	 * Get the GT timer Frame data for every GT Block Timer
> +	 */
> +	for (i = 0; i < block->timer_count; i++, gtdt_frame++) {
> +		if (gtdt_frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER)
> +			continue;
> +
> +		if (!gtdt_frame->base_address || !gtdt_frame->timer_interrupt)
> +			goto error;
> +
> +		frame = &timer_mem->frame[gtdt_frame->frame_number];
> +		frame->phys_irq = map_gt_gsi(gtdt_frame->timer_interrupt,
> +					     gtdt_frame->timer_flags);
> +		if (frame->phys_irq <= 0) {
> +			pr_warn("failed to map physical timer irq in frame %d.\n",
> +				gtdt_frame->frame_number);
> +			goto error;
> +		}
> +
> +		if (gtdt_frame->virtual_timer_interrupt) {
> +			frame->virt_irq =
> +				map_gt_gsi(gtdt_frame->virtual_timer_interrupt,
> +					   gtdt_frame->virtual_timer_flags);
> +			if (frame->virt_irq <= 0) {
> +				pr_warn("failed to map virtual timer irq in frame %d.\n",
> +					gtdt_frame->frame_number);
> +				acpi_unregister_gsi(gtdt_frame->timer_interrupt);
> +				goto error;
> +			}
> +		} else {
> +			frame->virt_irq = 0;
> +			pr_debug("virtual timer in frame %d not implemented.\n",
> +				 gtdt_frame->frame_number);
> +		}
> +
> +		frame->cntbase = gtdt_frame->base_address;
> +		/*
> +		 * The CNTBaseN frame is 4KB (register offsets 0x000 - 0xFFC).
> +		 * See ARM DDI 0487A.k_iss10775, page I1-5130, Table I1-4
> +		 * "CNTBaseN memory map".
> +		 */
> +		frame->size = SZ_4K;
> +		frame->valid = true;
> +	}
> +
> +	return 0;
> +
> +error:
> +	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
> +		frame = &timer_mem->frame[i];
> +		if (!frame->valid)
> +			continue;
> +		irq_dispose_mapping(frame->phys_irq);
> +		if (frame->virt_irq)
> +			irq_dispose_mapping(frame->virt_irq);
> +	}

We assign interrupts and may goto error before setting valid, so here we
won't free the interrupts of the last frame we parsed.

> +	return -EINVAL;
> +}
> +
> +/**
> + * acpi_arch_timer_mem_init() - Get the info of all GT blocks in GTDT table.
> + * @timer_mem:	The pointer to the array of struct arch_timer_mem for returning
> + *		the result of parsing. The element number of this array should
> + *		be platform_timer_count(the total number of platform timers).
> + * @timer_count: It points to a integer variable which is used for storing the
> + *		number of GT blocks we have parsed.
> + *
> + * Return: 0 if success, -EINVAL/-ENODEV if error.
> + */
> +int __init acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem,
> +				    int *timer_count)
> +{
> +	int ret;
> +	void *platform_timer;
> +
> +	*timer_count = 0;
> +	for_each_platform_timer(platform_timer) {
> +		if (is_timer_block(platform_timer)) {
> +			ret = gtdt_parse_timer_block(platform_timer, timer_mem);
> +			if (ret)
> +				return ret;
> +			timer_mem++;
> +			(*timer_count)++;
> +		}
> +	}

If we were to have multiple GT blocks, this would leave timer_mem in an
inconsistent state. In gtdt_parse_timer_block we'll blat any existing
timer_mem->cntctlbase, and blat some arbitrary set of frames. however,
*some* frames may have been held over from a previous iteration.

My understanding was that the system level timer had a single CNTCTLBase
frame, and hence we should only have a single GT block.

Judging by ARM DDI 0487A.k_iss10775, I1.3 "Memory-mapped timer
components" and I3.4 "Generic Timer memory-mapped registers overview",
it does appear that the system should only have one CNTCTLBase frame.

What's going on here?

Thanks,
Mark.
