Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35449 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbcLIIYz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 9 Dec 2016 03:24:55 -0500
Received: by mail-io0-f172.google.com with SMTP id h30so44850259iod.2
        for <linux-watchdog@vger.kernel.org>; Fri, 09 Dec 2016 00:24:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481231430.5946.34.camel@perches.com>
References: <20161208173319.6618-1-fu.wei@linaro.org> <20161208173319.6618-4-fu.wei@linaro.org>
 <1481231430.5946.34.camel@perches.com>
From: Fu Wei <fu.wei@linaro.org>
Date: Fri, 9 Dec 2016 16:24:54 +0800
Message-ID: <CADyBb7uW6rsKVRRy_CJDmsDxK7qm=Trgae46NdbAKtmQd_DD8Q@mail.gmail.com>
Subject: Re: [PATCH v18 03/15] clocksource/drivers/arm_arch_timer: Improve
 printk relevant code
To: Joe Perches <joe@perches.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

Hi Joe,

On 9 December 2016 at 05:10, Joe Perches <joe@perches.com> wrote:
> On Fri, 2016-12-09 at 01:33 +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patch defines pr_fmt(fmt) for all pr_* functions,
>> then the pr_* doesn't need to add "arch_timer:" everytime.
>
> trivia:
>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> []
>> @@ -966,7 +967,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
>>
>>       ret = -EINVAL;
>>       if (!irq) {
>> -             pr_err("arch_timer: Frame missing %s irq",
>> +             pr_err("Frame missing %s irq",
>>                      arch_timer_mem_use_virtual ? "virt" : "phys");
>>               goto out;
>>       }
>
> Missing terminating newline
>
>                 pr_err("Frame missing %s irq\n",

yes, you are right , will fix it. :-)
Thanks


-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
