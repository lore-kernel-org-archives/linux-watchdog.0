Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33793 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeIZCVq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 25 Sep 2018 22:21:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id t15so16746887wrx.1
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Sep 2018 13:12:31 -0700 (PDT)
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
References: <5baa3fa9.1c69fb81.4c7b7.19fdSMTPIN_ADDED_MISSING@mx.google.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <346cb95c-f9ce-f19b-30f3-75e9fb379290@linaro.org>
Date: Tue, 25 Sep 2018 22:12:28 +0200
MIME-Version: 1.0
In-Reply-To: <5baa3fa9.1c69fb81.4c7b7.19fdSMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 25/09/2018 15:38, Paul Cercueil wrote:
> 
> Le 24 sept. 2018 9:14 AM, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit :
>>
>> On 24/09/2018 08:53, Paul Cercueil wrote: 
>>>
>>> Le 24 sept. 2018 07:58, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit : 
>>>>
>>>> On 24/09/2018 07:49, Paul Cercueil wrote: 
>>>>>
>>>>> Le 24 sept. 2018 07:35, Daniel Lezcano <daniel.lezcano@linaro.org> a 
>>>>> écrit : 
>>>>>>
>>>>>> On 24/09/2018 07:24, Paul Cercueil wrote: 
>>>>>>> Hi Daniel, 
>>>>>>>
>>>>>>> Le 24 sept. 2018 05:12, Daniel Lezcano 
>>>>>>> <daniel.lezcano@linaro.org> a écrit : 
>>>>>>>>
>>>>>>>> On 21/08/2018 19:16, Paul Cercueil wrote: 
>>>>>>>>> This driver handles the TCU (Timer Counter Unit) present on 
>>>>>>>>> the Ingenic JZ47xx SoCs, and provides the kernel with a 
>>>>>>>>> system timer, and optionally with a clocksource and a 
>>>>>>>>> sched_clock. 
>>>>>>>>>
>>>>>>>>> It also provides clocks and interrupt handling to client 
>>>>>>>>> drivers. 
>>>>>>>>
>>>>>>>> Can you provide a much more complete description of the timer 
>>>>>>>> in order to make my life easier for the review of this patch? 
>>>>>>>
>>>>>>> See patch [03/24], it adds a doc file that describes the 
>>>>>>> hardware. 
>>>>>>
>>>>>> Thanks, I went through but it is incomplete to understand what the 
>>>>>> timer do. I will reverse-engineer the code but it would help if you 
>>>>>> can give the gross approach. Why multiple channels ? mutexes and 
>>>>>> completion ? 
>>>>>
>>>>> Much of the complexity is because of the multi-purpose nature of the 
>>>>> TCU channels. Each one can be used as timer/clocksource, or PWM. 
>>>>>
>>>>> The driver starts by using channels 0 and 1 as system timer and 
>>>>> clocksource, respectively, the other ones being unused for now. Then, 
>>>>> *if* the PWM driver requests one of the channels in use by the 
>>>>> timer/clocksource driver, say channel 0, the timer/clocksource driver 
>>>>> will dynamically reassign the system timer to a free channel, from 
>>>>> channel 0 to e.g. channel 2. Only in that case the completion/mutex 
>>>>> are actually used. 
>>>>
>>>> Why do you need to do this? Can't be the channels dedicated and reserved 
>>>> for clocksource and clockevent? 
>>>
>>> That's what I had in place (ingenic,timer-channel and ingenic,clocksource-channel DT properties), but Rob didn't want any linux-specific properties in the devicetree binding :( 
>>
>> Isn't possible to specify the channel to use in the DT? like renesas16 ? 
> 
> That's what I did in V6 (and before), but Rob did not want me to add properties for Linux-specific concepts such as clocksource.

Hmm, I remember something like that, yes but I did a delete of the
previous version when you posted the v7. Can you give a pointer to its
answer ?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
