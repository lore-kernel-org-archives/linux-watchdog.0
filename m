Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdAYPiQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 25 Jan 2017 10:38:16 -0500
Subject: Re: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
To: Fu Wei <fu.wei@linaro.org>, Mark Rutland <mark.rutland@arm.com>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-9-fu.wei@linaro.org> <20170124172400.GG7572@leverpostej>
 <CADyBb7sU6DVMk6px0963r8by--U-3k_XjESd88zZMkj7xbywgA@mail.gmail.com>
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
From: Christopher Covington <cov@codeaurora.org>
Message-ID: <e62c6f73-16e0-2764-126f-b8ed6adc3489@codeaurora.org>
Date: Wed, 25 Jan 2017 10:38:01 -0500
MIME-Version: 1.0
In-Reply-To: <CADyBb7sU6DVMk6px0963r8by--U-3k_XjESd88zZMkj7xbywgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fu,

On 01/25/2017 01:46 AM, Fu Wei wrote:
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

That sounds like a firmware problem. Firmware in EL3 is supposed to write
the value into CNTFRQ. If you're not currently using any firmware, I'd
recommend the bootwrapper on models/simulators/emulators.

http://git.kernel.org/cgit/linux/kernel/git/mark/boot-wrapper-aarch64.git/tree/arch/aarch64/boot.S#n48

Cheers,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
