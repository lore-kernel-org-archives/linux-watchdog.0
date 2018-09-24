Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55779 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIXLfc (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 24 Sep 2018 07:35:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id 206-v6so375236wmb.5
        for <linux-watchdog@vger.kernel.org>; Sun, 23 Sep 2018 22:35:08 -0700 (PDT)
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mathieu Malaterre <malat@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-doc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        od@zcrc.me, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@mips.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <5ba8750a.1c69fb81.501e8.d0f0SMTPIN_ADDED_MISSING@mx.google.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <58645f14-aec2-4f66-3a39-34beeabdb035@linaro.org>
Date: Mon, 24 Sep 2018 07:35:05 +0200
MIME-Version: 1.0
In-Reply-To: <5ba8750a.1c69fb81.501e8.d0f0SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 24/09/2018 07:24, Paul Cercueil wrote:
> Hi Daniel,
> 
> Le 24 sept. 2018 05:12, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit :
>>
>> On 21/08/2018 19:16, Paul Cercueil wrote: 
>>> This driver handles the TCU (Timer Counter Unit) present on the Ingenic 
>>> JZ47xx SoCs, and provides the kernel with a system timer, and optionally 
>>> with a clocksource and a sched_clock. 
>>>
>>> It also provides clocks and interrupt handling to client drivers. 
>>
>> Can you provide a much more complete description of the timer in order 
>> to make my life easier for the review of this patch? 
> 
> See patch [03/24], it adds a doc file that describes the hardware.

Thanks, I went through but it is incomplete to understand what the timer
do. I will reverse-engineer the code but it would help if you can give
the gross approach. Why multiple channels ? mutexes and completion ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
