Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-os2jpn01on0102.outbound.protection.outlook.com ([104.47.92.102]:51328
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727275AbeKEUDE (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 5 Nov 2018 15:03:04 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] watchdog: renesas_wdt: Fix typos
Date: Mon, 5 Nov 2018 10:43:56 +0000
Message-ID: <TY1PR01MB17702269352DA5A3F3B1C00EC0CA0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1541186471-2998-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20181102194808.GA17913@roeck-us.net>
In-Reply-To: <20181102194808.GA17913@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> Subject: Re: [PATCH] watchdog: renesas_wdt: Fix typos
>
> On Fri, Nov 02, 2018 at 07:21:11PM +0000, Fabrizio Castro wrote:
>
> Do not use "," but ";" to separate instructions.

I agree, will send a v2 for this.

Thanks,
Fab

>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> > ---
> >  drivers/watchdog/renesas_wdt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_=
wdt.c
> > index 0d74c3e..b570962 100644
> > --- a/drivers/watchdog/renesas_wdt.c
> > +++ b/drivers/watchdog/renesas_wdt.c
> > @@ -220,8 +220,8 @@ static int rwdt_probe(struct platform_device *pdev)
> >  goto out_pm_disable;
> >  }
> >
> > -priv->wdev.info =3D &rwdt_ident,
> > -priv->wdev.ops =3D &rwdt_ops,
> > +priv->wdev.info =3D &rwdt_ident;
> > +priv->wdev.ops =3D &rwdt_ops;
> >  priv->wdev.parent =3D &pdev->dev;
> >  priv->wdev.min_timeout =3D 1;
> >  priv->wdev.max_timeout =3D DIV_BY_CLKS_PER_SEC(priv, 65536);
> > --
> > 2.7.4
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
