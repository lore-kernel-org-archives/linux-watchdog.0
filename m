Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755116AbdC2KUz (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Mar 2017 06:20:55 -0400
Date: Wed, 29 Mar 2017 11:21:18 +0100
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
Message-ID: <20170329102118.GB10807@red-moon>
References: <20170321163122.9183-1-fu.wei@linaro.org>
 <20170321163122.9183-8-fu.wei@linaro.org>
 <20170328113535.GA17440@red-moon>
 <CADyBb7v9jaiQjaWzwafkih_tsU+-hNi+TA7hcDbFgtLLChXM_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7v9jaiQjaWzwafkih_tsU+-hNi+TA7hcDbFgtLLChXM_g@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 29, 2017 at 05:48:17PM +0800, Fu Wei wrote:

[...]

>  * @platform_timer_count: It points to a integer variable which is used
>  *                           for storing the number of platform timers.
>  *                           This pointer could be NULL, if the caller
>  *                           doesn't need this info.
> 
> >
> >> + *
> >> + * Return: 0 if success, -EINVAL if error.
> >> + */
> >> +int __init acpi_gtdt_init(struct acpi_table_header *table,
> >> +                       int *platform_timer_count)
> >> +{
> >> +     int ret = 0;
> >> +     int timer_count = 0;
> >> +     void *platform_timer = NULL;
> >> +     struct acpi_table_gtdt *gtdt;
> >> +
> >> +     gtdt = container_of(table, struct acpi_table_gtdt, header);
> >> +     acpi_gtdt_desc.gtdt = gtdt;
> >> +     acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
> >> +
> >> +     if (table->revision < 2)
> >> +             pr_warn("Revision:%d doesn't support Platform Timers.\n",
> >> +                     table->revision);
> >
> > Ok, two points here. First, I am not sure why you should warn if the
> > table revision is < 2, is that a FW bug ? I do not think it is, you
> > can just return 0.
> 
> I used pr_debug here before v20, then I got Hanjun's suggestion:
> -------
> GTDT table revision is updated to 2 in ACPI 5.1, we will
> not support ACPI version under 5.1 and disable ACPI in FADT
> parse before this code is called, so if we get revision
> <2 here, I think we need to print warning (we need to keep
> the firmware stick to the spec on ARM64).
> -------
> https://lkml.org/lkml/2017/1/19/82
> 
> So I started to use pr_warn.

Thanks for the explanation, so it is a FW bug and the warning
is granted :) just leave it there.

Still, please check my comment on acpi_gtdt_init() being called
multiple times on patch 11.

Thanks,
Lorenzo
