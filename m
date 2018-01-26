Return-Path: <fabrizio.castro@bp.renesas.com>
Return-path: <fabrizio.castro@bp.renesas.com>
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Wim Van Sebroeck <wim@iguana.be>,
	Russell King <linux@armlinux.org.uk>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Michael
 Turquette" <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>,
	Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
	"Geert Uytterhoeven" <geert+renesas@glider.be>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>, Ramesh Shanmugasundaram
	<ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [RFC 22/37] watchdog: renesas_wdt: Add restart support
Date: Fri, 26 Jan 2018 17:50:16 +0000
Message-ID: <TY1PR06MB0895CE80DD4121A7EB6B3B05C0E00@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1516903391-30467-23-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180126171418.GA16194@roeck-us.net>
In-Reply-To: <20180126171418.GA16194@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

thank you for your feedback.

> Subject: Re: [RFC 22/37] watchdog: renesas_wdt: Add restart support
>
> On Thu, Jan 25, 2018 at 06:02:56PM +0000, Fabrizio Castro wrote:
> > This commit extends the driver to add restart support by implementing
> > the restart callback to trigger the watchdog as quickly as possible.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.rene=
sas.com>
> > ---
> >  drivers/watchdog/renesas_wdt.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_=
wdt.c
> > index 831ef83..120ddac 100644
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
>
> Can this get stuck forever or should there be a timeout ?

This won't get stuck forever, the particular bit we are checking marks the =
period of time writing to register RWTCNT is prohibited due to synchronizat=
ion from the previous write. It gets cleared eventually (quite quickly). Al=
so, we use exactly the same logic for the "start" callback.

Best regards,
Fabrizio

>
> Guenter
>
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
