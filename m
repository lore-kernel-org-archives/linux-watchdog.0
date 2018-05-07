Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46764 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751948AbeEGM0T (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 7 May 2018 08:26:19 -0400
Date: Mon, 7 May 2018 14:26:16 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [v2] watchdog: renesas-wdt: Add support for the R8A77965 WDT
Message-ID: <20180507122616.kobh5buuvw3nedw7@ninjato>
References: <20180414101858.3208-1-wsa+renesas@sang-engineering.com>
 <20180506055902.GA3711@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="owbllm5epiuhjoqk"
Content-Disposition: inline
In-Reply-To: <20180506055902.GA3711@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--owbllm5epiuhjoqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Unfortunately this patch isn't based on anything recognized by git,
> and even though it is simple I can't get it to apply. Can someone please
> rebase it to mainline and resend ?

Will do. Sorry, it seems like not all of the Gen2 Watchdog support
patches did make it upstream this cycle like I assumed.


--owbllm5epiuhjoqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrwReQACgkQFA3kzBSg
KbY7SA/2NUnlefsMXPf7ptolF+P9dfUufvytY18qS5GrzonwTJgJnGw/ILYYoLcq
1Usg9UOsV2B/JAoCpvAJCgLE4Fxcc7s/iYdKEei7XPjiH/ZPPk21DOzCs0nshnBd
QL6pgJzuWI7vPaqdgT0vcBZfZDnVxY7pGNnGhbK83ta8y1i10Ghn02IyvfJ4dHDY
EsdlUTKBQf/QaW0JdxYJ/fwU8hE2MVmHcEUan8lCeN7MKakqRynWLyU6kMe2mVz9
AUu9y6RJdwZUdcdAXtQGE8jSH+BG6MoX7mrHhyLbTgLjz7IjCdZ2/jRUaDbTUPNP
NO6utzKFrVzeNgjrHj/J9gHYR/kqFSMsAeS8u0YBkoI3F0mlr44b6UUIEKiZbMyc
krtz5QIoVD5hPEBJVMqJ4y/AlUnkEkAEc/OfGt7hxOkHksIb2wE/4D5mBwFZOvtR
z0m2qlQz0gbz3sx0NQa6gLJFxr6gUzFXb4xqUp+VUu7OjORC+V6drMCfiwU5leqJ
nJQsORrqSNFLn/uTvnsgaS9YNVKhLhUq0uD8c69mgKn4jBYGbCKkwpFvo274SfpN
M6ZOYHfLKehUA7d0Dvd9bGxNPYG/atNV3eFaUxLIkB8VbFcH8FzjEuocL2RkcrNv
ZnKW7KyG6MLcn05fN6UXWjpFRQizNMPhC6rUMAA9nzOmba7bFQ==
=Ihyy
-----END PGP SIGNATURE-----

--owbllm5epiuhjoqk--
