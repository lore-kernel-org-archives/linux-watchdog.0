Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36251 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbcJZPYd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Oct 2016 11:24:33 -0400
Received: by mail-oi0-f52.google.com with SMTP id n202so21863337oig.3
        for <linux-watchdog@vger.kernel.org>; Wed, 26 Oct 2016 08:24:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161021113213.GD16630@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-8-git-send-email-fu.wei@linaro.org> <20161021113213.GD16630@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 26 Oct 2016 23:24:32 +0800
Message-ID: <CADyBb7sJfY4=5NKKPGosOGv4sq4Tg2_TBW-XbWYoqfz4JNE-LA@mail.gmail.com>
Subject: Re: [PATCH v14 7/9] clocksource/drivers/arm_arch_timer: Refactor the
 timer init code to prepare for GTDT
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

On 21 October 2016 at 19:32, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Sep 29, 2016 at 02:17:15AM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The patch refactor original memory-mapped timer init code:
>> (1) extract some subfunction for reusing some common code
>>     a. get_cnttidr
>>     b. is_best_frame
>> (2) move base address and irq code for arch_timer_mem to
>> arch_timer_mem_register
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 159 +++++++++++++++++++++--------------
>>  1 file changed, 96 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index c7b0040..e78095f 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -57,6 +57,7 @@
>>  static unsigned arch_timers_present __initdata;
>>
>>  static void __iomem *arch_counter_base;
>> +static void __iomem *cntctlbase __initdata;
>>
>>  struct arch_timer {
>>       void __iomem *base;
>> @@ -656,15 +657,49 @@ out:
>>       return err;
>>  }
>>
>> -static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
>> +static int __init arch_timer_mem_register(struct device_node *np, void *frame)
>>  {
>> -     int ret;
>> -     irq_handler_t func;
>> +     struct device_node *frame_node = NULL;
>>       struct arch_timer *t;
>> +     void __iomem *base;
>> +     irq_handler_t func;
>> +     unsigned int irq;
>> +     int ret;
>> +
>> +     if (!frame)
>> +             return -EINVAL;
>
> Why would we call this without a frame?

Sorry, I just verify it , make sure frame is not NULL,
Because it is a "static" function, so we do need this check?

>
>> +
>> +     if (np) {
>
> ... or without a node?

For "np", for now, we just  just verify it, but it is just paperation
for GTDT support,
Because in next patch, if np == NULL, that means we call this function
from GTDT, but not DT.

>
>> +             frame_node = (struct device_node *)frame;
>> +             base = of_iomap(frame_node, 0);
>> +             arch_timer_detect_rate(base, np);
>
> ... BANG! (we check base too late, below).
>
> Please as Marc requested several versions ago: split the FW parsing
> (ACPI and DT) so that happens first, *then* once we have the data in a
> common format, use that to drive poking the HW, requesting IRQs, etc,
> completely independent of the source.
>
> In patches, do this by:
>
> (1) adding the data structures
> (2) splitting the existing DT probing to use them
> (3) Adding ACPI functionality atop

this patch is a preparation for GTDT support, I have splitted some
functions for reusing them in next patch(GTDT support)

if np == NULL, that means we call this function from GTDT, but
if np != NULL, that means we call this function from DT


>
>> -static int __init arch_timer_mem_init(struct device_node *np)
>> +static int __init get_cnttidr(struct device_node *np, u32 *cnttidr)
>>  {
>> -     struct device_node *frame, *best_frame = NULL;
>> -     void __iomem *cntctlbase, *base;
>> -     unsigned int irq, ret = -EINVAL;
>> -     u32 cnttidr;
>> +     if (!cnttidr)
>> +             return -EINVAL;
>> +
>> +     if (np)
>> +             cntctlbase = of_iomap(np, 0);
>> +     else
>> +             return -EINVAL;
>
> We want to check this for ACPI too, no?

just like I said above, this is a preparation for GTDT support,

So please correct me if I am doing this in the wrong way, thanks :-)

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
