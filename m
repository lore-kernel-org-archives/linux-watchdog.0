Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39642 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbcHSCgL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 18 Aug 2016 22:36:11 -0400
Date: Thu, 18 Aug 2016 19:11:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        linux-mips@linux-mips.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Message-ID: <20160818181139.GS9347@sirena.org.uk>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/OxAoNYcURhUkoHv"
Content-Disposition: inline
In-Reply-To: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
Subject: Re: [PATCH 0/3] MIPS: TXx9: Common Clock Framework Conversion
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--/OxAoNYcURhUkoHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 18, 2016 at 07:34:24PM +0200, Geert Uytterhoeven wrote:

> Patches 1 and 2 can be applied independently.
> Patch 3 has a hard dependency on patches 1 and 2.
> I don't know how you prefer to handle this?

I can sign a tag for pulling in easily enough for the SPI change.

--/OxAoNYcURhUkoHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXtfpaAAoJECTWi3JdVIfQUZoH/iQFeSN75ptSllwhU4cxzmL3
GQuPrk70Ogkv5rX6oZs0n2lxoA5Ag+lECP7QxPIBSK7MMfFABUDr9uI7oNzTS8XY
Ww7eyY/gx1zha0MUgnjTAmcONgfibXZljnRggHpjvMNfZRrHEnEWAU/jlHksEv39
Q0aVntPDksyjKKkVv2x16uKZBubyr44axnPq7RltYEK8DH74coKcOeZwHQbslgjO
/Llj8kshJSsJ3IrEsNBiOCzoW2EFT82S7Cm7cFxmSVJf4Vx7vntR/AYtE85fW6RY
wEEHt+ObqlDvAPviCZe0Z+zxqG0o8qcXwJNm0lDyB95kJf5ulXOU0DhQDZB04Uc=
=IkHd
-----END PGP SIGNATURE-----

--/OxAoNYcURhUkoHv--
