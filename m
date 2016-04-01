Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57945 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027AbcDALjN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 Apr 2016 07:39:13 -0400
Date: Fri, 1 Apr 2016 13:39:09 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: r8a7795: Add RWDT node
Message-ID: <20160401113909.GB1389@katana>
References: <1459351725-14144-1-git-send-email-wsa@the-dreams.de>
 <1459351725-14144-3-git-send-email-wsa@the-dreams.de>
 <56FD2955.8030907@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <56FD2955.8030907@cogentembedded.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >+		wdt0: wdt@e6020000 {
>=20
>    ePAPR has "watchdog", not "wdt" for the name.

Huh, I thought I fixed this already. Thanks!


--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/l3dAAoJEBQN5MwUoCm25y0P/1K7/IzrkfwMnxObtMAzTgFy
dC9TForJ2crGStf+pkSjqFcBm+dMcfBE6zjDOUQmmHqEnIdb6TLsBAEN/Ut6R25+
md0w0N374DW+uqqhwhCChSOoa727OcIxJJGUbm1YPT+4X3NSrjnEi2L22hERhRbq
UcyT4A1Sg8MzlX592xouoEzaTh1AVPdLlOYIYlRpAqNv07TSEOk/z7R9eSxuxvzF
HAv2cpXjFqAV0kfeNDzArtvMaFsUdScaX6Hh2S5cNTHjpbu56Z502ZomZJKUrYB4
abc0wQmAJO0U5S2MRz9aR1P3NSRcT6owlKQpr95NFaKhvmIju4lObKkG9BGSrwIk
X5eQD4cAy0d2OOHlDVtx4FhBTbEpPhZ9A6lmeUl5pvjpVMesMgV4i2zhtHpgNG3z
F73UKtBjKfiNppPJwy3hjpzQ9iZ7/60a1DXzn38YuVCN7FaPSFXG8yGcpkX+3ag5
29r0HdhlfMdlv2e+P/GY6hToGVET75jTYgy0mQRQwQqSkvXO8/1aNduu4JDY1Tj5
w/Um+2huXhK4uSeeBSjTR6oeyY0JVU1cUlf4X/NHnE/dx1qTxt9T2QWat29CFNaO
7diH/g2X1UBhrWnDAKDleVUjSaHa8lb06NAZeBKn7DcyMueE85xSGXTO2x2NSv/I
GeKYofOaOaNFihs4szG7
=HL0A
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
