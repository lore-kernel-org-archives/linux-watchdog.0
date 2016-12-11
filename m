Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50315 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751986AbcLKJfa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 11 Dec 2016 04:35:30 -0500
Date: Sun, 11 Dec 2016 10:35:20 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Magnus Lilja <lilja.magnus@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21,
 i.MX27 and i.MX31 SoCs
Message-ID: <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
References: <20161211010648.6591-1-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20161211010648.6591-1-vz@mleia.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 11, 2016 at 03:06:48AM +0200, Vladimir Zapolskiy wrote:
> Power down counter enable/disable bit switch is located in WMCR
> register, but watchdog controllers found on legacy i.MX21, i.MX27 and
> i.MX31 SoCs don't have this register. As a result of writing data to
> the non-existing register on driver probe the SoC hangs up, to fix the
> problem add more OF compatible strings and on this basis get
> information about availability of the WMCR register.
>=20
> Fixes: 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on=
 boot")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
> Changes from RFC to v1:
> * replaced private data struct with a macro as suggested by Guenter,
> * updated the comment in the source code to reflect the change,
> * rearranged and simplified the logic of detecting WMCR presence,
> * pulled the fix out from the series with optional proposed DTS changes=
.
>=20
>  drivers/watchdog/imx2_wdt.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 4874b0f..66bd454 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -30,6 +30,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/watchdog.h>
> @@ -57,6 +58,7 @@
>  #define IMX2_WDT_WICR_WICT	0xFF		/* -> Interrupt Count Timeout */
> =20
>  #define IMX2_WDT_WMCR		0x08		/* Misc Register */
> +#define IMX2_WDT_NO_WMCR	((void *)true)	/* Indicates unavailable WMCR =
*/
> =20
>  #define IMX2_WDT_MAX_TIME	128
>  #define IMX2_WDT_DEFAULT_TIME	60		/* in seconds */
> @@ -70,6 +72,8 @@ struct imx2_wdt_device {
>  	bool ext_reset;
>  };
> =20
> +static const struct of_device_id imx2_wdt_dt_ids[];
> +
>  static bool nowayout =3D WATCHDOG_NOWAYOUT;
>  module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (d=
efault=3D"
> @@ -242,6 +246,7 @@ static const struct regmap_config imx2_wdt_regmap_c=
onfig =3D {
> =20
>  static int __init imx2_wdt_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *of_id;
>  	struct imx2_wdt_device *wdev;
>  	struct watchdog_device *wdog;
>  	struct resource *res;
> @@ -310,11 +315,13 @@ static int __init imx2_wdt_probe(struct platform_=
device *pdev)
>  	}
> =20
>  	/*
> -	 * Disable the watchdog power down counter at boot. Otherwise the pow=
er
> -	 * down counter will pull down the #WDOG interrupt line for one clock
> -	 * cycle.
> +	 * If watchdog controller has WMCR, disable the watchdog power
> +	 * down counter at boot. Otherwise the power down counter will
> +	 * pull down the #WDOG interrupt line for one clock cycle.
>  	 */
> -	regmap_write(wdev->regmap, IMX2_WDT_WMCR, 0);
> +	of_id =3D of_match_device(imx2_wdt_dt_ids, &pdev->dev);
> +	if (of_id && !of_id->data)
> +		regmap_write(wdev->regmap, IMX2_WDT_WMCR, 0);
> =20
>  	ret =3D watchdog_register_device(wdog);
>  	if (ret) {
> @@ -412,7 +419,20 @@ static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt=
_suspend,
>  			 imx2_wdt_resume);
> =20
>  static const struct of_device_id imx2_wdt_dt_ids[] =3D {
> -	{ .compatible =3D "fsl,imx21-wdt", },
> +	{ .compatible =3D "fsl,imx21-wdt", .data =3D IMX2_WDT_NO_WMCR },
> +	{ .compatible =3D "fsl,imx25-wdt",  },
> +	{ .compatible =3D "fsl,imx27-wdt", .data =3D IMX2_WDT_NO_WMCR },
> +	{ .compatible =3D "fsl,imx31-wdt", .data =3D IMX2_WDT_NO_WMCR },
> +	{ .compatible =3D "fsl,imx35-wdt",  },
> +	{ .compatible =3D "fsl,imx50-wdt",  },
> +	{ .compatible =3D "fsl,imx51-wdt",  },
> +	{ .compatible =3D "fsl,imx53-wdt",  },
> +	{ .compatible =3D "fsl,imx6q-wdt",  },
> +	{ .compatible =3D "fsl,imx6sl-wdt", },
> +	{ .compatible =3D "fsl,imx6sx-wdt", },
> +	{ .compatible =3D "fsl,imx6ul-wdt", },
> +	{ .compatible =3D "fsl,imx7d-wdt",  },
> +	{ .compatible =3D "fsl,vf610-wdt",  },

Up to now we only had fsl,imx21-wdt, now it seems that iMX31, i.MX27 and
i.MX21 form a group of equal watchdog IPs and the others form another
group, right?

So conceptually we should differenciate between

	fsl,imx21-wdt (which is used on i.MX21, i.MX27 and i.MX31)
	fsl,imx35-wdt (which is used on all others)

A reason to add e.g. fsl,imx6sl-wdt is that dtbs in the wild use

	"fsl,imx6sl-wdt", "fsl,imx21-wdt"

. But then I wonder if=20

	5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boot")

is that important to justify to add these all.

Independant of this I'd like to have all dtsi for the newer SoCs changed
to get

	"fsl,imx6sl-wdt", "fsl,imx35-wdt"

and if you really want to add all these compatibles, add a comment that
these are really fsl,imx35-wdt and were added to work around broken
dtbs.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
