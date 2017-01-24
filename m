Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:35520 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAXFLS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 24 Jan 2017 00:11:18 -0500
Received: by mail-it0-f48.google.com with SMTP id 203so79318648ith.0
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Jan 2017 21:11:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170123185418.GA961@leverpostej>
References: <20170118132541.8989-1-fu.wei@linaro.org> <20170123185418.GA961@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Tue, 24 Jan 2017 13:11:17 +0800
Message-ID: <CADyBb7tT2vWDUrzHV-+W8u8YUWwRTHziU9_ueZK0qkn=YZxHqw@mail.gmail.com>
Subject: Re: [PATCH v20 00/17] acpi, clocksource: add GTDT driver and GTDT
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

Hi Mark

On 24 January 2017 at 02:54, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Wed, Jan 18, 2017 at 09:25:24PM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patchset:
>>     (1)Preparation for adding GTDT support in arm_arch_timer:
>>         1. Clean up printk() usage
>>         2. Rename the type macros
>>         3. Rename the PPI enum & enum values
>>         4. Move the type macro and PPI enum into the header file
>>         5. Add new enum for SPIs
>>         6. Rework PPI determination;
>
> I've taken these few patches onto a preliminary/unstable branch [1].

Many thanks for the good news!

>
> I haven't had the time to take a look at the rest of the series yet. I
> intend to go over that tomorrow, picking what I can, and leaving
> feedback for anything that will need rework.

Thanks, I will wait for your feedback, and improve this patchset ASAP.

>
> Thanks,
> Mark.
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arch-timer/updates



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
