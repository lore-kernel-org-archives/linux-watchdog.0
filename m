Return-path: <Chris.Brandt@renesas.com>
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, "Geert
 Uytterhoeven" <geert@linux-m68k.org>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v4 1/3] watchdog: add rza_wdt driver
Date: Thu, 2 Mar 2017 15:38:07 +0000
Message-ID: <SG2PR06MB11656FE3E3CF8BAA1B8A86688A280@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170302135746.30550-1-chris.brandt@renesas.com>
 <20170302135746.30550-2-chris.brandt@renesas.com>
 <bf76e106-9272-622c-8d4e-c270a6b51d16@roeck-us.net>
In-Reply-To: <bf76e106-9272-622c-8d4e-c270a6b51d16@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

Thank you for your review!


On Thursday, March 02, 2017, Guenter Roeck wrote:
> > +/*
> > + * Renesas RZ/A Series WDT Driver
> > + *
> > + * Copyright (C) 2017 Renesas Electronics America, Inc.
> > + * Copyright (C) 2017 Chris Brandt
> > + *
> > + * This file is subject to the terms and conditions of the GNU
> > +General Public
> > + * License.  See the file "COPYING" in the main directory of this
> > +archive
> > + * for more details.
> > + *
> > + *
>=20
> The above two lines are unnecessary.

OK.

#I'll assume you mean take out just the last sentence (2 lines), not both
sentences (all 3 lines).

=20
> > +/* Watchdog Timer Registers */
> > +#define WTCSR 0
> > +#define WTCSR_MAGIC 0xA500
> > +#define WTSCR_WT (1<<6)
> > +#define WTSCR_TME (1<<5)
>=20
> BIT()

OK.

> > +#define WTSCR_CKS(i) i
>=20
> (i)

OK.


> > +#define WRCSR_CLEAR_WOVF 0xA500 /* special value */
>=20
> Please use
> #define SOMETHING<tab>value
> throughout and make sure value is aligned.

OK.

> > +	rate =3D clk_get_rate(priv->clk);
> > +	if (!rate)
> > +		return -ENOENT;
> > +
> > +	/* Assume slowest clock rate possible (CKS=3D7) */
> > +	rate /=3D 16384;
> > +
>=20
> The rate check should probably be here to avoid situations where rate <
> 16384.

Do I need that if it's technically not possible to have a 'rate' less than =
25MHz?

These watchdogs HW are always feed directly from the peripheral clock and t=
here
is no such thing as a 16kHz peripheral block an any Renesas SoC.


> > +	priv->wdev.info =3D &rza_wdt_ident,
> > +	priv->wdev.ops =3D &rza_wdt_ops,
> > +	priv->wdev.parent =3D &pdev->dev;
> > +
> > +	/*
> > +	 * Since the max possible timeout of our 8-bit count register is
> less
> > +	 * than a second, we must use max_hw_heartbeat_ms.
> > +	 */
> > +	priv->wdev.max_hw_heartbeat_ms =3D (1000 * U8_MAX)/rate;
>=20
> space before and after /

OK.
#Funny because checkpatch.pl said it didn't like a space on one side but
 not the other, so I choose no spaces and it was happy. I'm way below 80
 characters for that line so it doesn't matter to me.


> > +	dev_info(&pdev->dev, "max hw timeout of %dms\n",
> > +		 priv->wdev.max_hw_heartbeat_ms);
>=20
> dev_dbg ?

OK.
#I guess we don't need to see that info on every boot.

=20
> > +
> > +	priv->wdev.min_timeout =3D 1;
> > +	priv->wdev.timeout =3D DEFAULT_TIMEOUT;
> > +
>=20
> Add watchdog_init_timeout(&priv->wdev, 0, &pdev->dev); to optionally get
> the timeout from dt ?

OK. Good idea.

> > +	platform_set_drvdata(pdev, priv);
> > +	watchdog_set_drvdata(&priv->wdev, priv);
> > +
> > +	ret =3D watchdog_register_device(&priv->wdev);
>=20
> devm_watchdog_register_device()

OK.

=20
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int rza_wdt_remove(struct platform_device *pdev) {
> > +	struct rza_wdt *priv =3D platform_get_drvdata(pdev);
> > +
> > +	watchdog_unregister_device(&priv->wdev);
> > +	iounmap(priv->base);
>=20
> iounmap is unnecessary (and wrong).

Anything mapped with devm_ioremap_resource() automatically gets unmapped
when the drive gets unloaded?
I didn't know that.



I'll wait till the end of the day to see if anyone finds anything else, and
then I'll send out a v5.


Chris
