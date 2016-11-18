Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751965AbcKRT5m (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 18 Nov 2016 14:57:42 -0500
Date: Fri, 18 Nov 2016 19:56:57 +0000
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
Subject: Re: [PATCH v16 08/15] clocksource/drivers/arm_arch_timer: Refactor
 arch_timer_needs_probing, and call it only if acpi disabled.
Message-ID: <20161118195657.GM1197@leverpostej>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-9-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479304148-2965-9-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 16, 2016 at 09:49:01PM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The patch refactor original arch_timer_needs_probing function:
>     (1) Separate out arch_timer_needs_probing from arch_timer_common_init,
>     and call it only if acpi disabled.
>     (2) Rename arch_timer_needs_probing to arch_timer_needs_of_probing.

Please write a real commit message.

> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index fe4e812..9ddc091 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -792,15 +792,28 @@ static const struct of_device_id arch_timer_mem_of_match[] __initconst = {
>  	{},
>  };
>  
> -static bool __init
> -arch_timer_needs_probing(int type, const struct of_device_id *matches)
> +static bool __init arch_timer_needs_of_probing(void)
>  {
>  	struct device_node *dn;
>  	bool needs_probing = false;
> +	unsigned int mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
> +
> +	/* We have two timers, and both device-tree nodes are probed. */
> +	if ((arch_timers_present & mask) == mask)
> +		return false;
> +
> +	/*
> +	 * Only one type of timer is probed,
> +	 * check if we have another type of timer node in device-tree.
> +	 */
> +	if (arch_timers_present & ARCH_TIMER_TYPE_CP15)
> +		dn = of_find_matching_node(NULL, arch_timer_mem_of_match);
> +	else
> +		dn = of_find_matching_node(NULL, arch_timer_of_match);
>  
> -	dn = of_find_matching_node(NULL, matches);
> -	if (dn && of_device_is_available(dn) && !(arch_timers_present & type))
> +	if (dn && of_device_is_available(dn))
>  		needs_probing = true;
> +
>  	of_node_put(dn);
>  
>  	return needs_probing;
> @@ -808,17 +821,8 @@ arch_timer_needs_probing(int type, const struct of_device_id *matches)
>  
>  static int __init arch_timer_common_init(void)
>  {
> -	unsigned int mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
> -
> -	/* Wait until both nodes are probed if we have two timers */
> -	if ((arch_timers_present & mask) != mask) {
> -		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_MEM,
> -					     arch_timer_mem_of_match))
> -			return 0;
> -		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_CP15,
> -					     arch_timer_of_match))
> -			return 0;
> -	}

Why can't we just move this into the DT-specific caller of
arch_timer_common_init()?

Thanks
Mark.

> +	if (acpi_disabled && arch_timer_needs_of_probing())
> +		return 0;
>  
>  	arch_timer_banner(arch_timers_present);
>  	arch_counter_register(arch_timers_present);
> -- 
> 2.7.4
> 
