Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:35070 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753830AbcKUOi6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 21 Nov 2016 09:38:58 -0500
Received: by mail-it0-f43.google.com with SMTP id c20so87453649itb.0
        for <linux-watchdog@vger.kernel.org>; Mon, 21 Nov 2016 06:38:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161118195657.GM1197@leverpostej>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-9-git-send-email-fu.wei@linaro.org> <20161118195657.GM1197@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Mon, 21 Nov 2016 22:38:51 +0800
Message-ID: <CADyBb7uXaPVT1ppJav5=ckdvBcfv+6fSsMc3xbDjFEO2G_zjSQ@mail.gmail.com>
Subject: Re: [PATCH v16 08/15] clocksource/drivers/arm_arch_timer: Refactor
 arch_timer_needs_probing, and call it only if acpi disabled.
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

On 19 November 2016 at 03:56, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Nov 16, 2016 at 09:49:01PM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The patch refactor original arch_timer_needs_probing function:
>>     (1) Separate out arch_timer_needs_probing from arch_timer_common_init,
>>     and call it only if acpi disabled.
>>     (2) Rename arch_timer_needs_probing to arch_timer_needs_of_probing.
>
> Please write a real commit message.

OK, how about this:

clocksource/drivers/arm_arch_timer: Refactor
arch_timer_needs_probing, only use it in the DT init code

Currently, the arch_timer_common_init uses arch_timer_needs_probing call to
wait for both timers been probed which is only for booting from DT.

For booting from ACPI, we don't need these in arch_timer_common_init, these code
should be only in the DT init code.

This patch seperates arch_timer_needs_probing related code out into a
new function
named arch_timer_needs_of_probing, and then reworks arch_timer_of_init
to use it,
so that we can keep this only in the DT init code.


>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 34 +++++++++++++++++++---------------
>>  1 file changed, 19 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index fe4e812..9ddc091 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -792,15 +792,28 @@ static const struct of_device_id arch_timer_mem_of_match[] __initconst = {
>>       {},
>>  };
>>
>> -static bool __init
>> -arch_timer_needs_probing(int type, const struct of_device_id *matches)
>> +static bool __init arch_timer_needs_of_probing(void)
>>  {
>>       struct device_node *dn;
>>       bool needs_probing = false;
>> +     unsigned int mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
>> +
>> +     /* We have two timers, and both device-tree nodes are probed. */
>> +     if ((arch_timers_present & mask) == mask)
>> +             return false;
>> +
>> +     /*
>> +      * Only one type of timer is probed,
>> +      * check if we have another type of timer node in device-tree.
>> +      */
>> +     if (arch_timers_present & ARCH_TIMER_TYPE_CP15)
>> +             dn = of_find_matching_node(NULL, arch_timer_mem_of_match);
>> +     else
>> +             dn = of_find_matching_node(NULL, arch_timer_of_match);
>>
>> -     dn = of_find_matching_node(NULL, matches);
>> -     if (dn && of_device_is_available(dn) && !(arch_timers_present & type))
>> +     if (dn && of_device_is_available(dn))
>>               needs_probing = true;
>> +
>>       of_node_put(dn);
>>
>>       return needs_probing;
>> @@ -808,17 +821,8 @@ arch_timer_needs_probing(int type, const struct of_device_id *matches)
>>
>>  static int __init arch_timer_common_init(void)
>>  {
>> -     unsigned int mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
>> -
>> -     /* Wait until both nodes are probed if we have two timers */
>> -     if ((arch_timers_present & mask) != mask) {
>> -             if (arch_timer_needs_probing(ARCH_TIMER_TYPE_MEM,
>> -                                          arch_timer_mem_of_match))
>> -                     return 0;
>> -             if (arch_timer_needs_probing(ARCH_TIMER_TYPE_CP15,
>> -                                          arch_timer_of_match))
>> -                     return 0;
>> -     }
>
> Why can't we just move this into the DT-specific caller of
> arch_timer_common_init()?

yes, I have thought about this, but that means we have to split arch_timer_init,
and use arch_timer_register and arch_timer_common_init directly in
arch_timer_of_init.

In another word, I also need to modify arch_timer_of_init, not only
arch_timer_common_init,
but let me have a try in v17, see if you like it.

>
> Thanks
> Mark.
>
>> +     if (acpi_disabled && arch_timer_needs_of_probing())
>> +             return 0;
>>
>>       arch_timer_banner(arch_timers_present);
>>       arch_counter_register(arch_timers_present);
>> --
>> 2.7.4
>>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
