Return-path: <James.Hartley@imgtec.com>
From: James Hartley <James.Hartley@imgtec.com>
To: Guenter Roeck <linux@roeck-us.net>, Naidu Tellapati
	<naidu.tellapati@gmail.com>
CC: "wim@iguana.be" <wim@iguana.be>, "abrestic@chromium.org"
	<abrestic@chromium.org>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, James
 Hogan <James.Hogan@imgtec.com>, Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	Arul Ramasamy <Arul.Ramasamy@imgtec.com>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Jude Abraham <Jude.Abraham@imgtec.com>
Subject: RE: [PATCH RESEND v6 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
Date: Mon, 15 Dec 2014 18:28:58 +0000
Message-ID: <72BC0C8BD7BB6F45988A99382E5FBAE5443AB68E@hhmail02.hh.imgtec.org>
References: <1417064045-13274-1-git-send-email-Naidu.Tellapati@gmail.com>
 <1417064045-13274-2-git-send-email-Naidu.Tellapati@gmail.com>
 <20141215171744.GA16516@roeck-us.net>
In-Reply-To: <20141215171744.GA16516@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,=20

Thanks for your comments,=20

> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: 15 December 2014 17:18
> To: Naidu Tellapati
> Cc: wim@iguana.be; abrestic@chromium.org; Ezequiel Garcia; James Hartley;
> James Hogan; Naidu Tellapati; Arul Ramasamy; linux-
> watchdog@vger.kernel.org; devicetree@vger.kernel.org; Jude Abraham
> Subject: Re: [PATCH RESEND v6 1/2] watchdog: ImgTec PDC Watchdog Timer
> Driver
>=20
> On Thu, Nov 27, 2014 at 10:24:04AM +0530, Naidu Tellapati wrote:
> > This commit adds support for ImgTec PowerDown Controller Watchdog
> Timer.
> >
> > Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> > Signed-off-by: Jude.Abraham <Jude.Abraham@imgtec.com>
> > Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
> > Reviewed-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> > ---
> >  drivers/watchdog/Kconfig      |   11 ++
> >  drivers/watchdog/Makefile     |    1 +
> >  drivers/watchdog/imgpdc_wdt.c |  298
> > +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 310 insertions(+), 0 deletions(-)  create mode
> > 100644 drivers/watchdog/imgpdc_wdt.c
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
> > d0107d4..a184f23 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -1235,6 +1235,17 @@ config BCM_KONA_WDT_DEBUG
> >
> >  	  If in doubt, say 'N'.
> >
> > +config IMGPDC_WDT
> > +	tristate "Imagination Technologies PDC Watchdog Timer"
> > +	depends on HAS_IOMEM
> > +	depends on METAG || MIPS || COMPILE_TEST
> > +	help
> > +	  Driver for Imagination Technologies PowerDown Controller
> > +	  Watchdog Timer.
> > +
> > +	  To compile this driver as a loadable module, choose M here.
> > +	  The module will be called imgpdc_wdt.
> > +
> >  config LANTIQ_WDT
> >  	tristate "Lantiq SoC watchdog"
> >  	depends on LANTIQ
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index c569ec8..d4dfbb4 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -142,6 +142,7 @@ obj-$(CONFIG_OCTEON_WDT) +=3D octeon-wdt.o
> > octeon-wdt-y :=3D octeon-wdt-main.o octeon-wdt-nmi.o
> >  obj-$(CONFIG_LANTIQ_WDT) +=3D lantiq_wdt.o
> >  obj-$(CONFIG_RALINK_WDT) +=3D rt2880_wdt.o
> > +obj-$(CONFIG_IMGPDC_WDT) +=3D imgpdc_wdt.o
> >
> >  # PARISC Architecture
> >
> > diff --git a/drivers/watchdog/imgpdc_wdt.c
> > b/drivers/watchdog/imgpdc_wdt.c new file mode 100644 index
> > 0000000..efb00b5
> > --- /dev/null
> > +++ b/drivers/watchdog/imgpdc_wdt.c
> > @@ -0,0 +1,298 @@
> > +/*
> > + * Imagination Technologies PowerDown Controller Watchdog Timer.
> > + *
> > + * Copyright (c) 2014 Imagination Technologies Ltd.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify it
> > + * under the terms of the GNU General Public License version 2 as
> > +published by
> > + * the Free Software Foundation.
> > + *
> > + * Based on drivers/watchdog/sunxi_wdt.c Copyright (c) 2013 Carlo
> Caione
> > + *                                                     2012 Henrik Nor=
dstrom
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/log2.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/watchdog.h>
> > +
> > +/* registers */
> > +#define PDC_WD_SW_RESET			0x000
> > +
> > +#define PDC_WD_CONFIG			0x004
> > +#define PDC_WD_CONFIG_ENABLE		BIT(31)
> > +#define PDC_WD_CONFIG_DELAY_MASK	0x0000001f
> > +#define PDC_WD_CONFIG_DELAY_SHIFT	0
> > +
> > +#define PDC_WD_TICKLE1			0x008
> > +#define PDC_WD_TICKLE1_MAGIC		0xabcd1234
> > +
> > +#define PDC_WD_TICKLE2			0x00c
> > +#define PDC_WD_TICKLE2_MAGIC		0x4321dcba
> > +
> > +#define PDC_WD_TICKLE_STATUS_MASK	0x00000007
> > +#define PDC_WD_TICKLE_STATUS_SHIFT	0
> > +#define PDC_WD_TICKLE_STATUS_HRESET     0x0  /* Hard reset */
> > +#define PDC_WD_TICKLE_STATUS_TIMEOUT    0x1  /* Timeout */
> > +#define PDC_WD_TICKLE_STATUS_TICKLE     0x2  /* Tickled incorrectly */
> > +#define PDC_WD_TICKLE_STATUS_SRESET     0x3  /* Soft reset */
> > +#define PDC_WD_TICKLE_STATUS_USER       0x4  /* User reset */
> > +
> > +/* timeout in seconds */
> > +#define PDC_WD_MIN_TIMEOUT		1
> > +#define PDC_WD_DEFAULT_TIMEOUT		64
> > +
> > +static int timeout =3D PDC_WD_DEFAULT_TIMEOUT;
> module_param(timeout,
> > +int, 0); MODULE_PARM_DESC(timeout, "PDC watchdog delay in seconds
> > +(default 64s)");
>=20
> It might be better to use
> __MODULE_STRING(PDC_WD_DEFAULT_TIMEOUT)
> to encode the default timeout.
>=20
> > +
> > +static bool nowayout =3D WATCHDOG_NOWAYOUT;
> module_param(nowayout,
> > +bool, 0); MODULE_PARM_DESC(nowayout, "Watchdog cannot be
> stopped once
> > +started");
> > +
> > +struct pdc_wdt_dev {
> > +	struct watchdog_device wdt_dev;
> > +	struct clk *wdt_clk;
> > +	struct clk *sys_clk;
> > +	int min_delay;
> > +	void __iomem *base;
> > +};
> > +
> > +static int pdc_wdt_keepalive(struct watchdog_device *wdt_dev) {
> > +	struct pdc_wdt_dev *wdt =3D watchdog_get_drvdata(wdt_dev);
> > +
> > +	writel(PDC_WD_TICKLE1_MAGIC, wdt->base + PDC_WD_TICKLE1);
> > +	writel(PDC_WD_TICKLE2_MAGIC, wdt->base + PDC_WD_TICKLE2);
> > +
> > +	return 0;
> > +}
> > +
> > +static int pdc_wdt_stop(struct watchdog_device *wdt_dev) {
> > +	unsigned int val;
> > +	struct pdc_wdt_dev *wdt =3D watchdog_get_drvdata(wdt_dev);
> > +
> > +	val =3D readl(wdt->base + PDC_WD_CONFIG);
> > +	val &=3D ~PDC_WD_CONFIG_ENABLE;
> > +	writel(val, wdt->base + PDC_WD_CONFIG);
> > +
> > +	/* Must tickle to finish the stop */
> > +	pdc_wdt_keepalive(wdt_dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int pdc_wdt_set_timeout(struct watchdog_device *wdt_dev,
> > +			       unsigned int new_timeout)
> > +{
> > +	unsigned int val;
> > +	struct pdc_wdt_dev *wdt =3D watchdog_get_drvdata(wdt_dev);
> > +
> > +	wdt->wdt_dev.timeout =3D new_timeout;
> > +	/* round up to the next power of 2 */
> > +	new_timeout =3D order_base_2(new_timeout);
> > +	val =3D readl(wdt->base + PDC_WD_CONFIG);
> > +	val &=3D ~PDC_WD_CONFIG_DELAY_MASK;
> > +	val |=3D (new_timeout + wdt->min_delay) <<
> PDC_WD_CONFIG_DELAY_SHIFT;
> > +	writel(val, wdt->base + PDC_WD_CONFIG);
> > +
> > +	return 0;
> > +}
> > +
> > +/* Start the watchdog timer (delay should already be set) */ static
> > +int pdc_wdt_start(struct watchdog_device *wdt_dev) {
> > +	unsigned int val;
> > +	struct pdc_wdt_dev *wdt =3D watchdog_get_drvdata(wdt_dev);
> > +
> > +	val =3D readl(wdt->base + PDC_WD_CONFIG);
> > +	val |=3D PDC_WD_CONFIG_ENABLE;
> > +	writel(val, wdt->base + PDC_WD_CONFIG);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct watchdog_info pdc_wdt_info =3D {
> > +	.identity	=3D "IMG PDC Watchdog",
> > +	.options	=3D WDIOF_SETTIMEOUT |
> > +			  WDIOF_KEEPALIVEPING |
> > +			  WDIOF_MAGICCLOSE,
> > +};
> > +
> > +/* Kernel interface */
> > +static const struct watchdog_ops pdc_wdt_ops =3D {
> > +	.owner		=3D THIS_MODULE,
> > +	.start		=3D pdc_wdt_start,
> > +	.stop		=3D pdc_wdt_stop,
> > +	.ping		=3D pdc_wdt_keepalive,
> > +	.set_timeout	=3D pdc_wdt_set_timeout,
> > +};
> > +
> > +static int pdc_wdt_probe(struct platform_device *pdev) {
> > +	int ret, val;
> > +	unsigned long clk_rate;
> > +	struct resource *res;
> > +	struct pdc_wdt_dev *pdc_wdt;
> > +
> > +	pdc_wdt =3D devm_kzalloc(&pdev->dev, sizeof(*pdc_wdt),
> GFP_KERNEL);
> > +	if (!pdc_wdt)
> > +		return -ENOMEM;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	pdc_wdt->base =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(pdc_wdt->base))
> > +		return PTR_ERR(pdc_wdt->base);
> > +
> > +	pdc_wdt->sys_clk =3D devm_clk_get(&pdev->dev, "sys");
> > +	if (IS_ERR(pdc_wdt->sys_clk)) {
> > +		dev_err(&pdev->dev, "failed to get the sys clock.\n");
> > +		ret =3D PTR_ERR(pdc_wdt->wdt_clk);
>=20
> 					sys_clk
> > +		return ret;
>=20
> 		return PTR_ERR(pdc_wdt->sys_clk);
>=20
> On a higher level, what is sys_clk needed and used for in the first place=
 ?
> The need for wdt_clk is obvious, but there is no explanation for the need=
 of
> sys_clk, and the bindings file doesn't give a hint either.

I believe that the watchdog registers are clocked from sys_clk, so without =
that they are not accessible. =20

>=20
> > +	}
> > +
> > +	pdc_wdt->wdt_clk =3D devm_clk_get(&pdev->dev, "wdt");
> > +	if (IS_ERR(pdc_wdt->wdt_clk)) {
> > +		dev_err(&pdev->dev, "failed to get the wdt clock.\n");
> > +		ret =3D PTR_ERR(pdc_wdt->wdt_clk);
> > +		return ret;
>=20
> 		return PTR_ERR(pdc_wdt->wdt_clk);
>=20
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(pdc_wdt->sys_clk);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "could not prepare or enable sys
> clock.\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(pdc_wdt->wdt_clk);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "could not prepare or enable wdt
> clock.\n");
> > +		goto disable_sys_clk;
>=20
> I would suggest to drop the '.' in those messages.
>=20
> > +	}
> > +
> > +	/* We use the clock rate to calculate the max timeout */
> > +	clk_rate =3D clk_get_rate(pdc_wdt->wdt_clk);
> > +	if (clk_rate =3D=3D 0) {
> > +		dev_err(&pdev->dev, "failed to get clock rate\n");
> > +		ret =3D -EINVAL;
> > +		goto disable_wdt_clk;
> > +	}
> > +
> > +	if (order_base_2(clk_rate) > PDC_WD_CONFIG_DELAY_MASK + 1) {
> > +		dev_err(&pdev->dev, "invalid clock rate\n");
> > +		ret =3D -EINVAL;
> > +		goto disable_wdt_clk;
> > +	}
> > +
> > +	if (order_base_2(clk_rate) =3D=3D 0)
> > +		pdc_wdt->wdt_dev.min_timeout =3D
> PDC_WD_MIN_TIMEOUT + 1;
> > +	else
> > +		pdc_wdt->wdt_dev.min_timeout =3D
> PDC_WD_MIN_TIMEOUT;
> > +
> > +	pdc_wdt->min_delay =3D order_base_2(clk_rate) - 1;
>=20
> Ultimately this means that min_delay can be smaller than 0, which makes i=
t
> quite difficult to validate the rest of the code to ensure that it handle=
s this
> case correctly.
>=20
> Give that a clock rate of 1 is somewhere between highly unlikely and
> unreasonable, wouldn't it be much easier to consider it to be invalid and=
 not
> try to handle it ?

Sounds reasonable to me.

>=20
> > +
> > +	pdc_wdt->wdt_dev.info =3D &pdc_wdt_info;
> > +	pdc_wdt->wdt_dev.ops =3D &pdc_wdt_ops;
> > +	pdc_wdt->wdt_dev.max_timeout =3D
> > +			(1 << (PDC_WD_CONFIG_DELAY_MASK - pdc_wdt-
> >min_delay));
> > +	pdc_wdt->wdt_dev.parent =3D &pdev->dev;
> > +
> > +	ret =3D watchdog_init_timeout(&pdc_wdt->wdt_dev, timeout, &pdev-
> >dev);
> > +	if (ret < 0) {
> > +		pdc_wdt->wdt_dev.timeout =3D pdc_wdt-
> >wdt_dev.max_timeout;
> > +		dev_warn(&pdev->dev,
> > +			 "Initial timeout out of range! setting max
> timeout\n");
> > +	}
> > +
> > +	pdc_wdt_stop(&pdc_wdt->wdt_dev);
> > +
> > +	/* Find what caused the last reset */
> > +	val =3D readl(pdc_wdt->base + PDC_WD_TICKLE1);
> > +	val =3D (val & PDC_WD_TICKLE_STATUS_MASK) >>
> PDC_WD_TICKLE_STATUS_SHIFT;
> > +	switch (val) {
> > +	case PDC_WD_TICKLE_STATUS_TICKLE:
> > +	case PDC_WD_TICKLE_STATUS_TIMEOUT:
> > +		pdc_wdt->wdt_dev.bootstatus |=3D WDIOF_CARDRESET;
> > +		dev_info(&pdev->dev,
> > +			 "watchdog module last reset due to timeout\n");
> > +		break;
> > +	case PDC_WD_TICKLE_STATUS_HRESET:
> > +		dev_info(&pdev->dev,
> > +			 "watchdog module last reset due to hard reset\n");
> > +		break;
> > +	case PDC_WD_TICKLE_STATUS_SRESET:
> > +		dev_info(&pdev->dev,
> > +			 "watchdog module last reset due to soft reset\n");
> > +		break;
> > +	case PDC_WD_TICKLE_STATUS_USER:
> > +		dev_info(&pdev->dev,
> > +			 "watchdog module last reset due to user reset\n");
> > +		break;
> > +	default:
> > +		dev_info(&pdev->dev,
> > +			 "contains an illegal status code (%08x)\n", val);
> > +		break;
> > +	}
> > +
> > +	watchdog_set_nowayout(&pdc_wdt->wdt_dev, nowayout);
> > +
> > +	platform_set_drvdata(pdev, pdc_wdt);
> > +	watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
> > +
> > +	ret =3D watchdog_register_device(&pdc_wdt->wdt_dev);
> > +	if (ret)
> > +		goto disable_wdt_clk;
> > +
> > +	return 0;
> > +
> > +disable_wdt_clk:
> > +	clk_disable_unprepare(pdc_wdt->wdt_clk);
> > +disable_sys_clk:
> > +	clk_disable_unprepare(pdc_wdt->sys_clk);
> > +	return ret;
> > +}
> > +
> > +static void pdc_wdt_shutdown(struct platform_device *pdev) {
> > +	struct pdc_wdt_dev *pdc_wdt =3D platform_get_drvdata(pdev);
> > +
> > +	pdc_wdt_stop(&pdc_wdt->wdt_dev);
> > +}
> > +
> > +static int pdc_wdt_remove(struct platform_device *pdev) {
> > +	struct pdc_wdt_dev *pdc_wdt =3D platform_get_drvdata(pdev);
> > +
> > +	pdc_wdt_stop(&pdc_wdt->wdt_dev);
> > +	watchdog_unregister_device(&pdc_wdt->wdt_dev);
> > +	clk_disable_unprepare(pdc_wdt->wdt_clk);
> > +	clk_disable_unprepare(pdc_wdt->sys_clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id pdc_wdt_match[] =3D {
> > +	{ .compatible =3D "img,pdc-wdt" },
>=20
> Will "img" be added to the list of vendor prefixes with some other patch =
?

I think Img is already in the list of vendor prefixes.

>=20
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, pdc_wdt_match);
> > +
> > +static struct platform_driver pdc_wdt_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "imgpdc-wdt",
> > +		.of_match_table	=3D pdc_wdt_match,
> > +	},
> > +	.probe =3D pdc_wdt_probe,
> > +	.remove =3D pdc_wdt_remove,
> > +	.shutdown =3D pdc_wdt_shutdown,
> > +};
> > +module_platform_driver(pdc_wdt_driver);
> > +
> > +MODULE_AUTHOR("Jude Abraham <Jude.Abraham@imgtec.com>");
> > +MODULE_AUTHOR("Naidu Tellapati <Naidu.Tellapati@imgtec.com>");
> > +MODULE_DESCRIPTION("Imagination Technologies PDC Watchdog Timer
> > +Driver"); MODULE_LICENSE("GPL v2");
> > --
> > 1.7.0.4
> >

James.
