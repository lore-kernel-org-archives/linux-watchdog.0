Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64629 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab3CDGyd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Mar 2013 01:54:33 -0500
Date: Mon, 4 Mar 2013 07:54:23 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be,
	Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 4/4] watchdog: shwdt: Convert to devm_ioremap_resource()
Message-ID: <20130304065423.GD16261@avionic-0098.mockup.avionic-design.de>
References: <1362373604-26771-1-git-send-email-sachin.kamat@linaro.org>
 <1362373604-26771-4-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <1362373604-26771-4-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 10:36:44AM +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
>=20
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Paul Mundt <lethal@linux-sh.org>
> ---
>  drivers/watchdog/shwdt.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
> index 6a89e40..6185af2 100644
> --- a/drivers/watchdog/shwdt.c
> +++ b/drivers/watchdog/shwdt.c
> @@ -34,6 +34,7 @@
>  #include <linux/slab.h>
>  #include <linux/io.h>
>  #include <linux/clk.h>
> +#include <linux/err.h>
>  #include <asm/watchdog.h>
> =20
>  #define DRV_NAME "sh-wdt"
> @@ -249,9 +250,9 @@ static int sh_wdt_probe(struct platform_device *pdev)
>  		wdt->clk =3D NULL;
>  	}
> =20
> -	wdt->base =3D devm_request_and_ioremap(wdt->dev, res);
> -	if (unlikely(!wdt->base)) {
> -		rc =3D -EADDRNOTAVAIL;
> +	wdt->base =3D devm_ioremap_resource(wdt->dev, res);
> +	if (IS_ERR(wdt->base)) {
> +		rc =3D PTR_ERR(wdt->base);
>  		goto err;
>  	}

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRNEUfAAoJEN0jrNd/PrOhXu4P/3LVDHyuliSseoEwkSC+QPFN
VJ2Qn/dxZmAbnqk0yK8mlJQNtvVtoeXumPuS2Q3DzZYISn6ioHAG64M+qNqG1YH1
Zfg5bHkiGjr34psgVNuuwpXSqcukMAS2tJSTwdUN0it3YbhnT1Ef2WwD2YM9Hb9a
JFXB5AQoEbQPepkHGTgVDVg6/oVJBqE7mE0wVl/NDQHD6AP5nYt2gYdQ+ZjDu+U+
uB0EaIyJiIj4SoAZVPq1VhUdL6HbPVH24KZdkPWHCgxyMPKMehjRujWs7Z1Ag6gQ
C6Gd2ekoR0pMHr/d2EbzrzDySqfJiXzZodK0suwaqyfGeDofEXSa2QsTyueXB4s0
qObPAq072h69VVF6Sioz+O9nrkjnwBa7T/3tu701BjGSPYSvg1R7pitdvyleqL9T
d2FDk0zFybxCuOmKR64fScpT0TkzsdFrgyRwWsiwpTw2U9Xrqy2M093p5MjPIGaI
nzATyknb+04M1cP17fuxCqtSkHcdWdNgnx81t9u9kErbiuOJ2H4OxzO+uSgy4Usz
gge0Kr/gPRhw1IbMnpkBrHUh+sGuC/nVUwGYXiTL9AXKnrHFy49ZlGkRFBnxhnlO
mDgCiqtEAO5ne5xOsrcAYSOL4OU+pLsal+2hcKPVASHQOtrn/U7fTwx5B4mLVCwC
JRghkJStYN+qWDMAUdHE
=27gr
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
