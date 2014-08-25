Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46708 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbaHYHGA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Aug 2014 03:06:00 -0400
Date: Mon, 25 Aug 2014 09:05:50 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] watchdog: imx2_wdt: Remove seperate big endian handling
Message-ID: <20140825070550.GA11914@pengutronix.de>
References: <1408949015-28759-1-git-send-email-mpa@pengutronix.de>
 <4b9a55951535433aada42332b08f664f@BY2PR0301MB0613.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <4b9a55951535433aada42332b08f664f@BY2PR0301MB0613.namprd03.prod.outlook.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Xiubo,

On Mon, Aug 25, 2014 at 07:01:57AM +0000, Li.Xiubo@freescale.com wrote:
> Hi Markus,
>=20
> Thanks for your work.
>=20
> And there has already one patch for this:
>=20
> "watchdog: imx2_wdt: Convert to use regmap framework's endianness method."

Thanks didn't see this one.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT+uBOAAoJEEpcgKtcEGQQytkP/1Dx0rIwFMQmxRdsnJENEg/H
bal/AXZp+deCb2XORL4PuouzMckqQA/nJED1/eHbXDezrWX0BXuULDHHBDmPEyfa
mF7eVNh62H1AOLjpKCWgFOLxW2SNCmW60LMT0MNv52c+jGA2FWFrtvwmW8XarKPb
juEDNS55uw6ONZ2WbzpKg7sT3iKFGYT6du2YOSqJgv+D0U6rW5Q7BBucVLgtCoYq
nmkC7NjbytS+8dHtIiHw64evJO7X4z8Hk0M5WWpP8aQbBi3gRY000osgfyYxzXqr
JM+Hri+xV5ug9fH/JEgFi5B3N83459r+jm5eVBdE+hjHEQ1CtkR7CKTgGGjugN+f
ipUeUKl0vp9AJTDZC6fzsRG5PbWwwD20owZdxYHy4tjU2TzgSM8bX1Hk++PLKFuc
9vV/ovOpGf9sfRVUnKZ2C/BEKzKXSnowNyxBnfYpIi6Yj8vqcGXC6ciWii+4PItJ
vDrDBHNtKbfq4fSRl40PlKsP0IfpsEqj4sQAmoaGYTTPi/P7Hiwq5eYXiZawWYyj
5RlUvkKW9j3506TqABXRf73bzquj2U+T1d2uYhzfTuOlajsfVRpfXKNariNPQcdS
Nf+aNLQHFN8xT4ou/LYwwWqf8YESH2BHrbTYpwi1gRR/VNC7Nwahznm+O00Rt1zD
UaBEi9KDCAe4zfVkIfx3
=KH+c
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
