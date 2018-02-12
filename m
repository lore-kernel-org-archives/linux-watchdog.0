Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:57084 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754046AbeBLU7n (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Feb 2018 15:59:43 -0500
Date: Mon, 12 Feb 2018 21:59:39 +0100
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
Subject: Re: [PATCH v5 13/26] watchdog: renesas_wdt: Add restart handler
Message-ID: <20180212205939.75pszm5ih6ndw32h@katana>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1518457475-4480-14-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="smjbq6gp6e7bfkkm"
Content-Disposition: inline
In-Reply-To: <1518457475-4480-14-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--smjbq6gp6e7bfkkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2018 at 05:44:22PM +0000, Fabrizio Castro wrote:
> On iWave's boards iwg20d and iwg22d the only way to reboot the system is
> by means of the watchdog.
> This patch adds a restart handler to rwdt_ops, and also makes sure we
> keep its priority to a medium level, in order to not override other more
> effective handlers.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesa=
s.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--smjbq6gp6e7bfkkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqCADsACgkQFA3kzBSg
KbYw3xAAqmVQNhipNdgNc9uvqAS594wbi0zVXZ8vFS4xAklaG28qdwhqnh67w6ev
CnQdwxtU0XUPgSUvUcx/TWSpTqWF/pGyGiKpKAFZjEYntgDTMPA3LwItRBsAVrhW
z8v8Hoeq1UBUga0P7o++LNC5N/4IWiDJ/2rjomW6GsR9ubcvh+bLKXxtMQoNInNU
hU1eRMCAnnZhkTzUQs/1ckcbClub5q6eCDm+P5PqQhhDMLlAOgKlPjkUrjqrRxFK
glrx+nFDNN9gKyb2DsO2fp4ngIXFWz9j5ajasBIqiTwy8Bto1hCv/eP8p2NgQ3xm
tszMJrv1JCsxwNqwAAaRfejZmWaE1mA+kRdKoooE51bwqrpmRd216IWIGjhJSXTX
JiYO0LoGTTrw+uB0AziFbXLZsBKO3EHsx1acOHyPBaSjz7rOQDfgSbAMa7Im6vBW
tcj8SQ93x3jdoTnqN/6/xqPTqyR7WF2GeJ0u5t+wHuvc+5sT6lJkXL10095qR4is
C6Ux2JHjizJoJMLD5B+OiVjNWewB+J1b5vuYa5gQs0cBFeEmbUE8H08H8QIRreJM
efQmbShjMgohs44YjU5EHp6ofBA1D9bH7X3Q8ciK43zvdQrSCxd/WDXUFucIbMen
lDmnEeZmw1bf7p108qI9Y2d6zQ06pKh+obuAAwSm3EpaDmiBLr0=
=diQv
-----END PGP SIGNATURE-----

--smjbq6gp6e7bfkkm--
