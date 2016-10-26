Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932174AbcJZPqw (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Oct 2016 11:46:52 -0400
Date: Wed, 26 Oct 2016 16:46:15 +0100
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
Subject: Re: [PATCH v14 7/9] clocksource/drivers/arm_arch_timer: Refactor the
 timer init code to prepare for GTDT
Message-ID: <20161026154608.GB22713@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-8-git-send-email-fu.wei@linaro.org>
 <20161021113213.GD16630@leverpostej>
 <CADyBb7sJfY4=5NKKPGosOGv4sq4Tg2_TBW-XbWYoqfz4JNE-LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7sJfY4=5NKKPGosOGv4sq4Tg2_TBW-XbWYoqfz4JNE-LA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 26, 2016 at 11:24:32PM +0800, Fu Wei wrote:
> On 21 October 2016 at 19:32, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Sep 29, 2016 at 02:17:15AM +0800, fu.wei@linaro.org wrote:
> >> +static int __init arch_timer_mem_register(struct device_node *np, void *frame)
> >>  {
> >> -     int ret;
> >> -     irq_handler_t func;
> >> +     struct device_node *frame_node = NULL;
> >>       struct arch_timer *t;
> >> +     void __iomem *base;
> >> +     irq_handler_t func;
> >> +     unsigned int irq;
> >> +     int ret;
> >> +
> >> +     if (!frame)
> >> +             return -EINVAL;
> >
> > Why would we call this without a frame?
> 
> Sorry, I just verify it , make sure frame is not NULL,
> Because it is a "static" function, so we do need this check?

I'd rather we simply don't call the function rather than passing a NULL
frame in.

> >> +
> >> +     if (np) {
> >
> > ... or without a node?
> 
> For "np", for now, we just  just verify it, but it is just paperation
> for GTDT support,
> Because in next patch, if np == NULL, that means we call this function
> from GTDT, but not DT.

Please don't do that. More on that below.

> > Please as Marc requested several versions ago: split the FW parsing
> > (ACPI and DT) so that happens first, *then* once we have the data in a
> > common format, use that to drive poking the HW, requesting IRQs, etc,
> > completely independent of the source.
> >
> > In patches, do this by:
> >
> > (1) adding the data structures
> > (2) splitting the existing DT probing to use them
> > (3) Adding ACPI functionality atop
> 
> this patch is a preparation for GTDT support, I have splitted some
> functions for reusing them in next patch(GTDT support)
> 
> if np == NULL, that means we call this function from GTDT, but
> if np != NULL, that means we call this function from DT

As above, please structure the patches such that that never happens.

We currently have:

+--------------------------+
| DT Parsing + Common code |
+--------------------------+

Per (1 and 2) make this:

+------------+                       +-------------+
| DT parsing |--(common structure)-->| Common code |
+------------+                       +-------------+

Then per (3) make this:

+------------+                       
| DT parsing |--(common structure)------+
+------------+                          |
                                        v
                                    +-------------+
                                    | Common code |
                                    +-------------+
                                        ^
+--------------+                        |
| ACPI parsing |--(common structure)----+
+--------------+

Thanks,
Mark.
