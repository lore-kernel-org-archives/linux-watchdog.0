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
Subject: RE: [PATCH v5] watchdog: Add DA9063 PMIC watchdog driver.
Date: Tue, 26 Aug 2014 15:21:53 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7D0B39787@SW-EX-MBX02.diasemi.com>
References: <1409034367-15228-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1409034367-15228-1-git-send-email-mpa@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>


On 26 August 2014 07:26, Markus Pargmann wrote

> Subject: [PATCH v5] watchdog: Add DA9063 PMIC watchdog driver.
>=20

[...]

> +
> +static int da9063_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	mutex_lock(&wdt->lock);
> +	ret =3D regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> +			DA9063_TWDSCALE_MASK,
> +			DA9063_TWDSCALE_DISABLE);
> +	if (ret)
> +		dev_alert(wdt->da9063->dev, "Watchdog failed to stop (err =3D %d)\n",
> +				ret);
> +	mutex_unlock(&wdt->lock);
> +
> +	return ret;
> +}
> +

Hi Markus,

A quick typo.
ret =3D regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
should probably be wdt->da9063->regmap

Regards,
Steve
