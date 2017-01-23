Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35029 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAWGuN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 23 Jan 2017 01:50:13 -0500
Subject: Re: [PATCH 2/3] watchdog: add driver for Cortina Gemini watchdog
To: Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>
References: <20170122223902.29253-1-linus.walleij@linaro.org>
Cc: Janos Laube <janos.dev@gmail.com>,
        Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        openwrt-devel@openwrt.org, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ade23391-f7d4-0a9e-247a-dcbf6af61de8@roeck-us.net>
Date: Sun, 22 Jan 2017 22:50:03 -0800
MIME-Version: 1.0
In-Reply-To: <20170122223902.29253-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/22/2017 02:39 PM, Linus Walleij wrote:
> This add support for the Cortina systems Gemini (SL3516)
> SoC watchdog.
>
> I have tried to use all the right new kernel interfaces
> and tested with busybox' "watchdog" command both to kick
> and get timeouts and reboots.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/watchdog/Kconfig      |  11 ++
>  drivers/watchdog/Makefile     |   1 +
>  drivers/watchdog/gemini_wdt.c | 241 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 253 insertions(+)
>  create mode 100644 drivers/watchdog/gemini_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index acb00b53a520..3e5ab6712a1e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -301,6 +301,17 @@ config 977_WATCHDOG
>
>  	  Not sure? It's safe to say N.
>
> +config GEMINI_WATCHDOG
> +	tristate "Gemini watchdog"
> +	depends on ARCH_GEMINI
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here if to include support for the watchdog timer
> +	  embedded in the Cortina Systems Gemini family of devices.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called gemini_wdt.
> +
>  config IXP4XX_WATCHDOG
>  	tristate "IXP4xx Watchdog"
>  	depends on ARCH_IXP4XX
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 0c3d35e3c334..953d033b1152 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_OMAP_WATCHDOG) += omap_wdt.o
>  obj-$(CONFIG_TWL4030_WATCHDOG) += twl4030_wdt.o
>  obj-$(CONFIG_21285_WATCHDOG) += wdt285.o
>  obj-$(CONFIG_977_WATCHDOG) += wdt977.o
> +obj-$(CONFIG_GEMINI_WATCHDOG) += gemini_wdt.o
>  obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
>  obj-$(CONFIG_KS8695_WATCHDOG) += ks8695_wdt.o
>  obj-$(CONFIG_S3C2410_WATCHDOG) += s3c2410_wdt.o
> diff --git a/drivers/watchdog/gemini_wdt.c b/drivers/watchdog/gemini_wdt.c
> new file mode 100644
> index 000000000000..11e457538061
> --- /dev/null
> +++ b/drivers/watchdog/gemini_wdt.c
> @@ -0,0 +1,241 @@
> +/*
> + * Watchdog driver for Cortina Systems Gemini SoC
> + *
> + * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
> + *
> + * Inspired by the out-of-tree drivers from OpenWRT:
> + * Copyright (C) 2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <linux/slab.h>
> +#include <linux/bitops.h>
> +#include <linux/of_device.h>
> +#include <linux/interrupt.h>
> +

Alphabetic order please

> +#define GEMINI_WDCOUNTER	0x0
> +#define GEMINI_WDLOAD		0x4
> +#define GEMINI_WDRESTART	0x8
> +#define GEMINI_WDCR		0xC
> +
> +#define WDRESTART_MAGIC		0x5AB9
> +
> +#define WDCR_CLOCK_5MHZ		BIT(4)
> +#define WDCR_SYS_RST		BIT(1)
> +#define WDCR_ENABLE		BIT(0)
> +
> +#define WDT_CLOCK		5000000		/* 5 MHz */
> +
> +struct gemini_wdt {
> +	struct watchdog_device	wdd;
> +	struct device		*dev;
> +	void __iomem		*base;
> +	bool			enabled;

Not needed; see below

> +};
> +
> +static inline
> +struct gemini_wdt *to_gemini_wdt(struct watchdog_device *wdd)
> +{
> +	return container_of(wdd, struct gemini_wdt, wdd);
> +}
> +
> +static int gemini_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct gemini_wdt *gwdt = to_gemini_wdt(wdd);
> +
> +	writel(wdd->timeout * WDT_CLOCK, gwdt->base + GEMINI_WDLOAD);
> +	writel(WDRESTART_MAGIC, gwdt->base + GEMINI_WDRESTART);
> +	/* set clock before enabling */
> +	writel(WDCR_CLOCK_5MHZ | WDCR_SYS_RST,
> +			gwdt->base + GEMINI_WDCR);
> +	writel(WDCR_CLOCK_5MHZ | WDCR_SYS_RST | WDCR_ENABLE,
> +			gwdt->base + GEMINI_WDCR);
> +	gwdt->enabled = true;
> +
> +	return 0;
> +}
> +
> +static int gemini_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct gemini_wdt *gwdt = to_gemini_wdt(wdd);
> +
> +	writel(0, gwdt->base + GEMINI_WDCR);
> +
> +	return 0;
> +}
> +
> +static int gemini_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct gemini_wdt *gwdt = to_gemini_wdt(wdd);
> +
> +	writel(WDRESTART_MAGIC, gwdt->base + GEMINI_WDRESTART);
> +
> +	return 0;
> +}
> +
> +static int gemini_wdt_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int timeout)
> +{
> +	wdd->timeout = timeout;
> +	return gemini_wdt_start(wdd);

The watchdog does not have to be active when this function is called.

> +}
> +
> +static irqreturn_t gemini_wdt_interrupt(int irq, void *data)
> +{
> +	struct gemini_wdt *gwdt = data;
> +
> +	dev_crit(gwdt->dev, "watchdog is barking!\n");
> +

Nothing else ? No reboot ?

> +	return IRQ_HANDLED;
> +}
> +
> +static const struct watchdog_ops gemini_wdt_ops = {
> +	.start		= gemini_wdt_start,
> +	.stop		= gemini_wdt_stop,
> +	.ping		= gemini_wdt_ping,
> +	.set_timeout	= gemini_wdt_set_timeout,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static const struct watchdog_info gemini_wdt_info = {
> +	.options	= WDIOF_KEEPALIVEPING
> +			| WDIOF_MAGICCLOSE
> +			| WDIOF_SETTIMEOUT,
> +	.identity	= KBUILD_MODNAME,
> +};
> +
> +
> +static int gemini_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct gemini_wdt *gwdt;
> +	unsigned int reg;
> +	int irq;
> +	int ret;
> +
> +	gwdt = devm_kzalloc(dev, sizeof(*gwdt), GFP_KERNEL);
> +	if (!gwdt)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	gwdt->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(gwdt->base))
> +		return PTR_ERR(gwdt->base);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (!irq)
> +		return -EINVAL;
> +
> +	gwdt->dev = dev;
> +	gwdt->wdd.info = &gemini_wdt_info;
> +	gwdt->wdd.ops = &gemini_wdt_ops;
> +	gwdt->wdd.min_timeout = 1;
> +	gwdt->wdd.max_timeout = (0xFFFFFFFF / WDT_CLOCK);

