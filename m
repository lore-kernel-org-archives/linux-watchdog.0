Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:35163 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727049AbeICSRN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Sep 2018 14:17:13 -0400
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH 2/2] watchdog: renesas_wdt: stop when unregistering
Date: Mon, 3 Sep 2018 13:56:51 +0000
Message-ID: <TYXPR01MB17757C93A747366F5A1B3CDCC00C0@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <20180828101348.12443-1-wsa+renesas@sang-engineering.com>
 <20180828101348.12443-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180828101348.12443-3-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> Subject: [PATCH 2/2] watchdog: renesas_wdt: stop when unregistering
>
> We want to go into a sane state when unregistering. Currently, it
> happens that the watchdog stops when unbinding because of RuntimePM
> stopping the core clock. When rebinding, the core clock gets reactivated
> and the watchdog fires even though it hasn't been opened by userspace
> yet. Strange scenario, yes, but sane state is much preferred anyhow.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

> ---
>  drivers/watchdog/renesas_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wd=
t.c
> index 88d81feba4e6..f45cb183fa75 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -234,6 +234,7 @@ static int rwdt_probe(struct platform_device *pdev)
>  watchdog_set_drvdata(&priv->wdev, priv);
>  watchdog_set_nowayout(&priv->wdev, nowayout);
>  watchdog_set_restart_priority(&priv->wdev, 0);
> +watchdog_stop_on_unregister(&priv->wdev);
>
>  /* This overrides the default timeout only if DT configuration was found=
 */
>  ret =3D watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
> --
> 2.11.0




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
