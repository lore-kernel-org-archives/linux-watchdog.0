Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34667 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754656AbdCUFMw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 21 Mar 2017 01:12:52 -0400
Received: by mail-io0-f177.google.com with SMTP id b140so42660465iof.1
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Mar 2017 22:12:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170320180949.GM31213@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org> <20170206185015.12296-14-fu.wei@linaro.org>
 <20170317200153.GF15909@leverpostej> <CADyBb7uZV2Qe0ga4TTS_iis5MtwJ=u6PKYSV6ED103Cmh5_O3g@mail.gmail.com>
 <20170320180949.GM31213@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Tue, 21 Mar 2017 13:12:09 +0800
Message-ID: <CADyBb7s8YCZjPtiuesH-dqBtP74PewsbaEnjj3RjV7Bx_34wFg@mail.gmail.com>
Subject: Re: [PATCH v21 13/13] acpi/arm64: Add SBSA Generic Watchdog support
 in GTDT driver
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

On 21 March 2017 at 02:09, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Mar 21, 2017 at 01:57:58AM +0800, Fu Wei wrote:
>> On 18 March 2017 at 04:01, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Tue, Feb 07, 2017 at 02:50:15AM +0800, fu.wei@linaro.org wrote:
>
>> > I've not been able to find where the ACPI spec says that zero is not a
>> > valid GSIV. This may simply be an oversight/ambiguity in the spec.
>> >
>> > Is there any statement to that effect?
>>
>> you are right, zero is a  valid GSIV, I will delete this check. Thanks
>
> That being the case, how does one describe a watchdog that does not have
> an interrupt?

I think we may can use "Timer Flags", because all the GSIV come with a flag,
if we can define a bit field called "valid" for all GSIV

Bit Field   Bit Offset   Number of bits                 Description
Valid            31                 1                      This bit
indicates the validity of the timer interrupt
                                                                 1:
Interrupt is valid
                                                                 0:
Interrupt is invalid
Then we don't need to test the value of GSIV, just test this bit instead.

Just my thought, hope this makes sense to all of you :-)

>
> As I mentioned, I think this is an oversight/ambiguity in the spec tat
> we should address.
>
>> > My reading of SBSA is that there is one watchdog in the system.
>> >
>> > Is that not the case?
>>
>> do you mean:
>> ---------------
>> 4.2.4 Watchdogs
>> The base server system implements a Generic Watchdog as specified in
>> APPENDIX A: Generic Watchdog.
>> ---------------
>>
>> I am not sure about that if this is saying "we only have one SBSA
>> watchdog in a system"
>>
>> would you let me know where mention it? Do I miss something?
>
> My reading was that the 'a' above meant a single element. i.e.
>
>         The base server system implements _a_ Generic Watchdog as
>         specified in APPENDIX A: Generic Watchdog.
>
> Subsequently in 4.2.5, it is stated:
>
>         In this scenario, the system wakeup timer or generic watchdog is
>         still required to send its interrupt.
>
> ... which only makes sense if there is a single watchdog in the system.
>
> Perhaps this is an oversight in the specification.
>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
