Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52799 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbeJAPYx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 1 Oct 2018 11:24:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so7558961wmw.2
        for <linux-watchdog@vger.kernel.org>; Mon, 01 Oct 2018 01:48:12 -0700 (PDT)
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU drivers
To: Paul Cercueil <paul@crapouillou.net>, Rob Herring <robh@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
References: <20180724231958.20659-1-paul@crapouillou.net>
 <20180724231958.20659-5-paul@crapouillou.net>
 <20180725152105.GA6347@rob-hp-laptop>
 <1532988062.4702.2@smtp.crapouillou.net>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cfecfae5-abd0-c051-51a3-cb5d906006e9@linaro.org>
Date: Mon, 1 Oct 2018 10:48:09 +0200
MIME-Version: 1.0
In-Reply-To: <1532988062.4702.2@smtp.crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 31/07/2018 00:01, Paul Cercueil wrote:

[ ... ]

>>>  +- ingenic,timer-channel: Specifies the TCU channel that should be
>>> used as
>>>  +  system timer. If not provided, the TCU channel 0 is used for the
>>> system timer.
>>>  +
>>>  +- ingenic,clocksource-channel: Specifies the TCU channel that
>>> should be used
>>>  +  as clocksource and sched_clock. It must be a different channel
>>> than the one
>>>  +  used as system timer. If not provided, neither a clocksource nor a
>>>  +  sched_clock is instantiated.
>>
>> clocksource and sched_clock are Linux specific and don't belong in DT.
>> You should define properties of the hardware or use existing properties
>> like interrupts or clocks to figure out which channel to use. For
>> example, if some channels don't have an interrupt, then use them for
>> clocksource and not a clockevent. Or you could have timers that run in
>> low-power modes or not. If all the channels are identical, then it
>> shouldn't matter which ones the OS picks.

It can't work in this case because the pmw and the timer driver are not
communicating and the first one can stole a channel to the last one.


> We already talked about that. All the TCU channels can be used for PWM.
> The problem is I cannot know from the driver's scope which channels will
> be free and which channels will be requested for PWM. You suggested that I
> parse the devicetree for clients, and I did that in the V3/V4 patchset. But
> it only works for clients requesting through devicetree, not from platform
> code or even sysfs.
> 
> One thing I can try is to dynamically change the channels the system timer
> and clocksource are using when the current ones are requested for PWM. But
> that sounds hardcore...

Yes, it is :/

Sorry for letting you wasting time and effort to write an overkill code
not suitable for upstream.

A very gross thought, wouldn't be possible to "register" a channel from
the timer driver code in a shared data area (but well self-encapsulated)
and the pwm code will check such channel isn't in use ?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
