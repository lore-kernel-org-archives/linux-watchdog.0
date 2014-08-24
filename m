Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53475 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbaHXOho (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 24 Aug 2014 10:37:44 -0400
Date: Sun, 24 Aug 2014 16:37:30 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Support Opensource <support.opensource@diasemi.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [v4] watchdog: Add DA906x PMIC watchdog driver.
Message-ID: <20140824143730.GC23823@pengutronix.de>
References: <1408192545-23987-1-git-send-email-mpa@pengutronix.de>
 <20140820144322.GA7609@roeck-us.net>
 <20140821061525.GA23823@pengutronix.de>
 <20140821141959.GA26019@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline
In-Reply-To: <20140821141959.GA26019@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 21, 2014 at 07:19:59AM -0700, Guenter Roeck wrote:
> On Thu, Aug 21, 2014 at 08:15:25AM +0200, Markus Pargmann wrote:
> > Hi,
> >=20
> ...
> > > > +static int da9063_wdt_timeout_to_sel(int secs)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i =3D DA9063_TWDSCALE_MIN; i <=3D DA9063_TWDSCALE_MAX; i++) {
> > >=20
> > > When building with W=3D1, gcc complains about this line. Would be gre=
at if you can
> > > have a look and fix it.
> >=20
> > I just compiled with W=3D1, it doesn't complain here about this line.
> > Could you give me the warning?
> >=20
> drivers/watchdog/da9063_wdt.c: In function 'da9063_wdt_timeout_to_sel':
> drivers/watchdog/da9063_wdt.c:48:34: warning: comparison between signed a=
nd
> unsigned integer expressions [-Wsign-compare]
>=20
> This is with arm-poky-linux-gnueabi-gcc (GCC) 4.7.2.

Thanks, I am using gcc 4.8.3. I replaced the used 'int' type by 'unsigend
int', that should fix it.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT+fiqAAoJEEpcgKtcEGQQ7JwP/jfh3dvIJec81a1mZSy1fBQ/
c4T8XDrIdBDviluxbk7CUNzfToyAEGqIzifjN+hq6tEXFEmmKfjteE5KQBwYuBEI
biyTDDs2EPHpafFYlN3q2JGELYIqPJrcYc7z8HMLxRpNmoyKgA9PvhjcTqt3jJVX
WjRCqq0Fyz4XmlHlC950cUuJGWobbCDz5mdvLQhi43IXCR06lGLtohsMAgKRi5LH
Giw6q69yUH+B960enF8TsbLhWLVl6jlZPIWhqzfv9B9WYEzICX5j3CYGG2dK1mjX
Vc4XmqrymRUPIRYKcw5q4boRkxDiOORHlmWGhf27J6FrdtY4wN1S48NsEvg9gAxM
KbtsyBRdXUYbrF1Ov041JSp/wJRUx2gaqeLvwNbBlylPtJg1VHozN/IoCE3WI7EF
EOLs6BtGEYE+1Aig1iDuWplAmuP2oNk8sYJosq94f0Bgd0RXcjtBwa2fQVVEBLmH
wT8l0bYROKSwzKRb75P3bP01h9/gEn9itSZ3Pu79sBgtCsmrnhCZKVUjPmcgLvNV
u3H6amPpirdDZleg3+0DqEN6gARLLHpDFmGNsKILPv4FtNjDkWdtEU2Cwb8gFUm6
94g2At55920tMLYFp5tsBANngUC3sIiU2IdVS4kXdPCCiIwNr8j0d6W5pJD1XqbR
Q2RlbH2sIUEwYsyw9Gqw
=GvTx
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
