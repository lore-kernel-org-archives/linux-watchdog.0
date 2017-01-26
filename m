Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36448 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbdAZFzz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 26 Jan 2017 00:55:55 -0500
Received: by mail-it0-f41.google.com with SMTP id c7so123966446itd.1
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Jan 2017 21:55:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170125173516.GA25470@leverpostej>
References: <20170118132541.8989-1-fu.wei@linaro.org> <20170118132541.8989-9-fu.wei@linaro.org>
 <20170124172400.GG7572@leverpostej> <CADyBb7sU6DVMk6px0963r8by--U-3k_XjESd88zZMkj7xbywgA@mail.gmail.com>
 <e62c6f73-16e0-2764-126f-b8ed6adc3489@codeaurora.org> <20170125173516.GA25470@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Thu, 26 Jan 2017 13:55:53 +0800
Message-ID: <CADyBb7sL0-CW=xiHyCEv7vxGz0cjfCGSkt6-XvAOC6ZGuY3_CQ@mail.gmail.com>
Subject: Re: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
To: Mark Rutland <mark.rutland@arm.com>
Cc: Christopher Covington <cov@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mark, Christopher,

On 26 January 2017 at 01:36, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Jan 25, 2017 at 10:38:01AM -0500, Christopher Covington wrote:
>> On 01/25/2017 01:46 AM, Fu Wei wrote:
>> > On 25 January 2017 at 01:24, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> On Wed, Jan 18, 2017 at 09:25:32PM +0800, fu.wei@linaro.org wrote:
>> >>> From: Fu Wei <fu.wei@linaro.org>
>
>> > And for CNTFRQ(in CNTCTLBase and CNTBaseN) , we can NOT access it in
>> > Linux kernel (EL1),
>> > Because ARMv8 ARM says:
>> > In a system that implements both Secure and Non-secure states, this
>> > register is only accessible by Secure accesses.
>> > That means we still need to get the frequency of the system counter
>> > from CNTFRQ_EL0 in MMIO timer code.
>> > This have been proved when I tested this driver on foundation model, I
>> > got "0" when I access CNTFRQ from Linux kernel (Non-secure EL1)
>>
>> That sounds like a firmware problem. Firmware in EL3 is supposed to write
>> the value into CNTFRQ.
>
> Definitely. FW *should* program the CNTFRQ_EL0 CPU registers and any
> MMIO CNTFRQ registers.

Many thanks for the explanation. This might be the problem. Maybe we
can check the UEFI :-)

>
>> If you're not currently using any firmware, I'd
>> recommend the bootwrapper on models/simulators/emulators.
>>
>> http://git.kernel.org/cgit/linux/kernel/git/mark/boot-wrapper-aarch64.git/tree/arch/aarch64/boot.S#n48
>
> Unfortunately, the boot-wrapper only programs the CNTFRQ_EL0 CPU system
> registers, and does not program any MMIO CNTFRQ registers.
>
> IIRC the models it was originally written for didn't have any (and we
> had no DT binding until far later...). Luckily the model DTs do not
> expose any MMIO timer addresses to the kernel currently.

But according to another document(ARMv8-A Foundation Platform User
Guide  ARM DUI0677K), Table 3-2 ARMv8-A Foundation Platform memory
map,
we may have two frames in the Generic timer block, right?


>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
