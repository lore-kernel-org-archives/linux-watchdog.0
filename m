Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38924 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab1KWVnG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Nov 2011 16:43:06 -0500
Date: Wed, 23 Nov 2011 22:43:01 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: Marc Vertes <marc.vertes@sigfox.com>, wim@iguana.be,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	HaraldWelte@viatech.com, broonie@opensource.wolfsonmicro.com
Subject: Re: [PATCH RFC] watchdog: add a new driver for VIA chipsets
Message-ID: <20111123214301.GA32669@pengutronix.de>
References: <4ecb84b9.48rmEWqC3D6x18iE%marc.vertes@sigfox.com>
 <20111122112212.GD2734@pengutronix.de>
 <4ecbd66c.8a87vIwdu0Z+quuZ%marc.vertes@sigfox.com>
 <20111122173029.GA14349@pengutronix.de>
 <4ecbe56d.0B7WEVDKkK1s88MJ%marc.vertes@sigfox.com>
 <4ecbf011.dZASXe6D5kH4Uxve%marc.vertes@sigfox.com>
 <20111123121051.GA18320@rainbow>
 <4eccff3f.MbLR7E9v8jus19P8%marc.vertes@sigfox.com>
 <20111123192550.GA9918@rainbow>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20111123192550.GA9918@rainbow>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Ok. Thanks to you and Harald for explaining! That's sad HW doesn't
> behave according to datasheets. Maybe it's worth to add a note about this
> in the driver to warn future hackers? :)

Yes, please.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7NaOUACgkQD27XaX1/VRugDQCfXRMHUgEr1TVG+PAykH373Mnl
fCEAn3MAs0gBBV8k2tk26VDwklj5YOS1
=Yeen
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
