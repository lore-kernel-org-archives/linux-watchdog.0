Return-path: <mark.rutland@arm.com>
Date: Thu, 20 Oct 2016 17:58:17 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: fu.wei@linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com,
	sudeep.holla@arm.com, hanjun.guo@linaro.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, graeme.gregory@linaro.org,
	al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
	catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org, tn@semihalf.com,
	christoffer.dall@linaro.org, julien.grall@arm.com
Subject: Re: [PATCH v14 5/9] clocksource/drivers/arm_arch_timer: Simplify
 ACPI support code.
Message-ID: <20161020165747.GD27598@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-6-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475086637-1914-6-git-send-email-fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Sep 29, 2016 at 02:17:13AM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The patch update arm_arch_timer driver to use the function
> provided by the new GTDT driver of ACPI.
> By this way, arm_arch_timer.c can be simplified, and separate
> all the ACPI GTDT knowledge from this timer driver.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

This generally looks fine, but:

> +	arch_timer_ppi[PHYS_SECURE_PPI] = acpi_gtdt_map_ppi(PHYS_SECURE_PPI);

As mentioned on the prior patch, I think we shouldn't bother parsing the
secure interrupt, given the problem with the GSIV, and the fact that we
shouldn't need it in Linux.

> +	arch_timer_ppi[PHYS_NONSECURE_PPI] = acpi_gtdt_map_ppi(PHYS_NONSECURE_PPI);
> +	arch_timer_ppi[VIRT_PPI] = acpi_gtdt_map_ppi(VIRT_PPI);
> +	arch_timer_ppi[HYP_PPI] = acpi_gtdt_map_ppi(HYP_PPI);
> +	/* Always-on capability */
> +	arch_timer_c3stop = acpi_gtdt_c3stop();

... I think we should check the flag on the relevant interrupt, though
that's worth clarifying.

>  
> -	/* Always-on capability */
> -	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
> +	if (timer_count < 0)
> +		pr_err("Failed to get platform timer info.\n");

Why don't we log this in the code that would try to initialise the MMIO
timer? We can still fail after this.

Thanks,
Mark.
