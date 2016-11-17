Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:63069 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbcKQJbn (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 17 Nov 2016 04:31:43 -0500
Subject: Re: wdt, gpio: move arch_initcall into subsys_initcall ?
To: <hs@denx.de>, Guenter Roeck <linux@roeck-us.net>
References: <582AE18A.2060405@denx.de>
 <afbf394e-e411-5c43-e2b0-667b3fbc2edf@mentor.com>
 <e4472c2d-effa-9583-aded-8dcdfdd57ee6@mentor.com>
 <ee9824b8-f09f-3817-8893-8121c9fb9eb1@roeck-us.net>
 <582D5750.4000408@denx.de>
CC: <linux-watchdog@vger.kernel.org>,
        "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
        Shawn Guo <shawnguo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <6231eccc-62f0-041f-1aed-59e85abcc6c6@mentor.com>
Date: Thu, 17 Nov 2016 11:31:14 +0200
MIME-Version: 1.0
In-Reply-To: <582D5750.4000408@denx.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Heiko,

On 11/17/2016 09:08 AM, Heiko Schocher wrote:
> Hello Guenter, Vladimir,
>
> Sorry for the late response, but I was "on the road" ...
>
> Am 15.11.2016 um 14:46 schrieb Guenter Roeck:
>> On 11/15/2016 03:32 AM, Vladimir Zapolskiy wrote:
>>> On 11/15/2016 01:10 PM, Vladimir Zapolskiy wrote:
>>>> Hello Heiko,
>>>>
>>>> On 11/15/2016 12:20 PM, Heiko Schocher wrote:
>>>>> Hello,
>>>>>
>>>>> commit e188cbf7564f: "gpio: mxc: shift gpio_mxc_init() to
>>>>> subsys_initcall level"
>>>>> moves the gpio initialization of the mxc gpio driver
>>>>> from the arch_initcall level into subsys_initcall level.
>>>>>
>>>>> This leads now on mxc boards, which use a gpio wdt driver
>>>>> and the CONFIG_GPIO_WATCHDOG_ARCH_INITCALL option enabled,
>>>>> to unwanted driver probe deferrals during kernel boot.
>>>>>
>>>>> I see this currently on an imx6 based board (which has unfortunately
>>>>> 3 WDT: imx6 internal (disabled), gpio wdt and da9063 WDT ...).
>>>>>
>>>>> Also a side effect from above commit is, that the da9063 WDT driver
>>>>> is now probed before the gpio WDT driver ... so /dev/watchdog now
>>>>> does not point to the gpio_wdt, instead it points to the da9063 WDT.
>>>>>
>>>>> So there are 2 solutions possible:
>>>>>
>>>>> - add a CONFIG_GPIO_MCX_ARCH_INITCALL option
>>>>>   in drivers/gpio/gpio-mxc.c like for the gpio_wdt.c driver?
>>>>
>>>> in my opinion this is overly heavy solution and it might be
>>>> better to avoid it if possible.
>>>>
>>>> I would rather prefer to reconsider GPIO_WATCHDOG_ARCH_INITCALL
>>>> usage in the watchdog driver.
>>>>
>>>> Moreover adding this proposed GPIO_MCX_ARCH_INITCALL to call
>>>> the driver on arch level will result in deferring the GPIO driver.
>>>>
>>>>>   But how can we guarantee, that first the gpio driver and then
>>>>>   the gpio_wdt driver gets probed?
>>>>>
>>>>> - move the arch_initcall in gpio_wdt.c into a subsys_initcall
>>>>>   (Tested this, and the probe dereferral messages are gone ...)
>>>>>
>>>>>   But this may results in problems on boards, which needs an early
>>>>>   trigger on an gpio wdt ...
>>>>
>>>> The level of "earliness" can not be defined in absolute time value
>>>> in any case, why decreasing the init level of the watchdog driver
>>>> to subsys level can cause problems? For that there should exist
>>>> some kind of a dependency on IC or PCB hardware level, can you
>>>> name it please?
>
> On the current problem, there is no dependency on PCB, but I know
> of watchdogs triggered through a gpio pin, which must triggered < 1 second
> and subsys_initcall is too late for this. I think, this was the reason

This is not a valid reason, nobody guarantees that arch_initcall()
code is run in < 1 second time interval.

> for introducing the CONFIG_GPIO_WATCHDOG_ARCH_INITCALL option ...
>

Putting GPIO driver on arch_initcall() level results in deferring
of the GPIO driver. Because you desire to avoid probe deferring, you
should not consider putting GPIO driver on arch_initcall() level.

--
With best wishes,
Vladimir
