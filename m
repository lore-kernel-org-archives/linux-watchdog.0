Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33067 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbcGYPzu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Jul 2016 11:55:50 -0400
Received: by mail-oi0-f52.google.com with SMTP id j185so257919591oih.0
        for <linux-watchdog@vger.kernel.org>; Mon, 25 Jul 2016 08:55:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160725153118.GD19209@arm.com>
References: <1469460427-8643-1-git-send-email-fu.wei@linaro.org>
 <1469460427-8643-5-git-send-email-fu.wei@linaro.org> <20160725153118.GD19209@arm.com>
From: Fu Wei <fu.wei@linaro.org>
Date: Mon, 25 Jul 2016 23:55:49 +0800
Message-ID: <CADyBb7ubKceQiB7+u7sSA=1+9_VMUrGjiabf_FkN2-n4rq7Kgg@mail.gmail.com>
Subject: Re: [PATCH v9 4/9] clocksource/drivers/arm_arch_timer: use readq to
 get 64-bit CNTVCT
To: Will Deacon <will.deacon@arm.com>
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
	rruigrok@codeaurora.org, harba@codeaurora.org,
	Christopher Covington <cov@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>,
	wei@redhat.com, Arnd Bergmann <arnd@arndb.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Leo Duran <leo.duran@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Will,

On 25 July 2016 at 23:31, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Jul 25, 2016 at 11:27:02PM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patch simplify arch_counter_get_cntvct_mem function by
>> using readq to get 64-bit CNTVCT value instead of readl_relaxed.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 10 +---------
>>  1 file changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index e6fd42d..483d2f9 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -418,15 +418,7 @@ u32 arch_timer_get_rate(void)
>>
>>  static u64 arch_counter_get_cntvct_mem(void)
>>  {
>> -     u32 vct_lo, vct_hi, tmp_hi;
>> -
>> -     do {
>> -             vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
>> -             vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
>> -             tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
>> -     } while (vct_hi != tmp_hi);
>> -
>> -     return ((u64) vct_hi << 32) | vct_lo;
>> +     return readq(arch_counter_base + CNTVCT_LO);
>
> Please drop this patch. It doesn't work.

I am OK to drop this, but could you let me know why it doesn't work?

I did get some problem on Foundation model about readq, but it works on Seattle.
I guess that is a problem of model, but not a code problem.
So I just got confused, why readq  doesn't work,  :-)


>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/445369.html

I just replied to it, sorry.

>
> Will



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
