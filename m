Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35914 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471AbcDDO7Z (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Apr 2016 10:59:25 -0400
Date: Mon, 4 Apr 2016 16:59:19 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/4] watchdog: add driver for Renesas Gen3 WDT
 watchdogs
Message-ID: <20160404145919.GE2983@katana>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
 <CAMuHMdXQFD281m7iWc7RRdunW8Fo9nQfLBwytD1L3abW1ephtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXQFD281m7iWc7RRdunW8Fo9nQfLBwytD1L3abW1ephtw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> My Salvator-X reboots after timeout from "cat > /dev/watchdog0", but
> it doesn't reboot through "reboot" or "reboot -f"?
>=20

That sadly doesn't work on Gen3. From the RFC v5 cover letter:

=3D=3D=3D

* drop restart_handler since ARM64 uses PSCI firmware resets which do
  not call restart handlers

The last point was quite a bummer to me because plain reboot was the
reason I wrote this driver ;) Well, so is life...

=3D=3D=3D

   Wolfram


--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXAoFHAAoJEBQN5MwUoCm2a+wP/Ai0XLKSAGRmtOrlR2E+T4TP
WvCtGRY8LSwC0S6gYVZBNKBPBtzjmPNTiI2Z9t8x4TI0Ts1vpMBz8pCVCbWOFaSW
o2uFPN/UKOADj5Ki7RUV1bX5sBDs2cq7/hZ6IARwIyFj6WgW6tKDgHBC1W7SgTW8
ZAXZ/fwZKhTtebCwS1BNp+rgsk+cQCS6MOJfcv6aPAVfl2ecVBHxy/JGyeTLuBEI
wx9fAmFt7iNHv+6NtXplrlMa5ux5P+/SvvJoy9NFkA9XgZcOsxLKHnzwxA7Y22A+
ahzpAK+4RiobfGKTqqQQQJmGj3A+CHzSyKamhi7jMobZmSSojJpUxyObkoa63+jt
1E4V4ComMZc9WAbJ89pO14tEpMch2EemYthnzGVlrSjuRSDHOEDGxO8i3Dstd2eh
8m0B2BDRuwnQHSRP7QTV+rpRA5p+fnSqgOqsDm/fmgpQ5bdAtXNkT4zdF/NsJ7MQ
OoCMOB+gt0iXOxpvxl3GLMIHuOhHyYWQKEPrgi+ZR0RZeW3P+sKkaUE2PdCSoI++
avKWmHiaWTdabOUgbqhzg3kw1o4j2WOGwd+qV2ej84afGdjjHVAxKurhESwObney
hz8CVuX3iEUzUznVTTUtuTYnnKQ6SEUTc85cLvmglDs2IdVHD0lTS+DTBdEdDiXG
8kdP5UCBl0zpq3BJqlu4
=6kuL
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
