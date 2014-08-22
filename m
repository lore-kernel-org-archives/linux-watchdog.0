Return-Path: <stwiss.opensource@diasemi.com>
Return-Path: <stwiss.opensource@diasemi.com>
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Markus Pargmann <mpa@pengutronix.de>, Wim Van Sebroeck <wim@iguana.be>
CC: Support Opensource <Support.Opensource@diasemi.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH v4] watchdog: Add DA906x PMIC watchdog driver.
Date: Fri, 22 Aug 2014 15:47:48 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7D0B39421@SW-EX-MBX02.diasemi.com>
References: <1408192545-23987-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1408192545-23987-1-git-send-email-mpa@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On 16 August 2014 13:36, Markus Pargmann [mailto:mpa@pengutronix.de] wrote:

> Subject: [PATCH v4] watchdog: Add DA906x PMIC watchdog driver.

Hi Markus,

>=20
> From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
>=20
> This driver supports the watchdog device inside the DA906x PMIC.
>=20

There is only DA9063 , in this case there is no "x". Thanks.

[...]

> +
> +/*
> + * Watchdog selector to timeout in seconds.
> + *   0: WDT disabled;
> + *   others: timeout =3D 2048 ms * 2^(TWDSCALE-1).
> + */
> +static const int wdt_timeout[] =3D { 0, 2, 4, 8, 16, 32, 65, 131 };

This table is just an approximation of the real times provided by the PMIC.=
=20

The first three bits in the CONTROL_D register at 0x11 define a scaling val=
ue
for the nominal maximum time TWDMAX. The 7 values specifying the timeout
of the watchdog are:

001 =3D 1 =3D 1x =3D 2048ms=20
010 =3D 2 =3D 2x =3D 4096ms
011 =3D 3 =3D 4x =3D 8192ms
100 =3D 4 =3D 8x =3D 16384ms
101 =3D 5 =3D 16x =3D 32768ms
110 =3D 6 =3D 32x =3D 65536ms
111 =3D 7 =3D 64x =3D 131072ms

 [...]

> +
> +static int da9063_wdt_disable(struct da9063 *da9063)
> +{
> +	return regmap_update_bits(da9063->regmap,
> DA9063_REG_CONTROL_D,
> +			DA9063_TWDSCALE_MASK,
> +			DA9063_TWDSCALE_DISABLE);
> +}
> +
> +static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int
> regval)
> +{
> +	return regmap_update_bits(da9063->regmap,
> DA9063_REG_CONTROL_D,
> +			DA9063_TWDSCALE_MASK, regval);
> +}
> +
> +static int _da9063_wdt_kick(struct da9063 *da9063)
> +{
> +	return regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
> +			DA9063_WATCHDOG);
> +}
> +

The _da9063_wdt_kick() and da9063_wdt_disable() functions are only used onc=
e
throughout the code -- in the watchdog_ops functions da9063_wdt_ping() and
da9063_wdt_stop() respectively.=20
Since these are just simple regmap calls, could they be added at those plac=
es
directly and therefore remove the function calls?

[...]

> +static int da9063_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> +	unsigned int selector;
> +	int ret;
> +
> +	selector =3D da9063_wdt_timeout_to_sel(wdt->wdtdev.timeout);
> +	if (selector < 0) {

Unsigned if < 0

 [...]

> +static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
> +		unsigned int timeout)
> +{
> +	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> +	unsigned int selector;
> +	int ret;
> +
> +	selector =3D da9063_wdt_timeout_to_sel(timeout);
> +	if (selector < 0) {

And again

Regards,
Steve
