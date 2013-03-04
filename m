Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:51429 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab3CDGxs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Mar 2013 01:53:48 -0500
Date: Mon, 4 Mar 2013 07:53:43 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be,
	Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH 2/4] watchdog: ath79_wdt: Convert to
 devm_ioremap_resource()
Message-ID: <20130304065343.GB16261@avionic-0098.mockup.avionic-design.de>
References: <1362373604-26771-1-git-send-email-sachin.kamat@linaro.org>
 <1362373604-26771-2-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <1362373604-26771-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 10:36:42AM +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
>=20
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Gabor Juhos <juhosg@openwrt.org>
> ---
>  drivers/watchdog/ath79_wdt.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
> index 8987990..d184c48 100644
> --- a/drivers/watchdog/ath79_wdt.c
> +++ b/drivers/watchdog/ath79_wdt.c
> @@ -253,11 +253,9 @@ static int ath79_wdt_probe(struct platform_device *p=
dev)
>  		return -EINVAL;
>  	}
> =20
> -	wdt_base =3D devm_request_and_ioremap(&pdev->dev, res);
> -	if (!wdt_base) {
> -		dev_err(&pdev->dev, "unable to remap memory region\n");
> -		return -ENOMEM;
> -	}
> +	wdt_base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(wdt_base))
> +		return PTR_ERR(wdt_base);
> =20
>  	wdt_clk =3D devm_clk_get(&pdev->dev, "wdt");
>  	if (IS_ERR(wdt_clk))

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRNET3AAoJEN0jrNd/PrOhf+sQAI8dNHLgmsZGqkfXVvQ/PR7z
wt7EGL79h4f682h2UlMdFywlRjfu3QwpiOqKTisv9qgihngaDPFjMsoKb4KWYfSO
yYfvDk9TgdiyzH24Ss2HMfqA+Eo9N7HW9ER9Y5uQVoPELTY0Ahk3guZ1G97erBgh
uaPzWhvJatpQaqsrxbwixtETaa2B3R4tj9700aAU5XV3vQxKxvsE1olfpbk1CmZr
YMVOk6VGX/JPK2PPPbmKKZfIJRA6re28viJr/xcVVP7pApkno0suEDdE7SQIVJDn
BI9hGhe1IifXIEiNH5bsaudfbIsvQvORWuSRHRbgJfaG4wAxScdqQl6bl5HNl7a2
3v/SaMS9MNKhEZ1jsRUShc4SbeaVkzFEejZglPNq0WpfXW7XPE6UzfO4iFbETPH3
7ntJnVsswBDNn3GSKgQgZv82+Jw01sV+NlQyzztT6/b4rbtu70G7kVmq5oMf4g54
eV8AL7uHZNCoucnrPZw8bH+hIhAF5NU0igAGdpE2S7QMWdsZQEjNSP6u4h7A8iZ7
SREwgZfOgg6Gd0rASGkL+DrbklVnPkNsY4XPFKgAm5JMvP30r+xuW5PyJRzpS2Ur
6x2k6X8ZSGgCRd8ez42D92u4LzC90+oRW2qDJnk4XLvKYdIeGngWtnI7KwtbkeYx
R+dtYB8+8+BPzAwTETVh
=2F9e
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
