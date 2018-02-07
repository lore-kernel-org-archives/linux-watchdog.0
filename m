Return-Path: <wsa-dev@sang-engineering.com>
Return-path: <wsa-dev@sang-engineering.com>
Date: Thu, 8 Feb 2018 00:11:56 +0100
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
Subject: Re: [RFC v4 14/26] ARM: shmobile: defconfig: Enable RENESAS_WDT_GEN
Message-ID: <20180207231156.3o2eeymgb7eec3e3@katana>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-15-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ghjh2tvtbi7qarpp"
Content-Disposition: inline
In-Reply-To: <1517423070-24236-15-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>


--ghjh2tvtbi7qarpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 06:24:18PM +0000, Fabrizio Castro wrote:
> R-Car Gen2 and RZ/G1 platforms come with a watchdog IP, therefore enable
> its driver by default.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesa=
s.com>

Given the rest of the series works (same for the later patches):

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ghjh2tvtbi7qarpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7h7wACgkQFA3kzBSg
KbbNhg/8CA58qpPJ8IG15ptynCnCyyFcFrz0ljGiJXpGcuL2MI1FBxN7gPc1BsqE
kFOghwLAbv/meyZ4JjU1YjPMGm2Iqed0JAs1563VScCL0uoaCEjTo7RZnWTs1AFa
x+fY4OQIpr4VqenJRhak/fGx0l8OPcgetXUoaSNyJzj3UWeLnDV2738tB0F48ggT
RjKJdZguE/UmPMewIGUoyCgeS4U4qM7IfoQrygh1Phdg8Ia9rYlCW9oXb4ZzQdy8
FPu5LVRlC8wHBccXiKuwmQxgDMp8Ve9NgTLVMSXAgckFv+WW0brqcUkMJrGPzGg8
W1tlVq+8w2hNf/Kw6ZvjAAAI2a7315P4t7rn78AdfVu7oDHEYZimdJ4BobANDQ6m
m41Jx3I85T5EtDiYqk9rWJ5ZqD9j8C3NJ3AqwZjfFsoiUV/gLjiEC7u71boy48wc
YoDjVTyNhZCoLtljuPJTojSoZTwoNzCpd80wI+HqPzPxqph0m1ah0sufvY7Izpj5
4/NcPErVPFL0g2VHx7fM7IHJRMS05V1yEcvA34lM78hJE83l7oYmnSGM25vy4RYI
b65K4T9iKFpebv/EbJ82f7tWCEikdUvvjNaJEDh1FLX1S5yBOKml/409vG9aMQvF
PoILsfiOq6tuvDySZmWnwUsshqZQjW4rrwGHYLLuadOAgoAQ0os=
=krTo
-----END PGP SIGNATURE-----

--ghjh2tvtbi7qarpp--
