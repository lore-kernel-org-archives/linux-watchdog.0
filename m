Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54608 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab3GFQhE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 6 Jul 2013 12:37:04 -0400
Date: Sat, 6 Jul 2013 18:37:02 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: viniciusfre@gmail.com
Cc: linux-sunxi@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, henrik@henriknordstrom.net,
	linux@roeck-us.net, Carlo Caione <carlo.caione@gmail.com>
Subject: Re: [PATCH v5] ARM: sunxi: New watchdog driver for Allwinner A10/A13
Message-ID: <20130706163702.GA11243@lukather>
References: <1370547265-24854-1-git-send-email-carlo.caione@gmail.com>
 <80d67226-1d83-475a-a94c-cfecc1cd277e@googlegroups.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <80d67226-1d83-475a-a94c-cfecc1cd277e@googlegroups.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 06, 2013 at 07:39:13AM -0700, viniciusfre@gmail.com wrote:
> Hi Carlo,
>=20
> It is not possible to enable this driver because there is no
> 'ARCH_SUNXI' in default .config. What you intended to use,
> 'ARCH_SUNXI' or 'ARCH_SUN4I'? RTC driver presents the same issue.

This driver is intended for the mainline Linux Kernel, where ARCH_SUN4i
doesn't exist, and ARCH_SUNXI actually does.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR2EeuAAoJEBx+YmzsjxAgS7cQAIA1dDUb04bIqvkXiwmRxAn8
AZZWd+uxVquxowvrHgJuqlaXNJ4LeLTt1rJdWkJ3SK9WBrFtnt/KpjmwGYASOnc3
7o0jn3NjrK+8c8/vIeGBsuBm1af4jAjX3Btlf/goRxX5Abrfw+56dg1pCoRY2Nlu
pN4c3PJ+ACIkQn4NGJnGY+r5Fw0/dQJETc33QpDQrvNFaVn+0nvUGgY11DipV0hD
AbCvJcZ9TPkSDusfbzJI5joBlP55m9SA2oYvh7PdstbiR6I2WHZFlXawo+PYOrw3
Lr5uRWA/KPjJqzJ7EcEq4Rsxmsp7U0hFhdC+A1Ynen61K5b0fdSzhWo9eyjxeH67
UDFqr/7A/GjaD7rq6iaBIKyk9KKrT4U6cfSCPfW75K5oFihdZ0Sg/iHqigIggm91
LoFWxZeBR0eGqzJNZTUwiGHZt6WIxvxHUgiqLtEH67C7qNSbPsXPAcHQz0DNcwiS
+AEUBxGdDzQdxJFZdA3GMXDf56dceRhpf0m7eL/iadDGqsmD21gJKKcBDOaFqG+5
h+BiP2Kr59jyFyjfqPjuvxqk9oP64n+uinjNgH0T66/02iVbXSoRKvLhGuDkLfa1
keDNA8uRSTkkKYfy/FGTjVGhs/c/8Es8/zjBckdv7r0Rdnf4MyF8Drelmikd7QIy
FDnaX3Al/2MjP/ZyNTSj
=U1oc
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
