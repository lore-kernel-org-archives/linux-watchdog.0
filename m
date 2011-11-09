Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57696 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503Ab1KIWEn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 9 Nov 2011 17:04:43 -0500
Date: Wed, 9 Nov 2011 23:04:38 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
	wim@iguana.be
Subject: Re: [PATCH 2/2] watchdog: imx2_wdt: Disable watchdog during
 low-power modes
Message-ID: <20111109220438.GB6316@pengutronix.de>
References: <1316456640-32650-1-git-send-email-fabio.estevam@freescale.com>
 <1316456640-32650-2-git-send-email-fabio.estevam@freescale.com>
 <20110921132710.GK1966@pengutronix.de>
 <4EBAB12A.2030107@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <4EBAB12A.2030107@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> Activate WDZST so that the watchdog timer does not count during low po=
wer modes.
> >=20
> > Should be a user-selectable option IMHO. Changing the default behaviour
> > may cause regressions.
>=20
> I can=C2=B4t visualize a real system usage where the watchdog needs to be=
 active in low power mode.
>=20
> Which regressions exactly are you concerned about? Which platforms?

I don't have any concrete example, yet I see things I could not visualize
before daily ;)

My concern was that changing the default behaviour of a crucial device like=
 a
watchdog driver should be done _very_ carefully. And here it could be avoid=
ed
by making this feature optional per platform_data, so I thought. If others
think this is over-engineered, so be it. I just didn't want this concern go
unnoticed.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk66+PYACgkQD27XaX1/VRs5rwCgiHB6Bsk1Z7mBChe8cy5DbHu3
HykAoK4fUzugYUUxvcds17C6t61Op+VV
=bMiB
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
