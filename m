Return-path: <mpa@pengutronix.de>
Date: Wed, 24 Sep 2014 11:10:55 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Support Opensource <support.opensource@diasemi.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v6] watchdog: Add DA9063 PMIC watchdog driver.
Message-ID: <20140924091055.GB25366@pengutronix.de>
References: <1410184713-6436-1-git-send-email-mpa@pengutronix.de>
 <20140911163035.GA13969@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <20140911163035.GA13969@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

sorry for the late reply, I was on vacation.

On Thu, Sep 11, 2014 at 09:30:35AM -0700, Guenter Roeck wrote:
> On Mon, Sep 08, 2014 at 03:58:33PM +0200, Markus Pargmann wrote:
> > From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> >=20
> > This driver supports the watchdog device inside the DA9063 PMIC.
> >=20
> > Signed-off-by: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >=20
> > Notes:
> >     Changes in v6:
> >      - Fix compile error
> >    =20
> >     Changes in v5:
> >      - Kconfig: Add note about the module name.
> >      - Change selector variables to int
> >      - Style fixes
> >      - use unsigned int to remove gcc verbose warning
> >      - Integrate _kick() and _disable() into the calling functions
> >    =20
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
> >  drivers/watchdog/Kconfig      |   9 ++
> >  drivers/watchdog/Makefile     |   1 +
> >  drivers/watchdog/da9063_wdt.c | 222 ++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 232 insertions(+)
> >  create mode 100644 drivers/watchdog/da9063_wdt.c
> >=20
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index f57312fced80..669de63a7a48 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -87,6 +87,15 @@ config DA9055_WATCHDOG
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
> > +	  This driver can be built as a module. The module name is da9063_wdt.
> > +
> >  config GPIO_WATCHDOG
> >  	tristate "Watchdog device controlled through GPIO-line"
> >  	depends on OF_GPIO
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index 468c3204c3b1..6c467a9821fe 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -173,6 +173,7 @@ obj-$(CONFIG_XEN_WDT) +=3D xen_wdt.o
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
> > index 000000000000..88441bdd2d1b
> > --- /dev/null
> > +++ b/drivers/watchdog/da9063_wdt.c
> > @@ -0,0 +1,222 @@
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
>=20
> The watchdog subsystem already provides locking. I don't find a single ca=
se
> where this additional lock is needed. Can you give me one ?

Okay, I removed the lock.

>=20
> > +};
> > +
> > +static int da9063_wdt_timeout_to_sel(int secs)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i =3D DA9063_TWDSCALE_MIN; i <=3D DA9063_TWDSCALE_MAX; i++) {
> > +		if (wdt_timeout[i] >=3D secs)
> > +			return i;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int=
 regval)
> > +{
> > +	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> > +			DA9063_TWDSCALE_MASK, regval);
>=20
> For hwmon I decided to start enforcing indentation rules, for the simple
> reason that everyone otherwise uses different second-line indentations.
> Lucky for you I am not the watchdog maintainer ;-)

