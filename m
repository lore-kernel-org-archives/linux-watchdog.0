Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:55868 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033009AbeCARSa (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Mar 2018 12:18:30 -0500
Date: Thu, 1 Mar 2018 18:18:28 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@iguana.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 1/3] watchdog: renesas_wdt: Add suspend/resume support
Message-ID: <20180301171828.fuvexmnid25jz374@katana>
References: <1519919048-21884-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1519919048-21884-2-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d4d3jt2fkkjk5ae4"
Content-Disposition: inline
In-Reply-To: <1519919048-21884-2-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--d4d3jt2fkkjk5ae4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> +	unsigned int timeleft;

What about using
	u16 time_left;

=2E..

> +static void rwdt_set_timeleft(struct rwdt_priv *priv, unsigned int timel=
eft)
> +{
> +	rwdt_write(priv, 65536 - MUL_BY_CLKS_PER_SEC(priv, timeleft), RWTCNT);
> +}
> +

=2E.. skipping this ...

>  static int rwdt_init_timeout(struct watchdog_device *wdev)
>  {
>  	struct rwdt_priv *priv =3D watchdog_get_drvdata(wdev);
> =20
> -	rwdt_write(priv, 65536 - MUL_BY_CLKS_PER_SEC(priv, wdev->timeout), RWTC=
NT);
> -
> +	rwdt_set_timeleft(priv, wdev->timeout);

=2E.. and this ...

>  	return 0;
>  }
> =20
> @@ -203,6 +208,30 @@ static int rwdt_remove(struct platform_device *pdev)
>  	return 0;
>  }
> =20
> +static int __maybe_unused rwdt_suspend(struct device *dev)
> +{
> +	struct rwdt_priv *priv =3D dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&priv->wdev)) {
> +		priv->timeleft =3D rwdt_get_timeleft(&priv->wdev);

=2E..and read the register value directly here...

> +		rwdt_stop(&priv->wdev);
> +	}
> +	return 0;
> +}
> +
> +static int __maybe_unused rwdt_resume(struct device *dev)
> +{
> +	struct rwdt_priv *priv =3D dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&priv->wdev)) {
> +		rwdt_start(&priv->wdev);
> +		rwdt_set_timeleft(priv, priv->timeleft);

=2E.. and put it back here?

That would save calling the conversion macros which may introduce
rounding errors. It is also a tad faster and smaller. And less lines of
code.


--d4d3jt2fkkjk5ae4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqYNeQACgkQFA3kzBSg
Kbb0Eg//ZU6AX7a9it8OHytNM+xX6k9TOJRxNCX22fXIhwYtcs19QaBTOKePBvIj
1s+R1I4/KPZSVaEWyEizhc0Xk0chk6wB5o/lk54d8L1L/Oq/U9UCEGfJpZlw7InH
1Ek9TAuOzomqpzssUnQNZtfDQk3Bt8n0Bn5zEmE46RmTtS0NIQbXVlLMgm+PirKf
hHp4BUjkWXheN24RglX0bGY2uPcpuGXz60zCCF4kN9wYYge45tKsIodoWTZwnzbo
yckMDep1Nll2l7Jy+aBHP7kmVdQYLDYh0mCnQj4HWEqnNlQ3doOQj8dczbRVME4W
xhySf4gIi7cJGWnGFtUSsgKos9+/BxL0AolPWqlLXW70U+lLOmvbjPsGZwtd9UmW
kMjh/LKeMErhn2O3qUFj7Cw7ovdVq1sEFAh6YV5GDovd3JTqK6P6iakFc8wD0A4A
DoX5lpS3x5KyHozaGUoBRr4x0bqL9Hyzhnu0OJCEEgxlFIVRHc83lZJtCVXUSL6n
Tjuau7Mj5r/+qP5tGzbiVxqaei6kYb+3bSpEYREcbC3PILO7mIBQXaJRovLEQ+DX
2S8HxMtY/EAog9b/PZlE6oF15vZJIw/EKHnI+5fsD5SqaVwRNyEawgzu35TXwiyF
dYJ+WCLxxKHISHqGWIGeOkYtrHXx4k6bVU+mUcQ3Qi2R8fuR20g=
=UNRx
-----END PGP SIGNATURE-----

--d4d3jt2fkkjk5ae4--
