Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34052 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936420AbcKWMPx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 23 Nov 2016 07:15:53 -0500
Received: by mail-io0-f177.google.com with SMTP id c21so20096151ioj.1
        for <linux-watchdog@vger.kernel.org>; Wed, 23 Nov 2016 04:15:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161118202000.GP1197@leverpostej>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-15-git-send-email-fu.wei@linaro.org> <20161118202000.GP1197@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 23 Nov 2016 20:15:45 +0800
Message-ID: <CADyBb7v_SbTZBCeqEstq-E0svqOUqw2C8ssjfgsO7KdZ82=iBQ@mail.gmail.com>
Subject: Re: [PATCH v16 14/15] clocksource/drivers/arm_arch_timer: Add GTDT
 support for memory-mapped timer
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

On 19 November 2016 at 04:20, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Nov 16, 2016 at 09:49:07PM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The patch add memory-mapped timer register support by using the
>> information provided by the new GTDT driver of ACPI.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 26 +++++++++++++++++++++++++-
>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index c494ca8..0aad60a 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -1067,7 +1067,28 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
>>                      arch_timer_mem_of_init);
>>
>>  #ifdef CONFIG_ACPI_GTDT
>> -/* Initialize per-processor generic timer */
>> +static int __init arch_timer_mem_acpi_init(void)
>> +{
>> +     struct arch_timer_mem *timer_mem;
>> +     int ret = 0;
>> +     int i = 0;
>> +
>> +     timer_mem = kzalloc(sizeof(*timer_mem), GFP_KERNEL);
>
> Why do you need it zeroed? You don't clear it between iterations, so
> either you don't need this, or you have a bug in the loop.
>
>> +     if (!timer_mem)
>> +             return -ENOMEM;
>> +
>> +     while (!gtdt_arch_timer_mem_init(timer_mem, i)) {
>
> Huh?
>
> Why doesn't GTDT expose a function to fill in the entire arch_timer_mem
> in one go?

Yes, that is a good idea, but I need to find a way to get the number of
GT block in GTDT, then allocate a  struct arch_timer_mem array for all GT block

>
> There shouldn't be multiple instances, as far as I am aware. Am I
> mistaken?

I don't see any doc says : there is only one memory-mapped timer
in a soc.
Maybe we have more than one GT block in GTDT or
(in another word) we may have more than one memory-mapped
timer in a soc, right ??

Please correct me, If I miss something.

>
>> +             ret = arch_timer_mem_init(timer_mem);
>> +             if (ret)
>> +                     break;
>> +             i++;
>> +     }
>> +
>> +     kfree(timer_mem);
>> +     return ret;
>> +}
>
>
> Regardless, arch_timer_mem is small enough that you don't need dynamic
> allocaiton. Just put it on the stack, e.g.
>
> static int __init arch_timer_mem_acpi_init(void)
> {
>         int i = 0;
>         struct arch_timer_mem timer_mem;
>
>         while (!gtdt_arch_timer_mem_init(timer_mem, i)) {
>                 int ret = arch_timer_mem_init();
>                 if (ret)
>                         return ret;
>                 i++
>         }
>
>         return 0;
> }
>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
