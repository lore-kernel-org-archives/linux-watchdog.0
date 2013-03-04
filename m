Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:49453 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab3CDGyE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Mar 2013 01:54:04 -0500
Date: Mon, 4 Mar 2013 07:54:00 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH 3/4] watchdog: davinci_wdt: Convert to
 devm_ioremap_resource()
Message-ID: <20130304065400.GC16261@avionic-0098.mockup.avionic-design.de>
References: <1362373604-26771-1-git-send-email-sachin.kamat@linaro.org>
 <1362373604-26771-3-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <1362373604-26771-3-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 10:36:43AM +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
>=20
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/watchdog/davinci_wdt.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wd=
t.c
> index 7df1fdc..100d4fb 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -27,6 +27,7 @@
>  #include <linux/device.h>
>  #include <linux/clk.h>
>  #include <linux/slab.h>
> +#include <linux/err.h>
> =20
>  #define MODULE_NAME "DAVINCI-WDT: "
> =20
> @@ -221,11 +222,9 @@ static int davinci_wdt_probe(struct platform_device =
*pdev)
>  		return -ENOENT;
>  	}
> =20
> -	wdt_base =3D devm_request_and_ioremap(dev, wdt_mem);
> -	if (!wdt_base) {
> -		dev_err(dev, "ioremap failed\n");
> -		return -EADDRNOTAVAIL;
> -	}
> +	wdt_base =3D devm_ioremap_resource(dev, wdt_mem);
> +	if (IS_ERR(wdt_base))
> +		return PTR_ERR(wdt_base);
> =20
>  	ret =3D misc_register(&davinci_wdt_miscdev);
>  	if (ret < 0) {

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRNEUIAAoJEN0jrNd/PrOh9REQAKkrm2+o8HRj5lrT2pDPeW20
hLALyfjyasH9Wu1ELkjb10YYvySiZq8SF31mzRvzkDMSuEbI4AIUa5mE7buJhaei
SE7mfWTnDarxcaLttDapodD3P5wBba5K+z0mNBp382DXH3TAVfabGKnmLf5pqdPz
oRyxzzyoi2v9C9pDug/Pe75Fiz3oMeQwNKMm2wu1mpIf761N/kckq1xSaww9BhGT
Ca26mBfChOSLZPRLeWYTHxjhYjvi6wcvzzbh78aQL8NDKPuSmXguRrYNe83PUVGS
UkZVytN4FWUPRTfL6a7sppFTOeoVP/e2EgCxjTG4dQMnMBeiglmD20s9t9E+v/Jt
RlKU2CGlSxcQSXuAnJ94OJQBnbyaHe3CtSdeJwIfOFfn7TTJL49EXOaDV8gHDdUK
al1fEDCWhYRtD5t9mqMfdh8t0X9Dqe6ubuM8di1joGGdSnAHOOjv5N42T+DC1s21
SBNoAhESlyNmeFsPGnWkLXxEUQZH56oLeTlT0s4x0TGvvUgAy1EBARG3aWWU6KJO
sQ1Bm67o26iwwG/+lAGMLinYGQXRUgskOlc5aPHiL7m4NNdDmyokfrkqHEbP2W4i
hWyAYLnTheBKkLNr97EMuudDBb1gBLxg8MuUhnFdlO8em8P0akRjmd6hM93BwlXy
mBfFZne2Hnp2LelLfn+I
=KV0K
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
