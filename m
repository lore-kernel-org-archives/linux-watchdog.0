Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:35731 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbdC2FMK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Mar 2017 01:12:10 -0400
Received: by mail-it0-f53.google.com with SMTP id y18so139662953itc.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Mar 2017 22:12:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADyBb7uD1OqpPZf+ADsgbWryCGMGE3GqXOxz_4+1RzC1Pqsccg@mail.gmail.com>
References: <20170321163122.9183-1-fu.wei@linaro.org> <20170321163122.9183-3-fu.wei@linaro.org>
 <20170328145814.GE2123@mai> <CADyBb7uD1OqpPZf+ADsgbWryCGMGE3GqXOxz_4+1RzC1Pqsccg@mail.gmail.com>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 29 Mar 2017 13:11:58 +0800
Message-ID: <CADyBb7tzJAuvG73v6ZoBVO4ehCC3RMsc1pq5gKF2eQ94j6GXrg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Daniel,

On 29 March 2017 at 11:41, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Daniel,
>
> Great thanks for your review, allow me to answer your question below:
>
> On 28 March 2017 at 22:58, Daniel Lezcano <daniel.lezcano@linaro.org> wro=
te:
>> On Wed, Mar 22, 2017 at 12:31:13AM +0800, fu.wei@linaro.org wrote:
>>> From: Fu Wei <fu.wei@linaro.org>
>>>
>>> Currently, the counter frequency detection call(arch_timer_detect_rate)
>>> includes getting the frequency from the device-tree property, the per-c=
pu
>>> arch-timer and the memory-mapped (MMIO) timer interfaces.
>>> But reading device-tree property will be needed only when system boot w=
ith
>>> device-tree, and reading from the per-cpu arch-timer and the memory-map=
ped
>>> (MMIO) timer interfaces will be needed only when the system initializes
>>> the relevant timer.
>>>
>>> This patch separates out device-tree code, keep them in device-tree ini=
t
>>> function, and removes arch_timer_detect_rate founction, then uses the
>>> arch_timer_get_cntfrq and arch_timer_mem_get_cntfrq directly.
>>>
>>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>>> ---
>>>  drivers/clocksource/arm_arch_timer.c | 58 +++++++++++++++++++---------=
--------
>>>  1 file changed, 30 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource=
/arm_arch_timer.c
>>> index 843f923..29ca7d6 100644
>>> --- a/drivers/clocksource/arm_arch_timer.c
>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>> @@ -560,30 +560,6 @@ static u32 arch_timer_mem_get_cntfrq(void __iomem =
*cntbase)
>>>       return readl_relaxed(cntbase + CNTFRQ);
>>>  }
>>>
>>> -static void
>>> -arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
>>> -{
>>> -     /* Who has more than one independent system counter? */
>>> -     if (arch_timer_rate)
>>> -             return;
>>> -
>>> -     /*
>>> -      * Try to determine the frequency from the device tree or CNTFRQ,
>>> -      * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
>>> -      */
>>> -     if (!acpi_disabled ||
>>> -         of_property_read_u32(np, "clock-frequency", &arch_timer_rate)=
) {
>>> -             if (cntbase)
>>> -                     arch_timer_rate =3D arch_timer_mem_get_cntfrq(cnt=
base);
>>> -             else
>>> -                     arch_timer_rate =3D arch_timer_get_cntfrq();
>>> -     }
>>> -
>>> -     /* Check the timer frequency. */
>>> -     if (arch_timer_rate =3D=3D 0)
>>> -             pr_warn("frequency not available\n");
>>> -}
>>> -
>>>  static void arch_timer_banner(unsigned type)
>>>  {
>>>       pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
>>> @@ -958,7 +934,17 @@ static int __init arch_timer_of_init(struct device=
_node *np)
>>>       for (i =3D ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_P=
PI; i++)
>>>               arch_timer_ppi[i] =3D irq_of_parse_and_map(np, i);
>>>
>>> -     arch_timer_detect_rate(NULL, np);
>>> +     /*
>>> +      * Try to determine the frequency from the device tree,
>>> +      * if fail, get the frequency from the sysreg CNTFRQ.
>>> +      */
>>> +     if (!arch_timer_rate &&
>>
>> This variable is set only if "arm,armv7-timer" and "arm,armv7-timer-mem"=
 are
>> declared together in the DT, right ?
>>
>> Two declarations for a single variable ? Ignore the !arch_timer_rate.
>
> In this function, we try to initialize per-CPU arm arch_timer by DT.
> this "!arch_timer_rate" is for testing that if we have got system
> counter frequency from the memory-mapped timer. If so, we just skip
> getting the frequency from DT or sysreg cntfrq again.
> This variable is set only if "arm,armv7-timer-mem" is initialized
> earlier than "arm,armv7-timer", in another word, maybe the node of
> "arm,armv7-timer-mem" is declared earlier than  "arm,armv7-timer-mem"
> one in DT.
>
> we do this check is for keeping the same init logic as before in the
> DT, try to avoid any possibility of  breaking devices which boot by
> DT.
>
>>
>>> +         of_property_read_u32(np, "clock-frequency", &arch_timer_rate)=
)
>>> +             arch_timer_rate =3D arch_timer_get_cntfrq();
>>> +     if (!arch_timer_rate) {
>>> +             pr_err(FW_BUG "frequency not available.\n");
>>> +             return -EINVAL;
>>> +     }
>>
>> Please, clarify this block, the conditions are unclear.
>
> this "!arch_timer_rate" is for verifying that if the system counter
> frequency we just got from DT or sysreg cntfrq is valid(non-zero).
>
> So here, you can see I check arch_timer_rate twice, but they are for
> different cases.

I think about this several times,
For this block, it is a little unclear, so I think this will be better:

+ /*
+ * Try to determine the frequency:
+ * If we have got it in arch_timer_mem_of_init, we don't need to get
it again, skip.
+ * Otherwise, try to get the frequency from the device tree,
+ * if fail, try to get it from the sysreg CNTFRQ.
+ * Last, verify the arch_timer_rate before leaving this block.
+ */
+ if (!arch_timer_rate) {
+         if (of_property_read_u32(np, "clock-frequency", &arch_timer_rate)=
)
+                 arch_timer_rate =3D arch_timer_get_cntfrq();
+         if (!arch_timer_rate) {
+                 pr_err(FW_BUG "frequency not available.\n");
+                 return -EINVAL;
+         }
+ }

>
>>
>>>
>>>       arch_timer_c3stop =3D !of_property_read_bool(np, "always-on");
>>>
>>> @@ -1069,7 +1055,19 @@ static int __init arch_timer_mem_init(struct dev=
ice_node *np)
>>>               goto out;
>>>       }
>>>
>>> -     arch_timer_detect_rate(base, np);
>>> +     /*
>>> +      * Try to determine the frequency from the device tree,
>>> +      * if fail, get the frequency from the CNTFRQ reg of MMIO timer.
>>> +      */
>>> +     if (!arch_timer_rate &&
>>> +         of_property_read_u32(np, "clock-frequency", &arch_timer_rate)=
)
>>> +             arch_timer_rate =3D arch_timer_mem_get_cntfrq(base);
>>> +     if (!arch_timer_rate) {
>>> +             pr_err(FW_BUG "MMIO frequency not available.\n");
>>> +             ret =3D -EINVAL;
>>> +             goto out;
>>> +     }
>>> +
>>>       ret =3D arch_timer_mem_register(base, irq);
>>>       if (ret)
>>>               goto out;
>>> @@ -1130,8 +1128,12 @@ static int __init arch_timer_acpi_init(struct ac=
pi_table_header *table)
>>>               map_generic_timer_interrupt(gtdt->non_secure_el2_interrup=
t,
>>>               gtdt->non_secure_el2_flags);
>>>
>>> -     /* Get the frequency from CNTFRQ */
>>> -     arch_timer_detect_rate(NULL, NULL);
>>> +     /* Get the frequency from the sysreg CNTFRQ */
>>> +     arch_timer_rate =3D arch_timer_get_cntfrq();
>>> +     if (!arch_timer_rate) {
>>> +             pr_err(FW_BUG "frequency not available.\n");
>>> +             return -EINVAL;
>>> +     }
>>>
>>>       arch_timer_uses_ppi =3D arch_timer_select_ppi();
>>>       if (!arch_timer_ppi[arch_timer_uses_ppi]) {
>>> --
>>> 2.9.3
>>>
>>
>> --
>>
>>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for =
ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>
>
>
> --
> Best regards,
>
> Fu Wei
> Software Engineer
> Red Hat



--=20
Best regards,

Fu Wei
Software Engineer
Red Hat
