Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35999 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754782AbcJZLKz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Oct 2016 07:10:55 -0400
Received: by mail-oi0-f53.google.com with SMTP id n202so12448457oig.3
        for <linux-watchdog@vger.kernel.org>; Wed, 26 Oct 2016 04:10:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161020163719.GC27598@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-5-git-send-email-fu.wei@linaro.org> <20161020163719.GC27598@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 26 Oct 2016 19:10:54 +0800
Message-ID: <CADyBb7tLJpPiMqWs4KZE=uCpo3HX3WcNVju2UKNuPOR0+M4UDw@mail.gmail.com>
Subject: Re: [PATCH v14 4/9] acpi/arm64: Add GTDT table parse driver
To: Mark Rutland <mark.rutland@arm.com>
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mark,

On 21 October 2016 at 00:37, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> As a heads-up, on v4.9-rc1 I see conflicts at least against
> arch/arm64/Kconfig. Luckily git am -3 seems to be able to fix that up
> automatically, but this will need to be rebased before the next posting
> and/or merging.
>
> On Thu, Sep 29, 2016 at 02:17:12AM +0800, fu.wei@linaro.org wrote:
>> +static int __init map_gt_gsi(u32 interrupt, u32 flags)
>> +{
>> +     int trigger, polarity;
>> +
>> +     if (!interrupt)
>> +             return 0;
>
> Urgh.
>
> Only the secure interrupt (which we do not need) is optional in this
> manner, and (hilariously), zero appears to also be a valid GSIV, per
> figure 5-24 in the ACPI 6.1 spec.
>
> So, I think that:
>
> (a) we should not bother parsing the secure interrupt

If I understand correctly, from this point of view, kernel don't
handle the secure interrupt.
But the current arm_arch_timer driver still enable/disable/request
PHYS_SECURE_PPI
with PHYS_NONSECURE_PPI.
That means we still need to parse the secure interrupt.
Please correct me, if I misunderstand something? :-)

> (b) we should drop the check above

yes, if zero is a valid GSIV, this makes sense.

> (c) we should report the spec issue to the ASWG
>
>> +/*
>> + * acpi_gtdt_c3stop - got c3stop info from GTDT
>> + *
>> + * Returns 1 if the timer is powered in deep idle state, 0 otherwise.
>> + */
>> +bool __init acpi_gtdt_c3stop(void)
>> +{
>> +     struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
>> +
>> +     return !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
>> +}
>
> It looks like this can differ per interrupt. Shouldn't we check the
> appropriate one?

yes, I think you are right.

>
>> +int __init acpi_gtdt_init(struct acpi_table_header *table)
>> +{
>> +     void *start;
>> +     struct acpi_table_gtdt *gtdt;
>> +
>> +     gtdt = container_of(table, struct acpi_table_gtdt, header);
>> +
>> +     acpi_gtdt_desc.gtdt = gtdt;
>> +     acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
>> +
>> +     if (table->revision < 2) {
>> +             pr_debug("Revision:%d doesn't support Platform Timers.\n",
>> +                      table->revision);
>> +             return 0;
>> +     }
>> +
>> +     if (!gtdt->platform_timer_count) {
>> +             pr_debug("No Platform Timer.\n");
>> +             return 0;
>> +     }
>> +
>> +     start = (void *)gtdt + gtdt->platform_timer_offset;
>> +     if (start < (void *)table + sizeof(struct acpi_table_gtdt)) {
>> +             pr_err(FW_BUG "Failed to retrieve timer info from firmware: invalid data.\n");
>> +             return -EINVAL;
>> +     }
>> +     acpi_gtdt_desc.platform_timer_start = start;
>> +
>> +     return gtdt->platform_timer_count;
>> +}
>
> This is never used as anything other than a status code.
>
> Just return zero; we haven't parsed the platform timers themselves at
> this point anyway.

Sorry, in my driver, I use this return value to inform driver

 negative number : error
0 : we don't have platform timer in GTDT table.
positive number: the number of platform timer we have in GTDT table.

please correct me, if I am doing it in wrong way. Thanks :-)


>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
