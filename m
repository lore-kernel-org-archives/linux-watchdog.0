Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46828 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab1KWKt3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Nov 2011 05:49:29 -0500
Date: Wed, 23 Nov 2011 11:49:26 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Marc Vertes <marc.vertes@sigfox.com>
Cc: broonie@opensource.wolfsonmicro.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	HaraldWelte@viatech.com
Subject: Re: [PATCH RFC] watchdog: add a new driver for VIA chipsets
Message-ID: <20111123104926.GB4063@pengutronix.de>
References: <4ecb84b9.48rmEWqC3D6x18iE%marc.vertes@sigfox.com>
 <20111122112212.GD2734@pengutronix.de>
 <4ecbd66c.8a87vIwdu0Z+quuZ%marc.vertes@sigfox.com>
 <20111122173227.GK6624@sirena.org.uk>
 <20111122184051.GA30941@pengutronix.de>
 <4eccc3f0.iApQ//mCzaN3UsrB%marc.vertes@sigfox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <4eccc3f0.iApQ//mCzaN3UsrB%marc.vertes@sigfox.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(BTW I removed a few duplicates from the CC list)

> A question regarding "nowayout", in the case of this VIA chipset where
> a watchdog can not be stopped once started from BIOS. I think I should
> set unconditionally WDOG_NO_WAY_OUT in status, shouldn't I ?
>=20
> I also do not think it is correct to implement a timer and ping
> proactively in case of magicclose because 1) it complicates a bit the
> code, 2) there is no way to know the timeout value, and it set very low
> in the BIOS (1 s).

Yup, I'd accept the reason that you can't know the timeout value and
then setting NO_WAY_OUT unconditionally looks like the thing to do here.

@Wim: Would you accept drivers which can only ping a watchdog but
neither start/stop it?

@Marc: If he does, would you be interested in updating the watchdog-core
so that no start()/stop() will also be accepted if there is a ping()?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7Mz7YACgkQD27XaX1/VRutaACgvxMdwqxhzIB7ZPQzIwvLYkhr
H9cAoL5CGyOLeCfuw8eUmzXyFj6VQB/c
=PgJa
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
