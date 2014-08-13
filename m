Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59581 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbaHMJwP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Aug 2014 05:52:15 -0400
Date: Wed, 13 Aug 2014 11:52:09 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Support Opensource <support.opensource@diasemi.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2] watchdog: Add DA906x PMIC watchdog driver.
Message-ID: <20140813095209.GE17027@pengutronix.de>
References: <1407837403-15863-1-git-send-email-mpa@pengutronix.de>
 <53EA3D05.8000408@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
Content-Disposition: inline
In-Reply-To: <53EA3D05.8000408@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 12, 2014 at 09:12:53AM -0700, Guenter Roeck wrote:
> On 08/12/2014 02:56 AM, Markus Pargmann wrote:
> >From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> >
> >This driver supports watchdog device inside DA906x PMIC.
> >
> >Signed-off-by: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> >Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>=20
> What is different to v1 ?

I made some style fixes like removing strange indention, removing the
"_" function prefixes and so on.

>=20
> >---
> >  drivers/watchdog/Kconfig             |   7 ++
> >  drivers/watchdog/Makefile            |   1 +
> >  drivers/watchdog/da9063_wdt.c        | 226 +++++++++++++++++++++++++++=
++++++++
> >  include/linux/mfd/da9063/registers.h |   1 +
> >  4 files changed, 235 insertions(+)
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
> >index 000000000000..befd6314f3f4
> >--- /dev/null
> >+++ b/drivers/watchdog/da9063_wdt.c
> >@@ -0,0 +1,226 @@
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
> >+	struct watchdog_device *wdtdev;
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
> >+	return 0;
>=20
> It might be better to return -EINVAL and use it in the calling code.

Right, will fix that.

