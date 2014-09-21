Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44195 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751621AbaIUQuF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 21 Sep 2014 12:50:05 -0400
Date: Sun, 21 Sep 2014 18:46:29 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] watchdog: sunxi: Add A31 watchdog support
Message-ID: <20140921164629.GB15315@lukather>
References: <1411315519-26257-1-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <1411315519-26257-1-git-send-email-wens@csie.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 22, 2014 at 12:05:17AM +0800, Chen-Yu Tsai wrote:
> Hi,
>=20
> This is v2 of the Allwinner A31 watchdog support series. This series adds
> support for the watchdog hardware found in Allwinner A31 and later SoCs.
> These new chips have multiple watchdogs, with separate interrupt lines
> and registers, but the basic layout and operation is the same. This series
> is based on Guenter's restart handler series.
>=20
> Patch 1 prepares the sunxi-wdt driver for varying register offsets tied to
> compatible strings. Various ioread32/iowrite32 calls have been replaced w=
ith
> readl/writel as well.
>=20
> Patch 2 adds the sun6i compatible string with accompanying register offset
> data.
>=20
> I tested this series on my Cubieboard (sun4i) and A23 tablet (sun8i), whi=
ch
> has the same watchdog hardware as the A31 (sun6i). This covers the 2 clas=
ses
> of hardware supported.
>=20
> After this series is merged, we can remove the power/reset driver for sun=
6i.
>=20
>=20
> Changes since v1:
>   - Mention replacing ioread32/iowrite32 calls in patch 1 commit message.

On the whole series,

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHwDlAAoJEBx+YmzsjxAgE7AP/jrcRvxZRYBpfCTIk75mIrhE
mYvqpdHW6gaSblR4ec7nIc797xmKPZ6yapyfMOR+PluTdiSN8Q7NaWnaofJ055jF
0rc6N2a8TMwwfnkweDL2sz5og8ZKsM37/Uo6ngAPF0Epo8nLertguKI+aJKL0aaW
DipUtHzeknn0unO0igUuOOs1/ZasRvUKa3qnIZV4OwLbVPAcpBLDoRTELv2odjp/
Ew0q/b7siGqSytleQy3t+sqJywJK+8g+pcxH6G+EEBD+UCeWRBjDnGgf0G3xBfrr
+lqwHh6p4oajD/ks9yQI1FRlgAA3gecK2fEqKsMbLN6nhNuzzT0ARCCiT06sC2Yq
KGCQQDwqECVDCDV2lP4GeaOWJ07ajezlT93cuK4fnqdxC99xpO1xH2NYRW2EXqgz
Q1XBgsZOeX5XPbrGsvq142ePzQqRZgeuwaazw3dqYEYSS/uyCWNS4/r9sWXpiF5t
X7yn+K7f7LWrXPDYB6wbWU28H6lS9tlm4dg1zVBMVGbRdqrv7dq7xyn+02eWraYR
rNZALXJRExjqzrF5ltbvmzv4oJlFyNwOXdl/DadV7xvmo+2+PrpAYinQXj/BCZmC
DVTm481a+ICx6FbWy7KU8IzJp9dwRCacZyac18h3s9vDfadAp6wt8gH31KnqeCtl
luCRYa6OVI+EvVGWG/T1
=SihT
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
