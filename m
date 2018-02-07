Return-Path: <wsa-dev@sang-engineering.com>
Return-path: <wsa-dev@sang-engineering.com>
Date: Thu, 8 Feb 2018 00:17:15 +0100
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
Subject: Re: [RFC v4 19/26] clk: renesas: r8a7794: Add rwdt clock
Message-ID: <20180207231715.r42l7aekecwszeqd@katana>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-20-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2ppkhvycs7w7moi3"
Content-Disposition: inline
In-Reply-To: <1517423070-24236-20-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>


--2ppkhvycs7w7moi3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 06:24:23PM +0000, Fabrizio Castro wrote:
> Add "rwdt" clock to r8a7794_mod_clks. Also, since we may need to access
> the watchdog registers at any time, declare the clock as critical.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesa=
s.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--2ppkhvycs7w7moi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7iPoACgkQFA3kzBSg
Kbabqg/+PRinXdRPLN9NnawvsTfFj6IjK5Nou7kfTGjvbEMRZMhZSf4fOwB3Df73
O9Wsc5kG9fUC/R1qrSl+H7wQflfGazbY9WrwUjfH0DTcdbFFjnLgjiZg4S6rzK4W
OV10rOnayOQCcb3H8UwcjLgk3EZkAfY85vC+T22LglEH9larVmP+EoTpY0zRDb2D
Iuv0QAuj5VThbIYacFzPjVpJ/S+WnJqV76mPJw8w0i4um3sG4BlV6FSNC0Lvvk7g
DRpOmilYt91bPzLk7OzLwnbnlR3aLlau+w2yqQur81IZbPWqXVrHhzbJ0k1hDuxM
RRnH82zlXm/RFirnDOb1s8mut5wRAm8jOy+CT9f1utBI6/aKjIdH30VQGm1khfqP
HovodgbD3Veh9bQmQYwGV5woh3/lmkTSKcndKII9pWDDqAcBPI1Wr9qquupQkp3I
MQpY39rhioCi4Hkyea3ctnU4xrdzujcDw94QZNp4KcX2S3/EzlFJXmOEHSstrp5B
iN/zuEurQyNz44voI5PsY7NYm3NaSxbIiOld45VbWZLrfAKo/ii1FFpVsvvDp3IY
joIHI9Gqq6GJ1ITDuMk9jSeH8IC6UzfwK4VHASIxSEANSaRXKuqLI+uasFgS1mh+
8jQwfQzbfIjV6MoEmBeOn6yFmcqUe7pqETe484HqyFAiYyQRVVY=
=kbA+
-----END PGP SIGNATURE-----

--2ppkhvycs7w7moi3--
