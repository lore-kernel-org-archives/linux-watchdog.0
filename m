Return-Path: <wsa-dev@sang-engineering.com>
Return-path: <wsa-dev@sang-engineering.com>
Date: Thu, 8 Feb 2018 00:16:52 +0100
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
Subject: Re: [RFC v4 16/26] clk: renesas: r8a7745: Add rwdt clock
Message-ID: <20180207231652.4rr5xuazarh7lwml@katana>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-17-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b6h7wdwfbvkfq6zs"
Content-Disposition: inline
In-Reply-To: <1517423070-24236-17-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>


--b6h7wdwfbvkfq6zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 06:24:20PM +0000, Fabrizio Castro wrote:
> Add "rwdt" clock to r8a7745_mod_clks. Also, since we may need to access
> the watchdog registers at any time, declare the clock as critical.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesa=
s.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--b6h7wdwfbvkfq6zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7iOQACgkQFA3kzBSg
Kbav1Q/+Pq0nxXVmD8ouZLqlkab4XbW/KsPGA2K1LZWPYGmS+/b3d5f2DnL6ZAFJ
wrFlPlhj+TR6e6xXb5C/Ycih13rFXrmkV/getxWSnizDWRFGE6/4vOFbwLvAh0Uo
dydYbx6nq8FvQOLttz3Ag4TFBeYd6Ck0Jr62ak/Ggu4SpGVxLYtfyvs0/+j/rm/a
dwhQ8OU83jqeO/ccVlWxtSmNAuw7/FXWjCJprD0IsiXSPr3d67cFcU6Pwg7+y8zj
thQjg2gIEbTlrA+V1UOUgQ4RR/ZvwjZZpJjEfHG8vZ3sYZOmffokEWQ54q0PM9Rw
bckDaSEAS4840D8xgBE2ow+g+n1+zifz3KYuM2UdJL0emLB8p7ttlnHB9zKhmfYa
L6HY8DYy7WeGGlMpzILMbEtZBRnU7w91sVn2oIXzIzTNWjyG0U5I+F3XZj/XMNnv
uflv+/eknWVVCye0fFXXREsHFx51YfXjty+gpFRlNAcWY5dDROCyuYUZIsGJagqK
mM/XMbAiLlm1ueZvzI1poQnB6zKR/C0Hy5Lw7PFKEDXGFUiKWa5UZQdPMbn8umJF
v+zo3t2lQL4bTJAvEQf7LFkoz7Nehy7MECTGa+Kugud4ctveB6LL0ggmJme3LEnf
lREj8bnnql7e9zE/KmCuQLWVvarET6sAcSpFhMM2WfID1QuMydA=
=5N09
-----END PGP SIGNATURE-----

--b6h7wdwfbvkfq6zs--
