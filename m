Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbdCQSGG (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Mar 2017 14:06:06 -0400
Date: Fri, 17 Mar 2017 18:05:13 +0000
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
Subject: Re: [PATCH v21 01/13] clocksource: arm_arch_timer: introduce two
 functions to get the frequency from mmio and sysreg.
Message-ID: <20170317180513.GB15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-2-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206185015.12296-2-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 07, 2017 at 02:50:03AM +0800, fu.wei@linaro.org wrote:
> +static u32 arch_timer_get_sysreg_freq(void)
> +{
> +	/*
> +	 * Try to get the frequency from the CNTFRQ of sysreg.
> +	 */
> +	return arch_timer_get_cntfrq();
> +}

We already have arch_timer_get_cntfrq(), so I don't see the point in
this wrapper.

> +static u32 arch_timer_get_mmio_freq(void __iomem *cntbase)
> +{
> +	/*
> +	 * Try to get the frequency from the CNTFRQ of timer frame registers.
> +	 * Note: please verify cntbase in caller.
> +	 */
> +	return readl_relaxed(cntbase + CNTFRQ);
> +}

Wrapping the MMIO read makes sense if we're going to do this in more
than one place, so I'm happy with this wrapper.

If you can s/arch_timer_get_mmio_freq/arch_timer_get_cntfrq/, and drop
the comments, then this looks fine to me.

Thanks,
Mark.
