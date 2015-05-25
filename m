Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20150521152838.GB16668@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555DB4C4.5090606@roeck-us.net>
	<555DD8EE.1060607@codeaurora.org>
	<20150521152838.GB16668@roeck-us.net>
Date: Mon, 25 May 2015 11:43:31 +0800
Message-ID: <CADyBb7tH+oa_efFTA0V7YksNN+8L+4xGtWuXpxp91SO3e_f9Vg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timur Tabi <timur@codeaurora.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org, wim@iguana.be,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On 21 May 2015 at 23:28, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, May 21, 2015 at 08:09:02AM -0500, Timur Tabi wrote:
>> Guenter Roeck wrote:
>> >>
>> >>+static unsigned int sbsa_gwdt_get_timeleft(struct watchdog_device *wdd)
>> >>+{
>> >>+    struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> >>+    u64 timeleft = sbsa_gwdt_get_wcv(wdd) - arch_counter_get_cntvct();
>> >>+
>> >
>> >Still not happy about the use of arch_counter_get_cntvct
>> >instead of using the clock subsystem. I am quite sure this could be done,
>> >possibly through arch_sys_counter, though at this point I am getting wary
>> >of bringing it up, so I guess I'll just let it go.
>>
>> You made the same comment with my driver, and I keep asking for
>> clarification.  The clk_get_sys() API does not work on my system, because
>> there are not clocks defined.  That must be an ACPI limitation that I can't
>> fix.
>>
> Would it be possible to define such clocks ?
>
>> The alternative to arch_counter_get_cntvct() is arch_timer_read_counter(),
>> which is not exported.  So we have two choices,
>>
>> 1) Continue to use arch_counter_get_cntvct(), which works on all ARM64
>> platforms that this driver supports anyway
>>
>> 2) Export arch_timer_read_counter()
>>
>> I prefer option #1.
>>
> Do we have any feedback from the arm maintainers ?
>
> My problem is that I don't want to be the first one to permit using
> those functions outside architecture and clock code. If we do this,
> we should get an Ack from an arm maintainer specifically for the use
> of arch_counter_get_cntvct() and arch_timer_get_rate().

IMO, we may need to use  arch_timer_read_counter.
Reason:  Once the Linux kernel has KVM support and is in hyp mode. we
may need to use arch_counter_get_cntpct.
So arch_timer driver have helped us to make arch_timer_read_counter
point to the right function.
and arch_timer_read_counter is in the
include/clocksource/arm_arch_timer.h,  just like arch_timer_get_rate
as a interface




>
> Thanks,
> Guenter
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
