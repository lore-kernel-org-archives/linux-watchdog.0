Return-Path: <wsa-dev@sang-engineering.com>
Return-path: <wsa-dev@sang-engineering.com>
Date: Thu, 8 Feb 2018 00:12:06 +0100
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
Subject: Re: [RFC v4 15/26] clk: renesas: r8a7743: Add rwdt clock
Message-ID: <20180207231206.qnbl65q5i6op4xyf@katana>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-16-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rj5j2e2ok6ailfye"
Content-Disposition: inline
In-Reply-To: <1517423070-24236-16-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>


--rj5j2e2ok6ailfye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 06:24:19PM +0000, Fabrizio Castro wrote:
> Add "rwdt" clock to r8a7743_mod_clks. Also, since we may need to access
> the watchdog registers at any time, declare the clock as critical.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesa=
s.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--rj5j2e2ok6ailfye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7h8YACgkQFA3kzBSg
KbaILw/+IL5ScSSxvY6meNrlN000GcskdNwb7/3LsSHRfMjbMUIjWVXmZgLD3TLA
l/DuMb2zTdpp+sqjE7t4feP6TMonOusAzkSctdQEWqe0DYfW/Fbkips39pk/sPma
AoyVw+SVLitwrG9oG3E328IV/7Jk7SDTNjsdOjBgh9WQGg1hACuBbLjFtAM8jiC8
xFvE8qB9lOPXkXfQTjPGufvUzYtVFNXnSZ+AmmAyfM+tLJwE1W4+Clu4Z2ds4wDM
iGRWPOgDP0+ldcRBP1nPWfGN6gWqGu4bSdmYlG/aY3hTQzNLLuNCczAEsOy8PfdR
axD2A+OaJefxBlJW93SewSHOc1hMrKyfnyXkIjw4fjWtXgm9vqP0T7Tq/cZ7RPzR
VPndlvmIRVgGtVPTIlxvEl3eUqmrbEiTZz46/3YXF7ywakTrH/38R/q6mP+flGqb
wA55gflRXlfcy77sfV+E3F3wZgoaGP6Zd6ppdZFkH6D/5iV2yYciXQPpjo1y7eqy
uxQUZr/K66pPpK8yplNkcly2Yt6jAwlkJhDqaKGqPATRYmGauvomW2knDLZa/ahM
hsDcCnK3o2Be159cqcNr+T25AMKrSk6q1u/IoVl9SnhWhZl9IQplaMYD7YujCbzf
H1jabvmL1l12nfj3n8tiq0CadtzaXNjNSaLQ+Vo1LlhSHaoHbhE=
=TUQ+
-----END PGP SIGNATURE-----

--rj5j2e2ok6ailfye--
