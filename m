Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57993 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932616AbbKMQfh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Nov 2015 11:35:37 -0500
Subject: Re: [RESEND][PATCH] watchdog: add support for Sigma Designs SMP86xx
To: Mans Rullgard <mans@mansr.com>, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <1447420459-5301-1-git-send-email-mans@mansr.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56461155.80808@roeck-us.net>
Date: Fri, 13 Nov 2015 08:35:33 -0800
MIME-Version: 1.0
In-Reply-To: <1447420459-5301-1-git-send-email-mans@mansr.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/13/2015 05:14 AM, Mans Rullgard wrote:
> This adds support for the Sigma Designs SMP86xx family built-in
> watchdog.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>   drivers/watchdog/Kconfig      |   7 ++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/tangox_wdt.c | 185 ++++++++++++++++++++++++++++++++++++++++++

Why tangox_wdt instead of smp86xx_wdt.c ?

tangox also implies that this would (should) work for SMP87xx as well,
about which no statement is made. So why not tango3_wdt ?

[ ok, I see all drivers are named tangox, so if the other maintainers
   are ok with that, so am I. ]

Is it known if the driver will work for any of the other chips of the
series (SMP86XX/SMP87XX) ?

I think it would be helpful to describe in more detail which chips
are supported, or at least which chips should work but are untested.

>   3 files changed, 193 insertions(+)
>   create mode 100644 drivers/watchdog/tangox_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 79e1aa1..0ed5ee8 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1337,6 +1337,13 @@ config RALINK_WDT
>   	help
>   	  Hardware driver for the Ralink SoC Watchdog Timer.
>
> +config TANGOX_WDT
> +	tristate "SMP86xx watchdog"
> +	select WATCHDOG_CORE
> +	depends on ARCH_TANGOX
> +	help
> +	  Watchdog driver for Sigma Designs SMP86xx.

Not really; it is for SMP8642, and we don't know if other (later ?) chips
will be supported by the same driver. You should be explicit here. More chips
can be added later (that would be needed for the devicetree bindings anyway)
as they are tested.

