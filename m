Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:37684 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753442AbdCTNfP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Mar 2017 09:35:15 -0400
Received: by mail-it0-f49.google.com with SMTP id g138so95448278itb.0
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Mar 2017 06:35:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170317190539.GD15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org> <20170206185015.12296-5-fu.wei@linaro.org>
 <20170317190539.GD15909@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Mon, 20 Mar 2017 21:35:12 +0800
Message-ID: <CADyBb7utYy=VQ=hZnuecnCo1o=bXLg19ONHESUYfhBUdahoprw@mail.gmail.com>
Subject: Re: [PATCH v21 04/13] clocksource: arm_arch_timer: split
 arch_timer_rate for different types of timer
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

On 18 March 2017 at 03:05, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Feb 07, 2017 at 02:50:06AM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> Currently, arch_timer_rate is used to store the frequency got from per-cpu
>> arch-timer or the memory-mapped (MMIO) timers. But those values come from
>> different registers which should all be initialized by firmware.
>>
>> This patch remove arch_timer_rate, and use arch_timer_sysreg_freq and
>> arch_timer_mmio_freq instead.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>
> Thanks for attacking this. Generally, I do think this is the right thing
> to do.
>
> However...
>
>> @@ -1070,10 +1077,9 @@ static int __init arch_timer_mem_init(struct device_node *np)
>>        * Try to determine the frequency from the device tree,
>>        * if fail, get the frequency from the CNTFRQ reg of MMIO timer.
>>        */
>> -     if (!arch_timer_rate &&
>> -         of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
>> -             arch_timer_rate = arch_timer_get_mmio_freq(base);
>> -     if (!arch_timer_rate) {
>> +     if (of_property_read_u32(np, "clock-frequency", &arch_timer_mmio_freq))
>> +             arch_timer_mmio_freq = arch_timer_get_mmio_freq(base);
>> +     if (!arch_timer_mmio_freq) {
>>               pr_err(FW_BUG "frequency not available for MMIO timer.\n");
>>               ret = -EINVAL;
>>               goto out;
>
> ... unfortunately, I believe that this will break some DT platforms that
> have been (unintentionally) relying on the way currently allow the
> frequency to be probed from either the MMIO timer or the sysreg timer.
>

Ah, I 'm really not aware of this. Thanks for pointing it out.

> So while the above was my suggestion, it was not my best.
>
> For the timebeing, let's leave the single arch_timer_rate, but ensure
> that it doesn't get in the way fo the ACPI code, by making the ACPI
> probe path:
>
> * Probe the sysreg timers first, using the sysreg cntfrq().
>
> * Probe the MMIO timers second, verifying that each MMIO cntfrq matches
>   the already-probed sysreg cntfrq.
>
> ... which is what I believe you suggested previously.

OK, NP, will do this way.

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