As a lot of people seem to share your opinion about indentation I
configured my vim to align to the opening bracket now. So next version
will have aligned indentation ;-).
>=20
> > +}
> > +
> > +static int da9063_wdt_start(struct watchdog_device *wdd)
> > +{
> > +	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> > +	int selector;
> > +	int ret;
> > +
> > +	selector =3D da9063_wdt_timeout_to_sel(wdt->wdtdev.timeout);
> > +	if (selector < 0) {
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
> > +	ret =3D regmap_update_bits(wdt->da9063->regmap, DA9063_REG_CONTROL_D,
> > +			DA9063_TWDSCALE_MASK,
> > +			DA9063_TWDSCALE_DISABLE);
> > +	if (ret)
> > +		dev_alert(wdt->da9063->dev, "Watchdog failed to stop (err =3D %d)\n",
> > +				ret);
>=20
> I am personally not in favor of dumping error mesasges onto the console i=
f the
> error is also reported to user space. My logic is that if everyone would =
be
> doing that logging, the log would be all noise and be completely useless.

Yes, the userspace should handle error codes and report errors
appropriately. However as this is a quite serious error message, I would
prefer to have it as a kernel error message so that the reason for a
reset by watchdog is obvious and listed in the kernel log.

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
> > +	ret =3D regmap_write(wdt->da9063->regmap, DA9063_REG_CONTROL_F,
> > +			DA9063_WATCHDOG);
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
> > +	int selector;
> > +	int ret;
> > +
> > +	selector =3D da9063_wdt_timeout_to_sel(timeout);
> > +	if (selector < 0) {
> > +		dev_err(wdt->da9063->dev,
> > +				"Unsupported watchdog timeout, should be between 2 and 131\n");
>=20
> Since the caller already performs a range check, I wonder if this repeated
> error check really provides additional value. Seems to me it would be much
> simpler to have da9063_wdt_timeout_to_sel always return a valid value and
> to drop all those additional range checks.

Okay, finally removed all these rangechecks.

>=20
> > +		return -EINVAL;
> > +	}
> > +
> > +	mutex_lock(&wdt->lock);
> > +
> > +	ret =3D _da9063_wdt_set_timeout(wdt->da9063, selector);
> > +	if (ret)
> > +		dev_err(wdt->da9063->dev, "Failed to set watchdog timeout (err =3D %=
d)\n",
> > +				ret);
> > +	else
> > +		wdd->timeout =3D wdt_timeout[selector];
> > +
> > +	mutex_unlock(&wdt->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct watchdog_info da9063_watchdog_info =3D {
> > +	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> > +	.identity =3D "DA9063 Watchdog",
> > +};
> > +
> > +static const struct watchdog_ops da9063_watchdog_ops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.start =3D da9063_wdt_start,
> > +	.stop =3D da9063_wdt_stop,
> > +	.ping =3D da9063_wdt_ping,
> > +	.set_timeout =3D da9063_wdt_set_timeout,
> > +};
> > +
> > +static int da9063_wdt_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	struct da9063 *da9063;
> > +	struct da9063_watchdog *wdt;
> > +
> > +	if (!pdev->dev.parent)
> > +		return -EINVAL;
> > +
> > +	da9063 =3D dev_get_drvdata(pdev->dev.parent);
> > +	if (!da9063)
> > +		return -EINVAL;
> > +
>=20
> This is not really an invalid argument. -ENODEV seems to be more appropri=
ate,
> given the context (presumably it means that there is no parent mfd device=
).

Yes, but ENODEV will not result in a probe error message because the
driver core assumes that the driver is not for this device. I would like
to have a probe error message so that developers immediately see that
something went wrong. This driver without a parent is a invalid setup,
so I chose EINVAL.
I prefer returning -EINVAL but as an alternative I could add an error
message here and return ENODEV.

>=20
> > +	wdt =3D devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> > +	if (!wdt)
> > +		return -ENOMEM;
> > +
> > +	wdt->da9063 =3D da9063;
> > +	mutex_init(&wdt->lock);
> > +
> > +	wdt->wdtdev.info =3D &da9063_watchdog_info;
> > +	wdt->wdtdev.ops =3D &da9063_watchdog_ops;
> > +	wdt->wdtdev.min_timeout =3D DA9063_WDT_MIN_TIMEOUT;
> > +	wdt->wdtdev.max_timeout =3D DA9063_WDT_MAX_TIMEOUT;
> > +	wdt->wdtdev.timeout =3D DA9063_WDG_TIMEOUT;
> > +
> > +	wdt->wdtdev.status =3D WATCHDOG_NOWAYOUT_INIT_STATUS;
> > +
> > +	watchdog_set_drvdata(&wdt->wdtdev, wdt);
> > +	dev_set_drvdata(&pdev->dev, wdt);
> > +
> > +	ret =3D watchdog_register_device(&wdt->wdtdev);
> > +	if (ret) {
> > +		dev_err(da9063->dev, "da9063-watchdog registration failed (err =3D %=
d)",
> > +				ret);
>=20
> "da9063-watchdog" is really redundant since dev_err already displays
> the device name.

Also this error message is redundant, as the driver probing code will
print an error message when it failed. So I removed the message
completely.

Thanks for your feedback.

Best regards,

Markus

>=20
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int da9063_wdt_remove(struct platform_device *pdev)
> > +{
> > +	struct da9063_watchdog *wdt =3D dev_get_drvdata(&pdev->dev);
> > +
> > +	watchdog_unregister_device(&wdt->wdtdev);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver da9063_wdt_driver =3D {
> > +	.probe =3D da9063_wdt_probe,
> > +	.remove =3D da9063_wdt_remove,
> > +	.driver =3D {
> > +		.name =3D DA9063_DRVNAME_WATCHDOG,
> > +	},
> > +};
> > +module_platform_driver(da9063_wdt_driver);
> > +
> > +MODULE_AUTHOR("Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>");
> > +MODULE_DESCRIPTION("Watchdog driver for Dialog DA9063");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:" DA9063_DRVNAME_WATCHDOG);
> > --=20
> > 2.1.0
> >=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUIoqfAAoJEEpcgKtcEGQQzKIP/2+El9LrtqmCrkgxc14TCoFD
rCNvHWFec7kwO97WmtJnzHd4qFrYTSxRAzaN7Xr4prOqNfvJ4g6bDLH/ncxQHXrr
l6Ev/2gSlXUoRdC8wH50xmH81r0kIyuF05OfZxreJj82Tk7id3Drq/9xEFAS7KEB
LQ1ZmN1ZZEyOctX5mRyMU1i+nMZuRbdEH7AVhYe0M6myBfm2r7iuhSvEHtcDpyU8
5MprDZ75891dLwakjGqt6BL3xqbnCrj5DtMwA5AwohC3TFpQsGkkUS4fOZDoNy56
e2cqnzngd5JRH6pxIaDHTxiwBaUH5ROCKpScAa0Btep5/d4Y9kmMC/etIwDhdop4
Q8yb8HNP3N7fb4aInKoavmNNCbrhW1YLvQ/kuzWOxiAyVeq8NAHiO2IO0GQMPZjh
2aF1vGxOgAHYqa+wLfWFRm0tE4TOdUmZuONUujEgYOhJMpHizPA6ie0+ttjQsm3u
n6hSR8zV0NO65Q5m4cuBncRu/330YdEOHaaHbXgXxwKVajjgApj5+z2noxe1lrrC
QvRBZjdqqyN8CWQ/eT+tdS4gNp4zyaesOPS8CUXlOdprYk5bnSndI3MTWrFoqt+8
IjwtOXa7hzpf9L3NuvjbscOWduK9k5Sn5vHEfKppf3hSb43ZUlf0sQ79ZDoVD6j/
wP5K7/v9Za0nYDk9x1vC
=x7m+
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
