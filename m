Return-Path: <wsa-dev@sang-engineering.com>
Return-path: <wsa-dev@sang-engineering.com>
Date: Thu, 8 Feb 2018 00:17:08 +0100
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
Subject: Re: [RFC v4 18/26] clk: renesas: r8a7791/r8a7793: Add rwdt clock
Message-ID: <20180207231707.3caruy3zp5rnvebv@katana>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-19-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zcki4zdcdy3esctc"
Content-Disposition: inline
In-Reply-To: <1517423070-24236-19-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>


--zcki4zdcdy3esctc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 06:24:22PM +0000, Fabrizio Castro wrote:
> Add "rwdt" clock to r8a7791_mod_clks. Also, since we may need to access
> the watchdog registers at any time, declare the clock as critical.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesa=
s.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--zcki4zdcdy3esctc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7iPMACgkQFA3kzBSg
KbbpfQ/+O5orwvj8IimES8Emd6JKNsSEI387lSOlNKExT1lmxdbjLr6rcy5czrkV
VFphBrVAj+a+s4tXeJ55/FWDBg3b+HgkfgiruqnVI+oHs4BPonATjd9y5UngNgps
VM+MmYke+Gb85LznkxJQ++ePDNzgfEWUII/R37e2fWn0r6T3wg29KV4qX2X/vbqv
xHIPByMQpC3AVa/9mNRkPenEmOUsWlyfxPRrNw/XdKycE6keIGzpEDZqPy50Nixk
l/j2GACVPa7qjVkW8d3khgxAEu7NeVdovcZ+tNyOq6qjkGimeYZqniOxt1RE1Hln
sj7fmT4nrc+4EBywsvmQ4lNWyzGiQStgJrEOUteOe5XGtt0gSE6Eb/WEo25OBFpd
vAOCuVLhNvDCX7ol80aS7/CkzwWq4+WySe5Kgunbqno6I6b81d6kxob48SAAMluU
xJT3sLZGk2B1SW2f6Ec3lOGNZf0ZIXlDyAH4zfODhhMi7RXGfofJIq/aOp0N/xf4
X84PFrkXxpUM2AjKaWyRW0rM3UBzKVhPCvMJV/xsIcg1nqNCgb06dqvK1ACxUgd3
0+7D2ObVAwMkjSr9QFOv5sqBl2El/MK4RIQ054hBvIcJErzVzrBLmqTacftRKlh7
9m46pJyZp7GXsJFE3cGetd/X8cWfV7DW9YkHA6D3oYRqQFtJPyc=
=2zxp
-----END PGP SIGNATURE-----

--zcki4zdcdy3esctc--
