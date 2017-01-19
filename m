Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36671 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbdASMty (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 19 Jan 2017 07:49:54 -0500
Received: by mail-pf0-f179.google.com with SMTP id 189so13506916pfu.3
        for <linux-watchdog@vger.kernel.org>; Thu, 19 Jan 2017 04:49:02 -0800 (PST)
Subject: Re: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
To: Fu Wei <fu.wei@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-9-fu.wei@linaro.org>
 <cafa8c7a-9c7c-51ba-5566-0cfe1fe6f764@linaro.org>
 <CADyBb7uGVu6Po4hCD45WOrQvWYwZgtSbE5z9rbRa7gZ1P5-4tg@mail.gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <74160889-5eb0-ceb2-2727-61e9d538cf2f@linaro.org>
Date: Thu, 19 Jan 2017 20:41:14 +0800
MIME-Version: 1.0
In-Reply-To: <CADyBb7uGVu6Po4hCD45WOrQvWYwZgtSbE5z9rbRa7gZ1P5-4tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 2017/1/19 17:44, Fu Wei wrote:
> Hi Hanjun,
>
> On 19 January 2017 at 16:02, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> Hi Fuwei,
>>
>> One comments below.
>>
>>
>> On 2017/1/18 21:25, fu.wei@linaro.org wrote:
>>>
>>> From: Fu Wei <fu.wei@linaro.org>
>>>
>>> The counter frequency detection call(arch_timer_detect_rate) combines=
 two
>>> ways to get counter frequency: system coprocessor register and MMIO t=
imer.
>>> But in a specific timer init code, we only need one way to try:
>>> getting frequency from MMIO timer register will be needed only when w=
e
>>> init MMIO timer; getting frequency from system coprocessor register w=
ill
>>> be needed only when we init arch timer.
>>>
>>> This patch separates paths to determine frequency:
>>> Separate out the MMIO frequency and the sysreg frequency detection ca=
ll,
>>> and use the appropriate one for the counter.
>>>
>>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>>> ---
>>>  drivers/clocksource/arm_arch_timer.c | 40
>>> ++++++++++++++++++++++--------------
>>>  1 file changed, 25 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/arm_arch_timer.c
>>> b/drivers/clocksource/arm_arch_timer.c
>>> index 6484f84..9482481 100644
>>> --- a/drivers/clocksource/arm_arch_timer.c
>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>> @@ -488,23 +488,33 @@ static int arch_timer_starting_cpu(unsigned int=
 cpu)
>>>         return 0;
>>>  }
>>>
>>> -static void arch_timer_detect_rate(void __iomem *cntbase)
>>> +static void __arch_timer_determine_rate(u32 rate)
>>>  {
>>> -       /* Who has more than one independent system counter? */
>>> -       if (arch_timer_rate)
>>> -               return;
>>> +       /* Check the timer frequency. */
>>> +       if (!arch_timer_rate) {
>>> +               if (rate)
>>> +                       arch_timer_rate =3D rate;
>>> +               else
>>> +                       pr_warn("frequency not available\n");
>>> +       } else if (rate && arch_timer_rate !=3D rate) {
>>
>>                         ^
>> Typo? I think it's "&" here.
>
> Not a typo, It's definitely a =E2=80=9C&&=E2=80=9D  :-)
>
> Here arch_timer_rate is not zero.
>
> If rate is not zero(that means we got a valid rate), and
> arch_timer_rate !=3D rate ,
> we will print warning message.

Ah, misreading the code, thanks for clarify :)

Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
