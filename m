Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35880 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbdC2PBy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Mar 2017 11:01:54 -0400
Received: by mail-io0-f172.google.com with SMTP id l7so515219ioe.3
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Mar 2017 08:01:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170329144142.GL2123@mai>
References: <20170321163122.9183-1-fu.wei@linaro.org> <20170321163122.9183-3-fu.wei@linaro.org>
 <20170328145814.GE2123@mai> <CADyBb7uD1OqpPZf+ADsgbWryCGMGE3GqXOxz_4+1RzC1Pqsccg@mail.gmail.com>
 <CADyBb7tzJAuvG73v6ZoBVO4ehCC3RMsc1pq5gKF2eQ94j6GXrg@mail.gmail.com> <20170329144142.GL2123@mai>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 29 Mar 2017 23:01:50 +0800
Message-ID: <CADyBb7sTk_GH=vQcfwp7R+PeTtqc=EPRU8RpH9KTgEqO9c0FgA@mail.gmail.com>
Subject: Re: [PATCH v22 02/11] clocksource: arm_arch_timer: separate out
 device-tree code and remove arch_timer_detect_rate
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

On 29 March 2017 at 22:41, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On Wed, Mar 29, 2017 at 01:11:58PM +0800, Fu Wei wrote:
>> Hi Daniel,
>>
>> On 29 March 2017 at 11:41, Fu Wei <fu.wei@linaro.org> wrote:
>> > Hi Daniel,
>> >
>> > Great thanks for your review, allow me to answer your question below:
>> >
>> > On 28 March 2017 at 22:58, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> >> On Wed, Mar 22, 2017 at 12:31:13AM +0800, fu.wei@linaro.org wrote:
>> >>> From: Fu Wei <fu.wei@linaro.org>
>> >>>
>> >>> Currently, the counter frequency detection call(arch_timer_detect_rate)
>> >>> includes getting the frequency from the device-tree property, the per-cpu
>> >>> arch-timer and the memory-mapped (MMIO) timer interfaces.
>> >>> But reading device-tree property will be needed only when system boot with
>> >>> device-tree, and reading from the per-cpu arch-timer and the memory-mapped
>> >>> (MMIO) timer interfaces will be needed only when the system initializes
>> >>> the relevant timer.
>> >>>
>> >>> This patch separates out device-tree code, keep them in device-tree init
>> >>> function, and removes arch_timer_detect_rate founction, then uses the
>> >>> arch_timer_get_cntfrq and arch_timer_mem_get_cntfrq directly.
>> >>>
>> >>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> >>> ---
>> >>>  drivers/clocksource/arm_arch_timer.c | 58 +++++++++++++++++++-----------------
>> >>>  1 file changed, 30 insertions(+), 28 deletions(-)
>> >>>
>> >>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> >>> index 843f923..29ca7d6 100644
>> >>> --- a/drivers/clocksource/arm_arch_timer.c
>> >>> +++ b/drivers/clocksource/arm_arch_timer.c
>> >>> @@ -560,30 +560,6 @@ static u32 arch_timer_mem_get_cntfrq(void __iomem *cntbase)
>> >>>       return readl_relaxed(cntbase + CNTFRQ);
>> >>>  }
>> >>>
>> >>> -static void
>> >>> -arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
>> >>> -{
>> >>> -     /* Who has more than one independent system counter? */
>> >>> -     if (arch_timer_rate)
>> >>> -             return;
>> >>> -
>> >>> -     /*
>> >>> -      * Try to determine the frequency from the device tree or CNTFRQ,
>> >>> -      * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
>> >>> -      */
>> >>> -     if (!acpi_disabled ||
>> >>> -         of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
>> >>> -             if (cntbase)
>> >>> -                     arch_timer_rate = arch_timer_mem_get_cntfrq(cntbase);
>> >>> -             else
>> >>> -                     arch_timer_rate = arch_timer_get_cntfrq();
>> >>> -     }
>> >>> -
>> >>> -     /* Check the timer frequency. */
>> >>> -     if (arch_timer_rate == 0)
>> >>> -             pr_warn("frequency not available\n");
>> >>> -}
>> >>> -
>> >>>  static void arch_timer_banner(unsigned type)
>> >>>  {
>> >>>       pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
>> >>> @@ -958,7 +934,17 @@ static int __init arch_timer_of_init(struct device_node *np)
>> >>>       for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
>> >>>               arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
>> >>>
>> >>> -     arch_timer_detect_rate(NULL, np);
>> >>> +     /*
>> >>> +      * Try to determine the frequency from the device tree,
>> >>> +      * if fail, get the frequency from the sysreg CNTFRQ.
>> >>> +      */
>> >>> +     if (!arch_timer_rate &&
>> >>
>> >> This variable is set only if "arm,armv7-timer" and "arm,armv7-timer-mem" are
>> >> declared together in the DT, right ?
>> >>
>> >> Two declarations for a single variable ? Ignore the !arch_timer_rate.
>> >
>> > In this function, we try to initialize per-CPU arm arch_timer by DT.
>> > this "!arch_timer_rate" is for testing that if we have got system
>> > counter frequency from the memory-mapped timer. If so, we just skip
>> > getting the frequency from DT or sysreg cntfrq again.
>> > This variable is set only if "arm,armv7-timer-mem" is initialized
>> > earlier than "arm,armv7-timer", in another word, maybe the node of
>> > "arm,armv7-timer-mem" is declared earlier than  "arm,armv7-timer-mem"
>> > one in DT.
>> >
>> > we do this check is for keeping the same init logic as before in the
>> > DT, try to avoid any possibility of  breaking devices which boot by
>> > DT.
>> >
>> >>
>> >>> +         of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
>> >>> +             arch_timer_rate = arch_timer_get_cntfrq();
>> >>> +     if (!arch_timer_rate) {
>> >>> +             pr_err(FW_BUG "frequency not available.\n");
>> >>> +             return -EINVAL;
>> >>> +     }
>> >>
>> >> Please, clarify this block, the conditions are unclear.
>> >
>> > this "!arch_timer_rate" is for verifying that if the system counter
>> > frequency we just got from DT or sysreg cntfrq is valid(non-zero).
>> >
>> > So here, you can see I check arch_timer_rate twice, but they are for
>> > different cases.
>>
>> I think about this several times,
>> For this block, it is a little unclear, so I think this will be better:
>>
>> + /*
>> + * Try to determine the frequency:
>> + * If we have got it in arch_timer_mem_of_init, we don't need to get
>> it again, skip.
>> + * Otherwise, try to get the frequency from the device tree,
>> + * if fail, try to get it from the sysreg CNTFRQ.
>> + * Last, verify the arch_timer_rate before leaving this block.
>> + */
>> + if (!arch_timer_rate) {
>> +         if (of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
>> +                 arch_timer_rate = arch_timer_get_cntfrq();
>> +         if (!arch_timer_rate) {
>> +                 pr_err(FW_BUG "frequency not available.\n");
>> +                 return -EINVAL;
>> +         }
>> + }
>
> Hi Fu Wei,
>
> in my previous comment, I was suggesting to remove the first arch_timer_rate
> check.
>
> The code assumes something else initialized this variable. There is clearly a
> conflict in the variable assignment. So if a node is defined twice for this
> variable, then it is more sane to consider the second pass overwrites the first
> one. As the DT are specifying the same rate, for -mem and !-mem, then it should
> have not an impact (to be verified).

So the code will be like this:

+ /*
+ * Try to determine the frequency:
+ * If we try to get the frequency from the device tree,
+ * if fail, try to get it from the sysreg CNTFRQ.
+ * Then verify the arch_timer_rate.
+ */
+ if (of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
+         arch_timer_rate = arch_timer_get_cntfrq();
+ if (!arch_timer_rate) {
+         pr_err(FW_BUG "frequency not available.\n");
+         return -EINVAL;
+ }

I am OK to delete the  first arch_timer_rate check,
If arch_timer_mem is initialized first,  we just overwrite the
existing rate to arch_timer rate.
This makes sense to me.

-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
