Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40786 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab3A2Q0L (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Jan 2013 11:26:11 -0500
Date: Tue, 29 Jan 2013 17:26:09 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 0/3] improved watchdog driver for STMP3xyz/imx23/imx28
Message-ID: <20130129162609.GC3323@pengutronix.de>
References: <1357307929-1666-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <1357307929-1666-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2013 at 02:58:46PM +0100, Wolfram Sang wrote:
> Geez, this should have been sent a year ago but it dropped off somehow.
> Introduce a new user of the watchdog framework. This is a rewritten driver
> for STMP and imx23/28: Quoting Patch 2/3 for the motivation of a rewrite:
>=20
> =3D=3D=3D
>=20
> Replace the existing STMP3xxx driver because it has enough drawbacks
> that a rewrite is apropriate. The new driver is designed to use the
> watchdog framework which makes it a lot smaller and avoids open coding
> the watchdog API again. It also uses now an explicitly exported function
> from the RTC driver to set up its registers (the old driver silently
> reused the hopefully(!) already remapped RTC registers). Also, this
> driver is mach independent, while the old one depends on a mach replaced
> by another one a year ago. Since the user interface is still the
> standard watchdog API, users don't need to adapt.
>=20
> =3D=3D=3D
>=20
> The first patch adds an accessor routine to the RTC-driver which can hope=
fully
> go via the watchdog-tree as well (asking for Andrew's ack here). It is ne=
eded
> because the old driver silently assumed its IO area to be already remappe=
d by
> the RTC driver. The second patch adds the new driver, the third removes t=
he old
> one. The old driver was broken (=3D not compilable, no arch for it) anyho=
w, so
> there cannot be any regression. Based on 3.8-rc2 and tested on various MX=
28
> boards.
>=20
> Thanks,
>=20
>    Wolfram

Ping.

I rebased and tested the series against v3.8-rc5, added Andrew's ack and
pushed it out to

	git://git.pengutronix.de/git/wsa/linux.git watchdog_mxs

Would be awesome to have this (simple) driver in 3.9.

>=20
>=20
> Wolfram Sang (3):
>   rtc: stmp3xxx: add wdt-accessor function
>   watchdog: add new driver for STMP3xxx and i.MX23/28
>   watchdog: remove old STMP3xxx driver
>=20
>  drivers/rtc/rtc-stmp3xxx.c          |   64 ++++++++
>  drivers/watchdog/Kconfig            |   13 +-
>  drivers/watchdog/Makefile           |    2 +-
>  drivers/watchdog/stmp3xxx_rtc_wdt.c |  111 ++++++++++++++
>  drivers/watchdog/stmp3xxx_wdt.c     |  288 -----------------------------=
------
>  include/linux/stmp3xxx_rtc_wdt.h    |   15 ++
>  6 files changed, 198 insertions(+), 295 deletions(-)
>  create mode 100644 drivers/watchdog/stmp3xxx_rtc_wdt.c
>  delete mode 100644 drivers/watchdog/stmp3xxx_wdt.c
>  create mode 100644 include/linux/stmp3xxx_rtc_wdt.h
>=20
> --=20
> 1.7.10.4
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlEH+CEACgkQD27XaX1/VRul2QCgn+Oi7Dy35WMJ4g+SVK4CJSV+
1soAn2bEKmJuPc4TEF0stXr8rycjNh5s
=K8DA
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
