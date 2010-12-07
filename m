Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55824 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab0LGRAn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Dec 2010 12:00:43 -0500
Date: Tue, 7 Dec 2010 18:00:20 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	u.kleine-koenig@pengutronix.de, wim@iguana.be,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: imx: use clk_get to acquire the watchdog
 clock
Message-ID: <20101207170020.GC4134@pengutronix.de>
References: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
 <20101207164905.GD6017@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <20101207164905.GD6017@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 07, 2010 at 05:49:05PM +0100, Sascha Hauer wrote:

> I should have seen this happen. This breaks i.MX1 reset which uses
> imx-wdt.0.
>=20
> The root cause of this problem is that we have two different watchdog
> drivers with two different names but only one reset code for all i.MX.
> We could register an additional watchdog clock for all i.MXs and use it
> for the reset code.

Actually, there is no wdt-driver for mx1 yet. They _could_ be merged,
but the result will not be pretty.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkz+aCQACgkQD27XaX1/VRsrEACeIDr6tZ9TFw8sLghYBVTpwu7V
uL4AnRPZtZh67ST+yrRZ/mfX6Eh9Q2rX
=/mJ9
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
