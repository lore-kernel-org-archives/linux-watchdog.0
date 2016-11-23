Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:36112 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbcKWGKP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 23 Nov 2016 01:10:15 -0500
Received: by mail-io0-f176.google.com with SMTP id x94so7422709ioi.3
        for <linux-watchdog@vger.kernel.org>; Tue, 22 Nov 2016 22:10:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161118200335.GN1197@leverpostej>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-11-git-send-email-fu.wei@linaro.org> <20161118200335.GN1197@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 23 Nov 2016 14:10:13 +0800
Message-ID: <CADyBb7uzFkZH6d8Prg3eW5uNyU9=w2zCxgfPTG0vU7-YZn7uDQ@mail.gmail.com>
Subject: Re: [PATCH v16 10/15] clocksource/drivers/arm_arch_timer: Refactor
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


On 19 November 2016 at 04:03, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Nov 16, 2016 at 09:49:03PM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The patch refactor original memory-mapped timer init code:
>>     (1) Extract a subfunction for detecting a bast time frame:
>>         is_best_frame.
>
> Please leave this logic in arch_timer_mem_init(). Pulling it out gains
> us nothing, but makes the patch harder to review.

OK, I have put it back to arch_timer_mem_init() in next version: v17

>
>>     (2) Refactor "arch_timer_mem_init", make it become a common code for
>>         memory-mapped timer init.
>>     (3) Add a new function "arch_timer_mem_of_init" for DT init.
>
> These generally look fine.
>
> Thanks,
> Mark.
>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 162 +++++++++++++++++++++++------------
>>  1 file changed, 107 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 9ddc091..0836bb9 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -923,17 +923,35 @@ static int __init arch_timer_of_init(struct device_node *np)
>>  CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
>>  CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
>>
>> -static int __init arch_timer_mem_init(struct device_node *np)
>> +static bool __init is_best_frame(void __iomem *cntctlbase, u32 cnttidr, int n)
>> +{
>> +     u32 cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT | CNTACR_RWVT |
>> +                  CNTACR_RVOFF | CNTACR_RVCT;
>> +
>> +     /* Try enabling everything, and see what sticks */
>> +     writel_relaxed(cntacr, cntctlbase + CNTACR(n));
>> +     cntacr = readl_relaxed(cntctlbase + CNTACR(n));
>> +
>> +     if ((cnttidr & CNTTIDR_VIRT(n)) &&
>> +         !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT)))
>> +             arch_timer_mem_use_virtual = true;
>> +     else if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
>> +             return false;
>> +
>> +     return true;
>> +}
>> +
>> +static int __init arch_timer_mem_init(struct arch_timer_mem *timer_mem)
>>  {
>> -     struct device_node *frame, *best_frame = NULL;
>>       void __iomem *cntctlbase, *base;
>> -     unsigned int irq, ret = -EINVAL;
>> +     struct arch_timer_mem_frame *best_frame = NULL;
>> +     unsigned int irq;
>>       u32 cnttidr;
>> +     int i, ret;
>>
>> -     arch_timers_present |= ARCH_TIMER_TYPE_MEM;
>> -     cntctlbase = of_iomap(np, 0);
>> +     cntctlbase = ioremap(timer_mem->cntctlbase, timer_mem->size);
>>       if (!cntctlbase) {
>> -             pr_err("Can't find CNTCTLBase\n");
>> +             pr_err("Can't map CNTCTLBase.\n");
>>               return -ENXIO;
>>       }
>>
>> @@ -943,76 +961,110 @@ static int __init arch_timer_mem_init(struct device_node *np)
>>        * Try to find a virtual capable frame. Otherwise fall back to a
>>        * physical capable frame.
>>        */
>> -     for_each_available_child_of_node(np, frame) {
>> -             int n;
>> -             u32 cntacr;
>> -
>> -             if (of_property_read_u32(frame, "frame-number", &n)) {
>> -                     pr_err("Missing frame-number\n");
>> -                     of_node_put(frame);
>> -                     goto out;
>> -             }
>> -
>> -             /* Try enabling everything, and see what sticks */
>> -             cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
>> -                      CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
>> -             writel_relaxed(cntacr, cntctlbase + CNTACR(n));
>> -             cntacr = readl_relaxed(cntctlbase + CNTACR(n));
>> -
>> -             if ((cnttidr & CNTTIDR_VIRT(n)) &&
>> -                 !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
>> -                     of_node_put(best_frame);
>> -                     best_frame = frame;
>> -                     arch_timer_mem_use_virtual = true;
>> -                     break;
>> +     for (i = 0; i < timer_mem->num_frames; i++) {
>> +             if (is_best_frame(cntctlbase, cnttidr,
>> +                               timer_mem->frame[i].frame_nr)) {
>> +                     best_frame = &timer_mem->frame[i];
>> +                     if (arch_timer_mem_use_virtual)
>> +                             break;
>>               }
>> -
>> -             if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
>> -                     continue;
>> -
>> -             of_node_put(best_frame);
>> -             best_frame = of_node_get(frame);
>>       }
>> +     iounmap(cntctlbase);
>>
>> -     ret= -ENXIO;
>> -     base = arch_counter_base = of_iomap(best_frame, 0);
>> -     if (!base) {
>> -             pr_err("Can't map frame's registers\n");
>> -             goto out;
>> +     if (!best_frame) {
>> +             pr_err("Can't find frame for register\n");
>> +             return -EINVAL;
>>       }
>>
>>       if (arch_timer_mem_use_virtual)
>> -             irq = irq_of_parse_and_map(best_frame, ARCH_TIMER_VIRT_SPI);
>> +             irq = best_frame->virt_irq;
>>       else
>> -             irq = irq_of_parse_and_map(best_frame, ARCH_TIMER_PHYS_SPI);
>> +             irq = best_frame->phys_irq;
>>
>> -     ret = -EINVAL;
>>       if (!irq) {
>>               pr_err("Frame missing %s irq",
>>                      arch_timer_mem_use_virtual ? "virt" : "phys");
>> -             goto out;
>> +             return -EINVAL;
>>       }
>>
>> -     /*
>> -      * Try to determine the frequency from the device tree,
>> -      * if fail, get the frequency from CNTFRQ.
>> -      */
>> -     if (!arch_timer_rate &&
>> -         of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
>> -             arch_timer_detect_rate(base);
>> +     base = ioremap(best_frame->cntbase, best_frame->size);
>> +     if (!base) {
>> +             pr_err("Can't map frame's registers\n");
>> +             return -ENXIO;
>> +     }
>> +
>> +     arch_timer_detect_rate(base);
>>
>>       ret = arch_timer_mem_register(base, irq);
>> -     if (ret)
>> +     if (ret) {
>> +             iounmap(base);
>> +             return ret;
>> +     }
>> +
>> +     arch_counter_base = base;
>> +     arch_timers_present |= ARCH_TIMER_TYPE_MEM;
>> +
>> +     return 0;
>> +}
>> +
>> +static int __init arch_timer_mem_of_init(struct device_node *np)
>> +{
>> +     struct arch_timer_mem *timer_mem;
>> +     struct device_node *frame_node;
>> +     struct resource res;
>> +     int i, ret = -EINVAL;
>> +
>> +     timer_mem = kzalloc(sizeof(*timer_mem), GFP_KERNEL);
>> +     if (!timer_mem)
>> +             return -ENOMEM;
>> +
>> +     if (of_address_to_resource(np, 0, &res))
>>               goto out;
>> +     timer_mem->cntctlbase = res.start;
>> +     timer_mem->size = resource_size(&res);
>>
>> -     return arch_timer_common_init();
>> +     i = 0;
>> +     for_each_available_child_of_node(np, frame_node) {
>> +             int n;
>> +             struct arch_timer_mem_frame *frame = &timer_mem->frame[i];
>> +
>> +             if (of_property_read_u32(frame_node, "frame-number", &n)) {
>> +                     pr_err("Missing frame-number\n");
>> +                     of_node_put(frame_node);
>> +                     goto out;
>> +             }
>> +             frame->frame_nr = n;
>> +
>> +             if (of_address_to_resource(frame_node, 0, &res)) {
>> +                     of_node_put(frame_node);
>> +                     goto out;
>> +             }
>> +             frame->cntbase = res.start;
>> +             frame->size = resource_size(&res);
>> +
>> +             frame->virt_irq = irq_of_parse_and_map(frame_node,
>> +                                                    ARCH_TIMER_VIRT_SPI);
>> +             frame->phys_irq = irq_of_parse_and_map(frame_node,
>> +                                                    ARCH_TIMER_PHYS_SPI);
>> +
>> +             if (++i >= ARCH_TIMER_MEM_MAX_FRAMES)
>> +                     break;
>> +     }
>> +     timer_mem->num_frames = i;
>> +
>> +     /* Try to determine the frequency from the device tree */
>> +     if (!arch_timer_rate)
>> +             of_property_read_u32(np, "clock-frequency", &arch_timer_rate);
>> +
>> +     ret = arch_timer_mem_init(timer_mem);
>> +     if (!ret)
>> +             ret = arch_timer_common_init();
>>  out:
>> -     iounmap(cntctlbase);
>> -     of_node_put(best_frame);
>> +     kfree(timer_mem);
>>       return ret;
>>  }
>>  CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
>> -                    arch_timer_mem_init);
>> +                    arch_timer_mem_of_init);
>>
>>  #ifdef CONFIG_ACPI
>>  static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
>> --
>> 2.7.4
>>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
