Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39772 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933861AbcLMRFf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 13 Dec 2016 12:05:35 -0500
Date: Tue, 13 Dec 2016 09:05:27 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Hui Chun Ong <hui.chun.ong@ni.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "wim@iguana.be" <wim@iguana.be>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Julia Cartwright <julia.cartwright@ni.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Hearn <jonathan.hearn@ni.com>
Subject: Re: [PATCH v3] watchdog: nic7018_wdt: Add NIC7018 watchdog driver
Message-ID: <20161213170527.GB29124@roeck-us.net>
References: <1481365545-49894-1-git-send-email-hui.chun.ong@ni.com>
 <5f137b29-b90b-df10-ca8f-0059f1c556c1@roeck-us.net>
 <1481624182.54688.13.camel@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1481624182.54688.13.camel@ni.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 10:16:23AM +0000, Hui Chun Ong wrote:
> On Sat, 2016-12-10 at 09:22 -0800, Guenter Roeck wrote:
> > On 12/10/2016 02:25 AM, Hui Chun Ong wrote:
> > >=20
> > > Add support for the watchdog timer on PXI Embedded Controller.
> > >=20
> > > Signed-off-by: Hui Chun Ong <hui.chun.ong@ni.com>
> > > ---
> > > v2: Remove mutex lock and platform_device *pdev fields from struct
> > > nic7018_wdt.
> > > =A0=A0=A0=A0Update config NIC7018_WDT description.
> > > =A0=A0=A0=A0Update nic7018_get_config() to never return error.
> > > =A0=A0=A0=A0Remove checking for IO resource size in nic7018_probe()=
.
> > >=20
> > > v1: Remove non-standard attributes.
> > > =A0=A0=A0=A0Change from acpi_driver to platform_driver.
> > > =A0=A0=A0=A0Rename driver from ni7018_wdt to nic7018_wdt.
> > > ---
> > > =A0Documentation/watchdog/watchdog-parameters.txt |=A0=A0=A05 +
> > > =A0drivers/watchdog/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A010 +
> > > =A0drivers/watchdog/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A01 +
> > > =A0drivers/watchdog/nic7018_wdt.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0| 277
> > > +++++++++++++++++++++++++
> > > =A04 files changed, 293 insertions(+)
> > > =A0create mode 100644 drivers/watchdog/nic7018_wdt.c
> > >=20
> > > diff --git a/Documentation/watchdog/watchdog-parameters.txt
> > > b/Documentation/watchdog/watchdog-parameters.txt
> > > index a8d3642..bd142fa 100644
> > > --- a/Documentation/watchdog/watchdog-parameters.txt
> > > +++ b/Documentation/watchdog/watchdog-parameters.txt
> > > @@ -209,6 +209,11 @@ timeout: Initial watchdog timeout in seconds
> > > (0<timeout<516, default=3D60)
> > > =A0nowayout: Watchdog cannot be stopped once started
> > > =A0	(default=3Dkernel config parameter)
> > > =A0-------------------------------------------------
> > > +nic7018_wdt:
> > > +timeout: Initial watchdog timeout in seconds (0<timeout<464,
> > > default=3D80)
> > > +nowayout: Watchdog cannot be stopped once started
> > > +	(default=3Dkernel config parameter)
> > > +-------------------------------------------------
> > > =A0nuc900_wdt:
> > > =A0heartbeat: Watchdog heartbeats in seconds.
> > > =A0	(default =3D 15)
> > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > > index fdd3228..baa79825 100644
> > > --- a/drivers/watchdog/Kconfig
> > > +++ b/drivers/watchdog/Kconfig
> > > @@ -1325,6 +1325,16 @@ config NI903X_WDT
> > > =A0	=A0=A0To compile this driver as a module, choose M here: the
> > > module will be
> > > =A0	=A0=A0called ni903x_wdt.
> > >=20
> > > +config NIC7018_WDT
> > > +	tristate "NIC7018 Watchdog"
> > > +	depends on X86 && ACPI
> > > +	select WATCHDOG_CORE
> > > +	---help---
> > > +	=A0=A0Support for National Instruments NIC7018 Watchdog.
> > > +
> > > +	=A0=A0To compile this driver as a module, choose M here: the
> > > module will be
> > > +	=A0=A0called nic7018_wdt.
> > > +
> > > =A0# M32R Architecture
> > >=20
> > > =A0# M68K Architecture
> > > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > > index caa9f4a..bd88e2e 100644
> > > --- a/drivers/watchdog/Makefile
> > > +++ b/drivers/watchdog/Makefile
> > > @@ -139,6 +139,7 @@ obj-$(CONFIG_INTEL_SCU_WATCHDOG) +=3D
> > > intel_scu_watchdog.o
> > > =A0obj-$(CONFIG_INTEL_MID_WATCHDOG) +=3D intel-mid_wdt.o
> > > =A0obj-$(CONFIG_INTEL_MEI_WDT) +=3D mei_wdt.o
> > > =A0obj-$(CONFIG_NI903X_WDT) +=3D ni903x_wdt.o
> > > +obj-$(CONFIG_NIC7018_WDT) +=3D nic7018_wdt.o
> > >=20
> > > =A0# M32R Architecture
> > >=20
> > > diff --git a/drivers/watchdog/nic7018_wdt.c
> > > b/drivers/watchdog/nic7018_wdt.c
> > > new file mode 100644
> > > index 0000000..9b7b8d3
> > > --- /dev/null
> > > +++ b/drivers/watchdog/nic7018_wdt.c
> > > @@ -0,0 +1,277 @@
> > > +/*
> > > + * Copyright (C) 2016 National Instruments Corp.
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > modify
> > > + * it under the terms of the GNU General Public License as
> > > published by
> > > + * the Free Software Foundation; either version 2 of the License,
> > > or
> > > + * (at your option) any later version.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=A0=A0See t=
he
> > > + * GNU General Public License for more details.
> > > + */
> > > +
> > > +#include <linux/acpi.h>
> > > +#include <linux/bitops.h>
> > > +#include <linux/device.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/watchdog.h>
> > > +
> > > +#define LOCK			0xA5
> > > +#define UNLOCK			0x5A
> > > +
> > > +#define WDT_CTRL_RESET_EN	BIT(7)
> > > +#define WDT_RELOAD_PORT_EN	BIT(7)
> > > +
> > > +#define WDT_CTRL		1
> > > +#define WDT_RELOAD_CTRL		2
> > > +#define WDT_PRESET_PRESCALE	4
> > > +#define WDT_REG_LOCK		5
> > > +#define WDT_COUNT		6
> > > +#define WDT_RELOAD_PORT		7
> > > +
> > > +#define WDT_MIN_TIMEOUT		1
> > > +#define WDT_MAX_TIMEOUT		464
> > > +#define WDT_DEFAULT_TIMEOUT	80
> > > +
> > > +#define WDT_MAX_COUNTER		15
> > > +
> > > +static unsigned int timeout;
> > > +module_param(timeout, uint, 0);
> > > +MODULE_PARM_DESC(timeout,
> > > +		=A0"Watchdog timeout in seconds. (default=3D"
> > > +		=A0__MODULE_STRING(WDT_DEFAULT_TIMEOUT) ")");
> > > +
> > > +static bool nowayout =3D WATCHDOG_NOWAYOUT;
> > > +module_param(nowayout, bool, 0);
> > > +MODULE_PARM_DESC(nowayout,
> > > +		=A0"Watchdog cannot be stopped once started.
> > > (default=3D"
> > > +		=A0__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> > > +
> > > +struct nic7018_wdt {
> > > +	u16 io_base;
> > > +	u32 period_ms;
> > > +	struct watchdog_device wdd;
> > > +};
> > > +
> > > +struct nic7018_config {
> > > +	u32 period_ms;
> > > +	u8 divider;
> > > +};
> > > +
> > > +static const struct nic7018_config nic7018_configs[] =3D {
> > > +	{=A0=A0=A0125, 3 },
> > The maximum timeout is (125 * 15) - 62, or 1813 ms. This will never
> > be selected,
> > since with a timeout of 2s count will be 17 below, and the entry will
> > be skipped.
> > With a timeout of 1000, the second table entry will be used as well
> > since the
> > timeout with the first entry is not exactly 1 second.
> >=20
> > Given that, you might as well drop this entry.
> >=20
> >=20
> > >=20
> > > +	{=A0=A02000, 4 },
> > > +	{ 32000, 5 },
> > > +};
> > > +
> > > +static inline u32 nic7018_timeout_ms(u32 period_ms, u8 counter)
> > > +{
> > > +	return period_ms * counter - period_ms / 2;
> > > +}
> > > +
> > > +static const struct nic7018_config *nic7018_get_config(u32
> > > timeout_ms,
> > > +						=A0=A0=A0=A0=A0=A0=A0u8
> > > *counter)
> > > +{
> > > +	u32 delta, i, best_delta =3D U32_MAX;
> > > +	const struct nic7018_config *config, *best_config =3D NULL;
> > > +	u8 count;
> > > +	*counter =3D WDT_MAX_COUNTER;
> > > +
> > > +	for (i =3D 0; i < ARRAY_SIZE(nic7018_configs); i++) {
> > > +		config =3D &nic7018_configs[i];
> > > +
> > > +		count =3D DIV_ROUND_UP(timeout_ms + config-
> > > >period_ms / 2,
> > > +				=A0=A0=A0=A0=A0config->period_ms);
> > > +
> > > +		if (count > WDT_MAX_COUNTER)
> > > +			continue;
> > > +
> > > +		delta =3D nic7018_timeout_ms(config->period_ms,
> > > count) -
> > > +			timeout_ms;
> > > +
> > > +		if (delta < best_delta) {
> > > +			best_delta =3D delta;
> > > +			best_config =3D config;
> > > +			*counter =3D count;
> > > +		}
> > > +	}
> > > +
> > > +	return (!best_config) ? config : best_config;
> > Unecessary (), and
> > 	return best_config ? : config;
> > works without the '!'.
> >=20
> > Also, given the above, it seems to me that
> >=20
> > 	if (timeout < 30 && timeout !=3D 16) {
> > 		config =3D &nic7018_configs[0];
> > 		count =3D timeout / 2 + 1;
> > 	} else {
> > 		config =3D &nic7018_configs[1];
> > 		count =3D DIV_ROUND_UP(timeout + 16, 32);
> > 		if (count > WDT_MAX_COUNTER;
> > 			count =3D WDT_MAX_COUNTER;
> > 	}
> > 	*counter =3D count;
> > 	return config;
> >=20
> > would accomplish the same as your code and be much less complex and
> > easier
> > to understand. As a side effect, you could keep all timeouts in
> > seconds
> > and would not have to deal with milliseconds at all.
> >=20
>=20
> Is it possible to keep the miliseconds calculation in the driver even
> though its doesn't seem to be needed? The reason is because the
> watchdog timer has miliseconds timeout resolution that we plan to
> utilize for our specific application. Do you foresee the watchdog core
> adding support for miliseconds timeout?
>=20

Not anytime soon. There was some argument about it, but in practice Linux
user space demons have a hard time meeting low-second timeouts. On top of=
 that,
it really would only make sense for low-second or sub-second timeouts, bu=
t for
those I don't really see the point because it takes much longer to reboot=
 the
kernel.

In my opinion, it is better to keep the code simple and add complexity la=
ter
if/when needed. Writing complex code just in case it may be needed at som=
e
point in the future doesn't make much sense to me.

Guenter
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
