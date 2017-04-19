Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937792AbdDSPzx (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Apr 2017 11:55:53 -0400
Date: Wed, 19 Apr 2017 16:56:27 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linaro-acpi@lists.linaro.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rruigrok@codeaurora.org, wim@iguana.be,
        fu.wei@linaro.org, wei@redhat.com, al.stone@linaro.org,
        tn@semihalf.com, timur@codeaurora.org, daniel.lezcano@linaro.org,
        linux-acpi@vger.kernel.org, linux@roeck-us.net, lenb@kernel.org,
        harba@codeaurora.org, julien.grall@arm.com,
        linux-watchdog@vger.kernel.org, arnd@arndb.de,
        marc.zyngier@arm.com, jcm@redhat.com, cov@codeaurora.org,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        graeme.gregory@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, leo.duran@amd.com,
        hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com,
        sudeep.holla@arm.com, christoffer.dall@linaro.org
Subject: Re: [PATCH v24 09/11] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
Message-ID: <20170419155627.GA9439@red-moon>
References: <20170414184014.8524-1-fu.wei@linaro.org>
 <20170414184014.8524-10-fu.wei@linaro.org>
 <20170418172107.GA1401@red-moon>
 <20170419150725.GH27829@leverpostej>
 <20170419154554.GJ27829@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170419154554.GJ27829@leverpostej>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Apr 19, 2017 at 04:45:54PM +0100, Mark Rutland wrote:
> On Wed, Apr 19, 2017 at 04:07:25PM +0100, Mark Rutland wrote:
> > On Tue, Apr 18, 2017 at 06:21:07PM +0100, Lorenzo Pieralisi wrote:
> > > On Sat, Apr 15, 2017 at 02:40:12AM +0800, fu.wei@linaro.org wrote:
>  
> > > If yes, why can't it simply be written like this ?
> > > 
> > > for (; i >= 0; i--, gtdt_frame--) {
> > > 	frame = &timer_mem->frame[gtdt_frame->frame_number];
> > > 
> > > 	/* not sure this check is actually needed */
> > > 	if (gtdt_frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER)
> > > 		continue;
> > > 
> > > 	if (frame->phys_irq > 0)
> > > 		acpi_unregister_gsi(gtdt_frame->timer_interrupt);
> > > 	if (frame->virt_irq > 0)
> > > 		acpi_unregister_gsi(gtdt_frame->virtual_timer_interrupt);
> > > }
> > 
> > A reverse loop of this form will work.
> > 
> > That requires some restructuring, and care to avoid going out of bounds
> > instantaneously with the gtdt_frame--, so as to not invoke nasal demons.
> > 
> > I've attacked this locally, and will send this out after testing. I'll
> > drop the new ACPI API patch.
> 
> FWIW, I've set this up so the cleanup path is:
> 
> do {
>         if (gtdt_frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER ||
>             gtdt_frame->frame_number >= ARCH_TIMER_MEM_MAX_FRAMES)
>                 continue;
> 
>         frame = &timer_mem->frame[gtdt_frame->frame_number];
> 
>         if (frame->phys_irq > 0)
>                 acpi_unregister_gsi(gtdt_frame->timer_interrupt);
>         frame->phys_irq = 0;
> 
>         if (frame->virt_irq > 0)
>                 acpi_unregister_gsi(gtdt_frame->virtual_timer_interrupt);
>         frame->virt_irq = 0;
> } while (i-- >= 0 && gtdt_frame--);
> 
> ... the zeroing is to account for duplicate frames, which I now check for in
> the probe path (as we do for DT).
> 
> Can I take it per your comment on the prior version that with this change I can
> take your ack?

Yes, thanks for fixing it up, please add my:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> I also assume that you're happy for all of the drivers/acpi/arm64/ patches in the
> series to go via the clocksource tree?

Yes that's how I expect them to go upstream, that's the simplest way.

Thanks !
Lorenzo
