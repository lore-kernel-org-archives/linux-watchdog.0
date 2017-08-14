Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49319 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdHNQFj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 12:05:39 -0400
Date: Mon, 14 Aug 2017 09:05:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 04/11] watchdog: ftwdt010: Add clock support
Message-ID: <20170814160536.GC7025@roeck-us.net>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-5-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170812184318.10144-5-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Aug 12, 2017 at 08:43:11PM +0200, Linus Walleij wrote:
> The Gemini platform now provides a proper clock look-up for this
> and other IPs, so add clock support to the driver. This also aids
> in using the same driver with other platforms such as MOXA ART.
> 
> The IP has two clock inputs: PCLK (the IP peripheral clock) and
> EXTCLK (an external clock). We are a bit elaborate around this:
> on Gemini the EXTCLK is used by default today and it's 5MHz, and
> on MOXA ART the PCLK is used. On Aspeed the EXTCLK is used and
> it's 1MHz. So add some clever code to fall back to platform
> defaults if PCLK or EXTCLK is not provided by the device tree.
> 
> Take this opportnity to implement .remove() for the driver that

opportunity

> stops the watchdog and disables the clocks.
> 
> Add credits that this code is inspired by MOXA ART.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/watchdog/ftwdt010_wdt.c | 79 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 71 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
> index ab38a3a89300..680279f5c679 100644
> --- a/drivers/watchdog/ftwdt010_wdt.c
> +++ b/drivers/watchdog/ftwdt010_wdt.c
> @@ -5,6 +5,8 @@
>   *
>   * Inspired by the out-of-tree drivers from OpenWRT:
>   * Copyright (C) 2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
> + * Inspired by the MOXA ART driver from Jonas Jensen:
> + * Copyright (C) 2013 Jonas Jensen <jonas.jensen@gmail.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -18,9 +20,11 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/watchdog.h>
> +#include <linux/clk.h>

Any chance to maintain alphabetic order with include files ?

>  
>  #define FTWDT010_WDCOUNTER	0x0
>  #define FTWDT010_WDLOAD		0x4
> @@ -29,19 +33,21 @@
>  
>  #define WDRESTART_MAGIC		0x5AB9
>  
> -#define WDCR_CLOCK_5MHZ		BIT(4)
> +#define WDCR_EXTCLK		BIT(4)
>  #define WDCR_WDEXT		BIT(3)
>  #define WDCR_WDINTR		BIT(2)
>  #define WDCR_SYS_RST		BIT(1)
>  #define WDCR_ENABLE		BIT(0)
>  
> -#define WDT_CLOCK		5000000		/* 5 MHz */
> -
>  struct ftwdt010_wdt {
>  	struct watchdog_device	wdd;
>  	struct device		*dev;
>  	void __iomem		*base;
>  	bool			has_irq;
> +	struct clk		*pclk;
> +	struct clk		*extclk;
> +	unsigned int		clk_freq;
> +	bool			use_extclk;
>  };
>  
>  static inline
> @@ -55,12 +61,13 @@ static int ftwdt010_wdt_start(struct watchdog_device *wdd)
>  	struct ftwdt010_wdt *gwdt = to_ftwdt010_wdt(wdd);
>  	u32 enable;
>  
> -	writel(wdd->timeout * WDT_CLOCK, gwdt->base + FTWDT010_WDLOAD);
> +	writel(wdd->timeout * gwdt->clk_freq, gwdt->base + FTWDT010_WDLOAD);
>  	writel(WDRESTART_MAGIC, gwdt->base + FTWDT010_WDRESTART);
>  	/* set clock before enabling */
> -	enable = WDCR_CLOCK_5MHZ | WDCR_SYS_RST;
> +	enable = WDCR_SYS_RST;
> +	if (gwdt->use_extclk)
> +		enable |= WDCR_EXTCLK;
>  	writel(enable, gwdt->base + FTWDT010_WDCR);
> -	enable |= WDCR_CLOCK_5MHZ;
>  	if (gwdt->has_irq)
>  		enable |= WDCR_WDINTR;
>  	enable |= WDCR_ENABLE;
> @@ -125,6 +132,7 @@ static const struct watchdog_info ftwdt010_wdt_info = {
>  static int ftwdt010_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
>  	struct resource *res;
>  	struct ftwdt010_wdt *gwdt;
>  	unsigned int reg;
> @@ -140,11 +148,51 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(gwdt->base))
>  		return PTR_ERR(gwdt->base);
>  
> +	gwdt->use_extclk = of_property_read_bool(np, "faraday,use-extclk");
> +
> +	gwdt->pclk = devm_clk_get(dev, "PCLK");
> +	if (!IS_ERR(gwdt->pclk)) {

devm_clk_get() can return NULL (if the clock subsystem is not enabled).

> +		ret = clk_prepare_enable(gwdt->pclk);

Why enable pclk if extclk is used ?

> +		if (ret) {
> +			dev_err(&pdev->dev, "unable to enable PCLK\n");
> +			return ret;
> +		}
> +		if (!gwdt->use_extclk)
> +			gwdt->clk_freq = clk_get_rate(gwdt->pclk);
> +	} else {
> +		dev_info(dev, "PCLK clock not found assume always-on\n");

Those info messages seem more like debug messages to me. Is this and the message
below about 5MHz clock on Gemini really necessary ?

> +	}
> +
> +	gwdt->extclk = devm_clk_get(dev, "EXTCLK");
> +	if (!IS_ERR(gwdt->extclk)) {

devm_clk_get() can return NULL.

> +		/* Only enable and get frequency from EXTCLK if it's in use */
> +		if (gwdt->use_extclk) {
> +			ret = clk_prepare_enable(gwdt->extclk);
> +			if (ret) {
> +				dev_err(&pdev->dev,
> +					"unable to enable EXTCLK\n");
> +				return ret;
> +			}
> +			gwdt->clk_freq = clk_get_rate(gwdt->extclk);
> +		}
> +	} else {
> +		if (of_device_is_compatible(np, "cortina,gemini-watchdog")) {
> +			gwdt->clk_freq = 5000000;
> +			gwdt->use_extclk = true;
> +			dev_info(dev, "assume 5MHz EXTCLK on Gemini\n");
> +		}
> +	}
> +
> +	if (gwdt->clk_freq == 0) {
> +		dev_err(dev, "no clocking available\n");
> +		return -EINVAL;

So far this situation defaulted to 5 MHz (as there was nothing else).
Is this a new restriction or did it just not happen ?

Also, this can at least in theory happen if clk_get_rate() returns 0,
which would leave the clock enabled (although that would be an odd
situation).

> +	}
> +
>  	gwdt->dev = dev;
>  	gwdt->wdd.info = &ftwdt010_wdt_info;
>  	gwdt->wdd.ops = &ftwdt010_wdt_ops;
>  	gwdt->wdd.min_timeout = 1;
> -	gwdt->wdd.max_timeout = 0xFFFFFFFF / WDT_CLOCK;
> +	gwdt->wdd.max_timeout = UINT_MAX / gwdt->clk_freq;
>  	gwdt->wdd.parent = dev;
>  

