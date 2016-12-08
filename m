Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50018 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbcLHOPU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 8 Dec 2016 09:15:20 -0500
Subject: Re: [PATCH v2] watchdog: nic7018_wdt: Add NIC7018 watchdog driver
To: Hui Chun Ong <hui.chun.ong@ni.com>,
        "corbet@lwn.net" <corbet@lwn.net>, "wim@iguana.be" <wim@iguana.be>
References: <1479266515-9205-1-git-send-email-hui.chun.ong@ni.com>
 <ba6df233-af61-2553-27ab-72d5153c4f19@roeck-us.net>
 <1481188760.20527.16.camel@ni.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Julia Cartwright <julia.cartwright@ni.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Hearn <jonathan.hearn@ni.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c0d35005-3d8e-c7c6-c725-3f8cc526b00d@roeck-us.net>
Date: Thu, 8 Dec 2016 06:15:15 -0800
MIME-Version: 1.0
In-Reply-To: <1481188760.20527.16.camel@ni.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/08/2016 01:19 AM, Hui Chun Ong wrote:
> On Thu, 2016-11-24 at 11:56 -0800, Guenter Roeck wrote:
>> On 11/15/2016 07:21 PM, Hui Chun Ong wrote:
>>>
>>> Add support for the watchdog timer on PXI Embedded Controller.
>>>
>>> Signed-off-by: Hui Chun Ong <hui.chun.ong@ni.com>
>>> ---
>>> v1: Remove non-standard attributes.
>>>     Change from acpi_driver to platform_driver.
>>>     Rename driver from ni7018_wdt to nic7018_wdt.
>>> ---
>>>  Documentation/watchdog/watchdog-parameters.txt |   5 +
>>>  drivers/watchdog/Kconfig                       |  10 +
>>>  drivers/watchdog/Makefile                      |   1 +
>>>  drivers/watchdog/nic7018_wdt.c                 | 303 +++++++++++++++++++++++++
>>>  4 files changed, 319 insertions(+)
>>>  create mode 100644 drivers/watchdog/nic7018_wdt.c
>>>
>>> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
>>> index a8d3642..bd142fa 100644
>>> --- a/Documentation/watchdog/watchdog-parameters.txt
>>> +++ b/Documentation/watchdog/watchdog-parameters.txt
>>> @@ -209,6 +209,11 @@ timeout: Initial watchdog timeout in seconds (0
>>>  nowayout: Watchdog cannot be stopped once started
>>>  	(default=kernel config parameter)
>>>  -------------------------------------------------
>>> +nic7018_wdt:
>>> +timeout: Initial watchdog timeout in seconds (0
>>> +nowayout: Watchdog cannot be stopped once started
>>> +	(default=kernel config parameter)
>>> +-------------------------------------------------
>>>  nuc900_wdt:
>>>  heartbeat: Watchdog heartbeats in seconds.
>>>  	(default = 15)
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index fdd3228..79fb224 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -1325,6 +1325,16 @@ config NI903X_WDT
>>>  	  To compile this driver as a module, choose M here: the module will be
>>>  	  called ni903x_wdt.
>>>
>>> +config NIC7018_WDT
>>> +	tristate "NIC7018 Watchdog"
>>> +	depends on X86 && ACPI
>>> +	select WATCHDOG_CORE
>>> +	---help---
>>> +	  This is the device driver for National Instruments NIC7018 Watchdog.
>>> +
>> This should describe what the watchdog is for.
>>
>> "Support for National Instruments NIC7018 Watchdog".
>>
>>>
>>> +	  To compile this driver as a module, choose M here: the module will be
>>> +	  called nic7018_wdt.
>>> +
>>>  # M32R Architecture
>>>
>>>  # M68K Architecture
>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>> index caa9f4a..bd88e2e 100644
>>> --- a/drivers/watchdog/Makefile
>>> +++ b/drivers/watchdog/Makefile
>>> @@ -139,6 +139,7 @@ obj-$(CONFIG_INTEL_SCU_WATCHDOG) += intel_scu_watchdog.o
>>>  obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
>>>  obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
>>>  obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
>>> +obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
>>>
>>>  # M32R Architecture
>>>
>>> diff --git a/drivers/watchdog/nic7018_wdt.c b/drivers/watchdog/nic7018_wdt.c
>>> new file mode 100644
>>> index 0000000..780edc6
>>> --- /dev/null
>>> +++ b/drivers/watchdog/nic7018_wdt.c
>>> @@ -0,0 +1,303 @@
>>> +/*
>>> + * Copyright (C) 2016 National Instruments Corp.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#include
>>> +#include
>>> +#include
>>> +#include
>>> +#include
>>> +#include
>>> +#include
>>> +
>>> +#define LOCK			0xA5
>>> +#define UNLOCK			0x5A
>>> +
>>> +#define WDT_CTRL_RESET_EN	BIT(7)
>>> +#define WDT_RELOAD_PORT_EN	BIT(7)
>>> +
>> Should include linux/bitops.h
>>
>>>
>>> +#define WDT_CTRL		1
>>> +#define WDT_RELOAD_CTRL		2
>>> +#define WDT_PRESET_PRESCALE	4
>>> +#define WDT_REG_LOCK		5
>>> +#define WDT_COUNT		6
>>> +#define WDT_RELOAD_PORT		7
>>> +
>>> +#define WDT_MIN_TIMEOUT		1
>>> +#define WDT_MAX_TIMEOUT		464
>> 32 * 15 would be 480 ? I assume the limit above is because of the rounding down
>> by 16 in the driver, but that only shows that this rounding is maybe not the best
>> idea. After all, the maximum timeout _is_ 480 seconds, if I understand the code
>> correctly.
>>
> The formula for timeout calculation is = (period * counter) - (period / 2). So in this case, (32 * 15) - (32 / 2) = 464
>

I understand that this is the formula used here. But is it the real timeout ?
It appears unlikely for any hardware to use a subtract operation internally
to calculate a timeout.

Same for the default timeout. Question there is: If you set the default timeout as
set to 80 seconds, does the watchdog time out after 80 seconds, or after 96 seconds ?

Similar, if one sets the timeout value to the minimum, which per your calculation
should be 16 seconds, does the watchdog really time out after 16 seconds, or does
it time out after 32 seconds ? This should be easy to verify with real hardware.

Guenter

