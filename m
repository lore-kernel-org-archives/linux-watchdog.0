Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60114 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758271Ab1KVLWS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Nov 2011 06:22:18 -0500
Date: Tue, 22 Nov 2011 12:22:12 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Marc Vertes <marc.vertes@sigfox.com>
Cc: wim@iguana.be, Sebroeck@vger.kernel.org, Van@vger.kernel.org,
	Wim@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, HaraldWelte@viatech.com,
	Welte@vger.kernel.org, Harald@vger.kernel.org
Subject: Re: [PATCH RFC] watchdog: add a new driver for VIA chipsets
Message-ID: <20111122112212.GD2734@pengutronix.de>
References: <4ecb84b9.48rmEWqC3D6x18iE%marc.vertes@sigfox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <4ecb84b9.48rmEWqC3D6x18iE%marc.vertes@sigfox.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2011 at 12:17:13PM +0100, Marc Vertes wrote:
> Add a new driver for the hardware watchdog timer on VIA chipsets.
> Tested on a Artigo A1100, VX855 chipset.
>=20
> Signed-off-by: Marc Vertes <marc.vertes@sigfox.com>

New watchdog drivers should use the framework. Have a look at
Documentation/watchdog/convert_drivers_to_kernel_api.txt for a guide. It
is mainly removing code, though.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7LheQACgkQD27XaX1/VRutYACdEU7AXPGKVZ9fV6SaT2B010iK
LhAAoMBk4btczZxmA/0iXTLQQwqq0Jqt
=bziw
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
