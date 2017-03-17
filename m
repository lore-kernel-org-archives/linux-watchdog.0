Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbdCQSKz (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Mar 2017 14:10:55 -0400
Date: Fri, 17 Mar 2017 18:07:26 +0000
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
Subject: Re: [PATCH v21 03/13] clocksource: arm_arch_timer: remove
 arch_timer_detect_rate
Message-ID: <20170317180725.GC15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-4-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206185015.12296-4-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 07, 2017 at 02:50:05AM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The original counter frequency detection call(arch_timer_detect_rate)
> include getting the frequency from the per-cpu arch-timer and the
> memory-mapped (MMIO) timer interfaces. But they will be needed only when
> the system initializes the relevant timer.
> 
> This patch remove arch_timer_detect_rate founction, and use the
> arch_timer_get_sysreg_freq and arch_timer_get_mmio_freq directly.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

Could you please fold this with the prior patch?

> @@ -1087,7 +1072,12 @@ static int __init arch_timer_mem_init(struct device_node *np)
>  	 */
>  	if (!arch_timer_rate &&
>  	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
> -		arch_timer_detect_rate(base);
> +		arch_timer_rate = arch_timer_get_mmio_freq(base);
> +	if (!arch_timer_rate) {
> +		pr_err(FW_BUG "frequency not available for MMIO timer.\n");

It would be better to say "MMIO frequency not available.\n" here.

Thanks,
Mark.
