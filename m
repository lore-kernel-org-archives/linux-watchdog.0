Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:38602 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbdDFSHl (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Apr 2017 14:07:41 -0400
Received: by mail-it0-f45.google.com with SMTP id y18so30801060itc.1
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Apr 2017 11:07:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170406175252.GB11871@leverpostej>
References: <20170331175105.8370-1-fu.wei@linaro.org> <20170331175105.8370-10-fu.wei@linaro.org>
 <20170405183808.GB27550@leverpostej> <CADyBb7sz6ongbyqR0FzBZybJBYwnLvqV+NsX1+W=6tv0_vLt1g@mail.gmail.com>
 <20170406172410.GA11871@leverpostej> <CADyBb7vEHQCpMoXhtBMGf_iou1qxsvVSJfxcYy5W33SNFyCwwA@mail.gmail.com>
 <20170406175252.GB11871@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Fri, 7 Apr 2017 02:07:40 +0800
Message-ID: <CADyBb7suSedttCma7Q6-RGfduJBOD5AWCpOA3pyvjDn6z+uSow@mail.gmail.com>
Subject: Re: [PATCH v23 09/11] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
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

On 7 April 2017 at 01:52, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Apr 07, 2017 at 01:39:09AM +0800, Fu Wei wrote:
>> On 7 April 2017 at 01:24, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Fri, Apr 07, 2017 at 12:47:47AM +0800, Fu Wei wrote:
>> >> On 6 April 2017 at 02:38, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> > On Sat, Apr 01, 2017 at 01:51:03AM +0800, fu.wei@linaro.org wrote:
>
>> > However, I would prefer to simplify this such that we only free the
>> > IRQs in the error path.
>> >
>> > We should be able to iterate over all freams, freeing any non-zero
>> > interrupt, since !valid frames shouldn't have non-zero interrupts.
>>
>> Yes, that is what I am doing :
>>
>>  if (!frame->valid)
>>           continue;
>
> What I meant was that we won't look at the frame->valid flag at all;
> only the interrupts. e.g.
>
> for (int i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
>         if (frame->phys_irq > 0)
>                 free_the_phys_irq_somehow();
>         if (frame->virt_irq > 0)
>                 free_the_virt_irq_somehow();
> }

Since we use "kcalloc" to allocate struct arch_timer_mem, this should be OK.

>
> ... where we somehow figure out the GSI, or we introduce an api like
> unregister_gsi_for_irq(irq).

Yes, If you are OK with introducing a new API , this problem is solved :-)

>
> Since the !valid frames should all have zero for their interrupt fields,
> no special handling is necessary.
>
> That way, we only free the IRQs in one place, it's obvious that we
> consistently free all of them, etc.
>
>> Lorenzo addressed the API issue, we may can fix it by getting GSI info
>> from DT, then register it until we figure the best frame.
>> It may need some big change in DT code
>
> I'd prefer to keep this constrained to the ACPI code. ;)
>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
