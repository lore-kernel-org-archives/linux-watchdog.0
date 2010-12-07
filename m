Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59897 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab0LGMGI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Dec 2010 07:06:08 -0500
Date: Tue, 7 Dec 2010 13:06:02 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
	u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH] watchdog: imx: use clk_get to acquire the watchdog
 clock
Message-ID: <20101207120602.GA4134@pengutronix.de>
References: <1291664293-28360-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <1291664293-28360-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2010 at 05:38:13PM -0200, Fabio Estevam wrote:
> Use clk_get to acquire the watchdog clock and also avoid hardcoding the c=
lock name.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkz+IyoACgkQD27XaX1/VRs08wCdEo7kCT20+wf3X85w+kvdQOig
RWoAn1IC6ebqNSJuAFpcdsRRfeB3Zg43
=JD5i
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
