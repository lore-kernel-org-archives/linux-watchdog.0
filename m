Return-Path: <wsa@the-dreams.de>
Return-path: <wsa@the-dreams.de>
Date: Tue, 28 Aug 2018 22:07:40 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH v2 1/4] watchdog: core: add mechanism to prevent
 removing if NOWAYOUT
Message-ID: <20180828200739.ghu5trdp7jq6ixiz@katana>
References: <20180828191416.7781-1-wsa+renesas@sang-engineering.com>
 <20180828191416.7781-2-wsa+renesas@sang-engineering.com>
 <20180828193320.GA22656@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fskyd7oe6xqs6pie"
Content-Disposition: inline
In-Reply-To: <20180828193320.GA22656@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>


--fskyd7oe6xqs6pie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

> > +		__driver.remove =3D NULL; \
>=20
> Does that really do any good ? If I understand correctly, the only
> impact is that the platform driver remove function will believe that
> nothing needs to be done on removal. See platform_drv_remove().

This might be biased for my use case. Not calling remove will also leave
the clock for that module enabled. But true, the platform device will be
removed and without proper cleanup, there could be dangling pointers.

In general, what do you think of this approach if we'd left out the
above line?

Thanks,

   Wolfram

--fskyd7oe6xqs6pie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluFq4YACgkQFA3kzBSg
KbaDyxAAj/HMTkJa1uRvKLaTYXC1Aj2VHTuodoNuOIFblhc3Fs8swKqCj2y1/04v
GOQ70vdMjaev5Zh6bhCctFEWT6RYE3SXxtXnhkvHBkZWBY16j7l52/GbkPhiXsq0
GuX/WavNsflRgMvQkMu3pBKJoeWPd/dVvKhDLJ6+LuAw9jdCw27wXg6T8FaA88VJ
9mSZz0n9qyqBSPeqSfgEn+gH86Bmpg0fyjutFgT0DAamQ20tphb3GNGQdvAQIHyn
GRNnut1pYEH21VDQD29Ek90upA7Ht1xPh7IGsGyqsWoUhaKiZEnpVOwKEw6Yz34O
vd3iPPX08I9LwUXAqQDkWLoQz2uyA1phJG/1eW+4eIlMSRMOqtlgRrPYx3BuENCh
cu2go4CsaMhVVMclf91tRbQJ2OamssOBroeoZVhPqwUcPxGyjn6Y+AEL2K+0EdyS
R/OmZgQREhPgYs3IOgkWb0fNhsmnTHPrsfwDrKfhUdgmsgGi9PjTMsGHKJmvdkNo
SETxwbHDpAlrWQdJWERLRAMC1dy/HHmdlZmSzdpwisynWdRrAnRXl6Lqm53gOzw1
ORY1eHxxJqLSXSiTT5jIf8JJwmtOF+aunvqZcaY5Mhq/vzHmG5jltRO4ouXwzqIK
Yoo1SAGA1zm+G5ECjYCee4tO3/r5+HyexhIHl37BNanIpr+/AY8=
=hGGZ
-----END PGP SIGNATURE-----

--fskyd7oe6xqs6pie--
