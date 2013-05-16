Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:59886 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab3EPPda (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 16 May 2013 11:33:30 -0400
Message-ID: <5194FC33.8090303@free-electrons.com>
Date: Thu, 16 May 2013 17:33:07 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: Carlo Caione <carlo.caione@gmail.com>, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: sunxi: New watchdog driver for Allwinner A10/A13
References: <1368390994-27161-1-git-send-email-carlo.caione@gmail.com> <51934896.3000506@free-electrons.com> <20130515122834.GA26168@roeck-us.net>
In-Reply-To: <20130515122834.GA26168@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi,

Le 15/05/2013 14:28, Guenter Roeck a =E9crit :
> On Wed, May 15, 2013 at 10:34:30AM +0200, Maxime Ripard wrote:
>> Hi Carlo,
>>
>> Le 12/05/2013 22:36, Carlo Caione a =E9crit :
>>> This patch adds the driver for the watchdog found in the Allwinner A1=
0 and
>>> A13 SoCs. It has DT-support and uses the new watchdog framework.
>>>
>>> Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
>>> ---
>>>  drivers/watchdog/Kconfig     |  10 ++
>>>  drivers/watchdog/Makefile    |   1 +
>>>  drivers/watchdog/sunxi_wdt.c | 218 +++++++++++++++++++++++++++++++++=
++++++++++
>>>  3 files changed, 229 insertions(+)
>>>  create mode 100644 drivers/watchdog/sunxi_wdt.c
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index e89fc31..473e670 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -299,6 +299,16 @@ config ORION_WATCHDOG
>>>  	  To compile this driver as a module, choose M here: the
>>>  	  module will be called orion_wdt.
>>> =20
>>> +config SUNXI_WATCHDOG
>>> +	tristate "Sunxi watchdog"
>>
>> Maybe mention what sunxi is? something like "Allwinner SoCs watchdog
>> support"
>>
>>> +	depends on ARCH_SUNXI
>>> +	select WATCHDOG_CORE
>>> +	help
>>> +	  Say Y here to include support for the watchdog timer
>>> +	  in Allwinner A10 and A13.
>>
>> I'd be more generic here. As far as we know, this code is found in A10=
,
>> A10s, A13, and can easily be adapted to support the A31 (and I suspect
>> the A20 as well). Something like "Allwinner SoCs"
>>
>>> +	  To compile this driver as a module, choose M here: the
>>> +	  module will be called sunxi_wdt.
>>> +
>>>  config COH901327_WATCHDOG
>>>  	bool "ST-Ericsson COH 901 327 watchdog"
>>>  	depends on ARCH_U300
>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>> index a300b94..5012d5f 100644
>>> --- a/drivers/watchdog/Makefile
>>> +++ b/drivers/watchdog/Makefile
>>> @@ -47,6 +47,7 @@ obj-$(CONFIG_PNX4008_WATCHDOG) +=3D pnx4008_wdt.o
>>>  obj-$(CONFIG_IOP_WATCHDOG) +=3D iop_wdt.o
>>>  obj-$(CONFIG_DAVINCI_WATCHDOG) +=3D davinci_wdt.o
>>>  obj-$(CONFIG_ORION_WATCHDOG) +=3D orion_wdt.o
>>> +obj-$(CONFIG_SUNXI_WATCHDOG) +=3D sunxi_wdt.o
>>>  obj-$(CONFIG_COH901327_WATCHDOG) +=3D coh901327_wdt.o
>>>  obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) +=3D stmp3xxx_rtc_wdt.o
>>>  obj-$(CONFIG_NUC900_WATCHDOG) +=3D nuc900_wdt.o
>>> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wd=
t.c
>>> new file mode 100644
>>> index 0000000..fe193b3
>>> --- /dev/null
>>> +++ b/drivers/watchdog/sunxi_wdt.c
>>> @@ -0,0 +1,218 @@
>>> +/*
>>> + *      sunxi Watchdog Driver
>>> + *
>>> + *      Copyright (c) 2013 Carlo Caione
>>> + *                    2012 Henrik Nordstrom
>>> + *
>>> + *      This program is free software; you can redistribute it and/o=
r
>>> + *      modify it under the terms of the GNU General Public License
>>> + *      as published by the Free Software Foundation; either version
>>> + *      2 of the License, or (at your option) any later version.
>>> + *
>>> + *      Based on xen_wdt.c
>>> + *      (c) Copyright 2010 Novell, Inc.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/err.h>
>>> +#include <linux/init.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/moduleparam.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/types.h>
>>> +#include <linux/watchdog.h>
>>> +
>>> +#define WDT_MAX_TIMEOUT         16
>>> +#define WDT_MIN_TIMEOUT         1
>>> +#define WDT_MODE_TIMEOUT(n)     ((n) << 3)
>>> +#define WDT_TIMEOUT_MASK        WDT_MODE_TIMEOUT(0x0F)
>>> +
>>> +#define WDT_CTRL                0x00
>>> +#define WDT_MODE                0x04
>>> +
>>> +#define WDT_MODE_RST_EN         (1 << 1)
>>> +#define WDT_MODE_EN             (1 << 0)
>>> +
>>> +#define WDT_CTRL_RESTART        (1 << 0)
>>
>> I'd prefer to see the bits values just behind the register they belong=
 to.
>>
>>> +#define WDT_CTRL_RESERVED       (0x0a57 << 1)
>>> +#define DRV_NAME		"sunxi-wdt"
>>> +#define DRV_VERSION		"1.0"
>>> +
>>> +static bool nowayout =3D WATCHDOG_NOWAYOUT;
>>> +static int heartbeat =3D WDT_MAX_TIMEOUT;
>>> +
>>> +static const int wdt_timeout_map[] =3D {
>>> +	[1] =3D 0b0001,
>>> +	[2] =3D 0b0010,
>>> +	[3] =3D 0b0011,
>>> +	[4] =3D 0b0100,
>>> +	[5] =3D 0b0101,
>>> +	[6] =3D 0b0110,
>>> +	[8] =3D 0b0111,
>>> +	[10] =3D 0b1000,
>>> +	[12] =3D 0b1001,
>>> +	[14] =3D 0b1010,
>>> +	[16] =3D 0b1011,
>>> +};
>>
>> It would be great to have a comment about what this map is here for an=
d
>> how you store the values.
>>
>> You don't support the 0.5s timeout here as well. I know why, but some
>> new comer might not, so I guess it would be great to add it to the
>> comment as well.
>>
>> Moreover, I'd really like this to be supported. Maybe, since obviously
>> we can't put a value at the index 0.5, maybe saying that the 0 index i=
s
>> actually this 0.5ms timeout value?
>>
> guess you mean 0.5s, not 0.5ms.
>=20
> Since the watchdog infrastructure does not support it, how would you se=
t it ?

Ah, I wasn't aware of such limitation in the watchdog infrastructure.

Ok, You can ignore my comment about this then. But I'd still like some
comments before that structure.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
