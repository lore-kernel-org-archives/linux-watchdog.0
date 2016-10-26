Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35268 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbcJZIb4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Oct 2016 04:31:56 -0400
Received: by mail-oi0-f46.google.com with SMTP id i127so83494267oia.2
        for <linux-watchdog@vger.kernel.org>; Wed, 26 Oct 2016 01:31:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161020144510.GJ10234@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-2-git-send-email-fu.wei@linaro.org> <20161020144510.GJ10234@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 26 Oct 2016 16:31:55 +0800
Message-ID: <CADyBb7shWfCQycmo0GcheX2NSsrjYBpzdtYFqymvDNCKi0QM2A@mail.gmail.com>
Subject: Re: [PATCH v14 1/9] clocksource/drivers/arm_arch_timer: Move enums
 and defines to header file
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

Hi Mark

On 20 October 2016 at 22:45, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Thu, Sep 29, 2016 at 02:17:09AM +0800, fu.wei@linaro.org wrote:
>> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
>> index caedb74..6f06481 100644
>> --- a/include/clocksource/arm_arch_timer.h
>> +++ b/include/clocksource/arm_arch_timer.h
>> @@ -19,6 +19,9 @@
>
> Please add:
>
> #include <linux/bitops.h>
>
> ... immediately before the includes below; it's needed to ensure that
> BIT() is defined in all cases. Previously we were relying on implicit
> header includes, which is not good practice.

yes, you are right!
added this, thanks !

>
>>  #include <linux/timecounter.h>
>>  #include <linux/types.h>
>>
>> +#define ARCH_CP15_TIMER                      BIT(0)
>> +#define ARCH_MEM_TIMER                       BIT(1)
>
> If we're going to expose these in a header, it would be better to rename
> them to something that makes their usage/meaning clear. These should
> probably be ARCH_TIMER_TYPE_{CP15,MEM}.
>
> I guess this can wait for subsequent cleanup.
>
>> +enum ppi_nr {
>> +     PHYS_SECURE_PPI,
>> +     PHYS_NONSECURE_PPI,
>> +     VIRT_PPI,
>> +     HYP_PPI,
>> +     MAX_TIMER_PPI
>> +};
>
> Please rename this to arch_timer_ppi_nr (updating the single user in
> drivers/clocksource/arm_arch_timer.c). That'll avoid the potential for
> name clashes in files this happens to get included in (potentially
> transitively via other headers).

OK, NP, I have fixed this.

>
> With those changes (regardless of the ARCH_TIMER_TYPE_* bits):
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

For ARCH_TIMER_TYPE_*, maybe I should add a patch at the end of this
patchset to fix it, OK ?

Thanks for ACK :-)

>
> Thanks,
> Mark.
>
>> +
>>  #define ARCH_TIMER_PHYS_ACCESS               0
>>  #define ARCH_TIMER_VIRT_ACCESS               1
>>  #define ARCH_TIMER_MEM_PHYS_ACCESS   2
>> --
>> 2.7.4
>>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
