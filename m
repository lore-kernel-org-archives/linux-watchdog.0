Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbdAPRv3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Jan 2017 12:51:29 -0500
Date: Mon, 16 Jan 2017 17:50:26 +0000
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
Subject: Re: [PATCH v19 06/15] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
Message-ID: <20170116175025.GJ5908@leverpostej>
References: <20161221064603.11830-1-fu.wei@linaro.org>
 <20161221064603.11830-7-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161221064603.11830-7-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Dec 21, 2016 at 02:45:54PM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> Currently, the counter frequency detection call(arch_timer_detect_rate)
> combines all the ways to get counter frequency: device-tree property,
> system coprocessor register, MMIO timer. But in the most of use cases,
> we don't need all the ways to try:
> For example, reading device-tree property will be needed only when
> system boot with device-tree, getting frequency from MMIO timer register
> will beneeded only when we init MMIO timer.
> 
> This patch separates paths to determine frequency:
> Separate out device-tree code, keep them in device-tree init function.

Splitting these out makes sense to me.

> Separate out the MMIO frequency and the sysreg frequency detection call,
> and use the appropriate one for the counter.

> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/clocksource/arm_arch_timer.c | 49 +++++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index c7b4482..9a1f138 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -488,27 +488,31 @@ static int arch_timer_starting_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> -static void
> -arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
> +static void arch_timer_detect_rate(void)
>  {
> -	/* Who has more than one independent system counter? */
> -	if (arch_timer_rate)
> -		return;
> +	/*
> +	 * Try to get the timer frequency from
> +	 * cntfrq_el0(system coprocessor register).
> +	 */
> +	if (!arch_timer_rate)
> +		arch_timer_rate = arch_timer_get_cntfrq();
> +
> +	/* Check the timer frequency. */
> +	if (!arch_timer_rate)
> +		pr_warn("frequency not available\n");
> +}
>  
> +static void arch_timer_mem_detect_rate(void __iomem *cntbase)
> +{
>  	/*
> -	 * Try to determine the frequency from the device tree or CNTFRQ,
> -	 * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
> +	 * Try to determine the frequency from
> +	 * CNTFRQ in memory-mapped timer.
>  	 */
> -	if (!acpi_disabled ||
> -	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
> -		if (cntbase)
> -			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
> -		else
> -			arch_timer_rate = arch_timer_get_cntfrq();
> -	}
> +	if (!arch_timer_rate)
> +		arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
>  
>  	/* Check the timer frequency. */
> -	if (arch_timer_rate == 0)
> +	if (!arch_timer_rate)
>  		pr_warn("frequency not available\n");
>  }

There's a subtle change in behaviour here. Previously for ACPI we'd only
ever use the sysreg CNTFRQ value for arch_timer_rate, whereas now we
might use the MMIO timer rate. Maybe that's not a big deal, but I will
need to think.

Generally, the logic to determine the rate is fairly gnarly regardless.

It would be nice if we could split the MMIO and sysreg rates entirely,
and kill the implicit relationship between the two, or at least make one
canonical and warn if the two differ.

Thanks,
Mark.
