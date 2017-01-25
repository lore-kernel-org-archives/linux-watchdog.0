Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36594 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdAYHXd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 25 Jan 2017 02:23:33 -0500
Received: by mail-io0-f182.google.com with SMTP id j13so7399195iod.3
        for <linux-watchdog@vger.kernel.org>; Tue, 24 Jan 2017 23:23:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADyBb7sU6DVMk6px0963r8by--U-3k_XjESd88zZMkj7xbywgA@mail.gmail.com>
References: <20170118132541.8989-1-fu.wei@linaro.org> <20170118132541.8989-9-fu.wei@linaro.org>
 <20170124172400.GG7572@leverpostej> <CADyBb7sU6DVMk6px0963r8by--U-3k_XjESd88zZMkj7xbywgA@mail.gmail.com>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 25 Jan 2017 15:23:32 +0800
Message-ID: <CADyBb7tgsvi=7-mv29pJCTpLzsF_NedwAdObm0NEnYQPGuX5iw@mail.gmail.com>
Subject: Re: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
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

On 25 January 2017 at 14:46, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Mark,
>
> On 25 January 2017 at 01:24, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Wed, Jan 18, 2017 at 09:25:32PM +0800, fu.wei@linaro.org wrote:
>>> From: Fu Wei <fu.wei@linaro.org>
>>>
>>> The counter frequency detection call(arch_timer_detect_rate) combines two
>>> ways to get counter frequency: system coprocessor register and MMIO timer.
>>> But in a specific timer init code, we only need one way to try:
>>> getting frequency from MMIO timer register will be needed only when we
>>> init MMIO timer; getting frequency from system coprocessor register will
>>> be needed only when we init arch timer.
>>
>> When I mentioned this splitting before, I had mean that we'd completely
>> separate the two, with separate mmio_rate and sysreg_rate variables.
>
> sorry for misunderstanding.
>
> Are you saying :
>
> diff --git a/drivers/clocksource/arm_arch_timer.c
> b/drivers/clocksource/arm_arch_timer.c
> index 663a57a..eec92f6 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -65,7 +65,8 @@ struct arch_timer {
>
>  #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
>
> -static u32 arch_timer_rate;
> +static u32 arch_timer_sysreg_rate ;
> +static u32 arch_timer_mmio_rate;
>  static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI];
>
>  static struct clock_event_device __percpu *arch_timer_evt;
>
>
> But what have I learned From ARMv8 ARM is
> AArch64 System register CNTFRQ_EL0 is provided so that software can
> discover the frequency of the system counter.
> CNTFRQ(in CNTCTLBase and CNTBaseN) is provided so that software can
> discover the frequency of the system counter.
> The bit assignments of the registers are identical in the System
> register interface and in the memory-mapped system level interface.
> So I think they both contain the same value : the frequency of the
> system counter, just in different view, and can be accessed in
> different ways.
>
> So do we really need to separate mmio_rate and sysreg_rate variables?
>
> And for CNTFRQ(in CNTCTLBase and CNTBaseN) , we can NOT access it in
> Linux kernel (EL1),
> Because ARMv8 ARM says:
> In a system that implements both Secure and Non-secure states, this
> register is only accessible by Secure accesses.
> That means we still need to get the frequency of the system counter
> from CNTFRQ_EL0 in MMIO timer code.
> This have been proved when I tested this driver on foundation model, I
> got "0" when I access CNTFRQ from Linux kernel (Non-secure EL1)
>
> So I guess the logic of the original code is
>  static u32 arch_timer_rate keeps the frequency of the system counter,
>  no matter where the value comes from.
> Because  they should be the same value. if we have got the frequency
> of the system counter(arch_timer_rate != 0), then we don't need to get
> it again, even in anther way.

*IF*  the above is right,
For ARM32, boot with dtb,  the original logic and this patch work well.
For ARM64, boot with dtb,  if MMIO timer is probed first, and there is
not "clock-frequency" in the node. MMIO timer can't get  the
frequency. Because we will get "0" when we access CNTFRQ from Linux
kernel (Non-secure EL1), that means the original logic and this patch
won't work. To fix this issue, we need to get  the frequency  from
sysreg CNTFRQ_EL0.
For ARM64, boot with ACPI, the original logic and this patch work
well, because we always probe arch_timer first.

So *IF* I understand it correctly, May I suggest that we only get  the
frequency from sysreg CNTFRQ_EL0 in this driver?
I think that can simplify the code and avoid the issue when we boot
ARM64 with dtb.

Again,  please correct me if I misunderstand something.  :-)  Great
thanks for your help!

>
> But  the above is just my thought, and I believe you're the expert of
> ARM. So please correct me if I misunderstand something.  :-)
>
> Thanks!
>>
>> The probing logic relying on this is complicated and fragile, and I
>> think these patches are complicating that further (though I appreciate
>> that's far from the intent).
>>
>> I believe we need to split the MMIO and sysreg timer code apart
>> entirely. I've had a look at that today, though it's been fairly painful
>> so far. It appears some platforms may inadvertently be relying on the
>> order and manner in which the rates are probed, which is a major
>> headache.
>>
>> I will try to attack that some more tomorrow.
>>
>>> This patch separates paths to determine frequency:
>>> Separate out the MMIO frequency and the sysreg frequency detection call,
>>> and use the appropriate one for the counter.
>>>
>>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>>> ---
>>>  drivers/clocksource/arm_arch_timer.c | 40 ++++++++++++++++++++++--------------
>>>  1 file changed, 25 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>>> index 6484f84..9482481 100644
>>> --- a/drivers/clocksource/arm_arch_timer.c
>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>> @@ -488,23 +488,33 @@ static int arch_timer_starting_cpu(unsigned int cpu)
>>>       return 0;
>>>  }
>>>
>>> -static void arch_timer_detect_rate(void __iomem *cntbase)
>>> +static void __arch_timer_determine_rate(u32 rate)
>>>  {
>>> -     /* Who has more than one independent system counter? */
>>> -     if (arch_timer_rate)
>>> -             return;
>>> +     /* Check the timer frequency. */
>>> +     if (!arch_timer_rate) {
>>> +             if (rate)
>>> +                     arch_timer_rate = rate;
>>> +             else
>>> +                     pr_warn("frequency not available\n");
>>> +     } else if (rate && arch_timer_rate != rate) {
>>> +             pr_warn("got different frequency, keep original.\n");
>>> +     }
>>> +}
>>
>> This function should be killed off entirely. We need to be able to fail
>> the probe if we cannot determine the rate, and that means we need error
>> handling in the ACPI and DT cases anyway.
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
