Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49265 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758118Ab1IIIB3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 9 Sep 2011 04:01:29 -0400
Date: Fri, 9 Sep 2011 10:01:26 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>, tglx@linutronix.de,
	mingo@elte.hu, linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH 58/62] watchdog: irq: Remove IRQF_DISABLED
Message-ID: <20110909080126.GC1912@pengutronix.de>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
 <1315383059-3673-59-git-send-email-yong.zhang0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <1315383059-3673-59-git-send-email-yong.zhang0@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2011 at 04:10:55PM +0800, Yong Zhang wrote:
> This flag is a NOOP and can be removed now.
>=20
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5px9YACgkQD27XaX1/VRv0twCeN2k03xOkg7CL5VtYfTjXmIpk
VZ0AoIX+jOObAFy7B7rIkJA2RfHv+Ueq
=oQIz
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
