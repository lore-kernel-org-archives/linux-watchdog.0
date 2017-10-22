Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:50375 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbdJVRaC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 13:30:02 -0400
Received: by mail-pg0-f66.google.com with SMTP id y5so2243744pgq.7
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Oct 2017 10:30:02 -0700 (PDT)
Date: Sun, 22 Oct 2017 10:30:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [4/5,v2] watchdog: ftwdt010: Add clock support
Message-ID: <20171022173000.GA17484@roeck-us.net>
References: <20171016205427.4297-4-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016205427.4297-4-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Oct 16, 2017 at 10:54:26PM +0200, Linus Walleij wrote:
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
Am I missing something ? The code suggests that PCLK is mandatory.

+	gwdt->pclk = devm_clk_get(dev, "PCLK");
+	if (IS_ERR(gwdt->pclk))
+		return PTR_ERR(gwdt->pclk);

> Take this opportunity to implement .remove() for the driver that
> stops the watchdog and disables the clocks.
> 
> Add credits that this code is inspired by MOXA ART.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Strictly require the clock framework
> - Sort header files in alphabetic order
> - Fix the error path to properly disable the clocks
> - Fix spelling in commit message
> - Be minimalist with informational messages and cut down
>   on error messages
> ---
>  drivers/watchdog/Kconfig        |  1 +
>  drivers/watchdog/ftwdt010_wdt.c | 79 ++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 71 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index fd44a542036a..245cff03c992 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -324,6 +324,7 @@ config 977_WATCHDOG
>  config FTWDT010_WATCHDOG
>  	tristate "Faraday Technology FTWDT010 watchdog"
>  	depends on ARM || COMPILE_TEST
> +	depends on COMMON_CLK
>  	select WATCHDOG_CORE
>  	default ARCH_GEMINI
>  	help
> diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
> index a9c2912ee280..21c3ac7f557a 100644
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
> @@ -12,12 +14,14 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/clk.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/watchdog.h>
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
> @@ -55,10 +61,12 @@ static int ftwdt010_wdt_start(struct watchdog_device *wdd)
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
>  	if (gwdt->has_irq)
>  		enable |= WDCR_WDINTR;
> @@ -124,6 +132,7 @@ static const struct watchdog_info ftwdt010_wdt_info = {
>  static int ftwdt010_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
>  	struct resource *res;
>  	struct ftwdt010_wdt *gwdt;
>  	unsigned int reg;
> @@ -139,11 +148,40 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(gwdt->base))
>  		return PTR_ERR(gwdt->base);
>  
> +	gwdt->use_extclk = of_property_read_bool(np, "faraday,use-extclk");

Documentation and Ack from Rob required.

> +
> +	gwdt->pclk = devm_clk_get(dev, "PCLK");
> +	if (IS_ERR(gwdt->pclk))
> +		return PTR_ERR(gwdt->pclk);
> +	ret = clk_prepare_enable(gwdt->pclk);
> +	if (ret)
> +		return ret;
> +	if (!gwdt->use_extclk)
> +		gwdt->clk_freq = clk_get_rate(gwdt->pclk);

else case to the is statement below ?

> +
> +	/* Only enable and get frequency from EXTCLK if it's in use */
> +	if (gwdt->use_extclk) {

Does this use case still require pclk ?

> +		gwdt->extclk = devm_clk_get(dev, "EXTCLK");
> +		if (IS_ERR(gwdt->extclk)) {
> +			ret = PTR_ERR(gwdt->extclk);
> +			goto out_disable_pclk;
> +		}
> +		ret = clk_prepare_enable(gwdt->extclk);
> +		if (ret)
> +			goto out_disable_pclk;
> +		gwdt->clk_freq = clk_get_rate(gwdt->extclk);
> +	}
> +
> +	if (gwdt->clk_freq == 0) {
> +		ret = -EINVAL;
> +		goto out_disable_extclk;

Yet another use case of the rejected devm_clk_prepare_enable() :-(.

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
>  	/*
> @@ -165,19 +203,41 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
>  		ret = devm_request_irq(dev, irq, ftwdt010_wdt_interrupt, 0,
>  				       "watchdog bark", gwdt);
>  		if (ret)
> -			return ret;
> +			goto out_disable_extclk;
>  		gwdt->has_irq = true;
>  	}
>  
>  	ret = devm_watchdog_register_device(dev, &gwdt->wdd);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register watchdog\n");
> -		return ret;
> +		goto out_disable_extclk;
>  	}
>  
>  	/* Set up platform driver data */
>  	platform_set_drvdata(pdev, gwdt);
> -	dev_info(dev, "FTWDT010 watchdog driver enabled\n");
> +	dev_info(dev, "FTWDT010 watchdog driver @%uHz\n",
> +		 gwdt->clk_freq);
> +
> +	return 0;
> +
> +out_disable_extclk:
> +	if (gwdt->use_extclk)
> +		clk_disable_unprepare(gwdt->extclk);
> +out_disable_pclk:
> +	if (!IS_ERR(gwdt->pclk))
> +		clk_disable_unprepare(gwdt->pclk);
> +
> +	return ret;
> +}
> +
> +static int ftwdt010_wdt_remove(struct platform_device *pdev)
> +{
> +	struct ftwdt010_wdt *gwdt = platform_get_drvdata(pdev);
> +
> +	writel(0, gwdt->base + FTWDT010_WDCR);
> +	clk_disable_unprepare(gwdt->pclk);
> +	if (gwdt->use_extclk)
> +		clk_disable_unprepare(gwdt->extclk);
>  
>  	return 0;
>  }
> @@ -224,6 +284,7 @@ MODULE_DEVICE_TABLE(of, ftwdt010_wdt_match);
>  
>  static struct platform_driver ftwdt010_wdt_driver = {
>  	.probe		= ftwdt010_wdt_probe,
> +	.remove		= ftwdt010_wdt_remove,
>  	.driver		= {
>  		.name	= "ftwdt010-wdt",
>  		.of_match_table = of_match_ptr(ftwdt010_wdt_match),
