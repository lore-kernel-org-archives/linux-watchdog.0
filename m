Return-Path: <wsa-dev@sang-engineering.com>
Return-path: <wsa-dev@sang-engineering.com>
Date: Wed, 7 Feb 2018 23:53:56 +0100
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
Subject: Re: [RFC v4 12/26] watchdog: renesas_wdt: Add R-Car Gen2 support
Message-ID: <20180207225356.pgirh2ohdsv7xdne@katana>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-13-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x2emqnqh5zo5pl5i"
Content-Disposition: inline
In-Reply-To: <1517423070-24236-13-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>


--x2emqnqh5zo5pl5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +#ifdef CONFIG_PM
> +static int rwdt_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev;
> +	struct rwdt_priv *priv;
> +
> +	pdev = to_platform_device(dev);
> +	priv = platform_get_drvdata(pdev);

struct rwdt_priv *priv = dev_get_drvdata(dev);

?


> +	if (watchdog_active(&priv->wdev)) {
> +		rwdt_write(priv, priv->cks, RWTCSRA);
> +	}
> +	return 0;
> +}
> +
> +static int rwdt_resume(struct device *dev)
> +{
> +	struct platform_device *pdev;
> +	struct rwdt_priv *priv;
> +
> +	pdev = to_platform_device(dev);
> +	priv = platform_get_drvdata(pdev);

ditto

> +	if (watchdog_active(&priv->wdev)) {
> +		rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);
> +	}
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops rwdt_pm = {
> +	.suspend = rwdt_suspend,
> +	.resume = rwdt_resume,
> +};

Use SIMPLE_DEV_PM_OPS macro (see stmp3xxx_rtc_wdt.c for an example) for
more compact code and...

> +#ifdef CONFIG_PM
> +		.pm = &rwdt_pm,
> +#endif

... removing this ifdeffery?


--x2emqnqh5zo5pl5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7g38ACgkQFA3kzBSg
KbYnog/7BQsY8nwc8noFCm8FP2wPZmQ9mkLXkMz+xpFBzL2RJh5V60jwNfYdgqRH
523vlZJ7oJ3vFiOie5A29Xk3uQ6z9hybRyfoqEkdhTRV1GIl1iS4nZGzB5vuFHAb
sEaRyH4CfMOjpjlFNMoylJXNvqZO3SyIv/9JfNG0xTDTOOL2OabCgqo2hKC3qkfw
XFx2E/+UhGUXx24AjImWjM1u/98j5iubpXUqgML/N+M3youIrXloYSPjQ1aORSQR
zDuhk9H5WXcVUiyyyEzV2uC+rptqkoJAybYLjWM76rrrQRgoCw1Q68f3/aOBVza0
truSbQArJWKRMhjuW4wxdHeWlvEKlYfu2pHCB9lf3DScR4iW4DmaTtpQKiu9eUnm
/3V9Bs7345dpGf1sbtgIhMfGzDpKpM8xjNHHzsWMqAE9+kGVxgl4TouEedDh7t4Q
BkbgTKHcvaktebxXkCNeQIHrxqYAHGmySfZZC4BrsUtfJLX5yr72/SKT8LGpCS7O
5kpoil1jTz1Vkgx9l7c3tfTG4eX7p943dimpvr8K9MBUodCJAbsrzd/Wx446N8bx
1BX33C7EAJAmi9MWWWIUnTTLW2vwaqBJhiUDqKCcPI9N6jX1asgrPOITF8qxWjEW
oRuePWinnSbLgiU7Z/hOu0vVzftkQAHKbCqLw7wv86CZJBhY9hg=
=oLOg
-----END PGP SIGNATURE-----

--x2emqnqh5zo5pl5i--
