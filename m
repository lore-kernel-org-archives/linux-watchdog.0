Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752175AbdC2PYc (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Mar 2017 11:24:32 -0400
Date: Wed, 29 Mar 2017 16:24:08 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org,
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
Subject: Re: [PATCH v22 03/11] clocksource: arm_arch_timer: refactor
 arch_timer_needs_probing
Message-ID: <20170329152408.GM23442@leverpostej>
References: <20170321163122.9183-1-fu.wei@linaro.org>
 <20170321163122.9183-4-fu.wei@linaro.org>
 <20170328150220.GF2123@mai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170328150220.GF2123@mai>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Mar 28, 2017 at 05:02:20PM +0200, Daniel Lezcano wrote:
> On Wed, Mar 22, 2017 at 12:31:14AM +0800, fu.wei@linaro.org wrote:
> > From: Fu Wei <fu.wei@linaro.org>
> > 
> > When system init with device-tree, we don't know which node will be
> > initialized first. And the code in arch_timer_common_init should wait
> > until per-cpu timer and MMIO timer are both initialized. So we need
> > arch_timer_needs_probing to detect the init status of system.
> > 
> > But currently the code is dispersed in arch_timer_needs_probing and
> > arch_timer_common_init. And the function name doesn't specify that
> > it's only for device-tree. This is somewhat confusing.
> 
> Can the following patch help you to solve nicely the situation ?
> 
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1360007.html

This does not help.

The needs_probing logic is all there to bodge around a problem with
registering sched_clock, when you have two sources of the same
frequency, but one is otherwise better.

The sysreg clocksource has much lower latency than the MMIO clocksource,
so we always want to use that as the sched_clock if we have it.
Currently, the code ensures this by deferring registration of
sched_clock.

Ideally, we'd figure that out dynamically, or we'd have a rating
argument.

Thanks,
Mark.
