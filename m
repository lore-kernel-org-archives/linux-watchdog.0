Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35799 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbdASMnH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 19 Jan 2017 07:43:07 -0500
Received: by mail-pg0-f46.google.com with SMTP id 194so14114358pgd.2
        for <linux-watchdog@vger.kernel.org>; Thu, 19 Jan 2017 04:43:06 -0800 (PST)
Subject: Re: [PATCH v20 16/17] clocksource/drivers/arm_arch_timer: Add GTDT
 support for memory-mapped timer
To: Fu Wei <fu.wei@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-17-fu.wei@linaro.org>
 <ed4efe25-1b40-66e2-ae3f-77a4e32715b6@linaro.org>
 <CADyBb7tpDynA0EEUkFZXpUAksjvXeUzuoC82GnbVA2O1w2T22g@mail.gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <c1821a5b-8b32-e194-125c-3fd243059425@linaro.org>
Date: Thu, 19 Jan 2017 20:42:59 +0800
MIME-Version: 1.0
In-Reply-To: <CADyBb7tpDynA0EEUkFZXpUAksjvXeUzuoC82GnbVA2O1w2T22g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 2017/1/19 18:02, Fu Wei wrote:
> Hi Hanjun,
>
> On 19 January 2017 at 17:16, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> On 2017/1/18 21:25, fu.wei@linaro.org wrote:
>>>
>>> From: Fu Wei <fu.wei@linaro.org>
>>>
>>> The patch add memory-mapped timer register support by using the
>>> information provided by the new GTDT driver of ACPI.
>>>
>>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>>> ---
>>>  drivers/clocksource/arm_arch_timer.c | 35
>>> ++++++++++++++++++++++++++++++++---
>>>  1 file changed, 32 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/arm_arch_timer.c
>>> b/drivers/clocksource/arm_arch_timer.c
>>> index 79dc004..7ca2da7 100644
>>> --- a/drivers/clocksource/arm_arch_timer.c
>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>> @@ -1077,10 +1077,36 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem,
>>> "arm,armv7-timer-mem",
>>>                        arch_timer_mem_of_init);
>>>
>>>  #ifdef CONFIG_ACPI_GTDT
>>> -/* Initialize per-processor generic timer */
>>> +static int __init arch_timer_mem_acpi_init(int platform_timer_count)
>>> +{
>>> +       struct arch_timer_mem *timer_mem;
>>> +       int timer_count, i, ret;
>>> +
>>
>>
>> if (!platform_timer_count)
>>         return 0;
>>
>> Did I miss something?
>
> Ah, thanks, I guess I miss this check below.
>
>>
>> Thanks
>> Hanjun
>>
>>
>>> +       timer_mem = kcalloc(platform_timer_count, sizeof(*timer_mem),
>>> +                           GFP_KERNEL);
>>> +       if (!timer_mem)
>>> +               return -ENOMEM;
>>> +
>>> +       ret = acpi_arch_timer_mem_init(timer_mem, &timer_count);
>>> +       if (ret || !timer_count)
>>> +               goto error;
>>> +
>>> +       for (i = 0; i < timer_count; i++) {
>>> +               ret = arch_timer_mem_init(timer_mem);
>>> +               if (!ret)
>>> +                       break;
>>> +               timer_mem++;
>>> +       }
>>> +
>>> +error:
>>> +       kfree(timer_mem);
>>> +       return ret;
>>> +}
>>> +
>>> +/* Initialize per-processor generic timer and memory-mapped timer(if
>>> present) */
>>>  static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>>>  {
>>> -       int ret;
>>> +       int ret, platform_timer_count;
>>>
>>>         if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
>>>                 pr_warn("already initialized, skipping\n");
>>> @@ -1089,7 +1115,7 @@ static int __init arch_timer_acpi_init(struct
>>> acpi_table_header *table)
>>>
>>>         arch_timers_present |= ARCH_TIMER_TYPE_CP15;
>>>
>>> -       ret = acpi_gtdt_init(table, NULL);
>>> +       ret = acpi_gtdt_init(table, &platform_timer_count);
>>>         if (ret) {
>>>                 pr_err("Failed to init GTDT table.\n");
>>>                 return ret;
>>> @@ -1122,6 +1148,9 @@ static int __init arch_timer_acpi_init(struct
>>> acpi_table_header *table)
>>>         if (ret)
>>>                 return ret;
>>>
>>> +       if (arch_timer_mem_acpi_init(platform_timer_count))
>
> +       if (platform_timer_count &&
> +           arch_timer_mem_acpi_init(platform_timer_count))

It's better.

Thanks
Hanjun
