Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56360 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab1K2L6P (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Nov 2011 06:58:15 -0500
Date: Tue, 29 Nov 2011 12:58:13 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Marc Vertes <marc.vertes@sigfox.com>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Dimitry Andric <dimitry.andric@tomtom.com>,
	Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCH] watchdog: add nowayout helpers to Watchdog Timer
 Driver Kernel API
Message-ID: <20111129115813.GF5455@pengutronix.de>
References: <20111129111430.GA17609@infomag.iguana.be>
 <20111129114744.GA21542@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline
In-Reply-To: <20111129114744.GA21542@infomag.iguana.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2011 at 12:47:44PM +0100, Wim Van Sebroeck wrote:
> Hi Marc, Wolfram,
>=20
> > Add two nowayout helpers for the Watchdog Timer Driver Kernel API.
> >=20
> > Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7UyNUACgkQD27XaX1/VRs5RQCeMNBsKsJqoZ6oMpC2bwpEgSyA
w7AAoJU/axjvRQEAuDGlnPC2yunPpelU
=+ARp
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--
