Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48802 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705Ab1IUN1M (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 21 Sep 2011 09:27:12 -0400
Date: Wed, 21 Sep 2011 15:27:10 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
	wim@iguana.be
Subject: Re: [PATCH 2/2] watchdog: imx2_wdt: Disable watchdog during
 low-power modes
Message-ID: <20110921132710.GK1966@pengutronix.de>
References: <1316456640-32650-1-git-send-email-fabio.estevam@freescale.com>
 <1316456640-32650-2-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45wMVEkw4XUbiYON"
Content-Disposition: inline
In-Reply-To: <1316456640-32650-2-git-send-email-fabio.estevam@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--45wMVEkw4XUbiYON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 19, 2011 at 03:24:00PM -0300, Fabio Estevam wrote:
> Activate WDZST so that the watchdog timer does not count during low power=
 modes.

Should be a user-selectable option IMHO. Changing the default behaviour
may cause regressions.

>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/watchdog/imx2_wdt.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 19df82d..e1a9abb 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -41,6 +41,7 @@
>  #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
>  #define IMX2_WDT_WCR_WRE	(1 << 3)	/* -> WDOG Reset Enable */
>  #define IMX2_WDT_WCR_WDE	(1 << 2)	/* -> Watchdog Enable */
> +#define IMX2_WDT_WCR_WDZST	(1 << 0)	/* -> Watchdog Low Power */
> =20
>  #define IMX2_WDT_WSR		0x02		/* Service Register */
>  #define IMX2_WDT_SEQ1		0x5555		/* -> service sequence 1 */
> @@ -93,6 +94,9 @@ static inline void imx2_wdt_setup(void)
>  	/* Set the watchdog's Time-Out value */
>  	val |=3D WDOG_SEC_TO_COUNT(imx2_wdt.timeout);
> =20
> +	/* Disable watchdog suring low power modes */
> +	val |=3D IMX2_WDT_WCR_WDZST;
> +
>  	/* enable the watchdog */
>  	val |=3D IMX2_WDT_WCR_WDE;
>  	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> --=20
> 1.6.0.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--45wMVEkw4XUbiYON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk555i4ACgkQD27XaX1/VRvGHACfXdmceQUuSN0u+AxsYmYLhG1A
yiwAnj0QoLMOZhqiXEqQx2cFxL+KaYkI
=TLRH
-----END PGP SIGNATURE-----

--45wMVEkw4XUbiYON--
