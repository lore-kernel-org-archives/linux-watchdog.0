Return-path: <Vladimir_Zapolskiy@mentor.com>
Subject: Re: wdt, gpio: move arch_initcall into subsys_initcall ?
To: <hs@denx.de>, <linux-watchdog@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>
References: <582AE18A.2060405@denx.de>
CC: <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawnguo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>, "Jonas Mark (ST-FIR/ENG1)"
	<Mark.Jonas@de.bosch.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <afbf394e-e411-5c43-e2b0-667b3fbc2edf@mentor.com>
Date: Tue, 15 Nov 2016 13:10:32 +0200
MIME-Version: 1.0
In-Reply-To: <582AE18A.2060405@denx.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hello Heiko,

On 11/15/2016 12:20 PM, Heiko Schocher wrote:
> Hello,
>
> commit e188cbf7564f: "gpio: mxc: shift gpio_mxc_init() to subsys_initcall level"
> moves the gpio initialization of the mxc gpio driver
> from the arch_initcall level into subsys_initcall level.
>
> This leads now on mxc boards, which use a gpio wdt driver
> and the CONFIG_GPIO_WATCHDOG_ARCH_INITCALL option enabled,
> to unwanted driver probe deferrals during kernel boot.
>
> I see this currently on an imx6 based board (which has unfortunately
> 3 WDT: imx6 internal (disabled), gpio wdt and da9063 WDT ...).
>
> Also a side effect from above commit is, that the da9063 WDT driver
> is now probed before the gpio WDT driver ... so /dev/watchdog now
> does not point to the gpio_wdt, instead it points to the da9063 WDT.
>
> So there are 2 solutions possible:
>
> - add a CONFIG_GPIO_MCX_ARCH_INITCALL option
>   in drivers/gpio/gpio-mxc.c like for the gpio_wdt.c driver?

in my opinion this is overly heavy solution and it might be
better to avoid it if possible.

I would rather prefer to reconsider GPIO_WATCHDOG_ARCH_INITCALL
usage in the watchdog driver.

Moreover adding this proposed GPIO_MCX_ARCH_INITCALL to call
the driver on arch level will result in deferring the GPIO driver.

>   But how can we guarantee, that first the gpio driver and then
>   the gpio_wdt driver gets probed?
>
> - move the arch_initcall in gpio_wdt.c into a subsys_initcall
>   (Tested this, and the probe dereferral messages are gone ...)
>
>   But this may results in problems on boards, which needs an early
>   trigger on an gpio wdt ...

The level of "earliness" can not be defined in absolute time value
in any case, why decreasing the init level of the watchdog driver
to subsys level can cause problems? For that there should exist
some kind of a dependency on IC or PCB hardware level, can you
name it please?

Also please note that more than a half of all GPIO drivers settle
on subsys or later initcall level, this means that there is
an expected GPIO watchdog driver deferral for all of them.

I propose to send two patches for review:

1. remove GPIO_WATCHDOG_ARCH_INITCALL option completely and decouple
    module_platform_driver() into arch_initcall() and module_exit()
    unconditionally.

2. change arch_initcall() in the watchdog driver to subsys_initcall().
    This change removes probe deferrals on boot, when the driver is
    used with the most of the GPIO controllers.

> Other ideas?
>
> Thanks for all suggestions!
>

--
With best wishes,
Vladimir
