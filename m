Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751953AbdC2QCN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Mar 2017 12:02:13 -0400
Date: Wed, 29 Mar 2017 17:02:36 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Fu Wei <fu.wei@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v22 07/11] acpi/arm64: Add GTDT table parse driver
Message-ID: <20170329160236.GB11297@red-moon>
References: <20170321163122.9183-1-fu.wei@linaro.org>
 <20170321163122.9183-8-fu.wei@linaro.org>
 <20170328113535.GA17440@red-moon>
 <CADyBb7v9jaiQjaWzwafkih_tsU+-hNi+TA7hcDbFgtLLChXM_g@mail.gmail.com>
 <20170329102118.GB10807@red-moon>
 <CADyBb7sDnp+p5Z=Cde-YS2UG8pxo9O=Tvkq8D79k37wOrUw19Q@mail.gmail.com>
 <20170329113305.GA10960@red-moon>
 <CADyBb7snT+fvZYDyjUW7ZCVLX-ha4VXYBhfZsi8a3wOeYtdHkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7snT+fvZYDyjUW7ZCVLX-ha4VXYBhfZsi8a3wOeYtdHkQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 29, 2017 at 09:42:39PM +0800, Fu Wei wrote:

[...]

> >> For calling acpi_gtdt_init() twice:
> >> (1) 1st time: in early boot(bootmem), for init arch_timer and
> >> memory-mapped timer, we initialize the acpi_gtdt_desc.
> >> you can see that all the items in this struct are pointer.
> >> (2) 2nd time: when system switch from bootmem to slab, all the
> >> pointers in the acpi_gtdt_desc are invalid, so we have to
> >> re-initialize(re-map) them.
> >>
> >> I have tested it, if we don't re-initialize  the acpi_gtdt_desc,
> >> system will go wrong.
> >
> > Ok, that's what I feared. My complaint on patch 11 is that:
> >
> > 1) Stashing the GTDT pointer in acpi_gtdt_desc is not needed to
> >    parse SBSA watchdogs
> 
> The acpi_gtdt_desc is for sharing the info between acpi_gtdt_init and
> acpi_gtdt_c3stop, ;acpi_gtdt_map_ppi
> I re-use it in parsing SBSA watchdogs, because I try to re-use acpi_gtdt_init.
> 
> > 2) It is not clear at all from the code or the commit log _why_ you
> >    need to call acpi_gtdt_init() again (ie technically you don't need
> >    to call it - you grab a valid pointer to the table and parse the
> >    watchdogs in the _same_ function gtdt_sbsa_gwdt_init())
> 
> yes, we can avoid calling acpi_gtdt_init(), do the same thing in
> parsing SBSA watchdogs info.
> But if we will do the same thing(getting gtdt, platform_timer,
> timer_count), why not just re-using the same function?

Because that's not trivial to understand why it is needed,
it actually isn't :). Anyway, instead of painting the bikeshed
let's add the comment below and be done with this.

> So my suggestion is that:
> Could we re-use acpi_gtdt_init, and a comment at the head of SBSA
> watchdogs info parsing function to summarize this issue?
> The comment like this
> 
> Note: although the global variable acpi_gtdt_desc has been initialized
> by acpi_gtdt_init, when we initialized arch_timer. But when we call this
> function to get SBSA watchdogs info from GTDT, the system has switch
> from bootmem  to slab, so the pointers in acpi_gtdt_desc are dated, we
> need to  re-initialize(remap) them. So we call acpi_gtdt_init again here.
"Note: Even though the global variable acpi_gtdt_desc has been
initialized by acpi_gtdt_init() while initializing the arch timers, when
we call this function to get SBSA watchdogs info from GTDT, the pointers
stashed in it are stale (since they are early temporary mappings carried
out before acpi_permanent_mmap is set) and we need to
re-initialize them with permanent mapped pointer values to let the
GTDT parsing possible".

I still think that if we write the code by omitting acpi_gtdt_init()
call (which does things that are completely useless for SBSA watchdog)
it becomes simpler and much easier to understand, up to you, either you
do it or I will at -rc1 ;-)

Lorenzo

> 
> 
> Is that OK for you? :-)
> 
> >
> > I do not think there is much you can do to improve the arch timer gtdt
> > interface (and it is too late for that anyway) but in patch 11 it would
> > be ideal if you avoid calling acpi_gtdt_init() again, just parse GTDT
> > entries and initialize the corresponding watchdogs (ie pointers stashed
> > in acpi_gtdt_desc are stale anyway but that's __initdata so I can live
> > with that).
> >
> > You should add comments to summarize this issue so that it can be
> > easily understood by anyone maintaining this code, it is not crystal
> > clear by reading the code why you need to multiple acpi_gtdt_init()
> > calls and that's not a piffling detail.
> >
> > The ACPI patches are fine with me otherwise, I will complete the
> > review shortly.
> >
> > Thanks !
> > Lorenzo
> 
> 
> 
> -- 
> Best regards,
> 
> Fu Wei
> Software Engineer
> Red Hat
