Return-Path: <stwiss.opensource@diasemi.com>
Return-path: <stwiss.opensource@diasemi.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "lee.jones@linaro.org" <lee.jones@linaro.org>, Support Opensource
	<Support.Opensource@diasemi.com>, "wim@iguana.be" <wim@iguana.be>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, Stefan Christ <s.christ@phytec.de>
Subject: RE: [PATCH 3/6] watchdog: da9062: reset board on watchdog timeout
Date: Wed, 18 Oct 2017 14:28:10 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB70194131FC4@SW-EX-MBX02.diasemi.com>
References: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
 <20171017153027.24665-4-m.grzeschik@pengutronix.de>
In-Reply-To: <20171017153027.24665-4-m.grzeschik@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Hi Michael,

On 17 October 2017 16:30 Michael Grzeschik wrote:

> To: linux-watchdog@vger.kernel.org
> Subject: [PATCH 3/6] watchdog: da9062: reset board on watchdog timeout
>=20
> From: Stefan Christ <s.christ@phytec.de>
>=20
> In the default fuse configuration the watchdog poweroffs the system
> instead of resetting it on a watchdog timeout. This patch changes the
> behavior. Now the board is reseted and reboots.

We call the chip's fuze configuration the "OTP" (one-time programming).

>=20
> Note: This patch requires that the config register CONFIG_I is
> configured as writable in the da9062 multi function device.
>=20
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> Signed-off-by: Christian Hemp <c.hemp@phytec.de>
> ---
>  drivers/watchdog/da9062_wdt.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/watchdog/da9062_wdt.c
> b/drivers/watchdog/da9062_wdt.c
> index 4349a02215489..b95719b349e5c 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -112,6 +112,20 @@ static int da9062_wdt_start(struct watchdog_device
> *wdd)
>  	unsigned int selector;
>  	int ret;
>=20
> +	/*
> +	 * Use da9062's SHUTDOWN mode instead of POWERDOWN for watchdog reset.
> +	 * On timeout the PMIC should reset the system, not powering it
> +	 * off.
> +	 */
> +	ret =3D regmap_update_bits(wdt->hw->regmap,
> +				 DA9062AA_CONFIG_I,
> +				 DA9062AA_WATCHDOG_SD_MASK,
> +				 DA9062AA_WATCHDOG_SD_MASK);
> +	if (ret)
> +		dev_err(wdt->hw->dev,
> +			"failed to set wdt reset mode. Expect poweroff on watchdog reset: %d\=
n",
> +			ret);
> +

I am not quite understanding what you are trying to achieve.
It seems there could be be few different options here.

If the watchdog is running from power on and if the platform hangs early in=
 the start-up
sequence, then waiting to set WATCHDOG_SD in the DA9062 watchdog driver cou=
ld be
too late to modify the chip's behaviour. If the watchdog tripped early, the=
 system might
already be in POWERDOWN instead of SHUTDOWN before this point.

If a software change to CONFIG_I is to be done, then this register could be=
 modified very
early in the bootloader. If necessary, the Linux kernel driver can read the=
 CONFIG_I register
and decide if it needs to modify its behaviour accordingly. In this case, w=
rite changes to
CONFIG_I would not be needed.

The trivial option (for software at least) could be a different OTP: to enf=
orce
WATCHDOG_SD in the hardware.
DA9062 Datasheet revision 3.4, 27-Jun-2017, page 59, Section 10.
A hyperlink to the latest datasheet can be found in the DA9062 binding file=
:
Documentation/devicetree/bindings/mfd/da9062.txt

It doesn't seem correct to make this a permanent change in the general Linu=
x kernel driver.
At the very least, something like this sould be protected by a device tree =
boolean.=20

Regards,
Steve

>  	selector =3D da9062_wdt_timeout_to_sel(wdt->wdtdev.timeout);
>  	ret =3D da9062_wdt_update_timeout_register(wdt, selector);
>  	if (ret)
> --
> 2.11.0
