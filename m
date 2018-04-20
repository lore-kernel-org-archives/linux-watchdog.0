Return-Path: <fabrizio.castro@bp.renesas.com>
Return-path: <fabrizio.castro@bp.renesas.com>
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Wim Van Sebroeck
	<wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
CC: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] watchdog: renesas-wdt: Remove R-Car M2-W ES2.x from
 blacklist
Date: Fri, 20 Apr 2018 12:45:04 +0000
Message-ID: <TY1PR01MB1770A6DB4B3D33D1A4D4D1ECC0B40@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1524226849-13301-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1524226849-13301-1-git-send-email-geert+renesas@glider.be>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

> Subject: [PATCH] watchdog: renesas-wdt: Remove R-Car M2-W ES2.x from blac=
klist
>
> System restart triggered by watchdog time-out works fine on a Koelsch
> board with R-Car M2-W ES2.0.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

> ---
> Thanks to Magnus and Shimoda-san for providing board access!
> ---
>  drivers/watchdog/renesas_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wd=
t.c
> index 514db5cc15951125..88d81feba4e60087 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -146,7 +146,7 @@ static const struct soc_device_attribute rwdt_quirks_=
match[] =3D {
>  .data =3D (void *)1,/* needs single CPU */
>  }, {
>  .soc_id =3D "r8a7791",
> -.revision =3D "ES[12].*",
> +.revision =3D "ES1.*",
>  .data =3D (void *)1,/* needs single CPU */
>  }, {
>  .soc_id =3D "r8a7792",
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
