Return-Path: <stwiss.opensource@diasemi.com>
Return-path: <stwiss.opensource@diasemi.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Marco Felsch <m.felsch@pengutronix.de>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"Support Opensource" <Support.Opensource@diasemi.com>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2 2/2] watchdog: da9063: remove duplicated
 timeout_to_sel calls
Date: Tue, 5 Jun 2018 12:38:04 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941AD52A@SW-EX-MBX02.diasemi.com>
References: <20180604150059.8602-1-m.felsch@pengutronix.de>
 <20180604150059.8602-3-m.felsch@pengutronix.de>
In-Reply-To: <20180604150059.8602-3-m.felsch@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On 04 June 2018 16:01 Marco Felsch wrote,

> Subject: [PATCH v2 2/2] watchdog: da9063: remove duplicated timeout_to_se=
l calls
>=20
> Every time da9063_wdt_update_timeout() gets called a timeout_to_sel() is
> made because the timeout argument of update_timeout() is the raw
> register value. Moving the second<->raw-value translation into
> da9063_wdt_update_timeout() removes duplicated code.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/watchdog/da9063_wdt.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.=
c
> index 760aa9bca81b..384dca16af8b 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -64,8 +64,10 @@ static int da9063_wdt_disable_timer(struct da9063
> *da9063)
>  				  DA9063_TWDSCALE_DISABLE);
>  }
>=20
> -static int da9063_wdt_update_timeout(struct da9063 *da9063, unsigned int
> regval)
> +static int
> +da9063_wdt_update_timeout(struct da9063 *da9063, unsigned int timeout)
>  {
> +	unsigned int regval;
>  	int ret;
>=20
>  	/*
> @@ -81,6 +83,7 @@ static int da9063_wdt_update_timeout(struct da9063
> *da9063, unsigned int regval)
>  		return ret;
>=20
>  	usleep_range(150, 300);
> +	regval =3D da9063_wdt_timeout_to_sel(timeout);
>=20
>  	return regmap_update_bits(da9063->regmap,
> DA9063_REG_CONTROL_D,
>  				  DA9063_TWDSCALE_MASK, regval);
> @@ -89,11 +92,9 @@ static int da9063_wdt_update_timeout(struct da9063
> *da9063, unsigned int regval)
>  static int da9063_wdt_start(struct watchdog_device *wdd)
>  {
>  	struct da9063 *da9063 =3D watchdog_get_drvdata(wdd);
> -	unsigned int selector;
>  	int ret;
>=20
> -	selector =3D da9063_wdt_timeout_to_sel(wdd->timeout);
> -	ret =3D da9063_wdt_update_timeout(da9063, selector);
> +	ret =3D da9063_wdt_update_timeout(da9063, wdd->timeout);
>  	if (ret)
>  		dev_err(da9063->dev, "Watchdog failed to start (err =3D %d)\n",
>  			ret);
> @@ -132,11 +133,8 @@ static int da9063_wdt_set_timeout(struct
> watchdog_device *wdd,
>  				  unsigned int timeout)
>  {
>  	struct da9063 *da9063 =3D watchdog_get_drvdata(wdd);
> -	unsigned int selector;
>  	int ret =3D 0;
>=20
> -	selector =3D da9063_wdt_timeout_to_sel(timeout);
> -
>  	/*
>  	 * There are two cases when a set_timeout() will be called:
>  	 * 1. The watchdog is off and someone wants to set the timeout for the
> @@ -148,13 +146,13 @@ static int da9063_wdt_set_timeout(struct
> watchdog_device *wdd,
>  	 * enabling the watchdog, so the timeout must be buffered by the driver=
.
>  	 */
>  	if (watchdog_active(wdd))
> -		ret =3D da9063_wdt_update_timeout(da9063, selector);
> +		ret =3D da9063_wdt_update_timeout(da9063, timeout);
>=20
>  	if (ret)
>  		dev_err(da9063->dev, "Failed to set watchdog timeout (err =3D
> %d)\n",
>  			ret);
>  	else
> -		wdd->timeout =3D wdt_timeout[selector];
> +		wdd->timeout =3D
> wdt_timeout[da9063_wdt_timeout_to_sel(timeout)];
>=20
>  	return ret;
>  }
> @@ -220,10 +218,7 @@ static int da9063_wdt_probe(struct platform_device
> *pdev)
>=20
>  	/* Change the timeout to the default value if the watchdog is running *=
/
>  	if (da9063_wdt_is_running(da9063)) {
> -		unsigned int timeout;
> -
> -		timeout =3D
> da9063_wdt_timeout_to_sel(DA9063_WDG_TIMEOUT);
> -		da9063_wdt_update_timeout(da9063, timeout);
> +		da9063_wdt_update_timeout(da9063, DA9063_WDG_TIMEOUT);
>  		set_bit(WDOG_HW_RUNNING, &wdd->status);
>  	}
>=20
> --
> 2.17.1

Hi Marco,

Thanks.

Based upon this patch applied to:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
branch
  remotes/origin/watchdog-next
and git describe
  v4.17-rc1-344-gaeef812 + patch [PATCH v2 1/2] watchdog: da9063: rename he=
lper function to avoid misunderstandings

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
