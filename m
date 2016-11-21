Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35741 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbcKUOI2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 21 Nov 2016 09:08:28 -0500
Received: by mail-io0-f181.google.com with SMTP id n13so40368106ioe.2
        for <linux-watchdog@vger.kernel.org>; Mon, 21 Nov 2016 06:08:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161118195244.GL1197@leverpostej>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-8-git-send-email-fu.wei@linaro.org> <20161118195244.GL1197@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Mon, 21 Nov 2016 22:08:26 +0800
Message-ID: <CADyBb7v356dad+5A-31086=ALJ-+WAKgJ3fRLj2mCcuakRNGAQ@mail.gmail.com>
Subject: Re: [PATCH v16 07/15] clocksource/drivers/arm_arch_timer: Refactor
 arch_timer_detect_rate to keep dt code in *_of_init
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mark

On 19 November 2016 at 03:52, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Nov 16, 2016 at 09:49:00PM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The patch refactor original arch_timer_detect_rate function:
>>     (1) Separate out device-tree code, keep them in device-tree init
>>     function:
>>         arch_timer_of_init,
>>         arch_timer_mem_init;
>
> Please write a real commit message.

Sorry, will do

Since this patch will be separated into two patches.
the first patch will be separating out device-tree code, so commit
message can be:
-----------------
clocksource/drivers/arm_arch_timer: Separate out device-tree code from
arch_timer_detect_rate

Currently, the arch_timer_detect_rate can get system counter frequency
from device-tree, sysreg timers and MMIO timers. This is unnecessary and
confusing. For ACPI, we don't need a function included device-tree code.

This patch factors the device-tree related code out into device-tree
init function:
arch_timer_of_init and arch_timer_mem_init.
-----------------

the second patch will be split arch_timer_detect_rate in two, one is
for the MMIO timer,
another is for the CP15 timers, so commit message can be:
-----------------
clocksource/drivers/arm_arch_timer:split arch_timer_detect_rate for
the MMIO and CP15 timers

The arch_timer_detect_rate can get system counter frequency sysreg timers a=
nd
MMIO timers. This is unnecessary. For initializing sysreg timers, we
shouldn't try to
access MMIO timers.

This patch split arch_timer_detect_rate into two function:
arch_timer_detect_rate and arch_timer_mem_detect_rate.
-----------------

Please correct me if these commit message are inappropriate.
Great thanks

>
>>     (2) Improve original mechanism, if getting from memory-mapped timer
>>     fail, try arch_timer_get_cntfrq() again.
>
> This is *not* a refactoring. It's completely unrelated to the supposed
> refactoring from point (1), and if necessary, should be a separate
> patch.
>
> *Why* are you maknig this change? Does some ACPI platform have an MMIO
> timer with an ill-configured CNTFRQ register? If so, report that to the
> vendor. Don't add yet another needless bodge.
>
> I'd really like to split the MMIO and CP15 timers, and this is yet
> another hack that'll make it harder to do so.

you are right, I should split this founction for the MMIO and CP15 timers

>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 45 +++++++++++++++++++++++------=
-------
>>  1 file changed, 29 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/=
arm_arch_timer.c
>> index af22953..fe4e812 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -487,27 +487,31 @@ static int arch_timer_starting_cpu(unsigned int cp=
u)
>>       return 0;
>>  }
>>
>> -static void
>> -arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
>> +static void arch_timer_detect_rate(void __iomem *cntbase)
>>  {
>>       /* Who has more than one independent system counter? */
>>       if (arch_timer_rate)
>>               return;
>> -
>>       /*
>> -      * Try to determine the frequency from the device tree or CNTFRQ,
>> -      * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
>> +      * If we got memory-mapped timer(cntbase !=3D NULL),
>> +      * try to determine the frequency from CNTFRQ in memory-mapped tim=
er.
>>        */
>
> *WHY* ?
>
> If we're sharing arch_timer_rate across MMIO and sysreg timers, the
> sysreg value is alreayd sufficient.

yes, we are sharing arch_timer_rate across MMIO and sysreg timers,
But for booting with device-tree, we can't make sure which timer will
be initialized first,
so we may need :
       if (arch_timer_rate)
               return;

>
> If we're not, they should be completely independent.
>
>> -     if (!acpi_disabled ||
>> -         of_property_read_u32(np, "clock-frequency", &arch_timer_rate))=
 {
>> -             if (cntbase)
>> -                     arch_timer_rate =3D readl_relaxed(cntbase + CNTFRQ=
);
>> -             else
>> -                     arch_timer_rate =3D arch_timer_get_cntfrq();
>> -     }
>> +     if (cntbase)
>> +             arch_timer_rate =3D readl_relaxed(cntbase + CNTFRQ);
>> +     /*
>> +      * Because in a system that implements both Secure and
>> +      * Non-secure states, CNTFRQ is only accessible in Secure state.
>
> That's true for the CNTCTLBase frame, but that doesn't matter.
>
> The CNTBase<n> frames should have a readable CNTFRQ.

Sorry, maybe I misunderstand the ARM doc, but in I3.5.7
CNTFRQ, Counter-timer Frequency, it says:
-----------------
For the CNTBaseN and CNTEL0BaseN frames:
=E2=80=A2 A RO copy of CNTFRQ is implemented in the CNTBaseN frame when bot=
h:
  =E2=80=94 CNTACR<n>.RFRQ is 1.
  =E2=80=94 Bit[0] of CNTTIDR.Frame<n> is 1.
  Otherwise the encoding in CNTBaseN is RES 0.
=E2=80=A2 When CNTFRQ is RO in the CNTBaseN frame, it is also RO in the
CNTEL0BaseN frame
  if bit[2] of CNTTIDR.Frame<n> is 1 and either:
  =E2=80=94 The value of CNTEL0ACR.EL0VCTEN is 1.
  =E2=80=94 The value of CNTEL0ACR.EL0PCTEN is 1.
  Otherwise the CNTFRQ encoding in CNTEL0BaseN frame is RES 0.
In a system that implements both Secure and Non-secure states, this
register is only accessible by
Secure accesses.
-----------------

So I think this is for both  CNTBaseN and CNTEL0BaseN frames?
Please correct me.

When I tested my patchset on Foundation model, I got "0" from
CNTBaseN's CNTFRQ, so mybe is not implemented?

>
>> +      * So the operation above may fail, even if (cntbase !=3D NULL),
>> +      * especially on ARM64.
>> +      * In this case, we can try cntfrq_el0(system coprocessor register=
).
>> +      */
>> +     if (!arch_timer_rate)
>> +             arch_timer_rate =3D arch_timer_get_cntfrq();
>> +     else
>> +             return;
>
> Urrgh.
>
> Please have separate paths to determine the MMIO frequency and the
> sysreg frequency, and use the appropriate one for the counter you want
> to know the frequency of.

OK, will do

>
> Thanks,
> Mark.



--=20
Best regards,

Fu Wei
Software Engineer
Red Hat
