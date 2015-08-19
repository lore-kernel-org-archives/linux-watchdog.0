Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33091 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbbHSKKo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 19 Aug 2015 06:10:44 -0400
Date: Wed, 19 Aug 2015 12:09:38 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Pratyush Anand <panand@redhat.com>
Cc: linux@roeck-us.net, linux-watchdog@vger.kernel.org,
	kbuild test robot <fengguang.wu@intel.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	Andreas Werner <andreas.werner@men.de>,
	Barry Song <baohua@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	"open list:ARM/STI ARCHITECTURE" <kernel@stlinux.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Kukjin Kim <kgene@kernel.org>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"moderated list:ARM/U300 MACHINE SUPPORT"
	<linux-arm-kernel@lists.infradead.org>,
	"open list:INTEL MANAGEMENT ENGINE (mei)"
	<linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
	<linux-rpi-kernel@lists.infradead.org>,
	"moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
	<linux-samsung-soc@vger.kernel.org>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	"open list:WOLFSON MICROELECTRONICS DRIVERS"
	<patches@opensource.wolfsonmicro.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH V3] Watchdog: Fix parent of watchdog_devices
Message-ID: <20150819100937.GD26627@ulmo>
References: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
In-Reply-To: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2015 at 08:58:24AM +0530, Pratyush Anand wrote:
[...]
> diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
> index 30451ea46902..7f97cdd53f29 100644
> --- a/drivers/watchdog/tegra_wdt.c
> +++ b/drivers/watchdog/tegra_wdt.c
> @@ -218,6 +218,7 @@ static int tegra_wdt_probe(struct platform_device *pd=
ev)
>  	wdd->ops =3D &tegra_wdt_ops;
>  	wdd->min_timeout =3D MIN_WDT_TIMEOUT;
>  	wdd->max_timeout =3D MAX_WDT_TIMEOUT;
> +	wdd->parent =3D &pdev->dev;
> =20
>  	watchdog_set_drvdata(wdd, wdt);
> =20

Acked-by: Thierry Reding <treding@nvidia.com>

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV1FXhAAoJEN0jrNd/PrOhYu8P/300DOBiprLU0lK0vh6o4tMh
F9zoXKnCSLxaBeuUq4jEMFXPVNfAzEwEKGKQ/xnzbzH9o8hY6elDeifb9IC3T7+v
AqzN2BsF7IND8ZMaw8ZQaUzRMZ6klPZylurE71WoT0+ymIgY1H5F0hphA3qJN2x0
A1cNodJb9PW8RqKttBr9MjJ1JlCjSfvQbYW1FWBBYanSjv8OXWBibdEtBDHYVOUs
ALk9FkBZcWQxPTJvnlzBMO5JByDy3/iBvZZLg+twpnYm93S4KCtdib5M0w7cKyOe
vlPCNsFzNrlAAOTVIG9HWZoKPdqS9pJcNYEEaY2n+vLkpxuuTYP4B5Ppj11Sv4/O
ES98mtVg5H7etIeJcwXjJDLbe18xp/ZcjBApVILs8MmGkN/NKYgwBC0yDEcHAGUk
j0GzxHi/BDO6FjjIbkXSCP3MhLXMTXQsvknRCwkoJC2Z2JDgKnlOsqJ2JUnGQNbM
b1UQCzvvx5VD3a5z2rVOhNAE0zOcQk/bwEdFypv+A8iHXbzGY5RSBBIXgt6KeGuO
Sx69YOcfoMPvModaAZLF7PKn3o3XVCPopzWpgWmnLQA7Hun3e/txChtoOCC3la3B
VPeiP6FIppi6eGa2DkP/w6MXPP+RHLqJfWvROofYxAkRrUPXNIA9yOQ84r3XQWVE
J/uoqai24XDFAAAZyykW
=N2dJ
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