devm_watchdog_register_device() can fail, which would leave the clocks
enabled. Also see below.

>  	/*
> @@ -178,7 +226,21 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
>  
>  	/* Set up platform driver data */
>  	platform_set_drvdata(pdev, gwdt);
> -	dev_info(dev, "FTWDT010 watchdog driver enabled\n");
> +	dev_info(dev, "FTWDT010 watchdog driver @%uHz\n",
> +		 gwdt->clk_freq);
> +
> +	return 0;
> +}
> +
> +static int ftwdt010_wdt_remove(struct platform_device *pdev)
> +{
> +	struct ftwdt010_wdt *gwdt = platform_get_drvdata(pdev);
> +
> +	writel(0, gwdt->base + FTWDT010_WDCR);
> +	if (!IS_ERR(gwdt->pclk))
> +		clk_disable_unprepare(gwdt->pclk);
> +	if (!IS_ERR(gwdt->extclk) && gwdt->use_extclk)
> +		clk_disable_unprepare(gwdt->extclk);

One of those many situations where devm_clk_prepare_enable() would have
been very useful :-(. This disables the clocks while the watchdog itself
as well as its interrupt handler is still registered. I don't know if this
will have adverse affects, but it makes me quite concerned. Please consider
adding devm_add_action() calls to clean up the clocks. Note that I would
resist replacing all the devm_ functions with non-devm equivalents just
because the clock subsystem doesn't provide the necessary API functions.

Side note: Maybe we _should_ introduce devm_watchdog_clk_prepare_enable()
since this problem affects several watchdog drivers.

Guenter

>  
>  	return 0;
>  }
> @@ -225,6 +287,7 @@ MODULE_DEVICE_TABLE(of, ftwdt010_wdt_match);
>  
>  static struct platform_driver ftwdt010_wdt_driver = {
>  	.probe		= ftwdt010_wdt_probe,
> +	.remove		= ftwdt010_wdt_remove,
>  	.driver		= {
>  		.name	= "ftwdt010-wdt",
>  		.of_match_table = of_match_ptr(ftwdt010_wdt_match),
> -- 
> 2.13.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
