Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:56468 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751218AbaEZSv1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 May 2014 14:51:27 -0400
Date: Mon, 26 May 2014 20:51:23 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	carlo.caione@gmail.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: sunxi: Fix compilation with C=2
Message-ID: <20140526185123.GB21283@spo001.leaseweb.com>
References: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Emilio,

> When compiling sunxi_defconfig while using C=3D2, the following error
> causes the compilation to fail:
>=20
>     drivers/watchdog/sunxi_wdt.c:60:15: error: constant 0b0001 is not=
 a valid number
>=20
> Fix it by using hex notation instead of the non-standard binary one
>=20
> Signed-off-by: Emilio L=F3pez <emilio@elopez.com.ar>
> ---
>  drivers/watchdog/sunxi_wdt.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wd=
t.c
> index cd00a78..693b9d2 100644
> --- a/drivers/watchdog/sunxi_wdt.c
> +++ b/drivers/watchdog/sunxi_wdt.c
> @@ -57,17 +57,17 @@ struct sunxi_wdt_dev {
>   */
> =20
>  static const int wdt_timeout_map[] =3D {
> -	[1] =3D 0b0001,  /* 1s  */
> -	[2] =3D 0b0010,  /* 2s  */
> -	[3] =3D 0b0011,  /* 3s  */
> -	[4] =3D 0b0100,  /* 4s  */
> -	[5] =3D 0b0101,  /* 5s  */
> -	[6] =3D 0b0110,  /* 6s  */
> -	[8] =3D 0b0111,  /* 8s  */
> -	[10] =3D 0b1000, /* 10s */
> -	[12] =3D 0b1001, /* 12s */
> -	[14] =3D 0b1010, /* 14s */
> -	[16] =3D 0b1011, /* 16s */
> +	[1] =3D 0x1,  /* 1s  */
> +	[2] =3D 0x2,  /* 2s  */
> +	[3] =3D 0x3,  /* 3s  */
> +	[4] =3D 0x4,  /* 4s  */
> +	[5] =3D 0x5,  /* 5s  */
> +	[6] =3D 0x6,  /* 6s  */
> +	[8] =3D 0x7,  /* 8s  */
> +	[10] =3D 0x8, /* 10s */
> +	[12] =3D 0x9, /* 12s */
> +	[14] =3D 0xA, /* 14s */
> +	[16] =3D 0xB, /* 16s */
>  };
> =20
>  static int sunxi_wdt_ping(struct watchdog_device *wdt_dev)

This has been added to linux-watchdog-next.

Kind regards,
Wim.

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
