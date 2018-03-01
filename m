Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:62601 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1033627AbeCASFd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Mar 2018 13:05:33 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@iguana.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "Chris Paterson" <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 1/3] watchdog: renesas_wdt: Add suspend/resume support
Date: Thu, 1 Mar 2018 18:05:27 +0000
Message-ID: <TY1PR06MB08951F30415653988F8543C8C0C60@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1519919048-21884-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1519919048-21884-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180301171828.fuvexmnid25jz374@katana>
In-Reply-To: <20180301171828.fuvexmnid25jz374@katana>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

thank you for your feedback!

> Subject: Re: [PATCH v6 1/3] watchdog: renesas_wdt: Add suspend/resume sup=
port
>
>
> > +unsigned int timeleft;
>
> What about using
> u16 time_left;
>
> ...
>
> > +static void rwdt_set_timeleft(struct rwdt_priv *priv, unsigned int tim=
eleft)
> > +{
> > +rwdt_write(priv, 65536 - MUL_BY_CLKS_PER_SEC(priv, timeleft), RWTCNT);
> > +}
> > +
>
> ... skipping this ...
>
> >  static int rwdt_init_timeout(struct watchdog_device *wdev)
> >  {
> >  struct rwdt_priv *priv =3D watchdog_get_drvdata(wdev);
> >
> > -rwdt_write(priv, 65536 - MUL_BY_CLKS_PER_SEC(priv, wdev->timeout), RWT=
CNT);
> > -
> > +rwdt_set_timeleft(priv, wdev->timeout);
>
> ... and this ...
>
> >  return 0;
> >  }
> >
> > @@ -203,6 +208,30 @@ static int rwdt_remove(struct platform_device *pde=
v)
> >  return 0;
> >  }
> >
> > +static int __maybe_unused rwdt_suspend(struct device *dev)
> > +{
> > +struct rwdt_priv *priv =3D dev_get_drvdata(dev);
> > +
> > +if (watchdog_active(&priv->wdev)) {
> > +priv->timeleft =3D rwdt_get_timeleft(&priv->wdev);
>
> ...and read the register value directly here...
>
> > +rwdt_stop(&priv->wdev);
> > +}
> > +return 0;
> > +}
> > +
> > +static int __maybe_unused rwdt_resume(struct device *dev)
> > +{
> > +struct rwdt_priv *priv =3D dev_get_drvdata(dev);
> > +
> > +if (watchdog_active(&priv->wdev)) {
> > +rwdt_start(&priv->wdev);
> > +rwdt_set_timeleft(priv, priv->timeleft);
>
> ... and put it back here?

It works for me, I'll send a new version with your comments applied.

Thanks,
Fab

>
> That would save calling the conversion macros which may introduce
> rounding errors. It is also a tad faster and smaller. And less lines of
> code.




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
