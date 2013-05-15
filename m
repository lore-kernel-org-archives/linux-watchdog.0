Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:52129 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab3EOIeg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 15 May 2013 04:34:36 -0400
Message-ID: <51934896.3000506@free-electrons.com>
Date: Wed, 15 May 2013 10:34:30 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Carlo Caione <carlo.caione@gmail.com>
CC: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: sunxi: New watchdog driver for Allwinner A10/A13
References: <1368390994-27161-1-git-send-email-carlo.caione@gmail.com>
In-Reply-To: <1368390994-27161-1-git-send-email-carlo.caione@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

Le 12/05/2013 22:36, Carlo Caione a =E9crit :
> This patch adds the driver for the watchdog found in the Allwinner A10 =
and
> A13 SoCs. It has DT-support and uses the new watchdog framework.
>=20
> Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
> ---
>  drivers/watchdog/Kconfig     |  10 ++
>  drivers/watchdog/Makefile    |   1 +
>  drivers/watchdog/sunxi_wdt.c | 218 +++++++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 229 insertions(+)
>  create mode 100644 drivers/watchdog/sunxi_wdt.c
>=20
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index e89fc31..473e670 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -299,6 +299,16 @@ config ORION_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called orion_wdt.
> =20
> +config SUNXI_WATCHDOG
> +	tristate "Sunxi watchdog"

Maybe mention what sunxi is? something like "Allwinner SoCs watchdog
support"

> +	depends on ARCH_SUNXI
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the watchdog timer
> +	  in Allwinner A10 and A13.

I'd be more generic here. As far as we know, this code is found in A10,
A10s, A13, and can easily be adapted to support the A31 (and I suspect
the A20 as well). Something like "Allwinner SoCs"

> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sunxi_wdt.
> +
>  config COH901327_WATCHDOG
>  	bool "ST-Ericsson COH 901 327 watchdog"
>  	depends on ARCH_U300
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index a300b94..5012d5f 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_PNX4008_WATCHDOG) +=3D pnx4008_wdt.o
>  obj-$(CONFIG_IOP_WATCHDOG) +=3D iop_wdt.o
>  obj-$(CONFIG_DAVINCI_WATCHDOG) +=3D davinci_wdt.o
>  obj-$(CONFIG_ORION_WATCHDOG) +=3D orion_wdt.o
> +obj-$(CONFIG_SUNXI_WATCHDOG) +=3D sunxi_wdt.o
>  obj-$(CONFIG_COH901327_WATCHDOG) +=3D coh901327_wdt.o
>  obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) +=3D stmp3xxx_rtc_wdt.o
>  obj-$(CONFIG_NUC900_WATCHDOG) +=3D nuc900_wdt.o
> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.=
c
> new file mode 100644
> index 0000000..fe193b3
> --- /dev/null
> +++ b/drivers/watchdog/sunxi_wdt.c
> @@ -0,0 +1,218 @@
> +/*
> + *      sunxi Watchdog Driver
> + *
> + *      Copyright (c) 2013 Carlo Caione
> + *                    2012 Henrik Nordstrom
> + *
> + *      This program is free software; you can redistribute it and/or
> + *      modify it under the terms of the GNU General Public License
> + *      as published by the Free Software Foundation; either version
> + *      2 of the License, or (at your option) any later version.
> + *
> + *      Based on xen_wdt.c
> + *      (c) Copyright 2010 Novell, Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +
> +#define WDT_MAX_TIMEOUT         16
> +#define WDT_MIN_TIMEOUT         1
> +#define WDT_MODE_TIMEOUT(n)     ((n) << 3)
> +#define WDT_TIMEOUT_MASK        WDT_MODE_TIMEOUT(0x0F)
> +
> +#define WDT_CTRL                0x00
> +#define WDT_MODE                0x04
> +
> +#define WDT_MODE_RST_EN         (1 << 1)
> +#define WDT_MODE_EN             (1 << 0)
> +
> +#define WDT_CTRL_RESTART        (1 << 0)

I'd prefer to see the bits values just behind the register they belong to=
.

> +#define WDT_CTRL_RESERVED       (0x0a57 << 1)
> +#define DRV_NAME		"sunxi-wdt"
> +#define DRV_VERSION		"1.0"
> +
> +static bool nowayout =3D WATCHDOG_NOWAYOUT;
> +static int heartbeat =3D WDT_MAX_TIMEOUT;
> +
> +static const int wdt_timeout_map[] =3D {
> +	[1] =3D 0b0001,
> +	[2] =3D 0b0010,
> +	[3] =3D 0b0011,
> +	[4] =3D 0b0100,
> +	[5] =3D 0b0101,
> +	[6] =3D 0b0110,
> +	[8] =3D 0b0111,
> +	[10] =3D 0b1000,
> +	[12] =3D 0b1001,
> +	[14] =3D 0b1010,
> +	[16] =3D 0b1011,
> +};

It would be great to have a comment about what this map is here for and
how you store the values.

You don't support the 0.5s timeout here as well. I know why, but some
new comer might not, so I guess it would be great to add it to the
comment as well.

Moreover, I'd really like this to be supported. Maybe, since obviously
we can't put a value at the index 0.5, maybe saying that the 0 index is
actually this 0.5ms timeout value?

> +
> +static int sunxi_wdt_ping(struct watchdog_device *sunxi_wdt_dev)
> +{
> +	u32 reg;
> +	void __iomem *wdt_base =3D watchdog_get_drvdata(sunxi_wdt_dev);
> +
> +	reg =3D ioread32(wdt_base + WDT_CTRL);
> +	reg |=3D (WDT_CTRL_RESTART | WDT_CTRL_RESERVED);

The RESERVED part is not needed, especially if you OR the values already
there, it looks like it could trigger something nasty.

> +	iowrite32(reg, wdt_base + WDT_CTRL);
> +
> +	return 0;
> +}
> +
> +static int sunxi_wdt_set_timeout(struct watchdog_device *sunxi_wdt_dev=
,
> +		unsigned int timeout)
> +{
> +	u32 reg;
> +	void __iomem *wdt_base =3D watchdog_get_drvdata(sunxi_wdt_dev);
> +
> +	if ((timeout > WDT_MAX_TIMEOUT) || (0 =3D=3D wdt_timeout_map[timeout]=
))
> +		return -EINVAL;
> +
> +	sunxi_wdt_dev->timeout =3D timeout;
> +
> +	reg =3D ioread32(wdt_base + WDT_MODE);
> +	reg &=3D ~(WDT_TIMEOUT_MASK);
> +	reg |=3D WDT_MODE_TIMEOUT(wdt_timeout_map[sunxi_wdt_dev->timeout]);
> +	iowrite32(reg, wdt_base + WDT_MODE);
> +
> +	sunxi_wdt_ping(sunxi_wdt_dev);
> +
> +	return 0;
> +}
> +
> +static int sunxi_wdt_stop(struct watchdog_device *sunxi_wdt_dev)
> +{
> +	u32 reg;
> +	void __iomem *wdt_base =3D watchdog_get_drvdata(sunxi_wdt_dev);
> +
> +	reg =3D ioread32(wdt_base + WDT_MODE);
> +	reg &=3D ~(WDT_MODE_RST_EN | WDT_MODE_EN);
> +	iowrite32(reg, wdt_base + WDT_MODE);
> +
> +	return 0;
> +}
> +
> +static int sunxi_wdt_start(struct watchdog_device *sunxi_wdt_dev)
> +{
> +	u32 reg;
> +	int ret;
> +	void __iomem *wdt_base =3D watchdog_get_drvdata(sunxi_wdt_dev);
> +
> +	ret =3D sunxi_wdt_set_timeout(sunxi_wdt_dev, sunxi_wdt_dev->timeout);
> +	if (ret < 0)
> +		return ret;
> +
> +	reg =3D ioread32(wdt_base + WDT_MODE);
> +	reg |=3D (WDT_MODE_RST_EN | WDT_MODE_EN);
> +	iowrite32(reg, wdt_base + WDT_MODE);
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info sunxi_wdt_info =3D {
> +	.identity	=3D DRV_NAME,
> +	.options	=3D WDIOF_SETTIMEOUT |
> +			  WDIOF_KEEPALIVEPING |
> +			  WDIOF_MAGICCLOSE,
> +};
> +
> +static const struct watchdog_ops sunxi_wdt_ops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.start		=3D sunxi_wdt_start,
> +	.stop		=3D sunxi_wdt_stop,
> +	.ping		=3D sunxi_wdt_ping,
> +	.set_timeout	=3D sunxi_wdt_set_timeout,
> +};
> +
> +static struct watchdog_device sunxi_wdt_dev =3D {
> +	.info		=3D &sunxi_wdt_info,
> +	.ops		=3D &sunxi_wdt_ops,
> +	.timeout	=3D WDT_MAX_TIMEOUT,
> +	.max_timeout	=3D WDT_MAX_TIMEOUT,
> +	.min_timeout	=3D WDT_MIN_TIMEOUT,
> +};
> +
> +static int __init sunxi_wdt_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	void __iomem *wdt_base;
> +
> +	wdt_base =3D of_iomap(pdev->dev.of_node, 0);
> +	if (unlikely(!wdt_base)) {
> +		err =3D -ENOMEM;
> +		goto error_mem_out;
> +	}
> +
> +	sunxi_wdt_dev.parent =3D &pdev->dev;
> +	watchdog_init_timeout(&sunxi_wdt_dev, heartbeat, &pdev->dev);
> +	watchdog_set_nowayout(&sunxi_wdt_dev, nowayout);
> +
> +	err =3D watchdog_register_device(&sunxi_wdt_dev);
> +	if (unlikely(err))
> +		goto error_wdt;
> +
> +	watchdog_set_drvdata(&sunxi_wdt_dev, wdt_base);
> +
> +	pr_info("Watchdog enabled (heartbeat=3D%d sec, nowayout=3D%d)",
> +			sunxi_wdt_dev.timeout, nowayout);
> +	return 0;
> +
> +error_wdt:
> +	iounmap(wdt_base);
> +error_mem_out:
> +	return err;
> +}
> +
> +static int __exit sunxi_wdt_remove(struct platform_device *pdev)
> +{
> +	void __iomem *wdt_base =3D watchdog_get_drvdata(&sunxi_wdt_dev);
> +
> +	sunxi_wdt_stop(&sunxi_wdt_dev);
> +	watchdog_unregister_device(&sunxi_wdt_dev);
> +	iounmap(wdt_base);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sunxi_wdt_dt_ids[] =3D {
> +	{ .compatible =3D "allwinner,sun4i-wdt" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sunxi_wdt_dt_ids);
> +
> +static struct platform_driver sunxi_wdt_driver =3D {
> +	.probe		=3D sunxi_wdt_probe,
> +	.remove		=3D sunxi_wdt_remove,
> +	.driver		=3D {
> +		.owner		=3D THIS_MODULE,
> +		.name		=3D DRV_NAME,
> +		.of_match_table	=3D of_match_ptr(sunxi_wdt_dt_ids)
> +	},
> +};
> +
> +module_platform_driver(sunxi_wdt_driver);
> +
> +module_param(heartbeat, int, 0);
> +MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds");
> +
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
> +		"(default=3D" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Carlo Caione <carlo.caione@gmail.com>");
> +MODULE_AUTHOR("Henrik Nordstrom <henrik@henriknordstrom.net>");
> +MODULE_DESCRIPTION("sunxi WatchDog Timer Driver");
> +MODULE_VERSION(DRV_VERSION);
>=20


--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
