Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:53384 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751540AbeB0QW7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Feb 2018 11:22:59 -0500
Date: Tue, 27 Feb 2018 17:22:56 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: Re: [PATCH] watchdog: renesas_wdt: adapt timer setup to recommended
 procedure
Message-ID: <20180227162256.fgyd3oikydrq3e7i@katana>
References: <20180226214905.24516-1-wsa+renesas@sang-engineering.com>
 <20180226223853.GC5924@roeck-us.net>
 <20180227130058.pmgo33zjvbxwmlad@ninjato>
 <86da4e12-0d0c-c07a-eecd-76466f713da1@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nob3uhuqiyp5seo7"
Content-Disposition: inline
In-Reply-To: <86da4e12-0d0c-c07a-eecd-76466f713da1@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--nob3uhuqiyp5seo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> the core gets it wrong. Just add a note to the probe function where cks is
> initialized that RWTCSRA_TME must not be set, and that RWTCSRA_TME must be
> cleared before changing the divider.

But we would still need to disable TME sperately if the caclulated cks
is not the same value as the current register value (be it power-on
default or something the firmware did set). Because we shall not disable
TME and modify cks at the same time.


--nob3uhuqiyp5seo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqVhdwACgkQFA3kzBSg
KbaBXQ//ckMpPL3uvKehpBFa0X2BbsRyPB73N971Reum9azHiIqeoprZQvwH4pC3
oizoRlfryMk1NzaX93f9SD7f1FNmXVKPyR4NKCy1qOAeTL5NqgZUR++StGRUUwCi
zl3XhNCBxO5TTACTT5OVUktncRwO41dX8Kp7R40YuzA/MIYSiCI4Z1BIh6v2idZm
gLuox3hIR45T64k9yKFuZlD24d6g6womXQQEeQ1dvK0RWzkUKw7xDJ9P0A0yLFH+
4A0gaAOTtH/ysPtnYNVqJ/XgLYpLrasQAO/UEffcAPltKUWymrA56k9J18H3GR66
aMB5H2gALn7F6t+9XjDsYl2Zzbc/yVrs9oRCVyA40Z7BLX++rimOr+HMYQbCZl6F
ZLgCROt4n+mNz0lxSvDNWM+WiYRc95vKhNeGJuht1m9kp3Gb+6Ap1UsWiYWjxtEi
2FhAhhnFojsDv+nsLo+TtlqzCdzpwQPnjmA0oJ0JKqU8Lnxozw4wgvtsmofnO0QX
ZhHKklDXhu/BquCqNlB1bmZZw5ZaeIDhwKAiNownJUHAUYSN1J6OifGT7TB4Ey8d
fpkM1JXxBrJMa704hWpUc2DO1yGwYrtVkSHk5pKe6pZjHczrjFs0W+dvFdfy6YYJ
ZTEoitAzN1SYD6BVv88in3TyEqhzBtQ/fUJvKfh9Ro0bIGiHKYQ=
=aHdz
-----END PGP SIGNATURE-----

--nob3uhuqiyp5seo7--
