Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:39981 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759147Ab3GRXLE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Jul 2013 19:11:04 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so3565802pdi.2
        for <linux-watchdog@vger.kernel.org>; Thu, 18 Jul 2013 16:11:03 -0700 (PDT)
Date: Thu, 18 Jul 2013 16:11:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Carlo Caione <carlo.caione@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
	maxime.ripard@free-electrons.com, henrik@henriknordstrom.net
Subject: Re: [PATCH v6] ARM: sunxi: New watchdog driver for Allwinner A10/A13
Message-ID: <20130718231107.GB8465@roeck-us.net>
References: <1374009903-10203-1-git-send-email-carlo.caione@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1374009903-10203-1-git-send-email-carlo.caione@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jul 16, 2013 at 11:25:03PM +0200, Carlo Caione wrote:
> This patch adds the driver for the watchdog found in the Allwinner A10 and
> A13 SoCs. It has DT-support and uses the new watchdog framework.
> 
> Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/watchdog/Kconfig     |  10 ++
>  drivers/watchdog/Makefile    |   1 +
>  drivers/watchdog/sunxi_wdt.c | 241 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 252 insertions(+)
>  create mode 100644 drivers/watchdog/sunxi_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 362085d..d1d53f3 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -290,6 +290,16 @@ config ORION_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called orion_wdt.
>  
> +config SUNXI_WATCHDOG
> +	tristate "Allwinner SoCs watchdog support"
> +	depends on ARCH_SUNXI
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the watchdog timer
> +	  in Allwinner SoCs.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sunxi_wdt.
> +
>  config COH901327_WATCHDOG
>  	bool "ST-Ericsson COH 901 327 watchdog"
>  	depends on ARCH_U300
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 2f26a0b..6c5bb27 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_PNX4008_WATCHDOG) += pnx4008_wdt.o
>  obj-$(CONFIG_IOP_WATCHDOG) += iop_wdt.o
>  obj-$(CONFIG_DAVINCI_WATCHDOG) += davinci_wdt.o
>  obj-$(CONFIG_ORION_WATCHDOG) += orion_wdt.o
> +obj-$(CONFIG_SUNXI_WATCHDOG) += sunxi_wdt.o
>  obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
>  obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) += stmp3xxx_rtc_wdt.o
>  obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
> new file mode 100644
> index 0000000..11bfaf2
> --- /dev/null
> +++ b/drivers/watchdog/sunxi_wdt.c
> @@ -0,0 +1,241 @@
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

Is this include file really needed ?

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
> +#define WDT_CTRL_RELOAD         ((1 << 0) | (0x0a57 << 1))
> +
> +#define WDT_MODE                0x04
> +#define WDT_MODE_EN             (1 << 0)
> +#define WDT_MODE_RST_EN         (1 << 1)
> +
> +#define DRV_NAME		"sunxi-wdt"
> +#define DRV_VERSION		"1.0"
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +static unsigned int timeout = WDT_MAX_TIMEOUT;
> +
> +struct sunxi_wdt_dev {
> +	struct watchdog_device wdt_dev;
> +	void __iomem *wdt_base;
> +};
> +
> +/*
> + * wdt_timeout_map maps the watchdog timer interval value in seconds to
> + * the value of the register WDT_MODE bit 3:6
> + *
> + * [timeout seconds] = register value
> + *
> + */
> +
> +static const int wdt_timeout_map[] = {
> +	[1] = 0b0001,  /* 1s  */
> +	[2] = 0b0010,  /* 2s  */
> +	[3] = 0b0011,  /* 3s  */
> +	[4] = 0b0100,  /* 4s  */
> +	[5] = 0b0101,  /* 5s  */
> +	[6] = 0b0110,  /* 6s  */
> +	[8] = 0b0111,  /* 8s  */
> +	[10] = 0b1000, /* 10s */
> +	[12] = 0b1001, /* 12s */
> +	[14] = 0b1010, /* 14s */
> +	[16] = 0b1011, /* 16s */
> +};
> +
> +static int sunxi_wdt_ping(struct watchdog_device *wdt_dev)
> +{
> +	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
> +	void __iomem *wdt_base = sunxi_wdt->wdt_base;
> +
> +	iowrite32(WDT_CTRL_RELOAD, wdt_base + WDT_CTRL);
> +
> +	return 0;
> +}
> +
> +static int sunxi_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +		unsigned int timeout)
> +{
> +	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
> +	void __iomem *wdt_base = sunxi_wdt->wdt_base;
> +	u32 reg;
> +
> +	if (timeout > WDT_MAX_TIMEOUT)
> +		return -EINVAL;
> +
This check is already done by the infrastructure and thus not needed here.

Guenter
