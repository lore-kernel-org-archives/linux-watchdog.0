Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34613 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754572AbcKKNuq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 11 Nov 2016 08:50:46 -0500
Received: by mail-pg0-f53.google.com with SMTP id x23so10421965pgx.1
        for <linux-watchdog@vger.kernel.org>; Fri, 11 Nov 2016 05:50:45 -0800 (PST)
Message-ID: <5825CAFE.2080005@linaro.org>
Date: Fri, 11 Nov 2016 21:43:26 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>, Mark Rutland <mark.rutland@arm.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Subject: Re: [PATCH v14 4/9] acpi/arm64: Add GTDT table parse driver
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org> <1475086637-1914-5-git-send-email-fu.wei@linaro.org> <20161020163719.GC27598@leverpostej> <CADyBb7tLJpPiMqWs4KZE=uCpo3HX3WcNVju2UKNuPOR0+M4UDw@mail.gmail.com>
In-Reply-To: <CADyBb7tLJpPiMqWs4KZE=uCpo3HX3WcNVju2UKNuPOR0+M4UDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/26/2016 07:10 PM, Fu Wei wrote:
> Hi Mark,
>
> On 21 October 2016 at 00:37, Mark Rutland <mark.rutland@arm.com> wrote:
>> Hi,
>>
>> As a heads-up, on v4.9-rc1 I see conflicts at least against
>> arch/arm64/Kconfig. Luckily git am -3 seems to be able to fix that up
>> automatically, but this will need to be rebased before the next posting
>> and/or merging.
>>
>> On Thu, Sep 29, 2016 at 02:17:12AM +0800, fu.wei@linaro.org wrote:
>>> +static int __init map_gt_gsi(u32 interrupt, u32 flags)
>>> +{
>>> +     int trigger, polarity;
>>> +
>>> +     if (!interrupt)
>>> +             return 0;
>>
>> Urgh.
>>
>> Only the secure interrupt (which we do not need) is optional in this
>> manner, and (hilariously), zero appears to also be a valid GSIV, per
>> figure 5-24 in the ACPI 6.1 spec.
>>
>> So, I think that:
>>
>> (a) we should not bother parsing the secure interrupt
>
> If I understand correctly, from this point of view, kernel don't
> handle the secure interrupt.
> But the current arm_arch_timer driver still enable/disable/request
> PHYS_SECURE_PPI
> with PHYS_NONSECURE_PPI.
> That means we still need to parse the secure interrupt.
> Please correct me, if I misunderstand something? :-)
>
>> (b) we should drop the check above
>
> yes, if zero is a valid GSIV, this makes sense.
>
>> (c) we should report the spec issue to the ASWG
>>
>>> +/*
>>> + * acpi_gtdt_c3stop - got c3stop info from GTDT
>>> + *
>>> + * Returns 1 if the timer is powered in deep idle state, 0 otherwise.
>>> + */
>>> +bool __init acpi_gtdt_c3stop(void)
>>> +{
>>> +     struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
>>> +
>>> +     return !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
>>> +}
>>
>> It looks like this can differ per interrupt. Shouldn't we check the
>> appropriate one?
>
> yes, I think you are right.

I think Mark already clarified this it's a global flag which defined
in the spec, and we don't need to update it.

Thanks
Hanjun
