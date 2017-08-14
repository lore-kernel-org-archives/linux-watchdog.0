Return-Path: <wsa@the-dreams.de>
Return-path: <wsa@the-dreams.de>
Date: Mon, 14 Aug 2017 17:47:28 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 0/3] watchdog: renesas_wdt: use standard clock
 handling
Message-ID: <20170814154728.j5h3u4vs43six4z7@ninjato>
References: <20170726215439.9623-1-wsa+renesas@sang-engineering.com>
 <20170814153230.GA7025@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vom24tblpog6jodw"
Content-Disposition: inline
In-Reply-To: <20170814153230.GA7025@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>


--vom24tblpog6jodw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 08:32:30AM -0700, Guenter Roeck wrote:
> On Wed, Jul 26, 2017 at 11:54:36PM +0200, Wolfram Sang wrote:
> > As mentioned in a response to a previous patch, clock handling for Rene=
sas
> > R-Car is done via RuntimePM. Patch 1 implements that consequently. Patc=
h 2
> > is a cleanup then possible and patch 3 is a trivial copyright update.
> >=20
> > This is RFC because I'd like Geert's comments on these patches first wh=
ich
> > might take a few days...
> >=20
> Was there any feedback from Geert ? I don't recall seeing any.

He just got back from holidays and is bravely working through his mail
queue :)


--vom24tblpog6jodw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmRxhAACgkQFA3kzBSg
KbahqQ/9G76XlqJcbtxf+mtve0xHAvXTQyDZ39kLATTT+34vOB0SO2xniJrMDmYq
jL+9HN8wRPuuqMLy7toLb/B2Z1rlYM6kshNMyqDeLd8fJZPj6myczc3h/fGnHz7d
HH+T2RlGfHpcS3X/n/bdNcfJqIogpvIFKKuv0LkBWbtVDEu4d2Rnq1Mx8AfvSMxU
15JOkU3mxrIixfmoTOD0r6kh9WBHSjTOYgXhBGLfhuXmeTgSbwgWNJS8LuGvHzHJ
7r/LnUPxHNgW20lDhfsTk/A4HElIyZnecrMPy8Gn8HbFvkwSBy8cKNFgKfXmC1tK
RPzeIjA63rMid67YkIaqewQ+05rH3zz2vYcUkGIdzBuu2Pi6Zzysdl2zfro7F3rT
ZlL5nRKWaCbu6f9UXOsl9ZWE+YztDuXEgPLse+2AGQfRCIfjaV8jBMSWUu6Jr3DV
JldgNV1hUWgDf5drItVpLb9mJsdEyVBf4bTohNb/aeRhu/v94s4JkfLbuoSgCi3e
/VXzFJiEb4uDLNDBUP1FALAly4fFlUUuuGU6ya5adS2Sq9TaT4PaIYXAZehYW/WM
ikMomYCYWTRtpCAbHFfRi2E9/PePctGuPkjwipoP0aGWE/4x2M3P85kqBX+BidB/
BpNXe5wZXHb9ThJxB+jN8FwnQnT388FMJbn748j6/KHBL70bMoA=
=qegR
-----END PGP SIGNATURE-----

--vom24tblpog6jodw--
