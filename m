Return-Path: <wsa-dev@sang-engineering.com>
Return-path: <wsa-dev@sang-engineering.com>
Date: Thu, 8 Feb 2018 00:17:02 +0100
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
Subject: Re: [RFC v4 17/26] clk: renesas: r8a7790: Add rwdt clock
Message-ID: <20180207231702.4e6kzyddzi5nyfuq@katana>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-18-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ohc7ewrxqim5dlf4"
Content-Disposition: inline
In-Reply-To: <1517423070-24236-18-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>


--ohc7ewrxqim5dlf4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 06:24:21PM +0000, Fabrizio Castro wrote:
> Add "rwdt" clock to r8a7790_mod_clks. Also, since we may need to access
> the watchdog registers at any time, declare the clock as critical.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesa=
s.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ohc7ewrxqim5dlf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7iO4ACgkQFA3kzBSg
Kba0sg//ZiqvkxGuqd0reaNIc0/8qp6LCxyWq8dEcMqc7WbhG4GHYIrCtNSTT4RG
S/LigsDl+K/qEs278NRPSue8K3c/0hjoIzDL3tkcrxSLqFCpG31mmt7uUAZZJMdx
grOVuSgjNRhcdx3H558z8tZQbvtQSv8Cee8lKEDUB9kEC7XFnfHp+DTDGin3wMyn
p8yP7W3BTaUN3sgduHvayzhB9LCigOaWpFXJjGHjHnTVPmQAJMNz1dIuu4vFbI7D
K3NiU2O5GJ5NDMp6THVbJmpjFNgGeIO1SKQpC73p8MhNALWinyCoTe7/7HMsIGb1
cqftKVlS3esFtH/3/Cw7QwygOXI8KnGWV2w0LvCIipAVv2kIDqWUL/DK9gLlWjYn
UnO6haj4RwNDb9FGGr1JmMSwneDChrNReJYM8LnLketuaIMSV40hqqJ0pWMQWeVa
S1yc+WyJRBQr57/Bqj3H6C3iY6CF+4CdrNQyaE4qtBnsRgk7lSMOBc2jYxznGLrU
f6NBi2QxlKCdeG6t0mgAWlcucms0lnT1kKx1d2T+dFUcBfXSMVoD+LVOyqjSzQZv
zu48fU69rnqMDb6kjnmv6seck1lz+VhU+Yfb72xCNd61Wg7BHVA0m4Kldojz0wm1
pdG+MvdgyyTySdT08XrYvs9fB4nDPBZtqitoaw51F9qmLoPqf38=
=Qp//
-----END PGP SIGNATURE-----

--ohc7ewrxqim5dlf4--
