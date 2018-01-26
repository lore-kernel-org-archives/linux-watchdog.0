Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:12972 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750864AbeAZSAx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 26 Jan 2018 13:00:53 -0500
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
Subject: RE: [RFC 24/37] watchdog: renesas_wdt_gen2: Add Gen2 specific driver
Date: Fri, 26 Jan 2018 18:00:46 +0000
Message-ID: <TY1PR06MB0895ACEB1556E5304FE05E09C0E00@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1516903391-30467-25-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180126172835.GB16194@roeck-us.net>
In-Reply-To: <20180126172835.GB16194@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Guenter,

thank you so much for your feedback.
This driver is similar to the R-Car Gen3 watchdog driver (drivers/watchdog/=
renesas_wdt.c), at this point in time there is a discussion in progress abo=
ut merging the functionality specific to R-Car Gen2 into the R-Car Gen3 dri=
ver, but this decision is stalled until we agree on something else that has=
 in turn an impact on the driver implementation.
I'll keep your comments in mind whatever we decide to do, but I am going to=
 get back to you only after the decision has been made.

Thanks,
Fabrizio

> Subject: Re: [RFC 24/37] watchdog: renesas_wdt_gen2: Add Gen2 specific dr=
iver
>
> On Thu, Jan 25, 2018 at 06:02:58PM +0000, Fabrizio Castro wrote:
> > R-Car Gen2 (and RZ/G1) platforms need some tweaking for SMP and watchdo=
g
> > to coexist nicely.
> > This new driver is based on top of Wolfram Sang's driver
> > (drivers/watchdog/renesas_wdt.c), and it contains the quirks necessary
> > for R-Car Gen2 and RZ/G1 to work properly and in harmony with the rest =
of
> > the system. In particular, the driver:
> > * expects the device clock to be ON all the time,
> > * "pauses" the watchdog operation during suspend, and
> > * "reassures" the SMP bringup function about the availability of the
> >   watchdog registers.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.rene=
sas.com>
> > ---
> >  drivers/watchdog/Kconfig            |  15 +-
> >  drivers/watchdog/Makefile           |   1 +
> >  drivers/watchdog/renesas_wdt_gen2.c | 270 ++++++++++++++++++++++++++++=
++++++++
> >  drivers/watchdog/renesas_wdt_gen2.h |  22 +++
> >  4 files changed, 306 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/watchdog/renesas_wdt_gen2.c
> >  create mode 100644 drivers/watchdog/renesas_wdt_gen2.h
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index ca200d1..e580c72 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -725,12 +725,23 @@ config ATLAS7_WATCHDOG
> >    module will be called atlas7_wdt.
> >
> >  config RENESAS_WDT
> > -tristate "Renesas WDT Watchdog"
> > +tristate "Renesas R-Car Gen3 WDT Watchdog"
> >  depends on ARCH_RENESAS || COMPILE_TEST
> >  select WATCHDOG_CORE
> >  help
> >    This driver adds watchdog support for the integrated watchdogs in th=
e
> > -  Renesas R-Car and other SH-Mobile SoCs (usually named RWDT or SWDT).
> > +  Renesas R-Car Gen3 devices.
> > +
> > +config RENESAS_WDT_GEN2
> > +tristate "Renesas R-Car Gen2 and RZ/G1 WDT Watchdog"
> > +depends on ARCH_RENESAS || COMPILE_TEST
> > +select WATCHDOG_CORE
> > +help
> > +  This driver adds watchdog support for the integrated watchdogs in th=
e
> > +  Renesas R-Car Gen2 and RZ/G1 devices.
> > +
> > +  To compile this driver as a module, choose M here: the
> > +  module will be called renesas_wdt_gen2.
> >
> >  config RENESAS_RZAWDT
> >  tristate "Renesas RZ/A WDT Watchdog"
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index 715a210..57ab810 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -83,6 +83,7 @@ obj-$(CONFIG_LPC18XX_WATCHDOG) +=3D lpc18xx_wdt.o
> >  obj-$(CONFIG_BCM7038_WDT) +=3D bcm7038_wdt.o
> >  obj-$(CONFIG_ATLAS7_WATCHDOG) +=3D atlas7_wdt.o
> >  obj-$(CONFIG_RENESAS_WDT) +=3D renesas_wdt.o
> > +obj-$(CONFIG_RENESAS_WDT_GEN2) +=3D renesas_wdt_gen2.o
> >  obj-$(CONFIG_RENESAS_RZAWDT) +=3D rza_wdt.o
> >  obj-$(CONFIG_ASPEED_WATCHDOG) +=3D aspeed_wdt.o
> >  obj-$(CONFIG_ZX2967_WATCHDOG) +=3D zx2967_wdt.o
> > diff --git a/drivers/watchdog/renesas_wdt_gen2.c b/drivers/watchdog/ren=
esas_wdt_gen2.c
> > new file mode 100644
> > index 0000000..c841636
> > --- /dev/null
> > +++ b/drivers/watchdog/renesas_wdt_gen2.c
> > @@ -0,0 +1,270 @@
> > +/*
> > + * Watchdog driver for Renesas WDT watchdog
> > + *
> > + * Copyright (C) 2015-17 Wolfram Sang, Sang Engineering <wsa@sang-engi=
neering.com>
> > + * Copyright (C) 2018    Renesas Electronics Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License version 2 as publ=
ished by
> > + * the Free Software Foundation.
>
> Please use the SPDX identifier.
>
> > + */
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/watchdog.h>
> > +#include "renesas_wdt_gen2.h"
> > +
> > +#define RWTCNT0
> > +#define RWTCSRA4
> > +#define RWTCSRA_WOVFBIT(4)
> > +#define RWTCSRA_WRFLGBIT(5)
> > +#define RWTCSRA_TMEBIT(7)
> > +#define RWTCSRB8
> > +
> > +#define RWDT_DEFAULT_TIMEOUT60U
> > +
> > +/*
> > + * In probe, clk_rate is checked to be not more than 16 bit * biggest =
clock
> > + * divider (12 bits). d is only a factor to fully utilize the WDT coun=
ter and
> > + * will not exceed its 16 bits. Thus, no overflow, we stay below 32 bi=
ts.
> > + */
> > +#define MUL_BY_CLKS_PER_SEC(p, d) \
> > +DIV_ROUND_UP((d) * (p)->clk_rate, clk_divs[(p)->cks])
> > +
> > +/* d is 16 bit, clk_divs 12 bit -> no 32 bit overflow */
> > +#define DIV_BY_CLKS_PER_SEC(p, d) ((d) * clk_divs[(p)->cks] / (p)->clk=
_rate)
> > +
> > +static const unsigned int clk_divs[] =3D { 1, 4, 16, 32, 64, 128, 1024=
, 4096 };
> > +
> > +static bool nowayout =3D WATCHDOG_NOWAYOUT;
> > +module_param(nowayout, bool, 0);
> > +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (d=
efault=3D"
> > +__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> > +
> > +struct rwdt_priv {
> > +void __iomem *base;
> > +struct watchdog_device wdev;
> > +unsigned long clk_rate;
> > +bool enabled;
> > +u8 cks;
> > +};
> > +
> > +static void rwdt_write(struct rwdt_priv *priv, u32 val, unsigned int r=
eg)
> > +{
> > +if (reg =3D=3D RWTCNT)
> > +val |=3D 0x5a5a0000;
> > +else
> > +val |=3D 0xa5a5a500;
> > +
> > +writel_relaxed(val, priv->base + reg);
> > +}
> > +
> > +static int rwdt_init_timeout(struct watchdog_device *wdev)
> > +{
> > +struct rwdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +
> > +rwdt_write(priv, 65536 - MUL_BY_CLKS_PER_SEC(priv, wdev->timeout),
> > +   RWTCNT);
> > +
> > +return 0;
> > +}
> > +
> > +static int rwdt_start(struct watchdog_device *wdev)
> > +{
> > +struct rwdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +
> > +rwdt_write(priv, 0, RWTCSRB);
> > +rwdt_write(priv, priv->cks, RWTCSRA);
> > +rwdt_init_timeout(wdev);
> > +
> > +while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
> > +cpu_relax();
> > +
> Can this get stuck ?
>
> > +rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);
> > +
> > +return 0;
> > +}
> > +
> > +static int rwdt_stop(struct watchdog_device *wdev)
> > +{
> > +struct rwdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +
> > +rwdt_write(priv, priv->cks, RWTCSRA);
> > +
> > +return 0;
> > +}
> > +
> > +static unsigned int rwdt_get_timeleft(struct watchdog_device *wdev)
> > +{
> > +struct rwdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +u16 val =3D readw_relaxed(priv->base + RWTCNT);
> > +
> > +return DIV_BY_CLKS_PER_SEC(priv, 65536 - val);
> > +}
> > +
> > +static int rwdt_restart(struct watchdog_device *wdev, unsigned long ac=
tion,
> > +void *data)
> > +{
> > +struct rwdt_priv *priv =3D watchdog_get_drvdata(wdev);
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
> > +static const struct watchdog_info rwdt_ident =3D {
> > +.options =3D WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT=
,
> > +.identity =3D "Renesas WDT Watchdog",
> > +};
> > +
> > +static const struct watchdog_ops rwdt_ops =3D {
> > +.owner =3D THIS_MODULE,
> > +.start =3D rwdt_start,
> > +.stop =3D rwdt_stop,
> > +.ping =3D rwdt_init_timeout,
> > +.get_timeleft =3D rwdt_get_timeleft,
> > +.restart =3D rwdt_restart,
> > +};
> > +
> > +static int rwdt_probe(struct platform_device *pdev)
> > +{
> > +struct rwdt_priv *priv;
> > +struct resource *res;
> > +struct clk *clk;
> > +unsigned long clks_per_sec;
> > +int ret, i;
> > +
> > +priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +if (!priv)
> > +return -ENOMEM;
> > +res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +priv->base =3D devm_ioremap_resource(&pdev->dev, res);
> > +if (IS_ERR(priv->base))
> > +return PTR_ERR(priv->base);
> > +
> > +clk =3D devm_clk_get(&pdev->dev, NULL);
> > +if (IS_ERR(clk))
> > +return PTR_ERR(clk);
> > +
> > +
> > +priv->clk_rate =3D clk_get_rate(clk);
> > +
> > +if (!priv->clk_rate)
> > +return -ENOENT;
> > +
> Odd line spacing. Please no double empty lines, and please no
> empty line after a function and before checking the return value.
>
> ENOENT is an odd return value. No such file or directory ?
>
> > +for (i =3D ARRAY_SIZE(clk_divs) - 1; i >=3D 0; i--) {
> > +clks_per_sec =3D priv->clk_rate / clk_divs[i];
> > +if (clks_per_sec && clks_per_sec < 65536) {
> > +priv->cks =3D i;
> > +break;
> > +}
> > +}
> > +
> > +if (i < 0) {
> > +dev_err(&pdev->dev, "Can't find suitable clock divider\n");
> > +return -ERANGE;
>
> Another odd return value. Math result not presentable ?
>
> > +}
> > +
> > +priv->wdev.info =3D &rwdt_ident,
> > +priv->wdev.ops =3D &rwdt_ops,
> > +priv->wdev.parent =3D &pdev->dev;
> > +priv->wdev.min_timeout =3D 1;
> > +priv->wdev.max_timeout =3D DIV_BY_CLKS_PER_SEC(priv, 65536);
> > +priv->wdev.timeout =3D min(priv->wdev.max_timeout, RWDT_DEFAULT_TIMEOU=
T);
> > +
> > +platform_set_drvdata(pdev, priv);
> > +watchdog_set_drvdata(&priv->wdev, priv);
> > +watchdog_set_nowayout(&priv->wdev, nowayout);
> > +
> > +ret =3D watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
> > +if (ret)
> > +dev_warn(&pdev->dev,
> > + "Specified timeout value invalid, using default\n");
> > +shmobile_set_wdt_clock_status(RWDT_CLOCK_ON);
> > +
> > +ret =3D watchdog_register_device(&priv->wdev);
>
> Please consider using devm_watchdog_register_device().
>
> > +return ret;
> > +}
> > +
> > +static int rwdt_remove(struct platform_device *pdev)
> > +{
> > +struct rwdt_priv *priv =3D platform_get_drvdata(pdev);
> > +
> > +watchdog_unregister_device(&priv->wdev);
> > +
> > +return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int rwdt_suspend(struct device *dev)
> > +{
> > +struct platform_device *pdev;
> > +struct rwdt_priv *priv;
> > +u8 val;
> > +
> > +pdev =3D to_platform_device(dev);
> > +priv =3D platform_get_drvdata(pdev);
> > +val =3D readb_relaxed(priv->base + RWTCSRA);
> > +if (val & RWTCSRA_TME) {
> > +priv->enabled =3D true;
> > +rwdt_write(priv, val & ~RWTCSRA_TME, RWTCSRA);
> > +} else {
> > +priv->enabled =3D false;
> > +}
>
> This will require an explanation why you can't use watchdog_active()
> here and in the resume function.
>
> > +return 0;
> > +}
> > +
> > +static int rwdt_resume(struct device *dev)
> > +{
> > +struct platform_device *pdev;
> > +struct rwdt_priv *priv;
> > +u8 val;
> > +
> > +pdev =3D to_platform_device(dev);
> > +priv =3D platform_get_drvdata(pdev);
> > +if (priv->enabled) {
> > +val =3D readb_relaxed(priv->base + RWTCSRA);
> > +rwdt_write(priv, val | RWTCSRA_TME, RWTCSRA);
> > +}
> > +return 0;
> > +}
> > +
> > +static const struct dev_pm_ops rwdt_pm =3D {
> > +.suspend =3D rwdt_suspend,
> > +.resume =3D rwdt_resume,
>
> Any reason for not using helper functions such as SET_SYSTEM_SLEEP_PM_OPS=
()
> or SIMPLE_DEV_PM_OPS() ?
>
> > +};
> > +#endif
> > +
> > +static const struct of_device_id rwdt_ids[] =3D {
> > +{ .compatible =3D "renesas,rcar-gen2-wdt", },
> > +{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, rwdt_ids);
> > +
> > +static struct platform_driver rwdt_driver =3D {
> > +.driver =3D {
> > +.name =3D "renesas_wdt_gen2",
> > +.of_match_table =3D rwdt_ids,
> > +#ifdef CONFIG_PM
> > +.pm =3D &rwdt_pm,
> > +#endif
> > +},
> > +.probe =3D rwdt_probe,
> > +.remove =3D rwdt_remove,
> > +};
> > +module_platform_driver(rwdt_driver);
> > +
> > +MODULE_DESCRIPTION("Renesas R-Car Gen2 Watchdog Driver");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("Fabrizio Castro <fabrizio.castro@bp.renesas.com>");
> > diff --git a/drivers/watchdog/renesas_wdt_gen2.h b/drivers/watchdog/ren=
esas_wdt_gen2.h
> > new file mode 100644
> > index 0000000..41b9e9c
> > --- /dev/null
> > +++ b/drivers/watchdog/renesas_wdt_gen2.h
> > @@ -0,0 +1,22 @@
> > +/*
> > + * drivers/watchdog/renesas_wdt_gen2.h
> > + *
> > + * Copyright (C) 2018 Renesas Electronics Corporation
> > + *
> > + * R-Car Gen2 and RZ/G specific symbols
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#ifndef RENESAS_WDT_GEN2_H
> > +#define RENESAS_WDT_GEN2_H
> > +
> > +#define RWDT_CLOCK_ON0xdeadbeef
> > +#define RWDT_CLOCK_OFF0x00000000
> > +
> > +extern void shmobile_set_wdt_clock_status(unsigned long value);
>
> Wrong file to declare this function. It is not defined in the watchdog dr=
iver.
> Same for the defines.
>
> > +
> > +#endif /* RENESAS_WDT_GEN2_H */
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