Unnecessary ( )

> +	gwdt->wdd.parent = dev;
> +	gwdt->enabled = false;
> +
> +	/*
> +	 * If 'timeout-sec' unspecified in devicetree, assume a 13 second
> +	 * default, unless the max timeout is less than 13 seconds, then use
> +	 * the max instead.
> +	 */
> +	gwdt->wdd.timeout = min(gwdt->wdd.max_timeout, 13U);

WDT_CLOCK is a constant 5000000, meaning the maximum is known to be 858.
Isn't this a lot of complexity for pretty much nothing ?

> +	watchdog_init_timeout(&gwdt->wdd, 0, dev);
> +
> +	reg = readw(gwdt->base + GEMINI_WDCR);
> +	if (reg & WDCR_ENABLE) {
> +		/* Watchdog was enabled by the bootloader, disable it. */
> +		reg &= ~(WDCR_ENABLE);

Unnecessary ( ).

> +		writel(reg, gwdt->base + GEMINI_WDCR);
> +	}
> +
> +	ret = devm_request_irq(dev, irq, gemini_wdt_interrupt, 0,
> +			       "watchdog bark", gwdt);
> +	if (ret)
> +		return ret;
> +
> +	ret = watchdog_register_device(&gwdt->wdd);

devm_watchdog_register_device ? then you can drop the remove function.

> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register watchdog\n");
> +		return ret;
> +	}
> +
> +	/* Set up platform driver data */
> +	platform_set_drvdata(pdev, gwdt);
> +	dev_info(dev, "Gemini watchdog driver enabled\n");
> +
> +	return 0;
> +}
> +
> +static int gemini_wdt_remove(struct platform_device *pdev)
> +{
> +	struct gemini_wdt *gwdt = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&gwdt->wdd);
> +	platform_set_drvdata(pdev, NULL);
> +
Unnecessary (probably gets you a 0day warning)

> +	return 0;
> +}
> +
> +static int __maybe_unused gemini_wdt_suspend(struct device *dev)
> +{
> +	struct gemini_wdt *gwdt = dev_get_drvdata(dev);
> +	unsigned int reg;
> +
> +	reg = readw(gwdt->base + GEMINI_WDCR);
> +	reg &= ~(WDCR_ENABLE);

Unnecessary ( )

> +	writel(reg, gwdt->base + GEMINI_WDCR);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused gemini_wdt_resume(struct device *dev)
> +{
> +	struct gemini_wdt *gwdt = dev_get_drvdata(dev);
> +	unsigned int reg;
> +
> +	if (gwdt->enabled) {

if (watchdog_active(&gwdt->wdd)) {

> +		reg = readw(gwdt->base + GEMINI_WDCR);
> +		reg |= WDCR_ENABLE;
> +		writel(reg, gwdt->base + GEMINI_WDCR);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops gemini_wdt_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(gemini_wdt_suspend,
> +				gemini_wdt_resume)
> +};
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id gemini_wdt_match[] = {
> +	{ .compatible = "cortina,gemini-watchdog" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, gemini_wdt_match);
> +#endif
> +
> +static struct platform_driver gemini_wdt_driver = {
> +	.probe		= gemini_wdt_probe,
> +	.remove		= gemini_wdt_remove,
> +	.driver		= {
> +		.name	= "gemini-wdt",
> +		.of_match_table = of_match_ptr(gemini_wdt_match),
> +		.pm = &gemini_wdt_dev_pm_ops,
> +	},
> +};
> +module_platform_driver(gemini_wdt_driver);
> +MODULE_AUTHOR("Linus Walleij");
> +MODULE_DESCRIPTION("Watchdog driver for Gemini");
> +MODULE_LICENSE("GPL");
>

