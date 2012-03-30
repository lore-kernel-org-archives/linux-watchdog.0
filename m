Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55303 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759343Ab2C3JrJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Mar 2012 05:47:09 -0400
Date: Fri, 30 Mar 2012 11:47:02 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Ashish Jangam <ashish.jangam@kpitcummins.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	David Dajun Chen <dajun.chen@diasemi.com>,
	linaro-dev@lists.linaro.org, sameo@linux.intel.com
Subject: Re: [PATCH 05/07] Watchdog: DA9052/53 watchdog support v1
Message-ID: <20120330094701.GA2455@pengutronix.de>
References: <1328532486.30549.82.camel@dhruva>
 <1331641624.7058.2.camel@dhruva>
 <1333099923.26252.0.camel@dhruva>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <1333099923.26252.0.camel@dhruva>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2012 at 03:02:03PM +0530, Ashish Jangam wrote:
> Any update on this patch?

Please use the watchdog framework to save a lot of code. A guide is
here: Documentation/watchdog/convert_drivers_to_kernel_api.txt

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk91gRUACgkQD27XaX1/VRupRwCeOMzn2ZUPJWAcN9NazTy/lA/s
+uQAnjvT6hTOwm5SBzHCZtczAjMOrvKa
=Ot7q
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
