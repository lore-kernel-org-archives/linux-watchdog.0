Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932913AbdDESnA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Apr 2017 14:43:00 -0400
Date: Wed, 5 Apr 2017 19:42:30 +0100
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
Subject: Re: [PATCH v23 06/11] clocksource: arm_arch_timer: refactor MMIO
 timer probing.
Message-ID: <20170405184229.GA29338@leverpostej>
References: <20170331175105.8370-1-fu.wei@linaro.org>
 <20170331175105.8370-7-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331175105.8370-7-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Apr 01, 2017 at 01:51:00AM +0800, fu.wei@linaro.org wrote:
> +	arch_timer_mem_freq = arch_timer_mem_get_cntfrq(base);
> +	if (!arch_timer_rate && arch_timer_mem_freq) {
> +		arch_timer_rate = arch_timer_mem_freq;
> +	} else if (!arch_timer_rate || arch_timer_rate != arch_timer_mem_freq) {
> +		pr_err(FW_BUG "invalid MMIO frequency.\n");
> +		iounmap(base);
> +		return -EINVAL;
> +	}

I thought I had previously mentioned that this last check has the
potential to break DT systems, which may be inadvertently relying on the
probe order.

I agree we must do this check for ACPI, but I think that for DT it needs
to be relaxed.

I'm happy to rework that locally, if you can address my comments on
patch 9.

Thanks,
Mark.
