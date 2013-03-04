Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61924 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365Ab3CDGxM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Mar 2013 01:53:12 -0500
Date: Mon, 4 Mar 2013 07:53:08 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH 1/4] watchdog: s3c2410_wdt: Convert to
 devm_ioremap_resource()
Message-ID: <20130304065308.GA16261@avionic-0098.mockup.avionic-design.de>
References: <1362373604-26771-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <1362373604-26771-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 10:36:41AM +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
>=20
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Thierry Reding <thierry.reding@avionic-design.de>
> ---
>  drivers/watchdog/s3c2410_wdt.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wd=
t.c
> index c1a221c..ee03135 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -330,10 +330,9 @@ static int s3c2410wdt_probe(struct platform_device *=
pdev)
>  	}
> =20
>  	/* get the memory region for the watchdog timer */
> -	wdt_base =3D devm_request_and_ioremap(dev, wdt_mem);
> -	if (wdt_base =3D=3D NULL) {
> -		dev_err(dev, "failed to devm_request_and_ioremap() region\n");
> -		ret =3D -ENOMEM;
> +	wdt_base =3D devm_ioremap_resource(dev, wdt_mem);
> +	if (IS_ERR(wdt_base)) {
> +		ret =3D PTR_ERR(wdt_base);
>  		goto err;
>  	}
> =20

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRNETUAAoJEN0jrNd/PrOh464P/3WGaBxjto1UgWRbLcnUwBxX
LafEh9BhtwQWKUd7kt96wCXNmrcRcY2L7hrpsBCrVra4w2gwh48guiNyEdLfGydw
LXc1BegfOBizDgHsdbuxOATpn4SSbWUwv9P7/zXMJsHlNCPRUjQjwDMoB0h5KNJV
8hO/l1XNH3TJU1RnXZu2ueUtnRBmu9g4UAg0ueOjzP4NuyEiefbUFFoi78py4gWe
pdjNfROMlhpOYzU7KhId8ENTeSy/CvqoSorwv8rAR/oiY4mUr3/Chyx+cny1+UdY
ikxmzIK68r/wixsa/qVnbiv+X1EDg94qfjyJKgu2SAEZ/5eYKvN5/C1U9Hd50AsX
uNcimKmWhbT72DYhTGi6iHHBRgdveH7UYBdVCadeuS7TTF1oEoNAZDygbg1CdmML
bfWF0M+FGWKqmbcwwcii2K7q2zxkSceQYA9/+kY1vBkKLCIH4Y/YpYOZVWn/x8RI
BiB2xtg9SW64BhvB3zYd93RI7FuIaWwfwXE/YM1HHm37fZc/XPGhU2k21MIRHwB3
CnbOhTgdYKoUQlL4MtzpQjx/LU/zE662DZTUOYvvAsi3P+FnecjwqTLZgEpKxlf8
kt26ylM3k6eehwFcy9121ZFdS2wzkOuaDgbt2e3d8NI3+88mdbl8E8YaLV7Jdx78
GR83fWy8VJ2+J+6ti3X0
=viXS
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
