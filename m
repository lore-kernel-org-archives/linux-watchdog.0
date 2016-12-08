Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35600 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752805AbcLHLVa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 8 Dec 2016 06:21:30 -0500
Received: by mail-io0-f182.google.com with SMTP id a124so21717113ioe.2
        for <linux-watchdog@vger.kernel.org>; Thu, 08 Dec 2016 03:21:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161208110410.GA9768@leverpostej>
References: <20161125084623.22515-9-fu.wei@linaro.org> <201611252221.UyJ9iWPV%fengguang.wu@intel.com>
 <CADyBb7uAObQn_JVp_qw9+7POiqUctdzy3cYLsb0rk-JMX5W1uw@mail.gmail.com>
 <CAOZdJXU7Lg66RKvA=sYtUXUdwLLbh9FtcW0_U-fmjaztnqS3Ng@mail.gmail.com>
 <CADyBb7vAfMGV5ERFqAbwo4v4BhJv5s_-x4DXmdvy=iUacBzJWQ@mail.gmail.com> <20161208110410.GA9768@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Thu, 8 Dec 2016 19:20:59 +0800
Message-ID: <CADyBb7u+EJ2ehan4suUCtXaP09S-OuZ6BMnCVF3=MpE0W2-Nag@mail.gmail.com>
Subject: Re: [Linaro-acpi] [PATCH v17 08/15] clocksource/drivers/arm_arch_timer:
 move arch_timer_needs_of_probing into DT init call
To: Mark Rutland <mark.rutland@arm.com>
Cc: Timur Tabi <timur@codeaurora.org>,
        kbuild test robot <lkp@intel.com>,
        Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>, Wei Huang <wei@redhat.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, kbuild-all@01.org,
        "Abdulhamid, Harb" <harba@codeaurora.org>,
        Julien Grall <julien.grall@arm.com>,
        linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jon Masters <jcm@redhat.com>,
        Christopher Covington <cov@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Len Brown <lenb@kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mark,

On 8 December 2016 at 19:04, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Dec 08, 2016 at 11:16:21AM +0800, Fu Wei wrote:
>> Hi Timur,
>>
>> On 8 December 2016 at 01:25, Timur Tabi <timur@codeaurora.org> wrote:
>> > On Fri, Nov 25, 2016 at 9:06 AM, Fu Wei <fu.wei@linaro.org> wrote:
>> >>
>> >> a "+ int ret;" should be move from [12/15] to here, I have fix the
>> >> problem in my repo, it would happen in next patchset
>> >>
>> >> https://git.linaro.org/people/fu.wei/linux.git/log/?h=topic-gtdt-wakeup-timer_upstream_v18_devel
>> >
>> > Fu, please post v18 to the mailing list so that it can be picked up
>> > for 4.10 (if it's not too late already).
>
> Unfortunately, it's too late for v4.10. It hasn't been sat in linux-next
> at all, and we've seen kbuild test failures.
>
> Hopefully there's time to beat this into shape and get it into
> linux-next so that it's ready to queue for v4.11, though.

cross fingers for getting into v4.11 :-)

>
>> Great thanks for your suggestion!  :-)
>> yes, you are right, I would love to post v18 ASAP.
>>
>> But I am still waiting for more feedback from the maintainers.
>
> Please post a version which passes inspection by the kbuild test robot.
> I haven't had a chance to look at this yet, and it'll be better to look
> at a version that actually works.

OK, NP, will post them in several hours
Great thanks for your feedback.

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
