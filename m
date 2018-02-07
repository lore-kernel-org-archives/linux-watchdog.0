Return-Path: <wsa-dev@sang-engineering.com>
Return-path: <wsa-dev@sang-engineering.com>
Date: Thu, 8 Feb 2018 00:03:10 +0100
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
Subject: Re: [RFC v4 13/26] watchdog: renesas_wdt: Add restart handler
Message-ID: <20180207230309.goxig2irkpxrw5el@katana>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-14-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ii2okpc4xrkcaei4"
Content-Disposition: inline
In-Reply-To: <1517423070-24236-14-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>


--ii2okpc4xrkcaei4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +static int rwdt_restart(struct watchdog_device *wdev, unsigned long action,
> +			void *data)
> +{
> +	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +	pm_runtime_get_sync(wdev->parent);
> +
> +	rwdt_write(priv, 0x00, RWTCSRB);
> +	rwdt_write(priv, 0x00, RWTCSRA);
> +	rwdt_write(priv, 0xffff, RWTCNT);
> +
> +	while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
> +		cpu_relax();
> +
> +	rwdt_write(priv, 0x80, RWTCSRA);
> +	return 0;
> +}

I used to have this simpler version (back then for the UP case):

+	rwdt_start(wdev);
+	rwdt_write(priv, 0xffff, RWTCNT);
+	return 0;

It should still work probably...


--ii2okpc4xrkcaei4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7ha0ACgkQFA3kzBSg
KbacvQ/8D8XYr0uC7zXPoAzE+CXEN7xox41cu1uhV5RPnDWwkmI/jHoVq9STySZB
ifUMM4hsbFUgeKnmZ+viMxa5tTKSj9at6WiUeyQ+K2rkhZ0Sqkmn3O7RFuyq0pf9
o52ysxCWQuch5ep/lj4N4O7aUU1nPlPIimX7b8QgaYDxYvVqdZSBhYymwhN+0fZB
X1uf+PXlzIxVPNKV7R0kg4yX7YdDU90S6jQ94szgGH0n+0y66K/ImeFV5eKeKBhi
jZWbLwt4+q63D+6r6vZBViJ1xivkiwe8mcAsth0ZyxLKEsqUSCJZkTU+l3XSN6dP
2BemCvP41GCTNDsxbrXMLd5X0YnXSV+PLJ+QZH2DggQTIu7ytFCfm6KLXVc9evx7
AVX6DnlbAXzuKOewB8Tx356P17p92EMQ9Qc5i7KbrUmpjoNPoNYpO+/6j/9GwvcQ
A+kYJUhK6QOcTvRWIY7JqOt3cz35Hn1TjBdqUEux09mG2f3fvdSHfALQM3iCM3G0
yjRkmk+EUx2zzD7p3LB6fAzG21ggcLLKD1h/oy4u0INM2bu+393YzK5uHgbWY+PN
X88AJZKY0cPvG9yT7QVRJ10MhaawGE6ohiNo6NfLtbZHrjPgYV6bM3/bfxGSXqrH
turo0tDcQr3fllKxAP4B8WbCS9vj1iNTnWRY/8yZhPQbCYrHsZ8=
=fuGM
-----END PGP SIGNATURE-----

--ii2okpc4xrkcaei4--
