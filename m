Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33104 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbcJZI07 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Oct 2016 04:26:59 -0400
Received: by mail-oi0-f48.google.com with SMTP id y2so137902883oie.0
        for <linux-watchdog@vger.kernel.org>; Wed, 26 Oct 2016 01:26:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161020150933.GK10234@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-3-git-send-email-fu.wei@linaro.org> <20161020150933.GK10234@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 26 Oct 2016 16:26:58 +0800
Message-ID: <CADyBb7t5TdN=MHdai7KbzR4RA1Zd503kZ8pqSJgcT1xK4OaBXg@mail.gmail.com>
Subject: Re: [PATCH v14 2/9] clocksource/drivers/arm_arch_timer: Add a new
 enum for spi type
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

On 20 October 2016 at 23:09, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Sep 29, 2016 at 02:17:10AM +0800, fu.wei@linaro.org wrote:
>> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
>> index 6f06481..16dcd10 100644
>> --- a/include/clocksource/arm_arch_timer.h
>> +++ b/include/clocksource/arm_arch_timer.h
>> @@ -45,6 +45,12 @@ enum ppi_nr {
>>       MAX_TIMER_PPI
>>  };
>>
>> +enum spi_nr {
>> +     PHYS_SPI,
>> +     VIRT_SPI,
>> +     MAX_TIMER_SPI
>> +};
>
> Please rename this to arch_timer_spi_nr (as with patch 1 for
> s/ppi_nr/arch_timer_ppi_nr/). With that:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

OK, NP, done :-)

Great thanks!

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
