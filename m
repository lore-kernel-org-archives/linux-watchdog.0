Return-Path: <andrew@aj.id.au>
Return-path: <andrew@aj.id.au>
Message-ID: <1507706094.5452.181.camel@aj.id.au>
Subject: Re: [PATCH 11/11] ARM: dts: Add PCLK to the Aspeed watchdogs
From: Andrew Jeffery <andrew@aj.id.au>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Jonas Jensen <jonas.jensen@gmail.com>, Joel Stanley <joel@jms.id.au>,
	"linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, LINUXWATCHDOG
	 <linux-watchdog@vger.kernel.org>
Date: Wed, 11 Oct 2017 17:44:54 +1030
In-Reply-To: <CACRpkdYQ8WE_-nVza=GnNBvfXV=WpcEipoJhVVn=atcqyQZbpw@mail.gmail.com>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
	 <20170812184318.10144-12-linus.walleij@linaro.org>
	 <1507693686.5452.174.camel@aj.id.au>
	 <CACRpkdYQ8WE_-nVza=GnNBvfXV=WpcEipoJhVVn=atcqyQZbpw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-8mcd8WxSR7DvxoqkWPah"
Mime-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>


--=-8mcd8WxSR7DvxoqkWPah
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-10-11 at 08:32 +0200, Linus Walleij wrote:
> > On Wed, Oct 11, 2017 at 5:48 AM, Andrew Jeffery <andrew@aj.id.au> wrote=
:
> > On Sat, 2017-08-12 at 20:43 +0200, Linus Walleij wrote:
> > > This adds the PCLK clock to the Aspeed watchdog blocks.
> > > I am not directly familiar with the Aspeed clocking, but
> > > since the IP is derived from Faraday FTWDT010 it probably
> > > has the ability to run the watchdog on the PCLK if
> > > desired
> >=20
> > This is true for the AST2400, but not the AST2500 where the only option
> > is EXTCLK (1MHz).
>=20
> The IP block/cell certainly has a PCLK even if it cannot be used
> to drive the watchdog timer. It is necessary to interface the
> SoC interconnect.

Hah, yep, brain-fade.

Cheers,

Andrew

>=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0clocks =3D <&clk_apb>;
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clock-names =3D "PCLK";
> >=20
> > Given the comment above, shouldn't we be doing something like the
> > following instead for each of the watchdogs?
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0faraday,use-extclk;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clock-names =3D "EXTCLK";
>=20
> So that will be added too, later, when there is a 1MHz clock
> to reference in the device tree. I guess after Joel's patches.
>=20
> Yours,
> Linus Walleij
--=-8mcd8WxSR7DvxoqkWPah
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZ3cTvAAoJEJ0dnzgO5LT5LDsQAIWKCuhsYgo86z0VjqziwNHB
JVtco/le+/Yjbantgyf9FeObJWma+S2eIFX7SU6N9DSOaOMzFRNdIOSY7OgQEc76
Gi/9GW2Aiua3hUg0JnPfPUpfjhQ5sB9wSg5J4HPVmPb8PeYOFP4CcEWS9lxu2T6E
YQctc4+MzomiUWU8EkVdiUHHAVIAYF+RgTHbO6dB89/rayAqmASdlGnoS7U6tM+5
NK4ZTH5VNnQgc+njiYEOd1NXHI1kxBFjaP5NMFiwql8HViT5dJH6vgfI0wE1AlsJ
HoWmSDXBGMWjPYr+ChjeozFuYiR58LRHOQjt8FRfM8Nu80/LvbPrvSQu9h6LpmPF
JvebjTYQY5fxHhxlGOmZAkTikSwqWlU7xZKqhEeJ/M1mCqrVP1EOe8YYjEPIAxMR
7Yt2iebvQjSukcLMl2851txkHIsoMW6Z5t3aDmOIAfjVrBVv4ZHcLMQkH8hGbhnc
nxZnmh5c3VvUBnKkcf9iqBpyjMQk9bIkeqxWKi3vlQCMjGLDTPPyxeRcqfKCNqzT
HT3fPhlgoJXAIR20IYpHqFgFoBqj6RGN9gaigdAnqug1mcezr6wVIOd0T14nKZ43
ftqqOYm5U3OPLLg0PIR1NREMs+a5P2eXIY2VFTIw3AUPz2PYmAFqfYEC6hY/Atbe
6yxtE7qYLze75vo4tjTq
=0h8Q
-----END PGP SIGNATURE-----

--=-8mcd8WxSR7DvxoqkWPah--
