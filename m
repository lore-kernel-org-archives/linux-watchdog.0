Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46913 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbaHNJ5k (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Aug 2014 05:57:40 -0400
Date: Thu, 14 Aug 2014 11:57:34 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Support Opensource <support.opensource@diasemi.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v3] watchdog: Add DA906x PMIC watchdog driver.
Message-ID: <20140814095733.GG17027@pengutronix.de>
References: <1407926776-16700-1-git-send-email-mpa@pengutronix.de>
 <53EC487E.2000602@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p7qwJlK53pWzbayA"
Content-Disposition: inline
In-Reply-To: <53EC487E.2000602@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--p7qwJlK53pWzbayA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2014 at 10:26:22PM -0700, Guenter Roeck wrote:
> On 08/13/2014 03:46 AM, Markus Pargmann wrote:
> >From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> >
> >This driver supports the watchdog device inside the DA906x PMIC.
> >
> >Signed-off-by: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> >Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>=20
> Couple of additional comments.
>=20
> Guenter
>=20
> >---
> >  drivers/watchdog/Kconfig      |   7 ++
> >  drivers/watchdog/Makefile     |   1 +
> >  drivers/watchdog/da9063_wdt.c | 228 ++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 236 insertions(+)
> >  create mode 100644 drivers/watchdog/da9063_wdt.c
> >
> >diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >index c845527b503a..8d5c9b33552a 100644
> >--- a/drivers/watchdog/Kconfig
> >+++ b/drivers/watchdog/Kconfig
> >@@ -87,6 +87,13 @@ config DA9055_WATCHDOG
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called da9055_wdt.
> >
> >+config DA9063_WATCHDOG
> >+	tristate "Dialog DA9063 Watchdog"
> >+	depends on MFD_DA9063
> >+	select WATCHDOG_CORE
> >+	help
> >+	  Support for the watchdog in the DA9063 PMIC.
> >+
> >  config GPIO_WATCHDOG
> >  	tristate "Watchdog device controlled through GPIO-line"
> >  	depends on OF_GPIO
> >diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> >index 7b8a91ed20e7..ce4a7632d863 100644
> >--- a/drivers/watchdog/Makefile
> >+++ b/drivers/watchdog/Makefile
> >@@ -172,6 +172,7 @@ obj-$(CONFIG_XEN_WDT) +=3D xen_wdt.o
> >  # Architecture Independent
> >  obj-$(CONFIG_DA9052_WATCHDOG) +=3D da9052_wdt.o
> >  obj-$(CONFIG_DA9055_WATCHDOG) +=3D da9055_wdt.o
> >+obj-$(CONFIG_DA9063_WATCHDOG) +=3D da9063_wdt.o
> >  obj-$(CONFIG_GPIO_WATCHDOG)	+=3D gpio_wdt.o
> >  obj-$(CONFIG_WM831X_WATCHDOG) +=3D wm831x_wdt.o
> >  obj-$(CONFIG_WM8350_WATCHDOG) +=3D wm8350_wdt.o
> >diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt=
=2Ec
> >new file mode 100644
> >index 000000000000..2b5ce564c4c1
> >--- /dev/null
> >+++ b/drivers/watchdog/da9063_wdt.c
> >@@ -0,0 +1,228 @@
> >+/*
> >+ * Watchdog driver for DA9063 PMICs.
> >+ *
> >+ * Copyright(c) 2012 Dialog Semiconductor Ltd.
> >+ *
> >+ * Author: Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>
> >+ *
> >+ * This program is free software; you can redistribute  it and/or modif=
y it
> >+ * under  the terms of  the GNU General  Public License as published by=
 the
> >+ * Free Software Foundation;  either version 2 of the  License, or (at =
your
> >+ * option) any later version.
> >+ */
> >+
> >+#include <linux/kernel.h>
> >+#include <linux/module.h>
> >+#include <linux/watchdog.h>
> >+#include <linux/platform_device.h>
> >+#include <linux/uaccess.h>
> >+#include <linux/slab.h>
> >+#include <linux/delay.h>
> >+#include <linux/mfd/da9063/registers.h>
> >+#include <linux/mfd/da9063/core.h>
> >+#include <linux/regmap.h>
> >+
> >+/*
> >+ * Watchdog selector to timeout in seconds.
> >+ *   0: WDT disabled;
> >+ *   others: timeout =3D 2048 ms * 2^(TWDSCALE-1).
> >+ */
> >+static const int wdt_timeout[] =3D { 0, 2, 4, 8, 16, 32, 65, 131 };
> >+#define DA9063_TWDSCALE_DISABLE		0
> >+#define DA9063_TWDSCALE_MIN		1
> >+#define DA9063_TWDSCALE_MAX		(ARRAY_SIZE(wdt_timeout) - 1)
> >+#define DA9063_WDT_MIN_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MIN]
> >+#define DA9063_WDT_MAX_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MAX]
> >+#define DA9063_WDG_TIMEOUT		wdt_timeout[3]
> >+
> >+struct da9063_watchdog {
> >+	struct da9063 *da9063;
> >+	struct watchdog_device wdtdev;
> >+	struct mutex lock;
> >+};
> >+
> >+static int da9063_wdt_timeout_to_sel(int secs)
> >+{
> >+	int i;
> >+
> >+	for (i =3D DA9063_TWDSCALE_MIN; i <=3D DA9063_TWDSCALE_MAX; i++) {
> >+		if (wdt_timeout[i] >=3D secs)
> >+			return i;
> >+	}
> >+
> >+	return -EINVAL;
> >+}
> >+
> >+static int da9063_wdt_disable(struct da9063 *da9063)
> >+{
> >+	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> >+			DA9063_TWDSCALE_MASK,
> >+			DA9063_TWDSCALE_DISABLE);
> >+}
> >+
> >+static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int =
regval)
> >+{
> >+	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> >+			DA9063_TWDSCALE_MASK, regval);
> >+}
> >+
> >+static int _da9063_wdt_kick(struct da9063 *da9063)
> >+{
> >+	return regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
> >+			DA9063_WATCHDOG);
> >+}
> >+
> >+static int da9063_wdt_start(struct watchdog_device *wdd)
> >+{
> >+	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> >+	unsigned int selector;
> >+	int ret =3D 0;
>=20
> Unnecessary initialization.

Thanks, I fixed all these initializations.
>=20
> >+
> >+	mutex_lock(&wdt->lock);
> >+	selector =3D da9063_wdt_timeout_to_sel(wdt->wdtdev.timeout);
> >+	if (selector < 0) {
> >+		dev_err(wdt->da9063->dev, "Timeout out of range (timeout=3D%d)\n",
> >+				wdt->wdtdev.timeout);
> >+		return selector;
>=20
> That only works if you move the lock further down, which should be ok.
> Otherwise you'll need to assign the return code to ret and jump to
> the unlock below.

Yes, moved.

>=20
> >+	}
> >+
> >+	ret =3D _da9063_wdt_set_timeout(wdt->da9063, selector);
> >+	if (ret) {
> >+		dev_err(wdt->da9063->dev, "Watchdog failed to start (err =3D %d)\n",
> >+				ret);
> >+	}
> >+	mutex_unlock(&wdt->lock);
> >+
> >+	return ret;
> >+}
> >+
> >+static int da9063_wdt_stop(struct watchdog_device *wdd)
> >+{
> >+	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> >+	int ret =3D 0;
>=20
> Unnecessary initialization.
>=20
> >+
> >+	mutex_lock(&wdt->lock);
> >+	ret =3D da9063_wdt_disable(wdt->da9063);
> >+	if (ret)
> >+		dev_alert(wdt->da9063->dev,
> >+			  "Watchdog failed to stop (err =3D %d)\n", ret);
> >+	mutex_unlock(&wdt->lock);
> >+
> >+	return ret;
> >+}
> >+
> >+static int da9063_wdt_ping(struct watchdog_device *wdd)
> >+{
> >+	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> >+	int ret =3D 0;
> >+
> Unnecessary initialization.
>=20
> >+	mutex_lock(&wdt->lock);
> >+	ret =3D _da9063_wdt_kick(wdt->da9063);
> >+	if (ret)
> >+		dev_alert(wdt->da9063->dev, "Failed to ping the watchdog (err =3D %d)=
\n",
> >+				ret);
> >+	mutex_unlock(&wdt->lock);
> >+
> >+	return ret;
> >+}
> >+
> >+static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
> >+							unsigned int timeout)
>=20
> Sometimes it seems to me people go through great pains not to follow Linux
> indentation rules, and use the "as many different indentations as possibl=
e"
> rule instead ;-). No, I am not enforcing it; that would be up to Wim if h=
e cares.

