Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbdAPRaq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Jan 2017 12:30:46 -0500
Date: Mon, 16 Jan 2017 17:29:28 +0000
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
Subject: Re: [PATCH v19 05/15] clocksource/drivers/arm_arch_timer: rework PPI
 determination
Message-ID: <20170116172927.GI5908@leverpostej>
References: <20161221064603.11830-1-fu.wei@linaro.org>
 <20161221064603.11830-6-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161221064603.11830-6-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Dec 21, 2016 at 02:45:53PM +0800, fu.wei@linaro.org wrote:
[...]

> -	if (is_hyp_mode_available() || !arch_timer_ppi[ARCH_TIMER_VIRT_PPI]) {
> -		bool has_ppi;
> +	if (is_hyp_mode_available() && is_kernel_in_hyp_mode())
> +		return ARCH_TIMER_HYP_PPI;
>  
> -		if (is_kernel_in_hyp_mode()) {
> -			arch_timer_uses_ppi = ARCH_TIMER_HYP_PPI;
> -			has_ppi = !!arch_timer_ppi[ARCH_TIMER_HYP_PPI];
> -		} else {
> -			arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
> -			has_ppi = (!!arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI] ||
> -				   !!arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
> -		}
> +	if (arch_timer_ppi[ARCH_TIMER_VIRT_PPI])
> +		return ARCH_TIMER_VIRT_PPI;
>  
> -		if (!has_ppi) {
> -			pr_warn("No interrupt available, giving up\n");
> -			return -EINVAL;
> -		}
> -	}
> +	if (IS_ENABLED(CONFIG_ARM64))
> +		return ARCH_TIMER_PHYS_NONSECURE_PPI;
> +
> +	return ARCH_TIMER_PHYS_SECURE_PPI;

For a 32-bit platform booted at hyp (with a virt PPI available), the new
logic will select ARCH_TIMER_VIRT_PPI. I beleive that will break KVM.

I think the logic should be:

	if (is_kernel_in_hyp_mode())
		return ARCH_TIMER_HYP_PPI;

	if (!is_hyp_mode_available() &&
	    arch_timer_ppi[ARCH_TIMER_VIRT_PPI])
	    	return ARCH_TIMER_VIRT_PPI;
	
	if (IS_ENABLED(CONFIG_ARM64))
		return ARCH_TIMER_PHYS_NONSECURE_PPI;
	
	return ARCH_TIMER_PHYS_SECURE_PPI;

Please use that instead (keeping the comment you retained).

> +static int __init arch_timer_init(void)
> +{
> +	int ret;
>  
>  	ret = arch_timer_register();
>  	if (ret)
> @@ -904,6 +906,13 @@ static int __init arch_timer_of_init(struct device_node *np)
>  	if (IS_ENABLED(CONFIG_ARM) &&
>  	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
>  		arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
> +	else
> +		arch_timer_uses_ppi = arch_timer_select_ppi();
> +
> +	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
> +		pr_err("No interrupt available, giving up\n");
> +		return -EINVAL;
> +	}
>  
>  	/* On some systems, the counter stops ticking when in suspend. */
>  	arch_counter_suspend_stop = of_property_read_bool(np,
> @@ -1049,6 +1058,12 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>  	/* Get the frequency from CNTFRQ */
>  	arch_timer_detect_rate(NULL, NULL);
>  
> +	arch_timer_uses_ppi = arch_timer_select_ppi();
> +	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
> +		pr_err("No interrupt available, giving up\n");
> +		return -EINVAL;
> +	}

I see that we have to duplicate this so we can special-case the
DT-specific behaviour, so that's fine by me.

If you can fix the arch_timer_select_ppi() logic as above, this should
be fine.

Thanks,
Mark.
