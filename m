Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55916 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbeLCNkD (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Dec 2018 08:40:03 -0500
Date: Mon, 3 Dec 2018 14:38:57 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: renesas_wdt: Fix typos
Message-ID: <20181203133857.r7man7cmqfkjpbkk@ninjato>
References: <1541415227-4991-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zrbv3qdnqob3r7fp"
Content-Disposition: inline
In-Reply-To: <1541415227-4991-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--zrbv3qdnqob3r7fp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 05, 2018 at 10:53:47AM +0000, Fabrizio Castro wrote:
> Do not use "," but ";" to separate instructions.

This sentence would even be better as $subject, because current $subject
sounds like fixing a comment or so. Other than that:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--zrbv3qdnqob3r7fp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwFMe0ACgkQFA3kzBSg
KbbkkxAAoSuwu+qH0zDsr7kMrpFDDW5gTHCDw2ti3u+J+hLLVjSz10UennNAVL8g
p8NK3VbXwZnj5+IuWHv43XYMdEPxr+onao1fqCNMP/wA1MuvX9J1cFRMemZnTW9V
l/rtePAL9+Gl1IQZavjVscGUodYmHpE2qhweGEqLnR4Jdx5OkRU0fyF7jDxAFJtM
pnSJ7ZQk4W/LLtFli0CNPwxA+1MsAMzARLYJte0pM7sYjn4OlBtUeDIlj/UXsUua
N14ush/pWmzE9c334NvBnr60ObVEClQAxlElmFZKGQb8aGBESvxqo5xU2r72mc3d
j99lYqdAAYB2iOkMXGT3Ku92CSW5Y/J0rs3+EhzLz1qxp2F6WarRmkD8CcLwcGWf
cvPqkKUiSm6eNpqPNES5MJhxS8uwNP5cxf2j170CJICRaBAJDaEgvgYSUm3nl5HT
6k6T2gZBejRYuu6TRJA/q3vlTv21qDqmQr86/4tDj2gTUX9dikVHwOCgiX4tsRws
59LdWKjC1J1LDCQgGtomOVttKdwLABBbrE4/6FKVEBSnUAcdmKt6h/t1coWLO0df
Cr1jFX739+pHEkdp9qDGb/wtcg8ii7xr55nVKx1jzbGdwBtZykajXGJ7H6Ie0CEI
XpGCqbDgGyn6ukjHUtaCy6qzrmq7vf9L8Mvn4PGxnePkOgOlmGc=
=h21u
-----END PGP SIGNATURE-----

--zrbv3qdnqob3r7fp--
