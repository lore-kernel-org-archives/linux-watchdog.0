Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33447 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757758AbcJZJCV (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Oct 2016 05:02:21 -0400
Received: by mail-oi0-f51.google.com with SMTP id y2so138681363oie.0
        for <linux-watchdog@vger.kernel.org>; Wed, 26 Oct 2016 02:01:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161021112120.GC16630@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-6-git-send-email-fu.wei@linaro.org> <20161020165747.GD27598@leverpostej>
 <20161021111352.GA16630@leverpostej> <20161021112120.GC16630@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 26 Oct 2016 16:54:48 +0800
Message-ID: <CADyBb7ukv4boB7iSt3cxr6SQK_KNsSirAWuP4J+zU-=E2QaEQA@mail.gmail.com>
Subject: Re: [PATCH v14 5/9] clocksource/drivers/arm_arch_timer: Simplify ACPI
 support code.
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Wei Huang <wei@redhat.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Al Stone <al.stone@linaro.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        Timur Tabi <timur@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Len Brown <lenb@kernel.org>,
        "Abdulhamid, Harb" <harba@codeaurora.org>,
        linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jon Masters <jcm@redhat.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Christopher Covington <cov@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        G Gregory <graeme.gregory@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, rruigrok@codeaurora.org,
        Leo Duran <leo.duran@amd.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Christoffer Dall <christoffer.dall@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mark,

On 21 October 2016 at 19:21, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Oct 21, 2016 at 12:14:01PM +0100, Mark Rutland wrote:
>> On Thu, Oct 20, 2016 at 05:58:17PM +0100, Mark Rutland wrote:
>> > On Thu, Sep 29, 2016 at 02:17:13AM +0800, fu.wei@linaro.org wrote:
>> > > + arch_timer_ppi[PHYS_NONSECURE_PPI] = acpi_gtdt_map_ppi(PHYS_NONSECURE_PPI);
>> > > + arch_timer_ppi[VIRT_PPI] = acpi_gtdt_map_ppi(VIRT_PPI);
>> > > + arch_timer_ppi[HYP_PPI] = acpi_gtdt_map_ppi(HYP_PPI);
>> > > + /* Always-on capability */
>> > > + arch_timer_c3stop = acpi_gtdt_c3stop();
>> >
>> > ... I think we should check the flag on the relevant interrupt, though
>> > that's worth clarifying.
>>
>> I see I misread the spec; this is part of the common flags.
>>
>> Please ignore this point; sorry for the noise.
>
> Actually, I misread the spec this time around; the flag *can* differ per
> interrupt for the sysreg/cp15 timer, but not for the MMIO timers where
> the flag is in a common field.
>
> So please *do* consider the above.

yes , you are right , will do
Thanks :-)

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
