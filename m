Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49120 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934033AbbKTC1n (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 19 Nov 2015 21:27:43 -0500
Subject: Re: [PATCH v4] watchdog: add support for Sigma Designs
 SMP86xx/SMP87xx
To: Mans Rullgard <mans@mansr.com>, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <1447970945-9382-1-git-send-email-mans@mansr.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564E851A.2070205@roeck-us.net>
Date: Thu, 19 Nov 2015 18:27:38 -0800
MIME-Version: 1.0
In-Reply-To: <1447970945-9382-1-git-send-email-mans@mansr.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/19/2015 02:09 PM, Mans Rullgard wrote:
> This adds support for the Sigma Designs SMP86xx/SMP87xx family built-in
> watchdog.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Did you send the bindings document to some other mailing list (only) ?
I see "PATCH 2/2" in some of your submissions, but I seem to be missing
patch 1/2.

Thanks,
Guenter

> ---
> Changes:
> - #include bitops.h
> - clk_disable_unprepare() on failure
> ---
>   drivers/watchdog/Kconfig      |  10 ++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/tangox_wdt.c | 225 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 236 insertions(+)
>   create mode 100644 drivers/watchdog/tangox_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 7a8a6c6..f43ff7a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -135,6 +135,16 @@ config MENF21BMC_WATCHDOG
>   	  This driver can also be built as a module. If so the module
>   	  will be called menf21bmc_wdt.
>
> +config TANGOX_WATCHDOG
> +	tristate "Sigma Designs SMP86xx/SMP87xx watchdog"
> +	select WATCHDOG_CORE
> +	depends on ARCH_TANGOX || COMPILE_TEST
> +	help
> +	  Support for the watchdog in Sigma Designs SMP86xx (tango3)
> +	  and SMP87xx (tango4) family chips.
> +
> +	  This driver can be built as a module. The module name is tangox_wdt.
> +
>   config WM831X_WATCHDOG
>   	tristate "WM831x watchdog"
>   	depends on MFD_WM831X
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 53d4827..46cb387 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -187,6 +187,7 @@ obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
>   obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
>   obj-$(CONFIG_DA9063_WATCHDOG) += da9063_wdt.o
>   obj-$(CONFIG_GPIO_WATCHDOG)	+= gpio_wdt.o
> +obj-$(CONFIG_TANGOX_WATCHDOG) += tangox_wdt.o
>   obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
>   obj-$(CONFIG_WM8350_WATCHDOG) += wm8350_wdt.o
>   obj-$(CONFIG_MAX63XX_WATCHDOG) += max63xx_wdt.o
> diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
> new file mode 100644
> index 0000000..b9ee624
> --- /dev/null
> +++ b/drivers/watchdog/tangox_wdt.c
> @@ -0,0 +1,225 @@
> +/*
> + *  Copyright (C) 2015 Mans Rullgard <mans@mansr.com>
> + *  SMP86xx/SMP87xx Watchdog driver
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under  the terms of the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the License, or (at your
> + *  option) any later version.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/notifier.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/watchdog.h>
> +
> +#define DEFAULT_TIMEOUT 30
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +		 "Watchdog cannot be stopped once started (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static unsigned int timeout;
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout");
> +
> +/*
> + * Counter counts down from programmed value.  Reset asserts when
> + * the counter reaches 1.
> + */
> +#define WD_COUNTER		0
> +
> +#define WD_CONFIG		4
> +#define WD_CONFIG_XTAL_IN	BIT(0)
> +#define WD_CONFIG_DISABLE	BIT(31)
> +
> +struct tangox_wdt_device {
> +	struct watchdog_device wdt;
> +	void __iomem *base;
> +	unsigned long clk_rate;
> +	struct clk *clk;
> +	struct notifier_block restart;
> +};
> +
> +static int tangox_wdt_set_timeout(struct watchdog_device *wdt,
> +				  unsigned int new_timeout)
> +{
> +	wdt->timeout = new_timeout;
> +
> +	return 0;
> +}
> +
> +static int tangox_wdt_start(struct watchdog_device *wdt)
> +{
> +	struct tangox_wdt_device *dev = watchdog_get_drvdata(wdt);
> +	u32 ticks;
> +
> +	ticks = 1 + wdt->timeout * dev->clk_rate;
> +	writel(ticks, dev->base + WD_COUNTER);
> +
> +	return 0;
> +}
> +
> +static int tangox_wdt_stop(struct watchdog_device *wdt)
> +{
> +	struct tangox_wdt_device *dev = watchdog_get_drvdata(wdt);
> +
> +	writel(0, dev->base + WD_COUNTER);
> +
> +	return 0;
> +}
> +
> +static unsigned int tangox_wdt_get_timeleft(struct watchdog_device *wdt)
> +{
> +	struct tangox_wdt_device *dev = watchdog_get_drvdata(wdt);
> +	u32 count;
> +
> +	count = readl(dev->base + WD_COUNTER);
> +
> +	if (!count)
> +		return 0;
> +
> +	return (count - 1) / dev->clk_rate;
> +}
> +
> +static const struct watchdog_info tangox_wdt_info = {
> +	.options  = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	.identity = "tangox watchdog",
> +};
> +
> +static const struct watchdog_ops tangox_wdt_ops = {
> +	.start		= tangox_wdt_start,
> +	.stop		= tangox_wdt_stop,
> +	.set_timeout	= tangox_wdt_set_timeout,
> +	.get_timeleft	= tangox_wdt_get_timeleft,
> +};
> +
> +static int tangox_wdt_restart(struct notifier_block *nb, unsigned long action,
> +			      void *data)
> +{
> +	struct tangox_wdt_device *dev =
> +		container_of(nb, struct tangox_wdt_device, restart);
> +
> +	writel(1, dev->base + WD_COUNTER);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int tangox_wdt_probe(struct platform_device *pdev)
> +{
> +	struct tangox_wdt_device *dev;
> +	struct resource *res;
> +	u32 config;
> +	int err;
> +
> +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	dev->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(dev->base))
> +		return PTR_ERR(dev->base);
> +
> +	dev->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);
> +
> +	err = clk_prepare_enable(dev->clk);
> +	if (err)
> +		return err;
> +
> +	dev->clk_rate = clk_get_rate(dev->clk);
> +
> +	dev->wdt.parent = &pdev->dev;
> +	dev->wdt.info = &tangox_wdt_info;
> +	dev->wdt.ops = &tangox_wdt_ops;
> +	dev->wdt.timeout = DEFAULT_TIMEOUT;
> +	dev->wdt.min_timeout = 1;
> +	dev->wdt.max_timeout = (U32_MAX - 1) / dev->clk_rate;
> +
> +	watchdog_init_timeout(&dev->wdt, timeout, &pdev->dev);
> +	watchdog_set_nowayout(&dev->wdt, nowayout);
> +	watchdog_set_drvdata(&dev->wdt, dev);
> +
> +	/*
> +	 * Deactivate counter if disable bit is set to avoid
> +	 * accidental reset.
> +	 */
> +	config = readl(dev->base + WD_CONFIG);
> +	if (config & WD_CONFIG_DISABLE)
> +		writel(0, dev->base + WD_COUNTER);
> +
> +	writel(WD_CONFIG_XTAL_IN, dev->base + WD_CONFIG);
> +
> +	/*
> +	 * Mark as active and restart with configured timeout if
> +	 * already running.
> +	 */
> +	if (readl(dev->base + WD_COUNTER)) {
> +		set_bit(WDOG_ACTIVE, &dev->wdt.status);
> +		tangox_wdt_start(&dev->wdt);
> +	}
> +
> +	err = watchdog_register_device(&dev->wdt);
> +	if (err) {
> +		clk_disable_unprepare(dev->clk);
> +		return err;
> +	}
> +
> +	platform_set_drvdata(pdev, dev);
> +
> +	dev->restart.notifier_call = tangox_wdt_restart;
> +	dev->restart.priority = 128;
> +	err = register_restart_handler(&dev->restart);
> +	if (err)
> +		dev_warn(&pdev->dev, "failed to register restart handler\n");
> +
> +	dev_info(dev->wdt.dev, "SMP86xx/SMP87xx watchdog registered\n");
> +
> +	return 0;
> +}
> +
> +static int tangox_wdt_remove(struct platform_device *pdev)
> +{
> +	struct tangox_wdt_device *dev = platform_get_drvdata(pdev);
> +
> +	tangox_wdt_stop(&dev->wdt);
> +	clk_disable_unprepare(dev->clk);
> +
> +	unregister_restart_handler(&dev->restart);
> +	watchdog_unregister_device(&dev->wdt);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id tangox_wdt_dt_ids[] = {
> +	{ .compatible = "sigma,smp8642-wdt" },
> +	{ .compatible = "sigma,smp8759-wdt" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, tangox_wdt_dt_ids);
> +
> +static struct platform_driver tangox_wdt_driver = {
> +	.probe	= tangox_wdt_probe,
> +	.remove	= tangox_wdt_remove,
> +	.driver	= {
> +		.name		= "tangox-wdt",
> +		.of_match_table	= tangox_wdt_dt_ids,
> +	},
> +};
> +
> +module_platform_driver(tangox_wdt_driver);
> +
> +MODULE_AUTHOR("Mans Rullgard <mans@mansr.com>");
> +MODULE_DESCRIPTION("SMP86xx/SMP87xx Watchdog driver");
> +MODULE_LICENSE("GPL");
>

