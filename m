Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35919 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754684AbcJZNlq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Oct 2016 09:41:46 -0400
Received: by mail-oi0-f46.google.com with SMTP id n202so17176393oig.3
        for <linux-watchdog@vger.kernel.org>; Wed, 26 Oct 2016 06:41:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <57010864-b2f0-d230-3138-8ace484acb04@arm.com>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-5-git-send-email-fu.wei@linaro.org> <20161020163719.GC27598@leverpostej>
 <CADyBb7tLJpPiMqWs4KZE=uCpo3HX3WcNVju2UKNuPOR0+M4UDw@mail.gmail.com> <57010864-b2f0-d230-3138-8ace484acb04@arm.com>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 26 Oct 2016 21:41:44 +0800
Message-ID: <CADyBb7uVaUGoOMBd-pnwT2suBy1OpAmQjLriOtSx1zMC-EWazw@mail.gmail.com>
Subject: Re: [PATCH v14 4/9] acpi/arm64: Add GTDT table parse driver
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

Hi Marc,

On 26 October 2016 at 20:11, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 26/10/16 12:10, Fu Wei wrote:
>> Hi Mark,
>>
>> On 21 October 2016 at 00:37, Mark Rutland <mark.rutland@arm.com> wrote:
>>> Hi,
>>>
>>> As a heads-up, on v4.9-rc1 I see conflicts at least against
>>> arch/arm64/Kconfig. Luckily git am -3 seems to be able to fix that up
>>> automatically, but this will need to be rebased before the next posting
>>> and/or merging.
>>>
>>> On Thu, Sep 29, 2016 at 02:17:12AM +0800, fu.wei@linaro.org wrote:
>>>> +static int __init map_gt_gsi(u32 interrupt, u32 flags)
>>>> +{
>>>> +     int trigger, polarity;
>>>> +
>>>> +     if (!interrupt)
>>>> +             return 0;
>>>
>>> Urgh.
>>>
>>> Only the secure interrupt (which we do not need) is optional in this
>>> manner, and (hilariously), zero appears to also be a valid GSIV, per
>>> figure 5-24 in the ACPI 6.1 spec.
>>>
>>> So, I think that:
>>>
>>> (a) we should not bother parsing the secure interrupt
>>
>> If I understand correctly, from this point of view, kernel don't
>> handle the secure interrupt.
>> But the current arm_arch_timer driver still enable/disable/request
>> PHYS_SECURE_PPI
>> with PHYS_NONSECURE_PPI.
>> That means we still need to parse the secure interrupt.
>> Please correct me, if I misunderstand something? :-)
>
> That's because we can use the per-cpu timer when 32bit Linux is running
> on the secure side (and we cannot distinguish between secure and
> non-secure at runtime). ACPI is 64bit only, and Linux on 64bit isn't
> supported on the secure side, so only registering the non-secure timer
> is perfectly acceptable.

Great thanks for your explanation :-)
So we just don't need to fill arch_timer_ppi[PHYS_SECURE_PPI] , just skip it.

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
