Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ty1jpn01on0128.outbound.protection.outlook.com ([104.47.93.128]:6292
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbeKHFip (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 8 Nov 2018 00:38:45 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH v2] watchdog: renesas_wdt: don't set divider while
 watchdog is running
Date: Wed, 7 Nov 2018 20:06:44 +0000
Message-ID: <TYXPR01MB17757A8FC1D72292734DC698C0C40@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <20181107194602.7209-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181107194602.7209-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

Thank you for your patch!

> Subject: [PATCH v2] watchdog: renesas_wdt: don't set divider while watchd=
og is running
>
> The datasheet says we must stop the timer before changing the clock
> divider. This can happen when the restart handler is called while the
> watchdog is running.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

> ---
>
> Change since V1: reworded commit message.
>
> I sent V1 back then when it was more a recommendation of the datasheet to=
 do it
> like this. But meanwhile the code changed, so we actually need to do it.
>
>  drivers/watchdog/renesas_wdt.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wd=
t.c
> index 0d74c3e48979..55c9eb6c6e51 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -74,12 +74,17 @@ static int rwdt_init_timeout(struct watchdog_device *=
wdev)
>  static int rwdt_start(struct watchdog_device *wdev)
>  {
>  struct rwdt_priv *priv =3D watchdog_get_drvdata(wdev);
> +u8 val;
>
>  pm_runtime_get_sync(wdev->parent);
>
> -rwdt_write(priv, 0, RWTCSRB);
> -rwdt_write(priv, priv->cks, RWTCSRA);
> +/* Stop the timer before we modify any register */
> +val =3D readb_relaxed(priv->base + RWTCSRA) & ~RWTCSRA_TME;
> +rwdt_write(priv, val, RWTCSRA);
> +
>  rwdt_init_timeout(wdev);
> +rwdt_write(priv, priv->cks, RWTCSRA);
> +rwdt_write(priv, 0, RWTCSRB);
>
>  while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
>  cpu_relax();
> --
> 2.11.0




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
