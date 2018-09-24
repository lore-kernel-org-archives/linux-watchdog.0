Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39113 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeIXL7O (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 24 Sep 2018 07:59:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id q8-v6so8686493wmq.4
        for <linux-watchdog@vger.kernel.org>; Sun, 23 Sep 2018 22:58:45 -0700 (PDT)
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mathieu Malaterre <malat@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        linux-watchdog@vger.kernel.org, od@zcrc.me,
        linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <5ba87b02.1c69fb81.1da88.1457SMTPIN_ADDED_MISSING@mx.google.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e5104bd9-1564-266d-4f27-affa8a9e825d@linaro.org>
Date: Mon, 24 Sep 2018 07:58:42 +0200
MIME-Version: 1.0
In-Reply-To: <5ba87b02.1c69fb81.1da88.1457SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 24/09/2018 07:49, Paul Cercueil wrote:
> 
> Le 24 sept. 2018 07:35, Daniel Lezcano <daniel.lezcano@linaro.org> a
> écrit :
>> 
>> On 24/09/2018 07:24, Paul Cercueil wrote:
>>> Hi Daniel,
>>> 
>>> Le 24 sept. 2018 05:12, Daniel Lezcano
>>> <daniel.lezcano@linaro.org> a écrit :
>>>> 
>>>> On 21/08/2018 19:16, Paul Cercueil wrote:
>>>>> This driver handles the TCU (Timer Counter Unit) present on
>>>>> the Ingenic JZ47xx SoCs, and provides the kernel with a
>>>>> system timer, and optionally with a clocksource and a
>>>>> sched_clock.
>>>>> 
>>>>> It also provides clocks and interrupt handling to client
>>>>> drivers.
>>>> 
>>>> Can you provide a much more complete description of the timer
>>>> in order to make my life easier for the review of this patch?
>>> 
>>> See patch [03/24], it adds a doc file that describes the
>>> hardware.
>> 
>> Thanks, I went through but it is incomplete to understand what the
>> timer do. I will reverse-engineer the code but it would help if you
>> can give the gross approach. Why multiple channels ? mutexes and
>> completion ?
> 
> Much of the complexity is because of the multi-purpose nature of the
> TCU channels. Each one can be used as timer/clocksource, or PWM.
> 
> The driver starts by using channels 0 and 1 as system timer and
> clocksource, respectively, the other ones being unused for now. Then,
> *if* the PWM driver requests one of the channels in use by the
> timer/clocksource driver, say channel 0, the timer/clocksource driver
> will dynamically reassign the system timer to a free channel, from
> channel 0 to e.g. channel 2. Only in that case the completion/mutex
> are actually used.

Why do you need to do this? Can't be the channels dedicated and reserved
for clocksource and clockevent?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
