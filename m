Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752394AbdDFRYk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Apr 2017 13:24:40 -0400
Date: Thu, 6 Apr 2017 18:24:10 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Fu Wei <fu.wei@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        G Gregory <graeme.gregory@linaro.org>,
        Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>,
        Wei Huang <wei@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Leo Duran <leo.duran@amd.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tomasz Nowicki <tn@semihalf.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH v23 09/11] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
Message-ID: <20170406172410.GA11871@leverpostej>
References: <20170331175105.8370-1-fu.wei@linaro.org>
 <20170331175105.8370-10-fu.wei@linaro.org>
 <20170405183808.GB27550@leverpostej>
 <CADyBb7sz6ongbyqR0FzBZybJBYwnLvqV+NsX1+W=6tv0_vLt1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7sz6ongbyqR0FzBZybJBYwnLvqV+NsX1+W=6tv0_vLt1g@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Apr 07, 2017 at 12:47:47AM +0800, Fu Wei wrote:
> On 6 April 2017 at 02:38, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Sat, Apr 01, 2017 at 01:51:03AM +0800, fu.wei@linaro.org wrote:
> >> +     /*
> >> +      * Get the GT timer Frame data for every GT Block Timer
> >> +      */
> >> +     for (i = 0; i < block->timer_count; i++, gtdt_frame++) {
> >> +             if (gtdt_frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER)
> >> +                     continue;
> >> +
> >> +             if (!gtdt_frame->base_address || !gtdt_frame->timer_interrupt)
> >> +                     goto error;
> >> +
> >> +             frame = &timer_mem->frame[gtdt_frame->frame_number];
> >> +             frame->phys_irq = map_gt_gsi(gtdt_frame->timer_interrupt,
> >> +                                          gtdt_frame->timer_flags);
> >> +             if (frame->phys_irq <= 0) {
> >> +                     pr_warn("failed to map physical timer irq in frame %d.\n",
> >> +                             gtdt_frame->frame_number);
> >> +                     goto error;
> >> +             }
> >> +
> >> +             if (gtdt_frame->virtual_timer_interrupt) {
> >> +                     frame->virt_irq =
> >> +                             map_gt_gsi(gtdt_frame->virtual_timer_interrupt,
> >> +                                        gtdt_frame->virtual_timer_flags);
> >> +                     if (frame->virt_irq <= 0) {
> >> +                             pr_warn("failed to map virtual timer irq in frame %d.\n",
> >> +                                     gtdt_frame->frame_number);
> >> +                             acpi_unregister_gsi(gtdt_frame->timer_interrupt);
> >> +                             goto error;
> >> +                     }
> >> +             } else {
> >> +                     frame->virt_irq = 0;
> >> +                     pr_debug("virtual timer in frame %d not implemented.\n",
> >> +                              gtdt_frame->frame_number);
> >> +             }
> >> +
> >> +             frame->cntbase = gtdt_frame->base_address;
> >> +             /*
> >> +              * The CNTBaseN frame is 4KB (register offsets 0x000 - 0xFFC).
> >> +              * See ARM DDI 0487A.k_iss10775, page I1-5130, Table I1-4
> >> +              * "CNTBaseN memory map".
> >> +              */
> >> +             frame->size = SZ_4K;
> >> +             frame->valid = true;
> >> +     }
> >> +
> >> +     return 0;
> >> +
> >> +error:
> >> +     for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
> >> +             frame = &timer_mem->frame[i];
> >> +             if (!frame->valid)
> >> +                     continue;
> >> +             irq_dispose_mapping(frame->phys_irq);
> >> +             if (frame->virt_irq)
> >> +                     irq_dispose_mapping(frame->virt_irq);
> >> +     }
> >
> > We assign interrupts and may goto error before setting valid, so here we
> 
> yes, I mean to do it.(setting valid at the end of loop)
> 
> > won't free the interrupts of the last frame we parsed.
> 
> that won't  be a problem, we may assign two interrupts in a round:
> First of all, if  the assignment goes  wrong, that means the current
> interrupt haven't been successfully assigned.
> (1)if the first goes wrong, the we goto error to unwind  the irqs
> assigned in previous rounds.
> (2)if the second one goes wrong , we acpi_unregister_gsi the first one
> and then  goto error to unwind  the irqs assigned in previous rounds.
> (3)If the two assignments are successful, set up valid flag
> 
> So we won't miss freeing the interrupts of the last frame we parsed.
> 
> Did I miss something?

No; you are correct, and I was mistaken.

However, I would prefer to simplify this such that we only free the
IRQs in the error path.

We should be able to iterate over all freams, freeing any non-zero
interrupt, since !valid frames shouldn't have non-zero interrupts.

I can make that update locally; no need to respin.

Thanks,
Mark.