> +
>   # PARISC Architecture
>
>   # POWERPC Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 0c616e3..ed00796 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -148,6 +148,7 @@ octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
>   obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
>   obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
>   obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
> +obj-$(CONFIG_TANGOX_WDT) += tangox_wdt.o
>
>   # PARISC Architecture
>
> diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
> new file mode 100644
> index 0000000..305759f
> --- /dev/null
> +++ b/drivers/watchdog/tangox_wdt.c
> @@ -0,0 +1,185 @@
> +/*
> + *  Copyright (C) 2014, Mans Rullgard <mans@mansr.com>
> + *  SMP86xx Watchdog driver
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under  the terms of the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the License, or (at your
> + *  option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/notifier.h>
> +#include <linux/delay.h>
> +#include <linux/reboot.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>

Please list include files in alphabetic order.

> +
> +#define DEFAULT_TIMEOUT	30
> +#define MAX_TIMEOUT	120
> +

This looks like an arbitrary value. You should calculate the real
maximum by dividing the maximum register value by the clock rate.

> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +		 "Watchdog cannot be stopped once started (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static unsigned int timeout = DEFAULT_TIMEOUT;
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(watchdog_timeout, "Watchdog timeout");
> +
> +#define WD_COUNTER	0
> +#define WD_CONFIG	4
> +
> +struct tangox_wdt_device {
> +	struct watchdog_device wdt;
> +	void __iomem *base;
> +	unsigned int timeout;
> +	struct clk *clk;
> +	struct notifier_block restart;
> +};
> +
> +static int tangox_wdt_ping(struct watchdog_device *wdt)
> +{
> +	struct tangox_wdt_device *dev = watchdog_get_drvdata(wdt);
> +
> +	writel(dev->timeout, dev->base + WD_COUNTER);
> +
> +	return 0;
> +}
> +
> +static int tangox_wdt_set_timeout(struct watchdog_device *wdt,
> +				  unsigned int new_timeout)
> +{
> +	struct tangox_wdt_device *dev = watchdog_get_drvdata(wdt);
> +
> +	wdt->timeout = new_timeout;
> +	dev->timeout = 1 + new_timeout * clk_get_rate(dev->clk);

Why "1 +" ?

> +
> +	tangox_wdt_ping(wdt);
> +
The infrastructure does that already.

> +	return 0;
> +}
> +
> +static int tangox_wdt_start(struct watchdog_device *wdt)
> +{
> +	return tangox_wdt_set_timeout(wdt, wdt->timeout);

This is an odd way of setting dev->timeout.
You should set it in the probe function instead.
Unless I am missing something, the ping and start functions will then
be the same and you'll only need one of them.

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
> +static const struct watchdog_info tangox_wdt_info = {
> +	.options  = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	.identity = "tangox watchdog",
> +};
> +
> +static const struct watchdog_ops tangox_wdt_ops = {
> +	.start		= tangox_wdt_start,
> +	.stop		= tangox_wdt_stop,
> +	.ping		= tangox_wdt_ping,
> +	.set_timeout	= tangox_wdt_set_timeout,
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

A comment might be useful here, explaining what this does (reset after minimum timeout ?).
Also, the code should wait a bit to ensure that the reset 'catches'
before the function returns.

> +	return NOTIFY_DONE;
> +}
> +
> +static int tangox_wdt_probe(struct platform_device *pdev)
> +{
> +	struct tangox_wdt_device *dev;
> +	struct resource *res;
> +	int err;
> +
> +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->wdt.parent = &pdev->dev;
> +	dev->wdt.info = &tangox_wdt_info;
> +	dev->wdt.ops = &tangox_wdt_ops;
> +	dev->wdt.timeout = timeout;

It might make more sense to use watchdog_init_timeout(),
especially since the driver supports devicetree and the timeout
can be set in devicetree data.

> +	dev->wdt.min_timeout = 1;
> +	dev->wdt.max_timeout = MAX_TIMEOUT;
> +	watchdog_set_nowayout(&dev->wdt, nowayout);
> +	watchdog_set_drvdata(&dev->wdt, dev);
> +
> +	dev->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);

Normally one calls clk_prepare_enable() after clk_get()
(and clk_disable_unprepare when exiting).

Also, it might make sense to read the clock rate once and store it
in a variable.

> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	dev->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(dev->base))
> +		return PTR_ERR(dev->base);
> +
> +	writel(0, dev->base + WD_COUNTER);

This always stops the watchdog even if already running.
Is this on purpose ?

> +	writel(1, dev->base + WD_CONFIG);

A define or a comment might help here to explain what this write does.

> +
> +	err = watchdog_register_device(&dev->wdt);
> +	if (err)
> +		return err;
> +
> +	platform_set_drvdata(pdev, dev);
> +
> +	dev->restart.notifier_call = tangox_wdt_restart;
> +	dev->restart.priority = 128;
> +	err = register_restart_handler(&dev->restart);
> +	if (err)
> +		dev_err(&pdev->dev, "failed to register restart handler\n");

dev_warn

> +
> +	dev_info(dev->wdt.dev, "SMP86xx watchdog registered\n");
> +
> +	return 0;
> +}
> +
> +static int tangox_wdt_remove(struct platform_device *pdev)
> +{
> +	struct tangox_wdt_device *dev = platform_get_drvdata(pdev);
> +
> +	tangox_wdt_stop(&dev->wdt);
> +	unregister_restart_handler(&dev->restart);
> +	watchdog_unregister_device(&dev->wdt);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id tangox_wdt_dt_ids[] = {
> +	{ .compatible = "sigma,smp8642-wdt" },

So this is really for smp8642 only, not for any other chips in the series ?

> +	{ }

Do you have a devicetree bindings file ? You should have, and it should
describe all necessary and optional bindings including clocks.

> +};
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
> +MODULE_DESCRIPTION("SMP86xx Watchdog driver");
> +MODULE_LICENSE("GPL");
>
MODULE_ALIAS ?

