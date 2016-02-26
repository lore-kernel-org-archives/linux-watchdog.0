Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:38922 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbcBZMM5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Feb 2016 07:12:57 -0500
Date: Fri, 26 Feb 2016 21:12:20 +0900
From: Mark Brown <broonie@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel-build-reports@lists.linaro.org,
	linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Message-ID: <20160226121220.GO18327@sirena.org.uk>
References: <E1aYsmb-0006qb-76@optimist>
 <20160226030949.GL18327@sirena.org.uk>
 <20160226091410.5dad4306@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xlNb4re00Yt31/7n"
Content-Disposition: inline
In-Reply-To: <20160226091410.5dad4306@free-electrons.com>
Subject: Re: next-20160225 build: 2 failures 44 warnings (next-20160225)
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--xlNb4re00Yt31/7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 26, 2016 at 09:14:10AM +0100, Thomas Petazzoni wrote:

> atomic_io_modify() is also used in the ->start() and ->stop() hooks, so
> not only during initialization. The reason we use atomic_io_modify()
> here is because this TIMER_CTRL register is shared with the clocksource
> drivers (time-orion.c, time-armada-370-xp.c). Indeed, the timers and
> watchdogs share a single register that allows to enable/disable all
> timers/watchdogs. Somewhat unfortunate choice, but that's how the HW is.

> By far the easiest solution is to add "depends on ARM" to
> ORION_WATCHDOG.

> Another solution would be to provide an implementation of
> atomic_io_modify() on arm64, though that would need the ACK from the
> ARM64 maintainers.

It also sounds like a more modern solution might be to use syscon for
the shared register, but perhaps I'm missing something about how the IP
is set up so ICBW.

--xlNb4re00Yt31/7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW0EEeAAoJECTWi3JdVIfQUpUH+QG78W+VOnN3orWqw/T9o2VT
H79UMEfR/0KjOacv2g9bDS9R4kYNxNwv4AbkV9HC93rokQAcwFhU7ckLv8DUw9vE
lAQ9cmIiIJUgxlRu5Lf0dF5fGn73q/KMKsFW8sR8IIQ5Ks/O6x+UhnZ6dJAxWHa7
N3cpLz5LMD2OVY19GfqynbNUNFENIeWWwdNJvGcGeGfRgpLyEltg5bnXcSgZ08qg
qfYPx1eG094d2bxm+OpsHvxQisPVpcNRNa75kWyp7hsLurKEpyJs8HYomQzv7Ea8
qAKAG/r3zTdPDEKIXC1ufike9Zi5MJT2sE9F8mJ1pBQkXr/b/alFtAr6ExZijig=
=ebLa
-----END PGP SIGNATURE-----

--xlNb4re00Yt31/7n--
