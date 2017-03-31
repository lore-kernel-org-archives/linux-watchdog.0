Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932882AbdCaLxp (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 31 Mar 2017 07:53:45 -0400
Date: Fri, 31 Mar 2017 12:54:03 +0100
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
Subject: Re: [PATCH v22 11/11] acpi/arm64: Add SBSA Generic Watchdog support
 in GTDT driver
Message-ID: <20170331115403.GB31763@red-moon>
References: <20170321163122.9183-1-fu.wei@linaro.org>
 <20170321163122.9183-12-fu.wei@linaro.org>
 <20170328154111.GC18046@red-moon>
 <CADyBb7uDyjhP2Pjtzh6pTN-0hkokB=KevY7V76G9qZOF-9-zoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7uDyjhP2Pjtzh6pTN-0hkokB=KevY7V76G9qZOF-9-zoQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 31, 2017 at 04:10:43PM +0800, Fu Wei wrote:

[...]

> >> +static int __init gtdt_sbsa_gwdt_init(void)
> >> +{
> >> +     int ret, i = 0;
> >> +     void *platform_timer;
> >> +     struct acpi_table_header *table;
> >> +
> >> +     if (acpi_disabled)
> >> +             return 0;
> >> +
> >> +     if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 0, &table)))
> >> +             return -EINVAL;
> >> +
> >> +     ret = acpi_gtdt_init(table, NULL);
> >> +     if (ret)
> >> +             return ret;
> >
> > Ok, I missed previous versions reviews so I miss the background
> > here and I apologise.
> >
> > I do not understand why you call acpi_gtdt_init() again (or better,
> > why acpi_gtdt_init() does not return straight away) here if the
> > stashed pointer in acpi_gtdt_desc is already set. I am not a big fan
> > of the for_each_platform_timer macro either, here you can just read
> > the ACPI_SIG_GTDT and parse its entries, I see no point in calling
> > acpi_gtdt_init() again, there is nothing to stash for later probing,
> > is there ?
> >
> > Or it is just to reuse common parsing code ? Regardless, if the
> > acpi_gtdt_desc struct is already initialized acpi_gtdt_init() should
> > just return or I am missing the point.
> >
> > I would like clarifications on the acpi_gtdt_init() call above please
> > (plus GSI unmap fix), apart from that:
> >
> > Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Actually, after the discussion in the 7th patch, I have tried to do
> this, see if that can make the code simpler.
> Then I found out that
> (1) If we would like to reuse "for_each_platform_timer" (and
> "next_platform_timer") to scan the GTDT for SBSA watchdog, we have to
> re-initialize acpi_gtdt_desc, too.
>      So we still need to explain that why we have to re-initialize
> acpi_gtdt_desc.
> (2) If we totally ignore acpi_gtdt_desc, and acpi_gtdt_init(), we
> can't re-use  "for_each_platform_timer" (and "next_platform_timer") .
> we have to re-write  the loop of scanning the GTDT for SBSA watchdog,

Or we get rid of for_each_platform_timer altogether that for me
is not useful at all and just obfuscates.

Anyway, add the comment below and you are done with this, at this point
in time it is best to avoid changing the code we'd just risk adding
bugs.

At -rc1 we will send patches to reshape this code as per this
discussion.

Thanks !
Lorenzo

> So may I suggest that maybe we can keep using acpi_gtdt_init, only add
> the comment to explain why we have to re-initialize
> acpi_gtdt_desc(Just what you have said in the 7th patch. Thanks for
> your correction for the comment, I will use that ), this way maybe can
> make the code simpler.
> 
> But If you still concern about this,  we still can discuss this at -rc1.
> 
> Great thanks for your help! :-)
> 
> >
> >> +     for_each_platform_timer(platform_timer) {
> >> +             if (is_non_secure_watchdog(platform_timer)) {
> >> +                     ret = gtdt_import_sbsa_gwdt(platform_timer, i);
> >> +                     if (ret)
> >> +                             break;
> >> +                     i++;
> >> +             }
> >> +     }
> >> +
> >> +     if (i)
> >> +             pr_info("found %d SBSA generic Watchdog(s).\n", i);
> >> +
> >> +     return ret;
> >> +}
> >> +
> >> +device_initcall(gtdt_sbsa_gwdt_init);
> >> --
> >> 2.9.3
> >>
> 
> 
> 
> -- 
> Best regards,
> 
> Fu Wei
> Software Engineer
> Red Hat
