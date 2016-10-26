Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35316 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbcJZIYd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Oct 2016 04:24:33 -0400
Received: by mail-oi0-f42.google.com with SMTP id i127so83327493oia.2
        for <linux-watchdog@vger.kernel.org>; Wed, 26 Oct 2016 01:24:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161020151655.GA27598@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <20161020143101.GI10234@leverpostej> <20161020145752.GC8731@red-moon> <20161020151655.GA27598@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 26 Oct 2016 16:24:31 +0800
Message-ID: <CADyBb7tePxYAk5oWv3ZKVeQsNaTWkJ=ddqB1D1XJRUfyOe-9Rg@mail.gmail.com>
Subject: Re: [PATCH v14 0/9] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
To: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
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

On 20 October 2016 at 23:17, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Oct 20, 2016 at 03:57:52PM +0100, Lorenzo Pieralisi wrote:
>> On Thu, Oct 20, 2016 at 03:31:01PM +0100, Mark Rutland wrote:
>> > Hi,
>> >
>> > On Thu, Sep 29, 2016 at 02:17:08AM +0800, fu.wei@linaro.org wrote:
>> > > From: Fu Wei <fu.wei@linaro.org>
>> >
>> > > This patchset depends on the following patchset:
>> > > [UPDATE PATCH V11 1/8] ACPI: I/O Remapping Table (IORT) initial support
>> > > https://lkml.org/lkml/2016/9/12/949
>> >
>> > Is there a branch with these anywhere? I wasn't Cc'd on those and it's
>> > rather difficult to get at the series from an LKML link.
>>
>> For the records, the dependency above has now been merged and it was
>> just a directory creation dependency (drivers/acpi/arm64, where some of
>> the code in this series will live).
>
> Ah, I see. That saves us all some trouble, then. :)

Sorry, I forgot to delete this in v14 cover letter.
The IORT patchset has been merged in to the mainline,
we don't need to mention this anymore. :-)

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
