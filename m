Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35603 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754089AbeBLKy7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Feb 2018 05:54:59 -0500
Date: Mon, 12 Feb 2018 11:54:56 +0100
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
        Guenter Roeck <linux@roeck-us.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: Re: [RFC v4 13/26] watchdog: renesas_wdt: Add restart handler
Message-ID: <20180212105456.3zejp3j7hfuzyc3c@ninjato>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-14-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180207230309.goxig2irkpxrw5el@katana>
 <TY1PR06MB089578618AA33335D90D16CEC0F70@TY1PR06MB0895.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f3tafwofa62vw2id"
Content-Disposition: inline
In-Reply-To: <TY1PR06MB089578618AA33335D90D16CEC0F70@TY1PR06MB0895.apcprd06.prod.outlook.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--f3tafwofa62vw2id
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I used to have this simpler version (back then for the UP case):
> >
> > +rwdt_start(wdev);
> > +rwdt_write(priv, 0xffff, RWTCNT);
> > +return 0;
> >
> > It should still work probably...
>=20
> It should still work, but it would be slower, I would stick with the
> version I have submitted if you don't mind.

Actually, I do mind. Because of code duplication reasons. We have a fix
in the works for rwdt_start() and it would be too easy to overlook the
same fix will be needed for a restart.


--f3tafwofa62vw2id
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqBcnwACgkQFA3kzBSg
KbYEIRAAmOdgWp0j0/mBjoenLahP/pw4rrf3wp/UyGmPh8RA/4JfoCsiAl2yP5Ub
xync2FvlM2HaScGRdSAhn6UlufChmQMXRw5X+5O5y/Td7Yl/pB/O2VNtCqbsMWUN
vpbe6vIqLwlTbeYX+zbhOhE/L8bx/DSDeDPO90x3jRVwk7t/kjA/LjJSgGXjm0WK
bJwpDWinVEuxctTSn5v9AbQtzHtpGzf2G0JN9vz/ceCSYz5dTfqxngpG7DE5PpyL
ZP9D2wNqqBzoVo60E1ikjrgXyDhIaKI3i+3vwMf6pvnL5gtjLG+x/5TOC2GI0muN
5Dez0IYPFgqmcOWD8/pXw9btArlb00Rns8FxUnzGxRRd/IZUihzHZ98lO3fVBGDX
x46YY5hMBAJiwvzlpTgSNsf4PQs6KGh6TuU28uoTKJnaUL+KWi9mH34LUZeZCirJ
RRoaU3S1d+hRph/0ZMye0CIr2I9cxMCUFYeYrHK5+YVtzI5JsYuD9T2s2GHi16al
K4OGIY3LQJ0c15uZFVPanPiMb5M2HEKB7W4bWzrppDyp4aahI6ZQpVVyMWk20Fgp
smnla6hBdux8C+nIkTITFHoM5E/PO0yqaY1T4TfGx0l4ULCHwtQz5ieoICMloa85
8esy3pSGmpTsW6xzn3Kaz2KPTmAjhZZnWOvjmK6x58+SwXUUS4s=
=o399
-----END PGP SIGNATURE-----

--f3tafwofa62vw2id--
