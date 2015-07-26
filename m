Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60509 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755205AbbGZTfG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 26 Jul 2015 15:35:06 -0400
Date: Sun, 26 Jul 2015 21:32:38 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Francesco Lavra <francescolavra.fl@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: sunxi: fix activation of system reset
Message-ID: <20150726193238.GM2564@lukather>
References: <55B32BCE.5050506@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P9KQiUGMzYCFwWCN"
Content-Disposition: inline
In-Reply-To: <55B32BCE.5050506@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--P9KQiUGMzYCFwWCN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2015 at 08:25:18AM +0200, Francesco Lavra wrote:
> Commit f2147de33470 ("watchdog: sunxi: support parameterized compatible
> strings") introduced a regression in sunxi_wdt_start(), by which
> the system reset function of the watchdog is not enabled upon
> starting the watchdog. As a result, the system is not reset when the
> watchdog expires. Fix it.=20
>=20
> Signed-off-by: Francesco Lavra <francescolavra.fl@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: f2147de33470 ("watchdog: sunxi: support parameterized compatible s=
trings")
> Cc: stable@vger.kernel.org

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--P9KQiUGMzYCFwWCN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVtTXWAAoJEBx+YmzsjxAgzIEQAJFbwDbSjPAm3gYFeqL0p/z0
QmUSvsVhU18SA/brUNBel8tvJjGkyI6Vhgu9KuaYgbi4GFyYRW9ep/qLpfVhBSra
nS19JCnATjRqkQpOqQ31NIEiRDmalVvvPR+sPWcgSyYeC5DFGATemtBg0wSqJmDE
kx4654NKv3UeWtI1n6G73z3+ZPmhuA58R9SzCxlOAbiTgpJW0VKR05DCJumjgtdg
bw4pT8aGgKPjF17ur0Woapk7m3yh1la0npfjQI8ukmDvzU8JP0jEMV8IZd/AyPtC
Jezz8bndDR7TitLc+mX2mLA1pIU88QPM0uThRuHW46Jh7CYEzs2PLoCxMd0Fk9B6
ai+RTLOa7n+F9KF2D092HAP5dilJuAoabQPx05g5rqjl+rU13XVJSHoD9I56c7XH
QwmnSXOSDg5NruIBOomokE5CavoEr+43AIK7otkWzEssPMTMMaOQVaZljRlQ1pTW
nnUQA+idesM/P/IKfvE06raR/we8Er11jyfdM0kGK2+21EEVs7HgR1OxwkAVOxgB
4PH6ClCD7lfLGrKJY6U+XKXe3s7D63HXreftZgcznr+apRsK4tz9I8dqwNUSArb/
dKnkFm82JXxK1B6Z21hFuC1VidCd4ge1HpJAw8EnoVL9GfKphkQRDArdnag29qoG
RKmzuh3092y2Xy8hQopT
=pjxp
-----END PGP SIGNATURE-----

--P9KQiUGMzYCFwWCN--
