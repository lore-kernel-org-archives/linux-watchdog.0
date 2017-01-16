Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdAPSbq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Jan 2017 13:31:46 -0500
Date: Mon, 16 Jan 2017 18:30:32 +0000
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
Subject: Re: [PATCH v19 10/15] clocksource/drivers/arm_arch_timer: Refactor
 the timer init code to prepare for GTDT
Message-ID: <20170116183032.GL5908@leverpostej>
References: <20161221064603.11830-1-fu.wei@linaro.org>
 <20161221064603.11830-11-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161221064603.11830-11-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Dec 21, 2016 at 02:45:58PM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The patch refactor original memory-mapped timer init code:
>     (1) Refactor "arch_timer_mem_init", make it become a common code for
>         memory-mapped timer init.
>     (2) Add a new function "arch_timer_mem_of_init" for DT init.

As a general note, please write proper commit messages, describing what
the problem is, and why we are making the changes. These bullet points
don't add anything to what can be derived from a glance at the code.

For this patch, you can use:

  clocksource: arm_arch_timer: refactor MMIO timer probing

  Currently the code to probe MMIO architected timers mixes DT parsing
  with actual poking of hardware. This makes the code harder than
  necessary to understand, and makes it difficult to add support for
  probing via ACPI.

  This patch factors all the DT-specific logic out of
  arch_timer_mem_init(), into a new function, arch_timer_mem_of_init().
  The former pokes the hardware and determines the suitablility of
  frames based on a datastructure populated by the latter.

  This cleanly separates the two and will make it possible to add
  probing using the ACPI GTDT in subsequent patches.

[...]

> +	for_each_available_child_of_node(np, frame_node) {
> +		int n;
> +		struct arch_timer_mem_frame *frame = &timer_mem->frame[i];
> +
> +		if (of_property_read_u32(frame_node, "frame-number", &n)) {
> +			pr_err("Missing frame-number\n");
> +			of_node_put(frame_node);
> +			goto out;
> +		}
> +		frame->frame_nr = n;
> +
> +		if (of_address_to_resource(frame_node, 0, &res)) {
> +			of_node_put(frame_node);
> +			goto out;
> +		}
> +		frame->cntbase = res.start;
> +		frame->size = resource_size(&res);
> +
> +		frame->virt_irq = irq_of_parse_and_map(frame_node,
> +						       ARCH_TIMER_VIRT_SPI);
> +		frame->phys_irq = irq_of_parse_and_map(frame_node,
> +						       ARCH_TIMER_PHYS_SPI);
>  
> -	if (!arch_timer_needs_of_probing())
> +		if (++i >= ARCH_TIMER_MEM_MAX_FRAMES)
> +			break;
> +	}

It would be good if we could warn upon seeing more than
ARCH_TIMER_MEM_MAX_FRAMES children, since that's obviously an error.

Thanks,
Mark.
