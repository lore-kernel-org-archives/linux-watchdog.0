Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:34481 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbdAQJW1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 17 Jan 2017 04:22:27 -0500
Received: by mail-it0-f41.google.com with SMTP id k200so11535211itb.1
        for <linux-watchdog@vger.kernel.org>; Tue, 17 Jan 2017 01:22:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170116170010.GH5908@leverpostej>
References: <20161221064603.11830-1-fu.wei@linaro.org> <20170116170010.GH5908@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Tue, 17 Jan 2017 17:14:31 +0800
Message-ID: <CADyBb7ukKotnhcY=uOsrqhVr_M9UbLU_UdKcKnTcBWfxF5VAyQ@mail.gmail.com>
Subject: Re: [PATCH v19 00/15] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
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

On 17 January 2017 at 01:00, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Wed, Dec 21, 2016 at 02:45:48PM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patchset:
>>     (1)Preparation for adding GTDT support in arm_arch_timer:
>>         1. Move some enums and marcos to header file;
>>         2. Add a new enum for spi type;
>>         3. Improve printk relevant code;
>>         4. Rename some enums and defines;
>
> Can we please rework these first few patches into a series:
>
> 1. Clean up printk() usage
> 2. Rename the type macros
> 3. Rename the PPI enum & enum values
> 4. Move the type macro and PPI enum into a header
> 5. Add new enum for SPIs
>
> Please leave CNTHCL_* as they originally were. It's not part of the
> interface of the driver, and leaving them as they are will save us an
> interdependency with KVM.
>
> I'm happy to queue that immediately, as it's purely structural and
> shouldn't have a functional impact anywhere. That will also shrink the
> series a bit, and we can rebase the following patches atop of that.

Thanks for your suggestion, I have finished this improvement.
It will be in v20.

https://git.linaro.org/people/fu.wei/linux.git/log/?h=topic-gtdt-wakeup-timer_upstream_v20_devel

>
>>         5. Rework PPI determination;
>>         6. Rework counter frequency detection;
>>         7. Refactor arch_timer_needs_probing, move it into DT init call
>>         8. Introduce some new structs and refactor the MMIO timer init code
>>         for reusing some common code.
>
> I'll review these in separate replies.
>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
