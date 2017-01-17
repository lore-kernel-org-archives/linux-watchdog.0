Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33823 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbdAQKqv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 17 Jan 2017 05:46:51 -0500
Received: by mail-io0-f176.google.com with SMTP id l66so111680372ioi.1
        for <linux-watchdog@vger.kernel.org>; Tue, 17 Jan 2017 02:46:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADyBb7tFaSshUmZsJbNO2tnbqAKEii39NQVfcx5CqDiDsK5OJA@mail.gmail.com>
References: <20161221064603.11830-1-fu.wei@linaro.org> <20161221064603.11830-11-fu.wei@linaro.org>
 <20170116183032.GL5908@leverpostej> <CADyBb7tFaSshUmZsJbNO2tnbqAKEii39NQVfcx5CqDiDsK5OJA@mail.gmail.com>
From: Fu Wei <fu.wei@linaro.org>
Date: Tue, 17 Jan 2017 18:39:18 +0800
Message-ID: <CADyBb7sa4Lfk+JestQj6FUd460JRM3GiSijGopHrQr5mHj8efA@mail.gmail.com>
Subject: Re: [PATCH v19 10/15] clocksource/drivers/arm_arch_timer: Refactor
 the timer init code to prepare for GTDT
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

On 17 January 2017 at 18:30, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Mark,
>
> On 17 January 2017 at 02:30, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Wed, Dec 21, 2016 at 02:45:58PM +0800, fu.wei@linaro.org wrote:
>>> From: Fu Wei <fu.wei@linaro.org>
>>>
>>> The patch refactor original memory-mapped timer init code:
>>>     (1) Refactor "arch_timer_mem_init", make it become a common code for
>>>         memory-mapped timer init.
>>>     (2) Add a new function "arch_timer_mem_of_init" for DT init.
>>
>> As a general note, please write proper commit messages, describing what
>> the problem is, and why we are making the changes. These bullet points
>> don't add anything to what can be derived from a glance at the code.
>>
>> For this patch, you can use:
>>
>>   clocksource: arm_arch_timer: refactor MMIO timer probing
>>
>>   Currently the code to probe MMIO architected timers mixes DT parsing
>>   with actual poking of hardware. This makes the code harder than
>>   necessary to understand, and makes it difficult to add support for
>>   probing via ACPI.
>>
>>   This patch factors all the DT-specific logic out of
>>   arch_timer_mem_init(), into a new function, arch_timer_mem_of_init().
>>   The former pokes the hardware and determines the suitablility of
>>   frames based on a datastructure populated by the latter.
>>
>>   This cleanly separates the two and will make it possible to add
>>   probing using the ACPI GTDT in subsequent patches.
>
> Great thanks for this upstream tip.
> I have used your example commit message instead.
> It will be in v20.
>
>>
>> [...]
>>
>>> +     for_each_available_child_of_node(np, frame_node) {
>>> +             int n;
>>> +             struct arch_timer_mem_frame *frame = &timer_mem->frame[i];
>>> +
>>> +             if (of_property_read_u32(frame_node, "frame-number", &n)) {
>>> +                     pr_err("Missing frame-number\n");
>>> +                     of_node_put(frame_node);
>>> +                     goto out;
>>> +             }
>>> +             frame->frame_nr = n;
>>> +
>>> +             if (of_address_to_resource(frame_node, 0, &res)) {
>>> +                     of_node_put(frame_node);
>>> +                     goto out;
>>> +             }
>>> +             frame->cntbase = res.start;
>>> +             frame->size = resource_size(&res);
>>> +
>>> +             frame->virt_irq = irq_of_parse_and_map(frame_node,
>>> +                                                    ARCH_TIMER_VIRT_SPI);
>>> +             frame->phys_irq = irq_of_parse_and_map(frame_node,
>>> +                                                    ARCH_TIMER_PHYS_SPI);
>>>
>>> -     if (!arch_timer_needs_of_probing())
>>> +             if (++i >= ARCH_TIMER_MEM_MAX_FRAMES)
>>> +                     break;
>>> +     }
>>
>> It would be good if we could warn upon seeing more than
>> ARCH_TIMER_MEM_MAX_FRAMES children, since that's obviously an error.
>
> OK, NP, will use
>
> if (i >= ARCH_TIMER_MEM_MAX_FRAMES) {
>         pr_err(FW_BUG "too many frames, ARMv8 spec only allows 8.\n");

Sorry,  this should be "ARM spec only allows 8.\n"

Not only ARMv8, but also ARMv7


>         goto out;
> }
>
> at the beginning of this loop.
>
> Here will be replaced by  i++;
>
> Great thanks for your suggestion!
>
>>
>> Thanks,
>> Mark.
>
>
>
> --
> Best regards,
>
> Fu Wei
> Software Engineer
> Red Hat



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
