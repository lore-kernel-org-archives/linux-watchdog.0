Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35851 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaHYHZI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Aug 2014 03:25:08 -0400
Date: Mon, 25 Aug 2014 09:24:55 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] watchdog: imx2_wdt: Remove seperate big endian handling
Message-ID: <20140825072455.GB11914@pengutronix.de>
References: <1408949015-28759-1-git-send-email-mpa@pengutronix.de>
 <4b9a55951535433aada42332b08f664f@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <20140825070550.GA11914@pengutronix.de>
 <5d35f7c722e14022ba7db0221b9cfdb1@BY2PR0301MB0613.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <5d35f7c722e14022ba7db0221b9cfdb1@BY2PR0301MB0613.namprd03.prod.outlook.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 07:11:36AM +0000, Li.Xiubo@freescale.com wrote:
> > On Mon, Aug 25, 2014 at 07:01:57AM +0000, Li.Xiubo@freescale.com wrote:
> > > Hi Markus,
> > >
> > > Thanks for your work.
> > >
> > > And there has already one patch for this:
> > >
> > > "watchdog: imx2_wdt: Convert to use regmap framework's endianness met=
hod."
> >=20
> > Thanks didn't see this one.
> >=20
> > Best regards,
> >=20
> > Markus
> >=20
>=20
> I also hoping for your comments about it if there has any problem.

I just noticed that you added an include of of_address.h in your
original patch:
f728f4bfc495 (watchdog: imx2_wdt: adds big endianness support.)

But you don't remove the include in your current patch. Was the include
missing in the driver?

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT+uTGAAoJEEpcgKtcEGQQTyQQALhR0OFIybIueobYWT6ZBVlE
gJEOulQpTwZ3TrtEmltkcJqAiqVGtW9xmDNDJIZ64P2fhaJdNYZT9wbj2sZceBMt
xVgVwq3IU3ya2s7I69oGk94x7Me8BN+tRWSiAjK8NQBxHcoDyAhBqecSnu6OwaKH
q5X6kpo0QJvNfeIL3gvENzWD/SPpJSeugBW1CW9h4JlTgxCgqMlu31MKCG/qJLHM
HDMmy8GR8aoVYY+mN5tB34lkDx6y8Sncvp+fHZ8e8wTxzIhWImIG969hX5e1ruLS
mdaR7CW5hKKAcTzzf6JiGrLdGwU2IHKlFVLUSE9PGRhCox0oULREbvPevgMjC1r3
P1amJpFELc54v6EpzSDsrLXYPRH4Xh2EzNNShISSmVDCt5LkQgrBl/uVnZxkMepq
CcpftuYP3qxzobd3GwDBbg/PlJX4iSW1P8geMfOE4ZY4UjSBJZ1YdvB6yzI2OX4Q
3uwhNH8qeAEXQX49D2utUlPCOr0OuRBVLfNm8EbT3TqgguUwJ+g9wxEuAS+y7Bni
ZuHu47Ubyi3aH9bdvy+wHrxcF8m2gDCOG+p8wFYQzoy7wdOl1bPXtbdtEM4ygLcm
CRIMzIgY9d1t8FJGgBRu91QVNLeWGDb5fCC8NLUD4XAPIJzW7ojG25deLkgeDfv0
3FSwSm34aGI6JxBRxPoq
=i8iL
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
