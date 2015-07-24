Return-path: <ariel@vanguardiasur.com.ar>
Message-ID: <55B2AB4E.1060806@vanguardiasur.com.ar>
Date: Fri, 24 Jul 2015 18:17:02 -0300
From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
CC: wim@iguana.be, ezequiel@vanguardiasur.com.ar,
 linux-arm-kernel@lists.infradead.org, manabian@gmail.com
Subject: Re: [PATCH v3 1/2] watchdog: NXP LPC18xx Watchdog Timer Driver
References: <1436921445-11138-1-git-send-email-ariel@vanguardiasur.com.ar> <1436921445-11138-2-git-send-email-ariel@vanguardiasur.com.ar> <55AEE8F5.3020700@roeck-us.net> <55B150B0.9020100@vanguardiasur.com.ar> <55B15AF1.3030509@roeck-us.net> <55B243B3.7050702@vanguardiasur.com.ar> <55B245D1.1020208@roeck-us.net> <55B2A6CA.5090205@vanguardiasur.com.ar>
In-Reply-To: <55B2A6CA.5090205@vanguardiasur.com.ar>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>



El 24/07/15 a las 17:57, Ariel D'Alessandro escibió:
> 
> 
> El 24/07/15 a las 11:04, Guenter Roeck escibió:
>> On 07/24/2015 06:54 AM, Ariel D'Alessandro wrote:
>>>
>>>
>>> El 23/07/15 a las 18:21, Guenter Roeck escibió:
>>>> On 07/23/2015 01:38 PM, Ariel D'Alessandro wrote:
>>>>> Hi Guenter,
>>>>>
>>>>> El 21/07/15 a las 21:51, Guenter Roeck escibió:
>>>>>> On 07/14/2015 05:50 PM, Ariel D'Alessandro wrote:
>>>>>>> This commit adds support for the watchdog timer found in NXP LPC SoCs
>>>>>>> family, which includes LPC18xx/LPC43xx. Other SoCs in that family may
>>>>>>> share the same watchdog hardware.
>>>>>>>
>>>>>>> Watchdog driver registers a restart handler that will restart the
>>>>>>> system
>>>>>>> by performing an incorrect feed after ensuring the watchdog is
>>>>>>> enabled in
>>>>>>> reset mode.
>>>>>>>
>>>>>>> As watchdog cannot be disabled in hardware, driver's stop routine
>>>>>>> will
>>>>>>> regularly send a keepalive ping using a timer.
>>>>>>>
>>>>>>> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
>>>>>>
>>>>>> Hi Ariel,
>>>>>>
>>>>>> sorry for the delayed response. Comments below.
>>>>>>
>>>>>> Guenter
>>>>>>
>>>>>>> ---
>>>>>>>     drivers/watchdog/Kconfig       |  11 ++
>>>>>>>     drivers/watchdog/Makefile      |   1 +
>>>>>>>     drivers/watchdog/lpc18xx_wdt.c | 344
>>>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>>>>     3 files changed, 356 insertions(+)
>>>>>>>     create mode 100644 drivers/watchdog/lpc18xx_wdt.c
>>>>>>>
>>>>>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>>>>>> index 742fbbc..af5e2e3 100644
>>>>>>> --- a/drivers/watchdog/Kconfig
>>>>>>> +++ b/drivers/watchdog/Kconfig
>>>>>>> @@ -547,6 +547,17 @@ config DIGICOLOR_WATCHDOG
>>>>>>>           To compile this driver as a module, choose M here: the
>>>>>>>           module will be called digicolor_wdt.
>>>>>>>
>>>>>>> +config LPC18XX_WATCHDOG
>>>>>>> +    tristate "LPC18xx/43xx Watchdog"
>>>>>>> +    depends on ARCH_LPC18XX || COMPILE_TEST
>>>>>>> +    select WATCHDOG_CORE
>>>>>>> +    help
>>>>>>> +      Say Y here if to include support for the watchdog timer
>>>>>>> +      in NXP LPC SoCs family, which includes LPC18xx/LPC43xx
>>>>>>> +      processors.
>>>>>>> +      To compile this driver as a module, choose M here: the
>>>>>>> +      module will be called lpc18xx_wdt.
>>>>>>> +
>>>>>>>     # AVR32 Architecture
>>>>>>>
>>>>>>>     config AT32AP700X_WDT
>>>>>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>>>>>> index 59ea9a1..1b0ef48 100644
>>>>>>> --- a/drivers/watchdog/Makefile
>>>>>>> +++ b/drivers/watchdog/Makefile
>>>>>>> @@ -66,6 +66,7 @@ obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
>>>>>>>     obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
>>>>>>>     obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
>>>>>>>     obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
>>>>>>> +obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
>>>>>>>
>>>>>>>     # AVR32 Architecture
>>>>>>>     obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
>>>>>>> diff --git a/drivers/watchdog/lpc18xx_wdt.c
>>>>>>> b/drivers/watchdog/lpc18xx_wdt.c
>>>>>>> new file mode 100644
>>>>>>> index 0000000..2b489fc
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/watchdog/lpc18xx_wdt.c
>>>>>>> @@ -0,0 +1,344 @@
>>>>>>> +/*
>>>>>>> + * NXP LPC18xx Watchdog Timer (WDT)
>>>>>>> + *
>>>>>>> + * Copyright (c) 2015 Ariel D'Alessandro <ariel@vanguardiasur.com>
>>>>>>> + *
>>>>>>> + * This program is free software; you can redistribute it and/or
>>>>>>> modify it
>>>>>>> + * under the terms of the GNU General Public License version 2 as
>>>>>>> published by
>>>>>>> + * the Free Software Foundation.
>>>>>>> + *
>>>>>>> + * Notes
>>>>>>> + * -----
>>>>>>> + * The Watchdog consists of a fixed divide-by-4 clock pre-scaler and
>>>>>>> a 24-bit
>>>>>>> + * counter which decrements on every clock cycle.
>>>>>>> + *
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include <linux/clk.h>
>>>>>>> +#include <linux/io.h>
>>>>>>> +#include <linux/module.h>
>>>>>>> +#include <linux/of.h>
>>>>>>> +#include <linux/platform_device.h>
>>>>>>> +#include <linux/reboot.h>
>>>>>>> +#include <linux/watchdog.h>
>>>>>>> +
>>>>>>> +/* Registers */
>>>>>>> +#define LPC18XX_WDT_MOD            0x00
>>>>>>> +#define LPC18XX_WDT_MOD_WDEN        BIT(0)
>>>>>>> +#define LPC18XX_WDT_MOD_WDRESET        BIT(1)
>>>>>>> +#define LPC18XX_WDT_MOD_WDTOF_MASK    0x04
>>>>>>
>>>>>> Not used.
>>>>>
>>>>> That's right. I'll remove it.
>>>>>
>>>>>>
>>>>>>> +
>>>>>>> +#define LPC18XX_WDT_TC            0x04
>>>>>>> +#define LPC18XX_WDT_TC_MIN        0xff
>>>>>>> +#define LPC18XX_WDT_TC_MAX        0xffffff
>>>>>>> +
>>>>>>> +#define LPC18XX_WDT_FEED        0x08
>>>>>>> +#define LPC18XX_WDT_FEED_MAGIC1        0xaa
>>>>>>> +#define LPC18XX_WDT_FEED_MAGIC2        0x55
>>>>>>> +
>>>>>>> +#define LPC18XX_WDT_TV            0x0c
>>>>>>> +
>>>>>>> +/* Clock pre-scaler */
>>>>>>> +#define LPC18XX_WDT_CLK_DIV        4
>>>>>>> +
>>>>>>> +/* Timeout values in seconds */
>>>>>>> +#define LPC18XX_WDT_DEF_TIMEOUT        5
>>>>>>> +
>>>>>>
>>>>>> This is (still) really low for Linux. Something like min(30,
>>>>>> max_timeout)
>>>>>> might make more sense.
>>>>>
>>>>> Remember that hardware limits timeout to a maximum value of 5.
>>>>>
>>>>> As you said before we could use a soft timer, but I not sure that's a
>>>>> good idea. As Ezequiel said [0], it might be adding bloat and we must
>>>>> consider that this watchdog controller is included in cortex-M MCUs.
>>>>>
>>>>> [0] http://www.spinics.net/lists/linux-watchdog/msg06904.html
>>>>>
>>>>
>>>> Further down you have
>>>>      lpc18xx_wdt->wdt_dev.max_timeout = (LPC18XX_WDT_TC_MAX *
>>>>                            LPC18XX_WDT_CLK_DIV) / clk_rate;
>>>>
>>>> which seems to contradict this statement. If the maximum timeout is 5
>>>> seconds,
>>>> why don't you set max_timeout to a fixed value of 5 seconds ?
>>>
>>> Well, I think that's the less hardcoded way. It might allow the driver
>>> to be extended to another HW variant that configures the wdt clk rate.
>>>
>>> I see what's your point. As you proposed, using the same criterion I
>>> should do this:
>>>
>>> #define LPC18XX_WDT_DEF_TIMEOUT         (unsigned int)30
>>>
>>> and further down, in probe function:
>>>
>>> lpc18xx_wdt->wdt_dev.timeout = min(LPC18XX_WDT_DEF_TIMEOUT,
>>>                    lpc18xx_wdt->wdt_dev.max_timeout);
>>>
>>> Is this close enough to your solution?
>>>
>> Yes, but why the typecast for LPC18XX_WDT_DEF_TIMEOUT ?
>>
> 
> Otherwise the compiler will warn about a comparison of distinct pointer
> types in expansion of the macro 'min'.
> 
> Should it be casted when using it better than in definition?
> 
Just realized that a literal suffix would be better.

#define LPC18XX_WDT_DEF_TIMEOUT         30U
