Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38797 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaHUGPo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Aug 2014 02:15:44 -0400
Date: Thu, 21 Aug 2014 08:15:25 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Support Opensource <support.opensource@diasemi.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [v4] watchdog: Add DA906x PMIC watchdog driver.
Message-ID: <20140821061525.GA23823@pengutronix.de>
References: <1408192545-23987-1-git-send-email-mpa@pengutronix.de>
 <20140820144322.GA7609@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20140820144322.GA7609@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 20, 2014 at 07:43:22AM -0700, Guenter Roeck wrote:
> On Sat, Aug 16, 2014 at 02:35:45PM +0200, Markus Pargmann wrote:
> > From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> >=20
> > This driver supports the watchdog device inside the DA906x PMIC.
> >=20
> > Signed-off-by: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >=20
> > ---
> > Notes:
> >     Changes in v4:
> >      - Fixed indentation
> >      - Fixed lock without unlock
> >      - Check for parent device and device driver data in probe(). If no=
t present,
> >        this is an invalid prober initialization, return -EINVAL.
> >    =20
> >     Changes in v3:
> >      - Cleanup error handling for timeout selection and setting
> >      - Fix race condition due to late wdt drvdata setup
> >      - Remove static struct watchdog_device. It is not initialized in t=
he probe
> >        function
> >      - Use WATCHDOG_NOWAYOUT_INIT_STATUS for the status
> >      - Remove 0 shift using DA9063_TWDSCALE_SHIFT
> >=20
> >  drivers/watchdog/Kconfig      |   7 ++
> >  drivers/watchdog/Makefile     |   1 +
> >  drivers/watchdog/da9063_wdt.c | 231 ++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 239 insertions(+)
> >  create mode 100644 drivers/watchdog/da9063_wdt.c
> >=20
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index c845527b503a..8d5c9b33552a 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -87,6 +87,13 @@ config DA9055_WATCHDOG
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called da9055_wdt.
> > =20
> > +config DA9063_WATCHDOG
> > +	tristate "Dialog DA9063 Watchdog"
> > +	depends on MFD_DA9063
> > +	select WATCHDOG_CORE
> > +	help
> > +	  Support for the watchdog in the DA9063 PMIC.
> > +
> Please add a note such as above, listing the module name.

Added such a note.

>=20
> >  config GPIO_WATCHDOG
> >  	tristate "Watchdog device controlled through GPIO-line"
> >  	depends on OF_GPIO
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index 7b8a91ed20e7..ce4a7632d863 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -172,6 +172,7 @@ obj-$(CONFIG_XEN_WDT) +=3D xen_wdt.o
> >  # Architecture Independent
> >  obj-$(CONFIG_DA9052_WATCHDOG) +=3D da9052_wdt.o
> >  obj-$(CONFIG_DA9055_WATCHDOG) +=3D da9055_wdt.o
> > +obj-$(CONFIG_DA9063_WATCHDOG) +=3D da9063_wdt.o
> >  obj-$(CONFIG_GPIO_WATCHDOG)	+=3D gpio_wdt.o
> >  obj-$(CONFIG_WM831X_WATCHDOG) +=3D wm831x_wdt.o
> >  obj-$(CONFIG_WM8350_WATCHDOG) +=3D wm8350_wdt.o
> > diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wd=
t.c
> > new file mode 100644
> > index 000000000000..a2d46bc55805
> > --- /dev/null
> > +++ b/drivers/watchdog/da9063_wdt.c
> > @@ -0,0 +1,231 @@
> > +/*
> > + * Watchdog driver for DA9063 PMICs.
> > + *
> > + * Copyright(c) 2012 Dialog Semiconductor Ltd.
> > + *
> > + * Author: Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>
> > + *
> > + * This program is free software; you can redistribute  it and/or modi=
fy it
> > + * under  the terms of  the GNU General  Public License as published b=
y the
> > + * Free Software Foundation;  either version 2 of the  License, or (at=
 your
> > + * option) any later version.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/watchdog.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/slab.h>
> > +#include <linux/delay.h>
> > +#include <linux/mfd/da9063/registers.h>
> > +#include <linux/mfd/da9063/core.h>
> > +#include <linux/regmap.h>
> > +
> > +/*
> > + * Watchdog selector to timeout in seconds.
> > + *   0: WDT disabled;
> > + *   others: timeout =3D 2048 ms * 2^(TWDSCALE-1).
> > + */
> > +static const int wdt_timeout[] =3D { 0, 2, 4, 8, 16, 32, 65, 131 };
> > +#define DA9063_TWDSCALE_DISABLE		0
> > +#define DA9063_TWDSCALE_MIN		1
> > +#define DA9063_TWDSCALE_MAX		(ARRAY_SIZE(wdt_timeout) - 1)
> > +#define DA9063_WDT_MIN_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MIN]
> > +#define DA9063_WDT_MAX_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MAX]
> > +#define DA9063_WDG_TIMEOUT		wdt_timeout[3]
> > +
> > +struct da9063_watchdog {
> > +	struct da9063 *da9063;
> > +	struct watchdog_device wdtdev;
> > +	struct mutex lock;
> > +};
> > +
> > +static int da9063_wdt_timeout_to_sel(int secs)
> > +{
> > +	int i;
> > +
> > +	for (i =3D DA9063_TWDSCALE_MIN; i <=3D DA9063_TWDSCALE_MAX; i++) {
>=20
> When building with W=3D1, gcc complains about this line. Would be great i=
f you can
> have a look and fix it.

I just compiled with W=3D1, it doesn't complain here about this line.
Could you give me the warning?

>=20
> > +		if (wdt_timeout[i] >=3D secs)
> > +			return i;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int da9063_wdt_disable(struct da9063 *da9063)
> > +{
> > +	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> > +			DA9063_TWDSCALE_MASK,
> > +			DA9063_TWDSCALE_DISABLE);
> > +}
> > +
> > +static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int=
 regval)
