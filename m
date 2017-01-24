Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbdAXRZG (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 24 Jan 2017 12:25:06 -0500
Date: Tue, 24 Jan 2017 17:24:00 +0000
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
Subject: Re: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
Message-ID: <20170124172400.GG7572@leverpostej>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-9-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118132541.8989-9-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 18, 2017 at 09:25:32PM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The counter frequency detection call(arch_timer_detect_rate) combines two
> ways to get counter frequency: system coprocessor register and MMIO timer.
> But in a specific timer init code, we only need one way to try:
> getting frequency from MMIO timer register will be needed only when we
> init MMIO timer; getting frequency from system coprocessor register will
> be needed only when we init arch timer.

When I mentioned this splitting before, I had mean that we'd completely
separate the two, with separate mmio_rate and sysreg_rate variables.

The probing logic relying on this is complicated and fragile, and I
think these patches are complicating that further (though I appreciate
that's far from the intent).

I believe we need to split the MMIO and sysreg timer code apart
entirely. I've had a look at that today, though it's been fairly painful
so far. It appears some platforms may inadvertently be relying on the
order and manner in which the rates are probed, which is a major
headache.

I will try to attack that some more tomorrow.

> This patch separates paths to determine frequency:
> Separate out the MMIO frequency and the sysreg frequency detection call,
> and use the appropriate one for the counter.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 40 ++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 6484f84..9482481 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -488,23 +488,33 @@ static int arch_timer_starting_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> -static void arch_timer_detect_rate(void __iomem *cntbase)
> +static void __arch_timer_determine_rate(u32 rate)
>  {
> -	/* Who has more than one independent system counter? */
> -	if (arch_timer_rate)
> -		return;
> +	/* Check the timer frequency. */
> +	if (!arch_timer_rate) {
> +		if (rate)
> +			arch_timer_rate = rate;
> +		else
> +			pr_warn("frequency not available\n");
> +	} else if (rate && arch_timer_rate != rate) {
> +		pr_warn("got different frequency, keep original.\n");
> +	}
> +}

This function should be killed off entirely. We need to be able to fail
the probe if we cannot determine the rate, and that means we need error
handling in the ACPI and DT cases anyway.

Thanks,
Mark.
