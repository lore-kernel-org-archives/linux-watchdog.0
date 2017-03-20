Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:36965 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbdCTH21 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Mar 2017 03:28:27 -0400
Received: by mail-it0-f53.google.com with SMTP id g138so85173740itb.0
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Mar 2017 00:27:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170317180725.GC15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org> <20170206185015.12296-4-fu.wei@linaro.org>
 <20170317180725.GC15909@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Mon, 20 Mar 2017 14:59:35 +0800
Message-ID: <CADyBb7spKzLKb2wZFRDcXLPBmxkgV+JPAoCiDbSXmFq9qqbuCw@mail.gmail.com>
Subject: Re: [PATCH v21 03/13] clocksource: arm_arch_timer: remove arch_timer_detect_rate
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

On 18 March 2017 at 02:07, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Feb 07, 2017 at 02:50:05AM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The original counter frequency detection call(arch_timer_detect_rate)
>> include getting the frequency from the per-cpu arch-timer and the
>> memory-mapped (MMIO) timer interfaces. But they will be needed only when
>> the system initializes the relevant timer.
>>
>> This patch remove arch_timer_detect_rate founction, and use the
>> arch_timer_get_sysreg_freq and arch_timer_get_mmio_freq directly.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>
> Could you please fold this with the prior patch?

Sure, will do

>
>> @@ -1087,7 +1072,12 @@ static int __init arch_timer_mem_init(struct device_node *np)
>>        */
>>       if (!arch_timer_rate &&
>>           of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
>> -             arch_timer_detect_rate(base);
>> +             arch_timer_rate = arch_timer_get_mmio_freq(base);
>> +     if (!arch_timer_rate) {
>> +             pr_err(FW_BUG "frequency not available for MMIO timer.\n");
>
> It would be better to say "MMIO frequency not available.\n" here.

thanks , will do

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