> > +{
> > +	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> > +			DA9063_TWDSCALE_MASK, regval);
> > +}
> > +
> > +static int _da9063_wdt_kick(struct da9063 *da9063)
> > +{
> > +	return regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
> > +			DA9063_WATCHDOG);
> > +}
> > +
> > +static int da9063_wdt_start(struct watchdog_device *wdd)
> > +{
> > +	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> > +	unsigned int selector;
> > +	int ret;
> > +
> > +	selector =3D da9063_wdt_timeout_to_sel(wdt->wdtdev.timeout);
> > +	if (selector < 0) {
>=20
> selector has to be an int for this to work. Building the driver with W=3D=
1 reports
> it, btw.

Yes, thanks, I changed both selector variables to int.

>=20
> > +		dev_err(wdt->da9063->dev, "Timeout out of range (timeout=3D%d)\n",
> > +				wdt->wdtdev.timeout);
> > +		return selector;
> > +	}
> > +
> > +	mutex_lock(&wdt->lock);
> > +	ret =3D _da9063_wdt_set_timeout(wdt->da9063, selector);
> > +	if (ret) {
> > +		dev_err(wdt->da9063->dev, "Watchdog failed to start (err =3D %d)\n",
> > +				ret);
> > +	}
> > +	mutex_unlock(&wdt->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int da9063_wdt_stop(struct watchdog_device *wdd)
> > +{
> > +	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> > +	int ret;
> > +
> > +	mutex_lock(&wdt->lock);
> > +	ret =3D da9063_wdt_disable(wdt->da9063);
> > +	if (ret)
> > +		dev_alert(wdt->da9063->dev, "Watchdog failed to stop (err =3D %d)\n",
> > +				ret);
>=20
> You have a number of places where the continuation line _on purpose_
> does not align to te opening '('. I would understand it if your indentati=
on
> rules were in any way consistent, but I don't see that either.
> Ok, I can see that you dislike the rule that continuation lines should be
> aligned to '(', but to misalign even when the '(' matches a tab position =
doesn't
> really make any sense.

My indentation rules are consistent, otherwise I made a mistake. I
always indent two tabs after an opening bracket when breaking long
lines. Also I can't find any specific rules about how to break long
lines in the coding style document.

>=20
> > +	mutex_unlock(&wdt->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int da9063_wdt_ping(struct watchdog_device *wdd)
> > +{
> > +	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> > +	int ret;
> > +
> > +	mutex_lock(&wdt->lock);
> > +	ret =3D _da9063_wdt_kick(wdt->da9063);
> > +	if (ret)
> > +		dev_alert(wdt->da9063->dev, "Failed to ping the watchdog (err =3D %d=
)\n",
> > +				ret);
> > +	mutex_unlock(&wdt->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
> > +		unsigned int timeout)
> > +{
> > +	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> > +	unsigned int selector;
> > +	int ret;
> > +
> > +	selector =3D da9063_wdt_timeout_to_sel(timeout);
> > +	if (selector < 0) {
>=20
> selector must be an int for this to work.
>=20
> > +		dev_err(wdt->da9063->dev, "Unsupported watchdog timeout, should be b=
etween 2 and 131\n");
>=20
> Please use a continuation line here.

Ok.

Thank you,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT9Y59AAoJEEpcgKtcEGQQprwP/0ewgHr6PhAkukE8Xotj/9+v
gYTy+BgpX+uZuHjzvP1/01MAO3lVysvWN4rXxrM3Aypcd1SdpAjD/3tfuyqTOV6g
OYuX97X1H3AiFdDE5j2gjA2UP+rGXOxcY2jtQIRMRC5kW07ML8qQK4XronTGw3Q6
2yKiWk8EFgnOBfn9I1fj74dvRa5ulGaTCjIzovtOLmpO1NgIk6rybHM7U5hpfqPN
RjlfsJIxjzpWr6I/oK8R9k8VAgwmrIsZLYwRVDRCawZEhRGICe9kzvAoM1uJCHTt
sYnJa7SUr9WXkqp5WpaZs3EMN2rqKmxPsyHuo4z6I2E7tlqEKfwRfe9bnNG88TKn
5EVQzel4z0u8WH380L4BGqp+LhqyKxUNSywe1LlElxA8M9xnWGqvlxnW2KYGn92m
HnrDniqttQoDubmdn/5Swi13tjZVhaIOdJphxfoyne6Ow5kTEVqfHE92ECjq1nyY
3PpJSGKmAM16+0/fC/PPIwAz823e5o9V0swt/qLe2Gw5P9L9LYgT77eR6hGrUaq3
F8dcGOYU/kON3/UXFCtgKrt7WTzICGwfko6duSCYlpsz7PV6V/ysgx3iEqcWmqXK
1uv8QKvkrgkSxy86iQ3+ATU6pHYeXFTiKAD9yKR9FWAtKjqK4HFpY/GJT/L+xTIo
m9lZuTQidO/CBR1cfn/x
=eeJd
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
