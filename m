Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:34201 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933419AbdCaRzb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 31 Mar 2017 13:55:31 -0400
Received: by mail-io0-f173.google.com with SMTP id b140so44450735iof.1
        for <linux-watchdog@vger.kernel.org>; Fri, 31 Mar 2017 10:55:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328145325.GD8643@leverpostej>
References: <20170321163122.9183-1-fu.wei@linaro.org> <1cc5a994-0af6-79ea-930d-44b3fc789427@jonmasters.org>
 <CADyBb7ujZKDF0aUJZRUN81jor04mZ-V5ESWScAjaxoHQUeVFSA@mail.gmail.com>
 <20170328130552.GA8643@leverpostej> <CADyBb7vddnQ4TZXaem3q=+v=vC41J7O4cVsokn04S2jGGU8veA@mail.gmail.com>
 <20170328145325.GD8643@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Sat, 1 Apr 2017 01:55:29 +0800
Message-ID: <CADyBb7uP031z6UoB75yEW10xsgZmY2j6-TmZuF8YaRxi1bmSfg@mail.gmail.com>
Subject: Re: [PATCH v22 00/11] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jon Masters <jcm@jonmasters.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On 28 March 2017 at 22:53, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Tue, Mar 28, 2017 at 10:29:10PM +0800, Fu Wei wrote:
>> On 28 March 2017 at 21:05, Mark Rutland <mark.rutland@arm.com> wrote:
>> > Sorry for the delay; I have not had the time to focus on this as I would
>> > like to. I'm happy with patches 1-4, but from patch 5 onwards, there's
>> > one change I'd like to see.
>> >
>> > I'd prefer that mmio timer frame rame N was always stored at
>> > arch_timer_mem::frame[N], rather than arch_timer_mem::frame[] being in
>> > an arbitrary order. That will make arch_timer_mem_frame::frame_nr
>> > redundant.
>> >
>> > To allow arch_timer_mem::frame[] this to be sparse, I'm happy to have a
>> > bool arch_timer_mem_frame::valid field that we set when probing each
>> > frame. Then we don't need arch_timer_mem::num_frames.
>> >
>> > This will make iterating over the frames far less confusing, and makes
>> > it simple to detect when a frame number is erroneously reused.
>> >
>> > Otherwise, I'm largely happy to pick the rest and apply any fixups
>> > myself.
>>
>> Great thanks for your feedback!
>> I will follow your suggestion to improve my patches, then post it in a day.
>
> Thanks, that is much appreciated.
>
>> So I will rebase my patchset on arch-timer/gtdt branch of your REPO
>> https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arch-timer/gtdt
>
> Yes please! The current HEAD should be:
>
> ebbfe8889cffa12f ("clocksource: arm_arch_timer: move arch_timer_needs_of_probing into DT init call").

Because there are some improvements on the first 4 patches, so I
fetched your gtdt branch, then rebase my v23  to the
arch-timer/cleanup

Thanks for your help! :-)

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