I fixed this indentation to the same style as the rest of the driver.

>=20
> >+{
> >+	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> >+	unsigned int selector;
> >+	int ret;
> >+
> >+	selector =3D da9063_wdt_timeout_to_sel(timeout);
> >+	if (selector < 0) {
> >+		dev_err(wdt->da9063->dev, "Unsupported watchdog timeout, should be be=
tween 2 and 131\n");
> >+		return -EINVAL;
> >+	}
> >+
> >+	mutex_lock(&wdt->lock);
> >+
> >+	ret =3D _da9063_wdt_set_timeout(wdt->da9063, selector);
> >+	if (ret)
> >+		dev_err(wdt->da9063->dev, "Failed to set watchdog timeout (err =3D %d=
)\n",
> >+				ret);
> >+	else
> >+		wdd->timeout =3D wdt_timeout[selector];
> >+
> >+	mutex_unlock(&wdt->lock);
> >+
> >+	return ret;
> >+}
> >+
> >+static const struct watchdog_info da9063_watchdog_info =3D {
> >+	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> >+	.identity =3D "DA9063 Watchdog",
> >+};
> >+
> >+static const struct watchdog_ops da9063_watchdog_ops =3D {
> >+	.owner =3D THIS_MODULE,
> >+	.start =3D da9063_wdt_start,
> >+	.stop =3D da9063_wdt_stop,
> >+	.ping =3D da9063_wdt_ping,
> >+	.set_timeout =3D da9063_wdt_set_timeout,
> >+};
> >+
> >+static int da9063_wdt_probe(struct platform_device *pdev)
> >+{
> >+	int ret;
> >+	struct da9063 *da9063 =3D dev_get_drvdata(pdev->dev.parent);
> >+	struct da9063_watchdog *wdt;
> >+
> >+	if (!da9063)
> >+		return -EPROBE_DEFER;
>=20
> Can this ever happen ? Isn't this driver instantiated from its parent,
> which would ensure that the parent's driver data is set ?

No this can't happen. I replaced it with BUG_ON and also introduced a
BUG_ON check for dev.parent.

>=20
> >+
> >+	wdt =3D devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> >+	if (!wdt)
> >+		return -ENOMEM;
> >+
> >+	wdt->da9063 =3D da9063;
> >+	mutex_init(&wdt->lock);
> >+
> >+	wdt->wdtdev.info =3D &da9063_watchdog_info;
> >+	wdt->wdtdev.ops =3D &da9063_watchdog_ops;
> >+	wdt->wdtdev.min_timeout =3D DA9063_WDT_MIN_TIMEOUT;
> >+	wdt->wdtdev.max_timeout =3D DA9063_WDT_MAX_TIMEOUT;
> >+	wdt->wdtdev.timeout =3D DA9063_WDG_TIMEOUT;
> >+
> >+	if (IS_ENABLED(CONFIG_WATCHDOG_NOWAYOUT))
> >+		wdt->wdtdev.status =3D WATCHDOG_NOWAYOUT_INIT_STATUS;
>=20
> You don't need the if() here. That is embedded in WATCHDOG_NOWAYOUT_INIT_=
STATUS.

Removed.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--p7qwJlK53pWzbayA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT7IgNAAoJEEpcgKtcEGQQu/MQAJLgzHH+9+GZW48OjJU5OcdH
ysfnzAhSg/9YNN7lEQXqbfaxVgS55fF31iR/dMsdUp7TkkryNmRD4XHw6JqqbttK
fhDbi1BWzyJD83iYV18bjBjbI3mCNCvagKPy9KiygRilxquknM1cVjRDcXEjCvRW
ZSBRJaSidpBXl14L6lOIhwm+qRhn5Q1zdmyKQWFzaazPZH6KP5fV5gLcYFsLqBho
a7SeGffL+6MZwMeuzDJ5MCvToPS/3kn4F/1TpG0X0md5toOGjWRHFbnmcGypoZs0
9NYbaL/DQWllSLH0d5GhMxFi6qvUTO0ZIXP2ptMkbhv86KNrq0WjCArGIJRcJLpl
PKqgtDFnuBwsnPhrc6vzUEVgPkFtqI6TlLMDx3twmzVSYWE2ADGW7nG2r8d5QQ97
QmIeUs3oTXJ0xFAPtArBg7befX/5BGwKgpT8LMjzbo44hmh6alWUApoNS3GnJ+qy
gYr3Y8iL3rA8J5fiYTLuH3D9AM0h7FCjzm7lbvpKmxYTFLn8GJtZCde8z7BosjgX
RTzfjBmesG/gi5paggHVw+PDGdrDe3rGkmH/0gVVMSfcTr8wrAKw+L9stB6h7Xyb
wwhV9xqs5h5jQNn5wgaSR7/5DbsElngndgm7aW0IDQt3ix7gsAXLhrDZwl5g/ewB
d6dm4mibQNRijes2DsKG
=lEx5
-----END PGP SIGNATURE-----

--p7qwJlK53pWzbayA--
