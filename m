Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:34879 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdAPAyr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 15 Jan 2017 19:54:47 -0500
Received: by mail-it0-f41.google.com with SMTP id 203so65653493ith.0
        for <linux-watchdog@vger.kernel.org>; Sun, 15 Jan 2017 16:54:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADyBb7vF0v2DwXA8fNUOTQcqriJK1Hp57_G8DKi0WO9FnvrB5w@mail.gmail.com>
References: <20161208173319.6618-1-fu.wei@linaro.org> <20170113192920.GF2472@leverpostej>
 <CADyBb7vF0v2DwXA8fNUOTQcqriJK1Hp57_G8DKi0WO9FnvrB5w@mail.gmail.com>
From: Fu Wei <fu.wei@linaro.org>
Date: Mon, 16 Jan 2017 08:54:46 +0800
Message-ID: <CADyBb7ugz_YpxKQUsJbF1vdjm_Nzyh2mH8TZMPqj1cSHGSPCFw@mail.gmail.com>
Subject: Re: [PATCH v18 00/15] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
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

On 14 January 2017 at 19:34, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Mark,
>
> On 14 January 2017 at 03:29, Mark Rutland <mark.rutland@arm.com> wrote:
>> Hi,
>>
>> On Fri, Dec 09, 2016 at 01:33:04AM +0800, fu.wei@linaro.org wrote:
>>> From: Fu Wei <fu.wei@linaro.org>
>>>
>>> This patchset:
>>>     (1)Preparation for adding GTDT support in arm_arch_timer:
>>>         1. Move some enums and marcos to header file;
>>>         2. Add a new enum for spi type;
>>>         3. Improve printk relevant code;
>>>         4. Rename some enums and defines;
>>>         5. Rework PPI determination;
>>>         6. Rework counter frequency detection;
>>>         7. Refactor arch_timer_needs_probing, move it into DT init call
>>>         8. Introduce some new structs and refactor the MMIO timer init code
>>>         for reusing some common code.
>>>
>>>     (2)Introduce ACPI GTDT parser: drivers/acpi/arm64/acpi_gtdt.c
>>>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>>>     memory-mapped timer and SBSA Generic Watchdog timer.
>>>     This driver can help to simplify all the relevant timer drivers,
>>>     and separate all the ACPI GTDT knowledge from them.
>>>
>>>     (3)Simplify ACPI code for arm_arch_timer
>>>
>>>     (4)Add GTDT support for ARM memory-mapped timer.
>>>
>>> This patchset has been tested on the following platforms with ACPI enabled:
>>>     (1)ARM Foundation v8 model
>>
>> Once v4.10-rc4 comes out this weekend, could you please rebase and
>> repost this?
>
> Yes, of course.
>
> I have rebased v19 to the latest v4.10-rc3-e96f8f1, it dosen't need
> any modification.
> I will rebase it every day, and will repost it if it need any  modification.
>
> But for now, V19 works well with the master branch of upstream kernel.
> Do I need to re-post it even if it doesn't need any improvement or
> modification? :-)

I just fetched the latest mainline kernel, and rebase v19 on the top
of 4.10-rc4.
I have double checked it, V19 works well with  4.10-rc4.
For rebasing,  it doesn't need any modification.

So please help me to review V19, I will improve it ASAP according to
your suggestion.

Many thanks!

>
>>
>> Marc and I will be happy to take a look then.
>
> Great thanks for your help!
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
