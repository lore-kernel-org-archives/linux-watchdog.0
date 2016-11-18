Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752234AbcKRTx3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 18 Nov 2016 14:53:29 -0500
Date: Fri, 18 Nov 2016 19:52:45 +0000
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
Subject: Re: [PATCH v16 07/15] clocksource/drivers/arm_arch_timer: Refactor
 arch_timer_detect_rate to keep dt code in *_of_init
Message-ID: <20161118195244.GL1197@leverpostej>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-8-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479304148-2965-8-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 16, 2016 at 09:49:00PM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The patch refactor original arch_timer_detect_rate function:
>     (1) Separate out device-tree code, keep them in device-tree init
>     function:
>         arch_timer_of_init,
>         arch_timer_mem_init;

Please write a real commit message.

>     (2) Improve original mechanism, if getting from memory-mapped timer
>     fail, try arch_timer_get_cntfrq() again.

This is *not* a refactoring. It's completely unrelated to the supposed
refactoring from point (1), and if necessary, should be a separate
patch.

*Why* are you maknig this change? Does some ACPI platform have an MMIO
timer with an ill-configured CNTFRQ register? If so, report that to the
vendor. Don't add yet another needless bodge.

I'd really like to split the MMIO and CP15 timers, and this is yet
another hack that'll make it harder to do so.

> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 45 +++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index af22953..fe4e812 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -487,27 +487,31 @@ static int arch_timer_starting_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> -static void
> -arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
> +static void arch_timer_detect_rate(void __iomem *cntbase)
>  {
>  	/* Who has more than one independent system counter? */
>  	if (arch_timer_rate)
>  		return;
> -
>  	/*
> -	 * Try to determine the frequency from the device tree or CNTFRQ,
> -	 * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
> +	 * If we got memory-mapped timer(cntbase != NULL),
> +	 * try to determine the frequency from CNTFRQ in memory-mapped timer.
>  	 */

*WHY* ?

If we're sharing arch_timer_rate across MMIO and sysreg timers, the
sysreg value is alreayd sufficient.

If we're not, they should be completely independent.

> -	if (!acpi_disabled ||
> -	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
> -		if (cntbase)
> -			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
> -		else
> -			arch_timer_rate = arch_timer_get_cntfrq();
> -	}
> +	if (cntbase)
> +		arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
> +	/*
> +	 * Because in a system that implements both Secure and
> +	 * Non-secure states, CNTFRQ is only accessible in Secure state.

That's true for the CNTCTLBase frame, but that doesn't matter.

The CNTBase<n> frames should have a readable CNTFRQ.

> +	 * So the operation above may fail, even if (cntbase != NULL),
> +	 * especially on ARM64.
> +	 * In this case, we can try cntfrq_el0(system coprocessor register).
> +	 */
> +	if (!arch_timer_rate)
> +		arch_timer_rate = arch_timer_get_cntfrq();
> +	else
> +		return;

Urrgh.

Please have separate paths to determine the MMIO frequency and the
sysreg frequency, and use the appropriate one for the counter you want
to know the frequency of.

Thanks,
Mark.
