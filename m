Return-Path: <wsa@the-dreams.de>
Return-path: <wsa@the-dreams.de>
Date: Tue, 28 Aug 2018 18:37:15 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [RFC PATCH] watchdog: HACK: disable bind attributes with NOWAYOUT
Message-ID: <20180828163715.bou2uhjp3prpqrkg@ninjato>
References: <20180828102906.12840-1-wsa@the-dreams.de>
 <3d3a5bde-b8bd-0810-5571-cdc64cd57ee4@roeck-us.net>
 <20180828141850.opoduyldzvp2e53v@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rljep6fp2uwthf37"
Content-Disposition: inline
In-Reply-To: <20180828141850.opoduyldzvp2e53v@ninjato>
List-ID: <linux-watchdog@vger.kernel.org>


--rljep6fp2uwthf37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> void watchdog_set_nowayout(struct watchdog_device *wdd, struct driver
> 			   *drv, bool nowayout)
>=20
> I'd think this would work from a layering perspective.

No, this is also bogus. probe() works per device, and
=2Esuppress_bind_attrs works per driver. We need to tackle this in the
init callback.


--rljep6fp2uwthf37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluFejYACgkQFA3kzBSg
Kbb0iQ/9HqcuKPDd/1W0mSIW06NtVE2MPiyPDegIeHP0Xx6JljHV2ync2KTUiYD6
E1WqBTQhNk9fchfizD+Ysvy3aEjYqe2YHthFPjh8v+8Qi6YZHPsyIv8TMu2BAn+8
uxusiIIHLoIitQRWBRtoQNkexR2Xk9B+zoxCgMk4jtCu22DI7J3VDRw43rx5i6s2
d1LY+1KiePVPxu29yXxuXnYLuiiEW917TJ37IPRr1s+hVo+70tuP8M/f9UEWGku7
BNqj4MzYjklXRRO22mg4Gii/w2SaauiR2caycN4QPOAtHVuaPAY0Xd/JNo+v06Nw
Vo34vwcM2eY3ktPdSGmT9sl35/wAYacr6uLg7W47jEJNxZ2J5AHFO6y3q730kTsp
H1BU9peLPz+1k/BK+uu+/dBUX6pE2NQ15nst9xTpq4g/SdbPSxfb7CDPYHUvlUCv
aSqjlUklNbIvMXTgzd1UBAoJAwQkyKK7dZtyY34/7gBC6F3c8gZcNiJ//YNoaH00
SiHeYVeO4rYwSsrr/UPjtk44IVtH2uFc1cGfgppCH0QbORbKLVY5f5MGdM3qvMK2
xQaG4QlnC+fsYy3tOELSSZtM2b/ex81DPEOoRBq/hFSCr4xJv3+ShdLL8MNuF/sj
UP6SytB7KGJezunVlxP4UOd5sn7mwY+w3dEgbl8Tz/Gw+LN/Iq4=
=25il
-----END PGP SIGNATURE-----

--rljep6fp2uwthf37--