>=20
> >+}
> >+
> >+static int da9063_wdt_disable(struct da9063 *da9063)
> >+{
> >+	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> >+			DA9063_TWDSCALE_MASK,
> >+			DA9063_TWDSCALE_DISABLE << DA9063_TWDSCALE_SHIFT);
> >+}
> >+
> >+static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int =
regval)
> >+{
> >+	if (regval < DA9063_TWDSCALE_MIN || regval > DA9063_TWDSCALE_MAX)
> >+		return -EINVAL;
> >+
> >+	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> >+			DA9063_TWDSCALE_MASK, regval << DA9063_TWDSCALE_SHIFT);
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
> >+
> >+	mutex_lock(&wdt->lock);
> >+	selector =3D da9063_wdt_timeout_to_sel(wdt->wdtdev->timeout);
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
> >+{
> >+	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> >+	unsigned int selector;
> >+	int ret;
> >+
> >+	selector =3D da9063_wdt_timeout_to_sel(timeout);
> >+	if (selector =3D=3D 0) {
> >+		dev_err(wdt->da9063->dev, "Unsupported watchdog timeout (select from:=
 2, 4, 8, 16, 32, 65, 131)\n");
>=20
> This error case should never happen, since the range is checked by the ca=
lling code.
> Besides, the error message is wrong. You do accept the entire range of [1=
 .. 131],
> not just selected values.
>=20
> Overall the error checking is inconsistent. Above you don't check the ret=
urn code
> but depend on _da9063_wdt_set_timeout to detect a range error.

Right I will fix the error handling.

>=20
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
> >+static struct watchdog_device da9063_watchdog_device =3D {
> >+	.info =3D &da9063_watchdog_info,
> >+	.ops =3D &da9063_watchdog_ops,
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
> >+
> >+	wdt =3D devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> >+	if (!wdt)
> >+		return -ENOMEM;
> >+
> >+	wdt->da9063 =3D da9063;
> >+	wdt->wdtdev =3D &da9063_watchdog_device;
> >+	mutex_init(&wdt->lock);
> >+
> >+	if (IS_ENABLED(CONFIG_WATCHDOG_NOWAYOUT))
> >+		set_bit(WDOG_NO_WAY_OUT, &wdt->wdtdev->status);
> >+
> Why not use watchdog_set_nowayout, or initialize .status with
> WATCHDOG_NOWAYOUT_INIT_STATUS, as suggested in the API documentation ?

No specific reason for that, WATCHDOG_NOWAYOUT_INIT_STATUS seems better.

>=20
> >+	wdt->wdtdev->min_timeout =3D DA9063_WDT_MIN_TIMEOUT;
> >+	wdt->wdtdev->max_timeout =3D DA9063_WDT_MAX_TIMEOUT;
> >+	wdt->wdtdev->timeout =3D DA9063_WDG_TIMEOUT;
> >+
>=20
> Why don't you set those variables directly in da9063_watchdog_device ?
> If you want to set it here, you might as well set ops and info
> and get rid of the static variable (by including the entire structure
> in wdt, not just a pointer to it).

Especially as watchdog_register_device is directly altering the struct,
it seems better to also assign ops and info here.

>=20
> >+	ret =3D watchdog_register_device(wdt->wdtdev);
> >+	if (ret) {
> >+		dev_err(da9063->dev, "da9063-watchdog registration failed (err =3D %d=
)",
> >+				ret);
> >+		return ret;
> >+	}
> >+
> >+	watchdog_set_drvdata(wdt->wdtdev, wdt);
> >+
> This creates a race condition, because at least in theory an access could
> already occur between the watchdog registration above and this code.

Yes, I will move it above the registration code.

>=20
> >+	return 0;
> >+}
> >+
> >+static int da9063_wdt_remove(struct platform_device *pdev)
> >+{
> >+	watchdog_unregister_device(&da9063_watchdog_device);
> >+
> >+	return 0;
> >+}
> >+
> >+static struct platform_driver da9063_wdt_driver =3D {
> >+	.probe =3D da9063_wdt_probe,
> >+	.remove =3D da9063_wdt_remove,
> >+	.driver =3D {
> >+		.name =3D DA9063_DRVNAME_WATCHDOG,
> >+	},
> >+};
> >+module_platform_driver(da9063_wdt_driver);
> >+
> >+MODULE_AUTHOR("Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>");
> >+MODULE_DESCRIPTION("Watchdog driver for Dialog DA9063");
> >+MODULE_LICENSE("GPL");
> >+MODULE_ALIAS("platform:" DA9063_DRVNAME_WATCHDOG);
> >diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da=
9063/registers.h
> >index 09a85c699da1..e11a66894afc 100644
> >--- a/include/linux/mfd/da9063/registers.h
> >+++ b/include/linux/mfd/da9063/registers.h
> >@@ -431,6 +431,7 @@
> >
> >  /* DA9063_REG_CONTROL_D (addr=3D0x11) */
> >  #define	DA9063_TWDSCALE_MASK			0x07
> >+#define	DA9063_TWDSCALE_SHIFT			0x00
>=20
> That is unnecessary. Why shift if there is nothing to shift ?
> It just adds unnecessary complexity to the code.

I thought it would be a bit nicer to see directly that it is shifted to
the correct location in the code. But I don't have any problem removing
it.

Thanks for your review.

Best regards,

Markus Pargmann

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT6zVJAAoJEEpcgKtcEGQQtXMQAKuzxwGDT0oUZOmSFlVlvSdT
2/9sNe9txxeMdX5ZIDarZE/CaSmtWFznrgHI1Db9pft1sMzjhK9p+X5ufD4TEQZo
jZ+Srqkiml6i/KETHIzkCaMECgvYJwRir6EC1o8mqWvJ3gMbYtQv7q/GjNbhpv+y
ZRj0KGSbZSMhy3YJeoOlCHyAiaSoXw7PAVVUH+fNGfmVDKOsEnrsj79AqtZ+AP/s
0u/ZlHDyQqGm3Xxqj0G0vvPVS2QJrWVswmYY8WIQsd39NgkBDrNk+eHpCoCFpj4H
JznO/m4SIKsOMfofo5q104j2TpexAzvI4F04a3O4/APioZ7OZdk35ZnUtzq3FOvU
jTLctO0TAnRMdBQ4853eDhQ97Pr8vm2Q7As8Uu01W2x2OJ8ec8Uk2QRnyXM3jrFR
xPBwDcXLTQWtkmZnCU4wU7tryFoFKGQbmfpc7Vx2Yer0y9zns4rTZD1XDJ/PEMew
befSTykJH4/FpY/D24JsjBT7BPYMD2/ls3K+EpQHfa4Tf4TWb8q7xORfNlQfvRxH
zDcXQkghz/fZQi5pNLRRZWNqofH03+/+rqPvSE0bDPKemGcgvfuU8kO/vNpdoI5m
AyIwshr5G4m0kNepjI9TdsKazz6pjECNpRyUmakwp0zFMV3Ez+KHTgF4NBXKjiPQ
Xjls53ulk2CyvVPHSoBR
=QAPf
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
