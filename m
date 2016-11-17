Return-path: <hs@denx.de>
Subject: Re: wdt, gpio: move arch_initcall into subsys_initcall ?
To: Guenter Roeck <linux@roeck-us.net>,
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
References: <582AE18A.2060405@denx.de>
 <afbf394e-e411-5c43-e2b0-667b3fbc2edf@mentor.com>
 <e4472c2d-effa-9583-aded-8dcdfdd57ee6@mentor.com>
 <ee9824b8-f09f-3817-8893-8121c9fb9eb1@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Wim Van Sebroeck <wim@iguana.be>,
 "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Reply-To: hs@denx.de
From: Heiko Schocher <hs@denx.de>
Message-ID: <582D5750.4000408@denx.de>
Date: Thu, 17 Nov 2016 08:08:00 +0100
MIME-Version: 1.0
In-Reply-To: <ee9824b8-f09f-3817-8893-8121c9fb9eb1@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter, Vladimir,

Sorry for the late response, but I was "on the road" ...

Am 15.11.2016 um 14:46 schrieb Guenter Roeck:
> On 11/15/2016 03:32 AM, Vladimir Zapolskiy wrote:
>> On 11/15/2016 01:10 PM, Vladimir Zapolskiy wrote:
>>> Hello Heiko,
>>>
>>> On 11/15/2016 12:20 PM, Heiko Schocher wrote:
>>>> Hello,
>>>>
>>>> commit e188cbf7564f: "gpio: mxc: shift gpio_mxc_init() to subsys_initcall level"
>>>> moves the gpio initialization of the mxc gpio driver
>>>> from the arch_initcall level into subsys_initcall level.
>>>>
>>>> This leads now on mxc boards, which use a gpio wdt driver
>>>> and the CONFIG_GPIO_WATCHDOG_ARCH_INITCALL option enabled,
>>>> to unwanted driver probe deferrals during kernel boot.
>>>>
>>>> I see this currently on an imx6 based board (which has unfortunately
>>>> 3 WDT: imx6 internal (disabled), gpio wdt and da9063 WDT ...).
>>>>
>>>> Also a side effect from above commit is, that the da9063 WDT driver
>>>> is now probed before the gpio WDT driver ... so /dev/watchdog now
>>>> does not point to the gpio_wdt, instead it points to the da9063 WDT.
>>>>
>>>> So there are 2 solutions possible:
>>>>
>>>> - add a CONFIG_GPIO_MCX_ARCH_INITCALL option
>>>>   in drivers/gpio/gpio-mxc.c like for the gpio_wdt.c driver?
>>>
>>> in my opinion this is overly heavy solution and it might be
>>> better to avoid it if possible.
>>>
>>> I would rather prefer to reconsider GPIO_WATCHDOG_ARCH_INITCALL
>>> usage in the watchdog driver.
>>>
>>> Moreover adding this proposed GPIO_MCX_ARCH_INITCALL to call
>>> the driver on arch level will result in deferring the GPIO driver.
>>>
>>>>   But how can we guarantee, that first the gpio driver and then
>>>>   the gpio_wdt driver gets probed?
>>>>
>>>> - move the arch_initcall in gpio_wdt.c into a subsys_initcall
>>>>   (Tested this, and the probe dereferral messages are gone ...)
>>>>
>>>>   But this may results in problems on boards, which needs an early
>>>>   trigger on an gpio wdt ...
>>>
>>> The level of "earliness" can not be defined in absolute time value
>>> in any case, why decreasing the init level of the watchdog driver
>>> to subsys level can cause problems? For that there should exist
>>> some kind of a dependency on IC or PCB hardware level, can you
>>> name it please?

On the current problem, there is no dependency on PCB, but I know
of watchdogs triggered through a gpio pin, which must triggered < 1 second
and subsys_initcall is too late for this. I think, this was the reason
for introducing the CONFIG_GPIO_WATCHDOG_ARCH_INITCALL option ...

>>> Also please note that more than a half of all GPIO drivers settle
>>> on subsys or later initcall level, this means that there is
>>> an expected GPIO watchdog driver deferral for all of them.
>>
>> Please find two more late notes though.
>>
>>> I propose to send two patches for review:
>>>
>>> 1. remove GPIO_WATCHDOG_ARCH_INITCALL option completely and decouple
>>>    module_platform_driver() into arch_initcall() and module_exit()
>>>    unconditionally.
>>>
>>> 2. change arch_initcall() in the watchdog driver to subsys_initcall().
>>>    This change removes probe deferrals on boot, when the driver is
>>>    used with the most of the GPIO controllers.
>>
>> Alternatively commit 5e53c8ed813d ("watchdog: gpio_wdt: Add option for
>> early registration") can be reverted and then module_platform_driver()
>> is decoupled into subsys_initcall() and module_exit() as its replacement.
>>
> Sure, only the reason for that was that there are situations where
> subsys_initcall() was too late. Also, when using arch_initcall() only,
> we get deferrals again, which is apparently hated by many and a reason
> for all those "avoid probe deferrals" patches.

Exactly. And I wonder, if this boards, who need this early trigger,
work with current kernel ? (Or this boards use a gpio driver, which is
not in subsys_initcall level ...)

>> And also please note that since quite many GPIO controller drivers
>> live on initcall levels after subsys_initcall(), the solution won't
>> let to avoid watchdog driver deferrals totally, this should be accepted.
>>
> ... except for others it isn't, and we are back to square one.
>
> GPIO_WATCHDOG_ARCH_INITCALL was intended to be only used in situations
> where needed. Why is it used here in the first place if that is not
> the case ?

Heh, good question ...

"/dev/watchdog" is in systemd hard-coded, see:
https://github.com/systemd/systemd/blob/dd8352659c9428b196706d04399eec106a8917ed/src/shared/watchdog.c#L86
http://0pointer.de/blog/projects/watchdog.html
https://www.freedesktop.org/software/systemd/man/systemd-system.conf.html

We have 2 WDT driver enabled on the board (GPIO WDT and the DA9063 WDT).

If both WDTs are in the subsys_initall level, first the da9063 wdt
gets probed, and so "/dev/watchdog" points to the da9063 wdt, but
we want to use the GPIO wdt as "/dev/watchdog" device.

Now, why not simple disabling the da9063 wdt ?

We could not disable the da9063 wdt functionallity, because we need
for a clean reboot that the da9063_wdt_restart() is called in the
restart sequence ... which is registered in the wdt driver:

static const struct watchdog_ops da9063_watchdog_ops = {
[...]
         .restart = da9063_wdt_restart,
};

Is there a possbility to register this restart function may somewhere
else? It seems, that this is not a WDT functionallity ...

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
