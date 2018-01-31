Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:35138 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751025AbeAaKri (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Jan 2018 05:47:38 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [RFC v3 11/25] watchdog: renesas_wdt: Add R-Car Gen2 support
Date: Wed, 31 Jan 2018 10:47:30 +0000
Message-ID: <TY1PR06MB0895ECB2936323F9D281C1EFC0FB0@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517343778-27902-12-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180130220504.GA16709@roeck-us.net>
In-Reply-To: <20180130220504.GA16709@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Guenter,

thank you for your feedback.

> Subject: Re: [RFC v3 11/25] watchdog: renesas_wdt: Add R-Car Gen2 support
>
> On Tue, Jan 30, 2018 at 08:22:44PM +0000, Fabrizio Castro wrote:
> > On R-Car Gen2 and RZ/G1 the rwdt clock needs to be always ON, therefore
> > when suspending to RAM we need to explicitly disable the counting by
> > clearing TME from RWTCSRA.
> > Also, on some systems RWDT is the only piece of HW that allows the SoC
> > to be restarted, therefore this patch implements the restart callback.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.rene=
sas.com>
> > ---
> > Wolfram, was the restart callback implementation missing for a reason?
> > Is its implementation going to break any Gen3 platform?
> >
>
> The changes clearly are way more than claimed in the subject. Adding
> restart handler and PM support may be prerequisites for Gen2, but the
> changes apply to Gen3 as well. What happened to "one patch per logical
> change" ?

The PM implementation should be ok for Gen3 too, without this patch series =
the kernel
would disable the rwdt clock when suspending to RAM, this would "pause" the=
 counting.
This patch series declares the rwdt clock as critical for Gen2 and RZ/G1, w=
hich means we
need to explicitly disable the counting to keep the same behaviour in place=
.
With respect to the restart callback implementation, that may well have con=
sequences on
Gen3, hopefully Wolfram will give us a feedback on this.
In particular I would like to know if we should be installing the restart c=
allback only when
we use "renesas,rcar-gen2-wdt" as compatible string, or it's ok to make it =
available for
Gen3 as well.
The only way to reboot iWave's boards iwg20d and iwg22d is to use the inter=
nal watchdog,
that's why the restart implementation was merged into this patch.
I can split this patch in two, one for PM support and one for restart suppo=
rt for the next
version, what do you think about this?

>
> > v1->v3:
> > * unified Gen2 and Gen3 drivers.
> >
> >  drivers/watchdog/renesas_wdt.c | 61 ++++++++++++++++++++++++++++++++++=
++++----
> >  1 file changed, 56 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_=
wdt.c
> > index 831ef83..eedb016 100644
> > --- a/drivers/watchdog/renesas_wdt.c
> > +++ b/drivers/watchdog/renesas_wdt.c
> > @@ -107,6 +107,24 @@ static unsigned int rwdt_get_timeleft(struct watch=
dog_device *wdev)
> >  return DIV_BY_CLKS_PER_SEC(priv, 65536 - val);
> >  }
> >
> > +static int rwdt_restart(struct watchdog_device *wdev, unsigned long ac=
tion,
> > +void *data)
> > +{
> > +struct rwdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +
> > +pm_runtime_get_sync(wdev->parent);
> > +
> > +rwdt_write(priv, 0x00, RWTCSRB);
> > +rwdt_write(priv, 0x00, RWTCSRA);
> > +rwdt_write(priv, 0xffff, RWTCNT);
> > +
> > +while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
> > +cpu_relax();
> > +
> > +rwdt_write(priv, 0x80, RWTCSRA);
> > +return 0;
> > +}
> > +
> >  static const struct watchdog_info rwdt_ident =3D {
> >  .options =3D WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT=
,
> >  .identity =3D "Renesas WDT Watchdog",
> > @@ -118,6 +136,7 @@ static const struct watchdog_ops rwdt_ops =3D {
> >  .stop =3D rwdt_stop,
> >  .ping =3D rwdt_init_timeout,
> >  .get_timeleft =3D rwdt_get_timeleft,
> > +.restart =3D rwdt_restart,
> >  };
> >
> >  static int rwdt_probe(struct platform_device *pdev)
> > @@ -203,13 +222,42 @@ static int rwdt_remove(struct platform_device *pd=
ev)
> >  return 0;
> >  }
> >
> > -/*
> > - * This driver does also fit for R-Car Gen2 (r8a779[0-4]) WDT. However=
, for SMP
> > - * to work there, one also needs a RESET (RST) driver which does not e=
xist yet
> > - * due to HW issues. This needs to be solved before adding compatibles=
 here.
> > - */
>
> Have those issues been resolved ?

This patch series addresses precisely those issues. The first implementatio=
n
used a flag that the watchdog driver needed to explicitly set to make every=
thing
work as expected. This new version uses a different concept that doesn't re=
quire
such an hack, and that's why the proposal now is to merge Gen2 and Gen3 dri=
vers.

Thanks,
Fab

>
> > +#ifdef CONFIG_PM
> > +static int rwdt_suspend(struct device *dev)
> > +{
> > +struct platform_device *pdev;
> > +struct rwdt_priv *priv;
> > +
> > +pdev =3D to_platform_device(dev);
> > +priv =3D platform_get_drvdata(pdev);
> > +if (watchdog_active(&priv->wdev)) {
> > +rwdt_write(priv, priv->cks, RWTCSRA);
> > +}
> > +return 0;
> > +}
> > +
> > +static int rwdt_resume(struct device *dev)
> > +{
> > +struct platform_device *pdev;
> > +struct rwdt_priv *priv;
> > +
> > +pdev =3D to_platform_device(dev);
> > +priv =3D platform_get_drvdata(pdev);
> > +if (watchdog_active(&priv->wdev)) {
> > +rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);
> > +}
> > +return 0;
> > +}
> > +
> > +static const struct dev_pm_ops rwdt_pm =3D {
> > +.suspend =3D rwdt_suspend,
> > +.resume =3D rwdt_resume,
> > +};
> > +#endif
> > +
> >  static const struct of_device_id rwdt_ids[] =3D {
> >  { .compatible =3D "renesas,rcar-gen3-wdt", },
> > +{ .compatible =3D "renesas,rcar-gen2-wdt", },
> >  { /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, rwdt_ids);
> > @@ -218,6 +266,9 @@ static struct platform_driver rwdt_driver =3D {
> >  .driver =3D {
> >  .name =3D "renesas_wdt",
> >  .of_match_table =3D rwdt_ids,
> > +#ifdef CONFIG_PM
> > +.pm =3D &rwdt_pm,
> > +#endif
> >  },
> >  .probe =3D rwdt_probe,
> >  .remove =3D rwdt_remove,
> > --
> > 2.7.4
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
