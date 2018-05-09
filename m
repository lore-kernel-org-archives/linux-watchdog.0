Return-Path: <groeck7+caf_=guenter=roeck-us.net@gmail.com>
Return-path: <groeck7+caf_=guenter=roeck-us.net@gmail.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Marco Felsch <m.felsch@pengutronix.de>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>
CC: Support Opensource <Support.Opensource@diasemi.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"fzuuzf@googlemail.com" <fzuuzf@googlemail.com>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>, Guenter Roeck
	<groeck7@gmail.com>
Subject: RE: [PATCH v2] watchdog: da9063: Fix setting/changing timeout
Date: Wed, 9 May 2018 13:50:25 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7019417EA41@SW-EX-MBX02.diasemi.com>
References: <20180509123243.21170-1-m.felsch@pengutronix.de>
In-Reply-To: <20180509123243.21170-1-m.felsch@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Hi Marco,

On 09 May 2018 13:33, Marco Felsch wrote:

> To: wim@linux-watchdog.org; linux@roeck-us.net
> Subject: [PATCH v2] watchdog: da9063: Fix setting/changing timeout
>=20
> The DA9063 watchdog always resets the system when it changes the timeout
> value after the bootloader (e.g. Barebox) has it already set.
>=20
> To update the timeout value we have to disable the watchdog, clear the
> watchdog counter value and write the new timeout value to the watchdog.
> Clearing the counter value is a feature to be on the safe side, because t=
he
> data sheet doesn't describe the behaviour of the watchdog counter value
> after a watchdog disabling-enable-sequence.
>=20
> The patch is based on Philipp Zabel's <p.zabel@pengutronix.de> previous
> patch but doesn't wait 150us because the DA9063 doesn't need this delay.

https://www.dialog-semiconductor.com/products/DA9063

Yes, according to the Dialog datasheet DA9063_2v1, there is no 150us minimu=
m
assert time limit. But ... that doesn't seem correct to me, because the DA9=
062
driver and DA9062 datasheet both show a minimum assertion time, like you sa=
id.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tre=
e/drivers/watchdog/da9062_wdt.c?h=3Dv4.17-rc3#n67

So let me check with the hardware engineers.

Regards,
Steve

>=20
> Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/watchdog/da9063_wdt.c | 33
> +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/watchdog/da9063_wdt.c
> b/drivers/watchdog/da9063_wdt.c
> index b17ac1bb1f28..bca247d44737 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -45,8 +45,38 @@ static unsigned int
> da9063_wdt_timeout_to_sel(unsigned int secs)
>  	return DA9063_TWDSCALE_MAX;
>  }
>=20
> +/*
> + * Writing a '1' to the self-clearing WATCHDOG bit resets the watchdog c=
ounter
> + * value.
> + */
> +static int _da9063_wdt_reset_timer(struct da9063 *da9063)
> +{
> +	return regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
> +			    DA9063_WATCHDOG);
> +}
> +
>  static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int r=
egval)
>  {
> +	int ret;
> +
> +	/*
> +	 * The watchdog trigger a reboot if a timeout value is already
> +	 * programmed. Because the timeout value combines two functions in
> +	 * one: indicating the counter limit and starting the watchdog. To be
> +	 * able to set the watchdog a second time (first time was done by the
> +	 * bootloader) disable the watchdog clear the counter value manually an=
d
> +	 * set the new timeout value.
> +	 */
> +	ret =3D regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> +				 DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
> +	if (ret)
> +		dev_warn(da9063->dev,
> +			 "Failed to disable watchdog before setting new timeout\n");
> +
> +	ret =3D _da9063_wdt_reset_timer(da9063);
> +	if (ret)
> +		dev_warn(da9063->dev, "Failed to reset watchdog counter\n");
> +
>  	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
>  				  DA9063_TWDSCALE_MASK, regval);
>  }
> @@ -85,8 +115,7 @@ static int da9063_wdt_ping(struct watchdog_device *wdd=
)
>  	struct da9063 *da9063 =3D watchdog_get_drvdata(wdd);
>  	int ret;
>=20
> -	ret =3D regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
> -			   DA9063_WATCHDOG);
> +	ret =3D _da9063_wdt_reset_timer(da9063);
>  	if (ret)
>  		dev_alert(da9063->dev, "Failed to ping the watchdog (err =3D %d)\n",
>  			  ret);
> --
> 2.17.0
