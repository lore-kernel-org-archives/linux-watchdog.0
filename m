Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34786 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754588AbbDXOof (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 Apr 2015 10:44:35 -0400
Date: Fri, 24 Apr 2015 09:42:59 -0500
From: Felipe Balbi <balbi@ti.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Lokesh Vutla <lokeshvutla@ti.com>, Felipe Balbi <balbi@ti.com>,
	<kernel@pengutronix.de>,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 1/3] watchdog: omap: use watchdog_init_timeout
Message-ID: <20150424144259.GB5692@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
References: <1429868913-24049-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1429868913-24049-2-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <1429868913-24049-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 24, 2015 at 11:48:31AM +0200, Uwe Kleine-K=F6nig wrote:
> Instead of (partly) open coding it use the core function. As a side
> effect the "timeout-sec" devicetree property is used now.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/watchdog/omap-wdt.txt | 9 +++++----
>  drivers/watchdog/omap_wdt.c                             | 5 +----
>  2 files changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt b/Do=
cumentation/devicetree/bindings/watchdog/omap-wdt.txt
> index c227970671ea..4f18ec38be2f 100644
> --- a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
> @@ -1,10 +1,11 @@
>  TI Watchdog Timer (WDT) Controller for OMAP
> =20
>  Required properties:
> -compatible:
> -- "ti,omap3-wdt" for OMAP3
> -- "ti,omap4-wdt" for OMAP4
> -- ti,hwmods: Name of the hwmod associated to the WDT
> +- compatible : "ti,omap3-wdt" (for OMAP3) or "ti,omap4-wdt" (for OMAP4)
> +- ti,hwmods : Name of the hwmod associated to the WDT
> +
> +Optional properties:
> +- timeout-sec : default watchdog timeout in seconds

adding a new property here ? Why ? In fact, none of these DT binding doc
changes fit in $subject. Sure, watchdog_init_timeout() needs
timeout-sec, but no OMAP DT today passes it.

> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 39a6cfcba016..0eb9ca04e672 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -234,10 +234,7 @@ static int omap_wdt_probe(struct platform_device *pd=
ev)
>  	omap_wdt->min_timeout =3D TIMER_MARGIN_MIN;
>  	omap_wdt->max_timeout =3D TIMER_MARGIN_MAX;
> =20
> -	if (timer_margin >=3D TIMER_MARGIN_MIN &&
> -	    timer_margin <=3D TIMER_MARGIN_MAX)
> -		omap_wdt->timeout =3D timer_margin;
> -	else
> +	if (watchdog_init_timeout(omap_wdt, timer_margin, &pdev->dev) < 0)
>  		omap_wdt->timeout =3D TIMER_MARGIN_DEFAULT;
> =20
>  	watchdog_set_drvdata(omap_wdt, wdev);
> --=20
> 2.1.4
>=20

--=20
balbi

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVOlZzAAoJEIaOsuA1yqREYowQAKmQI3QW6ZSNaQZzvb0SZwZv
2nriaXr8vB57BeFsaAGhoyiDMS+ZSVIEnUlOSlnboTE1Ae/CHC2wAAU2/vX0QCc1
Gm/BX1aeSV/gMnFuvH5mu2YTwsM8TYS/7OntjCpkMLD+ucyoZzayBD+Lgs9PEWmi
RA6bi08qyxzHw8CstjuJdnB2d4zCqcqMSJYkOEhU09N+IBnS5h2b5CVCoqGOUDtL
A+cG57l3OxFi2HQgNPg3k7HQ0zAjaxAvSxyQL5jruskNV9OBiEiL6M6fznriiIKQ
O+2aTp/wxKS9/5AVDaYT6itC014aq7xEWto/xIXjXC7p59LzxRN7YCqze2wM94b1
iriMkGuFOzBFFYYnmFODu/+jrHKN47hgY0gjHeyvkT6k36GLxRI2nHpKIDLthgvU
8sTxlf3SsimRNmzFqmm605ugMgptLUpsbqNo0N1wWbH2OmTm212YvcQgREKE0uyO
5w2/zENZspJuZosMw+a+JgwvyGmMn0DKY5EeV5RWrGqd916ufshn6Ngbh3+ByZy7
YZ/3gV151sbzmkszVrTYIHM9gQCUyMZoiK9ruXRcXhZU/KfFrf3UZGSQ9Lp/9z1n
DJ/KdiBz7saHrZVQLwWRLBkeUdS/YGvUOGE1ZHaL4IfGYu9YCWY3SNXJJKQkCXbg
2KAHhUWhQSHYR3f0HepU
=iwvt
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
