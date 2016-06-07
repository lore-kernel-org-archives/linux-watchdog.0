Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58615 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932364AbcFGR4N (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Jun 2016 13:56:13 -0400
Date: Tue, 7 Jun 2016 10:56:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: wim@iguana.be, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: max77620: Add support for watchdog timer
Message-ID: <20160607175600.GA3712@roeck-us.net>
References: <1465213964-25639-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465213964-25639-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On Mon, Jun 06, 2016 at 05:22:44PM +0530, Laxman Dewangan wrote:
> Maxim PMIC MAX77620 is Power management IC which have multiple
> sub blocks like regulators (DCDC/LDOs), GPIO, RTC, Clock, Watchdog
> timer etc.
> 
> Add the driver for watchdog timer under watchdog framework.
> The driver implements the watchdog callbacks to start, stop,
> ping and set timeout for watchodg framework.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/watchdog/Kconfig        |   9 ++
>  drivers/watchdog/Makefile       |   1 +
>  drivers/watchdog/max77620_wdt.c | 220 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 230 insertions(+)
>  create mode 100644 drivers/watchdog/max77620_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index b54f26c..6529aaa 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -516,6 +516,15 @@ config MAX63XX_WATCHDOG
>  	help
>  	  Support for memory mapped max63{69,70,71,72,73,74} watchdog timer.
>  
> +config MAX77620_WATCHDOG
> +	tristate "Maxim Max77620 Watchdog Timer"
> +	depends on MFD_MAX77620
> +	help
> +	 This is the driver for the Max77620 watchdog timer.
> +	 Say 'Y' here to enable the watchdog timer support for
> +	 MAX77620 chips. To compile this driver as a module,
> +	 choose M here: the module will be called max77620_wat.

max77620_wat ?

> +

>  config IMX2_WDT
>  	tristate "IMX2+ Watchdog"
>  	depends on ARCH_MXC || ARCH_LAYERSCAPE
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index a46e7c1..5d38173 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -203,6 +203,7 @@ obj-$(CONFIG_TANGOX_WATCHDOG) += tangox_wdt.o
>  obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
>  obj-$(CONFIG_WM8350_WATCHDOG) += wm8350_wdt.o
>  obj-$(CONFIG_MAX63XX_WATCHDOG) += max63xx_wdt.o
> +obj-$(CONFIG_MAX77620_WATCHDOG) += max77620_wdt.o
>  obj-$(CONFIG_ZIIRAVE_WATCHDOG) += ziirave_wdt.o
>  obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
>  obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
> diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
> new file mode 100644
> index 0000000..6acf0e9
> --- /dev/null
> +++ b/drivers/watchdog/max77620_wdt.c
> @@ -0,0 +1,220 @@
> +/*
> + * Maxim MAX77620 Watchdog Driver
> + *
> + * Copyright (C) 2016 NVIDIA CORPORATION. All rights reserved.
> + *
> + * Author: Laxman Dewangan <ldewangan@nvidia.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mfd/max77620.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/watchdog.h>
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +
> +struct max77620_wdt {
> +	struct device			*dev;
> +	struct regmap			*rmap;
> +	struct watchdog_device		wdt_dev;
> +	struct delayed_work		clear_wdt_wq;

Not used anywhere.

> +};
> +
> +static int max77620_wdt_start(struct watchdog_device *wdt_dev)
> +{
> +	struct max77620_wdt *wdt = watchdog_get_drvdata(wdt_dev);
> +	int ret;
> +
> +	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
> +				 MAX77620_WDTEN, MAX77620_WDTEN);
> +	if (ret < 0) {
> +		dev_err(wdt->dev, "Failed to set WDTEN: %d\n", ret);

I am not in favour of error messages like this; it should be sufficient to
inform the user about the failure. This would also simplify the code a lot,
since you could just return ret.

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77620_wdt_stop(struct watchdog_device *wdt_dev)
> +{
> +	struct max77620_wdt *wdt = watchdog_get_drvdata(wdt_dev);
> +	int ret;
> +
> +	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
> +				 MAX77620_WDTEN, 0);
> +	if (ret < 0) {
> +		dev_err(wdt->dev, "Failed to reset WDTEN: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77620_wdt_ping(struct watchdog_device *wdt_dev)
> +{
> +	struct max77620_wdt *wdt = watchdog_get_drvdata(wdt_dev);
> +	int ret;
> +
> +	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL3,
> +				 MAX77620_WDTC_MASK, 0x1);
> +	if (ret < 0) {
> +		dev_err(wdt->dev, "Failed to clear WDT: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77620_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +				    unsigned int timeout)
> +{
> +	struct max77620_wdt *wdt = watchdog_get_drvdata(wdt_dev);
> +	int ret;
> +	u8 regval = 0;
> +
Unnecessary initialization.

> +	if (timeout <= 2)
> +		regval = MAX77620_TWD_2s;
> +	else if (timeout <= 16)
> +		regval = MAX77620_TWD_16s;
> +	else if (timeout <= 64)
> +		regval = MAX77620_TWD_64s;
> +	else if (timeout <= 128)
> +		regval = MAX77620_TWD_128s;
> +	else
> +		return -EINVAL;
> +

Please also set wdt->timeout to the actual value. The error return is not
necessary since the watchdog core will already check the range. So you can
simplify the code to

	...
	else {
		regval = MAX77620_TWD_128s;
		wdt_dev->timeout = 128;
	}


> +	/* Clear watchdog before updating time. */
> +	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL3,
> +				 MAX77620_WDTC_MASK, 0x1);
> +	if (ret < 0) {
> +		dev_err(wdt->dev, "Failed to clear WDT: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
> +				 MAX77620_TWD_MASK, regval);
> +	if (ret < 0) {
> +		dev_err(wdt->dev, "Failed to set timeout of WDT: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info max77620_wdt_info = {
> +	.identity = "max77620-watchdog",
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,

Did you omit WDIOF_MAGICCLOSE on purpose ?

> +};
> +
> +static const struct watchdog_ops max77620_wdt_ops = {
> +	.start		= max77620_wdt_start,
> +	.stop		= max77620_wdt_stop,
> +	.ping		= max77620_wdt_ping,
> +	.set_timeout	= max77620_wdt_set_timeout,
> +};
> +
> +static int max77620_wdt_probe(struct platform_device *pdev)
> +{
> +	struct max77620_wdt *wdt;
> +	struct watchdog_device *wdt_dev;
> +	int ret;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->dev = &pdev->dev;
> +	wdt->rmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!wdt->rmap) {
> +		dev_err(wdt->dev, "Failed to get parent regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	wdt_dev = &wdt->wdt_dev;
> +	wdt_dev->info = &max77620_wdt_info;
> +	wdt_dev->ops = &max77620_wdt_ops;
> +	wdt_dev->min_timeout = 2;
> +	wdt_dev->max_timeout = 128;
> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	/* Stop watchodog */
> +	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
> +				 MAX77620_WDTEN, 0);
> +	if (ret < 0) {
> +		dev_err(wdt->dev, "Failed to reset WDTEN: %d\n", ret);
> +		return ret;
> +	}

Alternatively, you could set WDOG_HW_RUNNING to tell the watchdog core
that the watchdog is already running. The watchdog core would then ping
the watchdog until the watchdog device is opened.

That would also require to tell the watchdog core about the current (or default)
timeout, which doesn't seem to be set anywhere. That means it won't be set at all
unless user space updates it explicitly. This is quite unusual. Is it on purpose
or an oversight ? If it is on purpose, please explain.

> +
> +	/* Enable WD_RST_WK - WDT expire results in a restart */
> +	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_ONOFFCNFG2,
> +				 MAX77620_ONOFFCNFG2_WD_RST_WK,
> +				 MAX77620_ONOFFCNFG2_WD_RST_WK);
> +	if (ret < 0) {
> +		dev_err(wdt->dev, "Failed to set WD_RST_WK: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Set WDT clear in OFF and sleep mode */
> +	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
> +				 MAX77620_WDTOFFC | MAX77620_WDTSLPC,
> +				 MAX77620_WDTOFFC | MAX77620_WDTSLPC);
> +	if (ret < 0) {
> +		dev_err(wdt->dev, "Failed to set WDT OFF mode: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = watchdog_register_device(wdt_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "watchdog registration failed: %d\n", ret);
> +		return ret;
> +	}
> +	watchdog_set_nowayout(wdt_dev, nowayout);

nowayout is usually set before registration.

> +	watchdog_set_drvdata(wdt_dev, wdt);

This results in a race condition (the functions can be called right after
watchdog registration, when drvdata is not yet set). Please move ahead of
registration.

> +
> +	return ret;

	return 0;

> +}
> +
> +static int max77620_wdt_remove(struct platform_device *pdev)
> +{
> +	struct max77620_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	max77620_wdt_stop(&wdt->wdt_dev);
> +	watchdog_unregister_device(&wdt->wdt_dev);
> +
> +	return 0;
> +}
> +
> +static struct platform_device_id max77620_wdt_devtype[] = {
> +	{ .name = "max77620-watchdog", },
> +	{ },
> +};
> +
> +static struct platform_driver max77620_wdt_driver = {
> +	.driver	= {
> +		.name	= "max77620-watchdog",
> +	},
> +	.probe	= max77620_wdt_probe,
> +	.remove	= max77620_wdt_remove,
> +	.id_table = max77620_wdt_devtype,
> +};
> +
> +module_platform_driver(max77620_wdt_driver);
> +
> +MODULE_DESCRIPTION("Max77620 watchdog timer driver");
> +
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
> +	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.1.4
> 
