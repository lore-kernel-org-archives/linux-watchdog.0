Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33041 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbcJZI2p (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Oct 2016 04:28:45 -0400
Received: by mail-oi0-f41.google.com with SMTP id y2so137942330oie.0
        for <linux-watchdog@vger.kernel.org>; Wed, 26 Oct 2016 01:28:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161020153244.GB27598@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-4-git-send-email-fu.wei@linaro.org> <20161020153244.GB27598@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 26 Oct 2016 16:28:43 +0800
Message-ID: <CADyBb7tLeOoDsYHx_qE7TQgq-0VDVzY6E-t8nNmC=ge5u5xhMQ@mail.gmail.com>
Subject: Re: [PATCH v14 3/9] clocksource/drivers/arm_arch_timer: Improve
 printk relevant code
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

On 20 October 2016 at 23:32, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Sep 29, 2016 at 02:17:11AM +0800, fu.wei@linaro.org wrote:
>>  static void arch_timer_banner(unsigned type)
>>  {
>> -     pr_info("Architected %s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
>> -                  type & ARCH_CP15_TIMER ? "cp15" : "",
>> -                  type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
>> -                  type & ARCH_MEM_TIMER ? "mmio" : "",
>> -                  (unsigned long)arch_timer_rate / 1000000,
>> -                  (unsigned long)(arch_timer_rate / 10000) % 100,
>> -                  type & ARCH_CP15_TIMER ?
>> -                  (arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
>> -                     "",
>> -                  type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
>> -                  type & ARCH_MEM_TIMER ?
>> -                     arch_timer_mem_use_virtual ? "virt" : "phys" :
>> -                     "");
>> +     pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
>> +             type & ARCH_CP15_TIMER ? "cp15" : "",
>> +             type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
>> +             type & ARCH_MEM_TIMER ? "mmio" : "",
>> +             (unsigned long)arch_timer_rate / 1000000,
>> +             (unsigned long)(arch_timer_rate / 10000) % 100,
>> +             type & ARCH_CP15_TIMER ?
>> +             (arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
>> +             "",
> Please restore the additional indent on this line...
>
>> +             type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
>> +             type & ARCH_MEM_TIMER ?
>> +             arch_timer_mem_use_virtual ? "virt" : "phys" :
>> +             "");
>
> ... and these two.
>
> No matter what checkpatch says, I prefer the code that way so as to keep
> the ternary clear.

yes, NP, I have fixed it :-)

>
> [...]
>
>> @@ -768,7 +769,7 @@ static int __init arch_timer_init(void)
>>               return ret;
>>
>>       arch_timer_kvm_info.virtual_irq = arch_timer_ppi[VIRT_PPI];
>> -
>> +
>
> Please mention the whitespace fixup in the commit message. It's
> surprising otherwise.

OK, added this message.

>
> With all that:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Great thanks :-)

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
