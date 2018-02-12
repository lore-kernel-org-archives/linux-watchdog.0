Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:8954 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932941AbeBLKbO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Feb 2018 05:31:14 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Wolfram Sang <wsa@the-dreams.de>
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
        Guenter Roeck <linux@roeck-us.net>,
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
Subject: RE: [RFC v4 12/26] watchdog: renesas_wdt: Add R-Car Gen2 support
Date: Mon, 12 Feb 2018 10:31:06 +0000
Message-ID: <TY1PR06MB0895E25D31BA11A42F24DF80C0F70@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-13-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180207225356.pgirh2ohdsv7xdne@katana>
In-Reply-To: <20180207225356.pgirh2ohdsv7xdne@katana>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Wolfram,

thank you for your feedback!

> Subject: Re: [RFC v4 12/26] watchdog: renesas_wdt: Add R-Car Gen2 support
>
>
> > +#ifdef CONFIG_PM
> > +static int rwdt_suspend(struct device *dev)
> > +{
> > +struct platform_device *pdev;
> > +struct rwdt_priv *priv;
> > +
> > +pdev =3D to_platform_device(dev);
> > +priv =3D platform_get_drvdata(pdev);
>
> struct rwdt_priv *priv =3D dev_get_drvdata(dev);
>
> ?

will change

>
>
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
>
> ditto

will change

>
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
>
> Use SIMPLE_DEV_PM_OPS macro (see stmp3xxx_rtc_wdt.c for an example) for
> more compact code and...
>
> > +#ifdef CONFIG_PM
> > +.pm =3D &rwdt_pm,
> > +#endif
>
> ... removing this ifdeffery?

will take out the ifdeffery


Thanks,
Fabrizio



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
