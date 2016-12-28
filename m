Return-path: <ukl@pengutronix.de>
Date: Wed, 28 Dec 2016 21:38:05 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Magnus Lilja <lilja.magnus@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21,
 i.MX27 and i.MX31 SoCs
Message-ID: <20161228203805.26urb7hzpb5kgigr@pengutronix.de>
References: <20161211010648.6591-1-vz@mleia.com>
 <CAOMZO5CqpfH6nq_mqPitztfSX4-oR4-61z7PnYhvOYAVnYF0yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CqpfH6nq_mqPitztfSX4-oR4-61z7PnYhvOYAVnYF0yA@mail.gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, Dec 24, 2016 at 11:00:59AM -0200, Fabio Estevam wrote:
> On Sat, Dec 10, 2016 at 11:06 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> 
> >  static const struct of_device_id imx2_wdt_dt_ids[] = {
> > -       { .compatible = "fsl,imx21-wdt", },
> > +       { .compatible = "fsl,imx21-wdt", .data = IMX2_WDT_NO_WMCR },
> > +       { .compatible = "fsl,imx25-wdt",  },
> > +       { .compatible = "fsl,imx27-wdt", .data = IMX2_WDT_NO_WMCR },
> > +       { .compatible = "fsl,imx31-wdt", .data = IMX2_WDT_NO_WMCR },
> > +       { .compatible = "fsl,imx35-wdt",  },
> > +       { .compatible = "fsl,imx50-wdt",  },
> > +       { .compatible = "fsl,imx51-wdt",  },
> > +       { .compatible = "fsl,imx53-wdt",  },
> > +       { .compatible = "fsl,imx6q-wdt",  },
> > +       { .compatible = "fsl,imx6sl-wdt", },
> > +       { .compatible = "fsl,imx6sx-wdt", },
> > +       { .compatible = "fsl,imx6ul-wdt", },
> > +       { .compatible = "fsl,imx7d-wdt",  },
> > +       { .compatible = "fsl,vf610-wdt",  },
> >         { /* sentinel */ }
> 
> I understand this compatible list is not very nice, but in order to
> keep old dtb's working I don't see a better solution, so:
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

You can at least drop fsl,imx27-wdt and fsl,imx31-wdt which then fall
back correctly to fsl,imx21-wdt.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
