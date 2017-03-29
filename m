Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:37925 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754184AbdC2Ks2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Mar 2017 06:48:28 -0400
Received: by mail-it0-f51.google.com with SMTP id y18so52060916itc.1
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Mar 2017 03:48:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170329102118.GB10807@red-moon>
References: <20170321163122.9183-1-fu.wei@linaro.org> <20170321163122.9183-8-fu.wei@linaro.org>
 <20170328113535.GA17440@red-moon> <CADyBb7v9jaiQjaWzwafkih_tsU+-hNi+TA7hcDbFgtLLChXM_g@mail.gmail.com>
 <20170329102118.GB10807@red-moon>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 29 Mar 2017 18:48:26 +0800
Message-ID: <CADyBb7sDnp+p5Z=Cde-YS2UG8pxo9O=Tvkq8D79k37wOrUw19Q@mail.gmail.com>
Subject: Re: [PATCH v22 07/11] acpi/arm64: Add GTDT table parse driver
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Lorenzo,

On 29 March 2017 at 18:21, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Wed, Mar 29, 2017 at 05:48:17PM +0800, Fu Wei wrote:
>
> [...]
>
>>  * @platform_timer_count: It points to a integer variable which is used
>>  *                           for storing the number of platform timers.
>>  *                           This pointer could be NULL, if the caller
>>  *                           doesn't need this info.
>>
>> >
>> >> + *
>> >> + * Return: 0 if success, -EINVAL if error.
>> >> + */
>> >> +int __init acpi_gtdt_init(struct acpi_table_header *table,
>> >> +                       int *platform_timer_count)
>> >> +{
>> >> +     int ret = 0;
>> >> +     int timer_count = 0;
>> >> +     void *platform_timer = NULL;
>> >> +     struct acpi_table_gtdt *gtdt;
>> >> +
>> >> +     gtdt = container_of(table, struct acpi_table_gtdt, header);
>> >> +     acpi_gtdt_desc.gtdt = gtdt;
>> >> +     acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
>> >> +
>> >> +     if (table->revision < 2)
>> >> +             pr_warn("Revision:%d doesn't support Platform Timers.\n",
>> >> +                     table->revision);
>> >
>> > Ok, two points here. First, I am not sure why you should warn if the
>> > table revision is < 2, is that a FW bug ? I do not think it is, you
>> > can just return 0.
>>
>> I used pr_debug here before v20, then I got Hanjun's suggestion:
>> -------
>> GTDT table revision is updated to 2 in ACPI 5.1, we will
>> not support ACPI version under 5.1 and disable ACPI in FADT
>> parse before this code is called, so if we get revision
>> <2 here, I think we need to print warning (we need to keep
>> the firmware stick to the spec on ARM64).
>> -------
>> https://lkml.org/lkml/2017/1/19/82
>>
>> So I started to use pr_warn.
>
> Thanks for the explanation, so it is a FW bug and the warning
> is granted :) just leave it there.
>
> Still, please check my comment on acpi_gtdt_init() being called
> multiple times on patch 11.

Thanks

For calling acpi_gtdt_init() twice:
(1) 1st time: in early boot(bootmem), for init arch_timer and
memory-mapped timer, we initialize the acpi_gtdt_desc.
you can see that all the items in this struct are pointer.
(2) 2nd time: when system switch from bootmem to slab, all the
pointers in the acpi_gtdt_desc are invalid, so we have to
re-initialize(re-map) them.

I have tested it, if we don't re-initialize  the acpi_gtdt_desc,
system will go wrong.

>
> Thanks,
> Lorenzo



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
