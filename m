Return-path: <wsa@the-dreams.de>
Date: Mon, 27 Jun 2016 11:37:07 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Robin Gong <b38343@freescale.com>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: add pretimeout support to the core
Message-ID: <20160627093707.GD1602@katana>
References: <1466902865-14354-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1466902865-14354-2-git-send-email-vladimir_zapolskiy@mentor.com>
 <576F3E2E.7060606@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <576F3E2E.7060606@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Nitpick: If we consider pretimeout == timeout to be invalid, we should reject it here
> as well. So this should be >=.

I agree to that.

> to the next version. I'd suggest to wait a bit to give Wolfram time to provide input,
> though.

I liked the is_visible() change right away, so these patches are fine.
Guenter, what is your take on upstreaming the softdog pretimeout
support? I'd think it would be good to have for testing purposes. It
would also help me to upstream the busybox patch for the watchdog
applet.

Thanks,

   Wolfram


--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXcPPDAAoJEBQN5MwUoCm2U/EP/2CmvFradWeQBnYzmlDr4Smg
rDaUJO7YniG30RTme5PjSOIur6GFJnwbNh6e+HWBPoAh3dWTp9NzJ1KdQ2sVycfq
SiJZTTdLsUiTPzHgd9An6C2t7IOv6yAfByZoKiZG7ukhm8AxiYmuD28POjbUgzGU
zumeI+s+5Qqo9cpsAqVIblkmuEQkTiQbsXliULusA8g+KWRMokAw9end84Po6buJ
Ntqzmb/+58ashM9RBqTVNcnpNKQ01kCNPXm/BfTOGdaDYnZ02eeth96WWsUg+5Xt
f/Mt5LTJTgET/+rxu3YBoumegP5ciHM4CMucHERdcZUFYpbXrdsX1U/XAp5T4d3z
B1knOOrlGOyB7kZ+3SZ15OLvgR836PGu1N+ldknt3hFLljOABPcnMSlL/viDdAtP
XkNJYhjfmtiwkDudot7sCaSj7WjUTsCj92zGXBx5jLYcPZCdhCH2etC3gDqplXRd
8C9Xi9uQ6Y0Qjuip+C6z+81IpeUxrxtEM4lqtP4SB8ZOVVV37xj1y+rodNVdTCgu
k6pVrbTGWi/1Z3ZR2Wv+4+IVjQE31kJNtK/qpK/o+qGnvSHbtLc/gcZcXFjggpE1
lsvayn9XlSVYuxM7z7iCCU08ZAJijtD1MRh4+8N4asIYDZowenoUg8/Rr4qS/zg2
gcZ2YsCfer3VYfixvX4R
=cIQu
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
