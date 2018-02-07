Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:40370 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbeBGXVL (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 7 Feb 2018 18:21:11 -0500
Date: Thu, 8 Feb 2018 00:21:08 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: Re: [RFC v4 26/26] ARM: dts: iwg22m: Add watchdog support to SoM dtsi
Message-ID: <20180207232108.j2kei6djpxdzpflh@katana>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-27-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="osvn6dhlwkouweck"
Content-Disposition: inline
In-Reply-To: <1517423070-24236-27-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--osvn6dhlwkouweck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 06:24:30PM +0000, Fabrizio Castro wrote:
> This patch enables the watchdog from within the iwg20m SoM dtsi.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesa=
s.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--osvn6dhlwkouweck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7ieQACgkQFA3kzBSg
KbbDKg/+Lu6pn0FAn5PH4KYmlG5IurP0F7ID4CGz3wn+qkxF+VKykyZEVoizWcGF
BRwnEEgzEa9lNj9IPGHXc8HzSnYBrpOyFL4CoUJwvimqHsVCH+DSoFuKdDTiAi+M
pnoyMjaQKs96DxFAzWKDf4bpsjDSjtIEKcWqkK0bLE84E2F0DPEo2NsWl8elUOOw
aI1hSOsga8U48xABThbLyfxFE4T72xPC1fV2hONbYmOwp/5b/HN7EZ/dgclxuvDG
PzJuulPzO9uol9WzJ5zrH0BHSokLX5eJ34+VwYfnGPbH+tQ3r1CFLDiKsVmX2s9X
HcEmIT+1NdyCrnTCiWrIVSG61sT1yryt4qfsUIX9ZIanZ2uqbC5/IsZTOn7ZGoou
qkCdvHt9IoJRnc6Qi8UYYBNcbfXezc3I0X/+RyfyTivJhuVybOqfylMmWCFbI9JW
HfVw7/6gIZ8f9TJWqY2bJUGpBgjPRnLnw42T2jYLCusTZkKJ0FPcuRGLN/HTTMLM
Bn8KtxoblDcEEAyzaqR/MI99REekraW7JeDpJxa6SLIXQH4ukM++LsuQRZDgsYYt
egs9nGEYxs/nnUao9mEQ8o9rr4Y5ukhGxU8wB4XiOPVteu+5zVIRMMvapdq29dSy
rkDzt2/35utCKpUrDP1Rs35iXHO/SJ/eg0vZVbi/Macdc9te5oE=
=qzOw
-----END PGP SIGNATURE-----

--osvn6dhlwkouweck--
