Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764990AbdDSPHz (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Apr 2017 11:07:55 -0400
Date: Wed, 19 Apr 2017 16:07:25 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        marc.zyngier@arm.com, sudeep.holla@arm.com, hanjun.guo@linaro.org,
        linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org,
        al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com
Subject: Re: [PATCH v24 09/11] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
Message-ID: <20170419150725.GH27829@leverpostej>
References: <20170414184014.8524-1-fu.wei@linaro.org>
 <20170414184014.8524-10-fu.wei@linaro.org>
 <20170418172107.GA1401@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170418172107.GA1401@red-moon>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 18, 2017 at 06:21:07PM +0100, Lorenzo Pieralisi wrote:
> On Sat, Apr 15, 2017 at 02:40:12AM +0800, fu.wei@linaro.org wrote:

> > +error:
> > +	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
> > +		frame = &timer_mem->frame[i];
> > +		if (frame->phys_irq > 0)
> > +			acpi_unregister_irq(frame->phys_irq);
> > +		if (frame->virt_irq > 0)
> > +			acpi_unregister_irq(frame->virt_irq);
> > +	}
> 
> There are three error paths, none of them reset [i,gtdt_frame],
> correct ?

Correct.

> If yes, why can't it simply be written like this ?
> 
> for (; i >= 0; i--, gtdt_frame--) {
> 	frame = &timer_mem->frame[gtdt_frame->frame_number];
> 
> 	/* not sure this check is actually needed */
> 	if (gtdt_frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER)
> 		continue;
> 
> 	if (frame->phys_irq > 0)
> 		acpi_unregister_gsi(gtdt_frame->timer_interrupt);
> 	if (frame->virt_irq > 0)
> 		acpi_unregister_gsi(gtdt_frame->virtual_timer_interrupt);
> }

A reverse loop of this form will work.

That requires some restructuring, and care to avoid going out of bounds
instantaneously with the gtdt_frame--, so as to not invoke nasal demons.

I've attacked this locally, and will send this out after testing. I'll
drop the new ACPI API patch.

Thanks,
Mark.
