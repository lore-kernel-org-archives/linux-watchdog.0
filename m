Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36488 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756344AbbIYOCd (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 25 Sep 2015 10:02:33 -0400
Subject: Re: [PATCH] watchdog: iTCO_wdt: Fix unmet dependency in select
From: Jean Delvare <jdelvare@suse.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	Linux I2C <linux-i2c@vger.kernel.org>,
	Jim Davis <jim.epost@gmail.com>,
	Matt Fleming <matt.fleming@intel.com>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>
In-Reply-To: <56054C2E.9010703@roeck-us.net>
References: <20150925101045.06062b59@endymion.delvare>
	 <56054C2E.9010703@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2015 16:02:29 +0200
Message-ID: <1443189749.4919.2.camel@chaos.site>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

Le Friday 25 September 2015 =C3=A0 06:29 -0700, Guenter Roeck a =C3=A9c=
rit :
> On 09/25/2015 01:10 AM, Jean Delvare wrote:
> > ITCO_WDT selects I2C_I801 but does not select its dependencies (I2C=
=2E)
> > This can result in link-time failures:
> >
> > drivers/built-in.o: In function `i801_remove':
> > i2c-i801.c:(.text+0x1a6126): undefined reference to `i2c_del_adapte=
r'
> > drivers/built-in.o: In function `dmi_check_onboard_devices':
> > i2c-i801.c:(.text+0x1a7531): undefined reference to `i2c_new_device=
'
> > drivers/built-in.o: In function `i801_probe':
> > i2c-i801.c:(.text+0x1a7aa8): undefined reference to `i2c_add_adapte=
r'
> > i2c-i801.c:(.text+0x1a7e14): undefined reference to `i2c_new_device=
'
> >
> > So we must select I2C as well.
> >
> > Reported-by: Jim Davis <jim.epost@gmail.com>
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Fixes: 2a7a0e9bf7 ("watchdog: iTCO_wdt: Add support for TCO on Inte=
l Sunrisepoint")
> > Cc: Matt Fleming <matt.fleming@intel.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Wim Van Sebroeck <wim@iguana.be>
> > ---
> >   drivers/watchdog/Kconfig |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- linux-4.3-rc2.orig/drivers/watchdog/Kconfig	2015-09-24 11:43:29=
=2E959432358 +0200
> > +++ linux-4.3-rc2/drivers/watchdog/Kconfig	2015-09-25 09:56:20.5188=
40112 +0200
> > @@ -818,6 +818,7 @@ config ITCO_WDT
> >   	depends on (X86 || IA64) && PCI
> >   	select WATCHDOG_CORE
> >   	select LPC_ICH if !EXPERT
> > +	select I2C if !EXPERT
> >   	select I2C_I801 if !EXPERT
> >   	---help---
> >   	  Hardware driver for the intel TCO timer based watchdog devices=
=2E
> >
> >
>=20
> I had fixed the problem differently, similar to other drivers.
>=20
> http://patchwork.roeck-us.net/patch/239/

404 Not Found?

> Waiting for Wim to apply it.

--=20
Jean Delvare
SUSE L3 Support

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
