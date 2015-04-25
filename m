Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49413 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756483AbbDYCMH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 Apr 2015 22:12:07 -0400
Date: Fri, 24 Apr 2015 21:10:24 -0500
From: Felipe Balbi <balbi@ti.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: Felipe Balbi <balbi@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <kernel@pengutronix.de>
Subject: Re: [PATCH 1a/3] watchdog: omap: clearify device tree documentation
Message-ID: <20150425021024.GA14963@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
References: <20150424190207.GU19431@pengutronix.de>
 <1429906850-5420-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <1429906850-5420-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 10:20:50PM +0200, Uwe Kleine-K=F6nig wrote:
> ti,hwmods doesn't belong into the compatible section but is a property
> on it's own. Also reformat the section of required properties to match the
> usual style of dt binding documents.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

looks great to me, thanks

Reviewed-by: Felipe Balbi <balbi@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>

> ---
> Hello Felipe,
>=20
> what about this patch before the previously sent patch 1?
>=20
> Best regards
> Uwe
>=20
>  Documentation/devicetree/bindings/watchdog/omap-wdt.txt | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt b/Do=
cumentation/devicetree/bindings/watchdog/omap-wdt.txt
> index c227970671ea..597e19d18dca 100644
> --- a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
> @@ -1,10 +1,8 @@
>  TI Watchdog Timer (WDT) Controller for OMAP
> =20
>  Required properties:
> -compatible:
> -- "ti,omap3-wdt" for OMAP3
> -- "ti,omap4-wdt" for OMAP4
> -- ti,hwmods: Name of the hwmod associated to the WDT
> +- compatible : "ti,omap3-wdt" for OMAP3 or "ti,omap4-wdt" for OMAP4
> +- ti,hwmods : Name of the hwmod associated to the WDT
> =20
>  Examples:
> =20
> --=20
> 2.1.4
>=20

--=20
balbi

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVOveQAAoJEIaOsuA1yqREL0gP/34NgRMjYSMyHQO8DchbdLJ7
L9XsBtm/6JEVrlye/wGl+dTa/iNLXrF1Eb8nrqc36gUsXIO6snhVzS6+5fzL+QWh
qrzIJtfRbYdYNjIvbduUmNLZ0OmJZV12I7GxpvebgTnEamDVJ05QuP/twVm5gVkL
rq7kN2xspX5IplMuewC2pvxYXn2EfrhkFVwTfmdo3nKZ/y6GESq6eZgo9kWlh7ob
p47lehxFrqJdmqVDWKok15hbfkOSWaQ8jib5RqtwxkeKMr7PKp8A7JFLJt6plNBe
z6KA1C7bdDQp3MKy3I8PQB4PxAdroPgYmgcbztM3WFy4IL/Uj1M9kr6y/1DKlen6
7MQQ4rMI1eJMSX6luKVBwLQnMPy5Tqh9fUvhCNhukRJFxcDih0+W27xxVI0wqIr2
ax8vafSHsOEk8DK/57OO4/UyYjJc18V0OSNvatt2PWr4aTGQIM+ILu1Q7JHFMsKR
N8cd8G0lUguE86vaSicEBETm6EcezfYyHGHLEkyqn9DSLh6908CnC+CA0rIE1zY9
PSgNLh1swvvwr0qyCNDXuMp0oiGAsfYA0NU1JtHl/HfI4XgQR2dseREJpkjtg2gm
ITQK160CIW6hm4SUBY0aPIZ5bNWIGI8N20DcyzZSxch3uWTaMArUFVN9cFD7C00H
APhT8A0FQXgonbic1dF+
=qbg9
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
