Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754148AbcJULVz (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 21 Oct 2016 07:21:55 -0400
Date: Fri, 21 Oct 2016 12:21:20 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: fu.wei@linaro.org
Cc: linaro-acpi@lists.linaro.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        julien.grall@arm.com, wei@redhat.com, lorenzo.pieralisi@arm.com,
        al.stone@linaro.org, tn@semihalf.com, timur@codeaurora.org,
        daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org,
        linux@roeck-us.net, lenb@kernel.org, harba@codeaurora.org,
        linux-watchdog@vger.kernel.org, arnd@arndb.de,
        marc.zyngier@arm.com, jcm@redhat.com, sudeep.holla@arm.com,
        cov@codeaurora.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, graeme.gregory@linaro.org,
        rjw@rjwysocki.net, rruigrok@codeaurora.org, leo.duran@amd.com,
        hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com,
        wim@iguana.be, christoffer.dall@linaro.org
Subject: Re: [PATCH v14 5/9] clocksource/drivers/arm_arch_timer: Simplify
 ACPI support code.
Message-ID: <20161021112120.GC16630@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-6-git-send-email-fu.wei@linaro.org>
 <20161020165747.GD27598@leverpostej>
 <20161021111352.GA16630@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161021111352.GA16630@leverpostej>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 21, 2016 at 12:14:01PM +0100, Mark Rutland wrote:
> On Thu, Oct 20, 2016 at 05:58:17PM +0100, Mark Rutland wrote:
> > On Thu, Sep 29, 2016 at 02:17:13AM +0800, fu.wei@linaro.org wrote:
> > > +	arch_timer_ppi[PHYS_NONSECURE_PPI] = acpi_gtdt_map_ppi(PHYS_NONSECURE_PPI);
> > > +	arch_timer_ppi[VIRT_PPI] = acpi_gtdt_map_ppi(VIRT_PPI);
> > > +	arch_timer_ppi[HYP_PPI] = acpi_gtdt_map_ppi(HYP_PPI);
> > > +	/* Always-on capability */
> > > +	arch_timer_c3stop = acpi_gtdt_c3stop();
> > 
> > ... I think we should check the flag on the relevant interrupt, though
> > that's worth clarifying.
> 
> I see I misread the spec; this is part of the common flags.
> 
> Please ignore this point; sorry for the noise.

Actually, I misread the spec this time around; the flag *can* differ per
interrupt for the sysreg/cp15 timer, but not for the MMIO timers where
the flag is in a common field.

So please *do* consider the above.

Thanks,
Mark.
