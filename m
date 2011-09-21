Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48777 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705Ab1IUNZr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 21 Sep 2011 09:25:47 -0400
Date: Wed, 21 Sep 2011 15:25:43 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
	wim@iguana.be
Subject: Re: [PATCH 1/2] watchdog: imx2_wdt: Do not clear IMX2_WDT_WCR_WDE
Message-ID: <20110921132543.GJ1966@pengutronix.de>
References: <1316456640-32650-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I/5syFLg1Ed7r+1G"
Content-Disposition: inline
In-Reply-To: <1316456640-32650-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--I/5syFLg1Ed7r+1G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 19, 2011 at 03:23:59PM -0300, Fabio Estevam wrote:
> i.MX reference manual states that software can only write "1" into the WD=
E bit.

But it also says "Note: This bit can be set/reset in debug mode
(exception)."

> Remove the line that sets 0 to this bit and while at it remove an unneede=
d extra=20
> write to register WCR.

The MX31 manual says in 37.5.3.1:

"The Watchdog Control Register (WCR) field WT[7:0] must have a time-out
value written to it before the Watchdog can be enabled. The WDOG is
enabled by setting the Watchdog Enable (WDE) bit in the WCR."

I seem to recall that on some imx that two-folded write was indeed
necessary.

I'd say better safe than sorry and keep things as they are?

>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/watchdog/imx2_wdt.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index b8ef2c6..19df82d 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -89,13 +89,10 @@ static inline void imx2_wdt_setup(void)
>  	val &=3D ~IMX2_WDT_WCR_WT;
>  	/* Generate reset if WDOG times out */
>  	val &=3D ~IMX2_WDT_WCR_WRE;
> -	/* Keep Watchdog Disabled */
> -	val &=3D ~IMX2_WDT_WCR_WDE;
> +
>  	/* Set the watchdog's Time-Out value */
>  	val |=3D WDOG_SEC_TO_COUNT(imx2_wdt.timeout);
> =20
> -	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> -
>  	/* enable the watchdog */
>  	val |=3D IMX2_WDT_WCR_WDE;
>  	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> --=20
> 1.6.0.4
>=20
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--I/5syFLg1Ed7r+1G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk555dcACgkQD27XaX1/VRvQtACdE3K5WLARh2hwAySV7HYuIKo4
MF4AoKgmf1+iTAGKI4/greLiM/hSbroC
=K4b8
-----END PGP SIGNATURE-----

--I/5syFLg1Ed7r+1G--
