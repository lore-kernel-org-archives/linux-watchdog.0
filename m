Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751126AbdCQTPs (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Mar 2017 15:15:48 -0400
Date: Fri, 17 Mar 2017 19:05:42 +0000
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
Subject: Re: [PATCH v21 04/13] clocksource: arm_arch_timer: split
 arch_timer_rate for different types of timer
Message-ID: <20170317190539.GD15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-5-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206185015.12296-5-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 07, 2017 at 02:50:06AM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> Currently, arch_timer_rate is used to store the frequency got from per-cpu
> arch-timer or the memory-mapped (MMIO) timers. But those values come from
> different registers which should all be initialized by firmware.
> 
> This patch remove arch_timer_rate, and use arch_timer_sysreg_freq and
> arch_timer_mmio_freq instead.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

Thanks for attacking this. Generally, I do think this is the right thing
to do.

However...

> @@ -1070,10 +1077,9 @@ static int __init arch_timer_mem_init(struct device_node *np)
>  	 * Try to determine the frequency from the device tree,
>  	 * if fail, get the frequency from the CNTFRQ reg of MMIO timer.
>  	 */
> -	if (!arch_timer_rate &&
> -	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
> -		arch_timer_rate = arch_timer_get_mmio_freq(base);
> -	if (!arch_timer_rate) {
> +	if (of_property_read_u32(np, "clock-frequency", &arch_timer_mmio_freq))
> +		arch_timer_mmio_freq = arch_timer_get_mmio_freq(base);
> +	if (!arch_timer_mmio_freq) {
>  		pr_err(FW_BUG "frequency not available for MMIO timer.\n");
>  		ret = -EINVAL;
>  		goto out;

... unfortunately, I believe that this will break some DT platforms that
have been (unintentionally) relying on the way currently allow the
frequency to be probed from either the MMIO timer or the sysreg timer.

So while the above was my suggestion, it was not my best.

For the timebeing, let's leave the single arch_timer_rate, but ensure
that it doesn't get in the way fo the ACPI code, by making the ACPI
probe path:

* Probe the sysreg timers first, using the sysreg cntfrq().

* Probe the MMIO timers second, verifying that each MMIO cntfrq matches
  the already-probed sysreg cntfrq.

... which is what I believe you suggested previously. 

Thanks,
Mark.
