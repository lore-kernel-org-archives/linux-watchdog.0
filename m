Return-Path: <stwiss.opensource@diasemi.com>
Return-path: <stwiss.opensource@diasemi.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Marco Felsch <m.felsch@pengutronix.de>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"Support Opensource" <Support.Opensource@diasemi.com>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2 1/2] watchdog: da9063: rename helper function to
 avoid misunderstandings
Date: Tue, 5 Jun 2018 12:38:53 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941AD537@SW-EX-MBX02.diasemi.com>
References: <20180604150059.8602-1-m.felsch@pengutronix.de>
 <20180604150059.8602-2-m.felsch@pengutronix.de>
In-Reply-To: <20180604150059.8602-2-m.felsch@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On 04 June 2018 16:01 Marco Felsch wrote,

> Subject: [PATCH v2 1/2] watchdog: da9063: rename helper function to avoid
> misunderstandings
>=20
> _da9063_wdt_set_timeout() is called by da9063_wdg_set_timeout(),
> da9063_wdg_start() and da9063_wdg_probe() but the name expect only to be
> called by da9063_wdg_set_timeout(). Rename the function to avoid
> misunderstandings.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/watchdog/da9063_wdt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.=
c
> index a4380a887e85..760aa9bca81b 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -64,7 +64,7 @@ static int da9063_wdt_disable_timer(struct da9063 *da90=
63)
>  				  DA9063_TWDSCALE_DISABLE);
>  }
>=20
> -static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int r=
egval)
> +static int da9063_wdt_update_timeout(struct da9063 *da9063, unsigned int
> regval)
>  {
>  	int ret;
>=20
> @@ -93,7 +93,7 @@ static int da9063_wdt_start(struct watchdog_device *wdd=
)
>  	int ret;
>=20
>  	selector =3D da9063_wdt_timeout_to_sel(wdd->timeout);
> -	ret =3D _da9063_wdt_set_timeout(da9063, selector);
> +	ret =3D da9063_wdt_update_timeout(da9063, selector);
>  	if (ret)
>  		dev_err(da9063->dev, "Watchdog failed to start (err =3D %d)\n",
>  			ret);
> @@ -148,7 +148,7 @@ static int da9063_wdt_set_timeout(struct
> watchdog_device *wdd,
>  	 * enabling the watchdog, so the timeout must be buffered by the driver=
.
>  	 */
>  	if (watchdog_active(wdd))
> -		ret =3D _da9063_wdt_set_timeout(da9063, selector);
> +		ret =3D da9063_wdt_update_timeout(da9063, selector);
>=20
>  	if (ret)
>  		dev_err(da9063->dev, "Failed to set watchdog timeout (err =3D
> %d)\n",
> @@ -223,7 +223,7 @@ static int da9063_wdt_probe(struct platform_device
> *pdev)
>  		unsigned int timeout;
>=20
>  		timeout =3D
> da9063_wdt_timeout_to_sel(DA9063_WDG_TIMEOUT);
> -		_da9063_wdt_set_timeout(da9063, timeout);
> +		da9063_wdt_update_timeout(da9063, timeout);
>  		set_bit(WDOG_HW_RUNNING, &wdd->status);
>  	}
>=20
> --
> 2.17.1

Hi Marco,

Based upon this patch applied to:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
branch
  remotes/origin/watchdog-next
and git describe
  v4.17-rc1-344-gaeef812

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
