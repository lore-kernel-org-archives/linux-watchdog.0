Return-Path: <wsa@the-dreams.de>
Return-path: <wsa@the-dreams.de>
Date: Tue, 28 Aug 2018 16:18:50 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [RFC PATCH] watchdog: HACK: disable bind attributes with NOWAYOUT
Message-ID: <20180828141850.opoduyldzvp2e53v@ninjato>
References: <20180828102906.12840-1-wsa@the-dreams.de>
 <3d3a5bde-b8bd-0810-5571-cdc64cd57ee4@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dzpd3zmmitlxejtf"
Content-Disposition: inline
In-Reply-To: <3d3a5bde-b8bd-0810-5571-cdc64cd57ee4@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>


--dzpd3zmmitlxejtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

> > -	if (nowayout)
> > +	if (nowayout) {
> >   		set_bit(WDOG_NO_WAY_OUT, &wdd->status);
> > +		wdd->parent->driver->suppress_bind_attrs =3D true;
>=20
> That makes sense to me. We can not assume that wdd->parent is set, so it =
won't work as-is.

Good point!

> Not sure what a "correct" solution might be. Passing "parent" as argument=
 doesn't really
> solve any layering argument

I totally agree. I opted for passing a pointer to the driver to modify:

void watchdog_set_nowayout(struct watchdog_device *wdd, struct driver
			   *drv, bool nowayout)

I'd think this would work from a layering perspective.

> Did you ensure that the attributes are not already created by the time
> suppress_bind_attrs is set ?

Not yet. I first wanted to make sure if it makes sense, at all. But will
do for later versions.

Thanks for the review,

   Wolfram


--dzpd3zmmitlxejtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluFWcYACgkQFA3kzBSg
KbY4hA/9FwbVw1ez3eCb7hYPgDSFcLBQt/02Nmd+LQNCZwH9/PE+GDwaDL7z2pHA
B9iIg2C99LJwc99MI/ZKgJksOGmCokNfnHxqkiN+AXz9AusGfoFtW63QamFuBwlv
MzgoDfhNaqVEcJ1Oj+TddSFSQkKmBa7epsy8QWNF0d9H0g6pWIomEnwLwcVQMfFO
+M/kYhxKooUvO718iTGwxoV4HNFsr231J6/3eAvSPmSQ3XHiPQz/lmNy4rt5GYU+
3kt0vufs/g2HlupjcjPXU0L0FG6NOrWrdJ/SWNngVQ4qzk70yRsQ97eux7B9LRmU
ti5U09wLgvyOtCZJDjmENHxiKX2fAw7+Qcq+V6LAEBNhyeThHRLx7XPDnK0/N9fR
CYyFVYBcAmVd6bjXodcRADZSCAPaX7tnxKSD7cOyz4Gj+AQvPyHvI6otmKMleXZb
1zvJY7j18OGdcUsOR5O37HgH3VDer+JNP2QBMZkyegO0UrcsqeFHp0dyMGT7QIXP
246/XDVgC/hTsSBbHu7Jr6iza9d+ah6r4nBG8wGQkFQ0gn8sOB3YmHydHbBHds/j
XpnBIikIHuUY3bkIx1f1AtsrWcYnrFgeNgxRgPltoZ3uBZ+h+auQh8vB1ziy2aBF
E0ZPmWOvPulwoJyuG9P/AxpxmSznuwCe091Lzh4Vf3IveHJS5d0=
=QFwE
-----END PGP SIGNATURE-----

--dzpd3zmmitlxejtf--
