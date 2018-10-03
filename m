Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53891 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeJCTvF (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 3 Oct 2018 15:51:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so5641452wme.3
        for <linux-watchdog@vger.kernel.org>; Wed, 03 Oct 2018 06:02:45 -0700 (PDT)
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU drivers
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        linux-watchdog@vger.kernel.org, robh@kernel.org,
        linux-mips@linux-mips.org, Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <5bb4bb5d.1c69fb81.ed9a6.adc6SMTPIN_ADDED_MISSING@mx.google.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fa8dd794-3077-eb5c-5657-f62d1a6521b5@linaro.org>
Date: Wed, 3 Oct 2018 15:02:40 +0200
MIME-Version: 1.0
In-Reply-To: <5bb4bb5d.1c69fb81.ed9a6.adc6SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/10/2018 14:51, Paul Cercueil wrote:
> 
> Le 3 oct. 2018 2:47 PM, Daniel Lezcano <daniel.lezcano@linaro.org> a
> écrit :
>> 
>> On 03/10/2018 12:32, Paul Cercueil wrote:
>>> 
>>> Le 1 oct. 2018 10:48, Daniel Lezcano <daniel.lezcano@linaro.org>
>>> a écrit :
>>>> 
>>>> On 31/07/2018 00:01, Paul Cercueil wrote:
>>>> 
>>>> [ ... ]
>>>> 
>>>>>>> +- ingenic,timer-channel: Specifies the TCU channel that
>>>>>>>  should be used as +  system timer. If not provided, the
>>>>>>> TCU channel 0 is used for the system timer. + +- 
>>>>>>> ingenic,clocksource-channel: Specifies the TCU channel
>>>>>>> that should be used +  as clocksource and sched_clock. It
>>>>>>> must be a different channel than the one +  used as
>>>>>>> system timer. If not provided, neither a clocksource nor
>>>>>>> a +  sched_clock is instantiated.
>>>>>> 
>>>>>> clocksource and sched_clock are Linux specific and don't
>>>>>> belong in DT. You should define properties of the hardware
>>>>>> or use existing properties like interrupts or clocks to
>>>>>> figure out which channel to use. For example, if some
>>>>>> channels don't have an interrupt, then use them for
>>>>>> clocksource and not a clockevent. Or you could have timers
>>>>>> that run in low-power modes or not. If all the channels are
>>>>>> identical, then it shouldn't matter which ones the OS
>>>>>> picks.
>>>> 
>>>> It can't work in this case because the pmw and the timer driver
>>>> are not communicating and the first one can stole a channel to
>>>> the last one.
>>> 
>>> In that particular case the timer driver will always request its
>>>  channels first; with no timer set the system hangs before 
>>> subsys_initcall, and the PWM driver is a subnode of the timer
>>> node, so is probed only after the timer probed.
>>> 
>>>>> We already talked about that. All the TCU channels can be
>>>>> used for PWM. The problem is I cannot know from the driver's
>>>>> scope which channels will be free and which channels will be
>>>>> requested for PWM. You suggested that I parse the devicetree
>>>>> for clients, and I did that in the V3/V4 patchset. But it
>>>>> only works for clients requesting through devicetree, not
>>>>> from platform code or even sysfs.
>>>>> 
>>>>> One thing I can try is to dynamically change the channels the
>>>>>  system timer and clocksource are using when the current ones
>>>>> are requested for PWM. But that sounds hardcore...
>>>> 
>>>> Yes, it is :/
>>>> 
>>>> Sorry for letting you wasting time and effort to write an
>>>> overkill code not suitable for upstream.
>>>> 
>>>> A very gross thought, wouldn't be possible to "register" a
>>>> channel from the timer driver code in a shared data area (but
>>>> well self-encapsulated) and the pwm code will check such
>>>> channel isn't in use ?
>>> 
>>> Probably, but it's the contrary I need to do. The timer driver
>>> code can use any channel, and probes first. The PWM driver code
>>> must use specific channels, and probes last. So either the timer
>>> driver knows what channels it can't use, thanks to a device
>>> property, or it adapts itself when a channel in use is requested
>>> for PWM, which is what I tried in v7.
>> 
>> When you say "must use specific channels", where is coming this 
>> information ?
> 
> If the backlight for the LCD is connected to the pin that corresponds
> to PWM1, then you must use the TCU channel 1. It's that simple.

Is it a runtime detection or is it hardcoded somewhere ?

(just trying to understand the whole picture)

>>> I think we could find a way to use a devicetree property that
>>> doesn't trigger Rob. That would still be the easiest and cleanest
>>> solution.
>>> 
>>> Maybe "ingenic,reserved-channels-mask", which would contain a
>>> mask of channels that can only be used by the timer driver. And
>>> what the timer driver does with these channels, would be specific
>>> to the implementation and would not appear in the bindings. I
>>> hope Rob can work with that.
>>> 
>>> -Paul


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
