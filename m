Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40604 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752665AbdHNPEh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 11:04:37 -0400
Date: Mon, 14 Aug 2017 08:04:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 09/11] watchdog: ftwdt010/aspeed: Merge Aspeed into
 FTWDT010
Message-ID: <20170814150434.GH14491@roeck-us.net>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-10-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170812184318.10144-10-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Aug 12, 2017 at 08:43:16PM +0200, Linus Walleij wrote:
> These two drivers is for the almost the same hardware,
> the only differences are:
> - The Aspeed IP block has been hacked to use a different
>   magic value.
> - The Aspeed has hard-wired 1MHz to the EXTCLK and
>   apparently even disabled the use of PCLK for clocking
>   the block on AST2500.
> 
Confused. I thought the ast2500 is an EC. Am I missing something ?

Guenter

> Delete the old Aspeed driver and augment the FTWDT010 to
> probe on this platform too. Select the driver by default
> for ARCH_ASPEED to make a smooth transition of the platform.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/watchdog/Kconfig        |  18 +---
>  drivers/watchdog/Makefile       |   1 -
>  drivers/watchdog/aspeed_wdt.c   | 200 ----------------------------------------
>  drivers/watchdog/ftwdt010_wdt.c |  25 ++++-
>  4 files changed, 25 insertions(+), 219 deletions(-)
>  delete mode 100644 drivers/watchdog/aspeed_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index beef6bb5c6d9..0296fab14c35 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -327,10 +327,11 @@ config FTWDT010_WATCHDOG
>  	select WATCHDOG_CORE
>  	default ARCH_GEMINI
>  	default ARCH_MOXART
> +	default ARCH_ASPEED
>  	help
>  	  Say Y here if to include support for the Faraday Technology
> -	  FTWDT010 watchdog timer embedded in the Cortina Systems Gemini
> -	  family of devices.
> +	  FTWDT010 watchdog timer embedded in the Cortina Systems Gemini,
> +	  MOXA ART and Aspeed families of devices.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ftwdt010_wdt.
> @@ -733,19 +734,6 @@ config RENESAS_RZAWDT
>  	  This driver adds watchdog support for the integrated watchdogs in the
>  	  Renesas RZ/A SoCs. These watchdogs can be used to reset a system.
>  
> -config ASPEED_WATCHDOG
> -	tristate "Aspeed 2400 watchdog support"
> -	depends on ARCH_ASPEED || COMPILE_TEST
> -	select WATCHDOG_CORE
> -	help
> -	  Say Y here to include support for the watchdog timer
> -	  in Apseed BMC SoCs.
> -
> -	  This driver is required to reboot the SoC.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called aspeed_wdt.
> -
>  config ZX2967_WATCHDOG
>  	tristate "ZTE zx2967 SoCs watchdog support"
>  	depends on ARCH_ZX
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index fcab71f0a1c7..a9701d39928d 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -82,7 +82,6 @@ obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
>  obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
>  obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
>  obj-$(CONFIG_RENESAS_RZAWDT) += rza_wdt.o
> -obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
>  obj-$(CONFIG_ZX2967_WATCHDOG) += zx2967_wdt.o
>  obj-$(CONFIG_STM32_WATCHDOG) += stm32_iwdg.o
>  obj-$(CONFIG_UNIPHIER_WATCHDOG) += uniphier_wdt.o
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> deleted file mode 100644
> index 1c652582de40..000000000000
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ /dev/null
> @@ -1,200 +0,0 @@
> -/*
> - * Copyright 2016 IBM Corporation
> - *
> - * Joel Stanley <joel@jms.id.au>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/platform_device.h>
> -#include <linux/watchdog.h>
> -
> -struct aspeed_wdt {
> -	struct watchdog_device	wdd;
> -	void __iomem		*base;
> -	u32			ctrl;
> -};
> -
> -static const struct of_device_id aspeed_wdt_of_table[] = {
> -	{ .compatible = "aspeed,ast2400-wdt" },
> -	{ .compatible = "aspeed,ast2500-wdt" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
> -
> -#define WDT_STATUS		0x00
> -#define WDT_RELOAD_VALUE	0x04
> -#define WDT_RESTART		0x08
> -#define WDT_CTRL		0x0C
> -#define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
> -#define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
> -#define   WDT_CTRL_1MHZ_CLK		BIT(4)
> -#define   WDT_CTRL_WDT_EXT		BIT(3)
> -#define   WDT_CTRL_WDT_INTR		BIT(2)
> -#define   WDT_CTRL_RESET_SYSTEM		BIT(1)
> -#define   WDT_CTRL_ENABLE		BIT(0)
> -
> -#define WDT_RESTART_MAGIC	0x4755
> -
> -/* 32 bits at 1MHz, in milliseconds */
> -#define WDT_MAX_TIMEOUT_MS	4294967
> -#define WDT_DEFAULT_TIMEOUT	30
> -#define WDT_RATE_1MHZ		1000000
> -
> -static struct aspeed_wdt *to_aspeed_wdt(struct watchdog_device *wdd)
> -{
> -	return container_of(wdd, struct aspeed_wdt, wdd);
> -}
> -
> -static void aspeed_wdt_enable(struct aspeed_wdt *wdt, int count)
> -{
> -	wdt->ctrl |= WDT_CTRL_ENABLE;
> -
> -	writel(0, wdt->base + WDT_CTRL);
> -	writel(count, wdt->base + WDT_RELOAD_VALUE);
> -	writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
> -	writel(wdt->ctrl, wdt->base + WDT_CTRL);
> -}
> -
> -static int aspeed_wdt_start(struct watchdog_device *wdd)
> -{
> -	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
> -
> -	aspeed_wdt_enable(wdt, wdd->timeout * WDT_RATE_1MHZ);
> -
> -	return 0;
> -}
> -
> -static int aspeed_wdt_stop(struct watchdog_device *wdd)
> -{
> -	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
> -
> -	wdt->ctrl &= ~WDT_CTRL_ENABLE;
> -	writel(wdt->ctrl, wdt->base + WDT_CTRL);
> -
> -	return 0;
> -}
> -
> -static int aspeed_wdt_ping(struct watchdog_device *wdd)
> -{
> -	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
> -
> -	writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
> -
> -	return 0;
> -}
> -
> -static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
> -				  unsigned int timeout)
> -{
> -	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
> -	u32 actual;
> -
> -	wdd->timeout = timeout;
> -
> -	actual = min(timeout, wdd->max_hw_heartbeat_ms * 1000);
> -
> -	writel(actual * WDT_RATE_1MHZ, wdt->base + WDT_RELOAD_VALUE);
> -	writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
> -
> -	return 0;
> -}
> -
> -static int aspeed_wdt_restart(struct watchdog_device *wdd,
> -			      unsigned long action, void *data)
> -{
> -	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
> -
> -	aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
> -
> -	mdelay(1000);
> -
> -	return 0;
> -}
> -
> -static const struct watchdog_ops aspeed_wdt_ops = {
> -	.start		= aspeed_wdt_start,
> -	.stop		= aspeed_wdt_stop,
> -	.ping		= aspeed_wdt_ping,
> -	.set_timeout	= aspeed_wdt_set_timeout,
> -	.restart	= aspeed_wdt_restart,
> -	.owner		= THIS_MODULE,
> -};
> -
> -static const struct watchdog_info aspeed_wdt_info = {
> -	.options	= WDIOF_KEEPALIVEPING
> -			| WDIOF_MAGICCLOSE
> -			| WDIOF_SETTIMEOUT,
> -	.identity	= KBUILD_MODNAME,
> -};
> -
> -static int aspeed_wdt_probe(struct platform_device *pdev)
> -{
> -	struct aspeed_wdt *wdt;
> -	struct resource *res;
> -	int ret;
> -
> -	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> -	if (!wdt)
> -		return -ENOMEM;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	wdt->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(wdt->base))
> -		return PTR_ERR(wdt->base);
> -
> -	/*
> -	 * The ast2400 wdt can run at PCLK, or 1MHz. The ast2500 only
> -	 * runs at 1MHz. We chose to always run at 1MHz, as there's no
> -	 * good reason to have a faster watchdog counter.
> -	 */
> -	wdt->wdd.info = &aspeed_wdt_info;
> -	wdt->wdd.ops = &aspeed_wdt_ops;
> -	wdt->wdd.max_hw_heartbeat_ms = WDT_MAX_TIMEOUT_MS;
> -	wdt->wdd.parent = &pdev->dev;
> -
> -	wdt->wdd.timeout = WDT_DEFAULT_TIMEOUT;
> -	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
> -
> -	/*
> -	 * Control reset on a per-device basis to ensure the
> -	 * host is not affected by a BMC reboot, so only reset
> -	 * the SOC and not the full chip
> -	 */
> -	wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
> -		WDT_CTRL_1MHZ_CLK |
> -		WDT_CTRL_RESET_SYSTEM;
> -
> -	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
> -		aspeed_wdt_start(&wdt->wdd);
> -		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> -	}
> -
> -	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to register\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static struct platform_driver aspeed_watchdog_driver = {
> -	.probe = aspeed_wdt_probe,
> -	.driver = {
> -		.name = KBUILD_MODNAME,
> -		.of_match_table = of_match_ptr(aspeed_wdt_of_table),
> -	},
> -};
> -module_platform_driver(aspeed_watchdog_driver);
> -
> -MODULE_DESCRIPTION("Aspeed Watchdog Driver");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
> index 912b55e67110..072da594bcbd 100644
> --- a/drivers/watchdog/ftwdt010_wdt.c
> +++ b/drivers/watchdog/ftwdt010_wdt.c
> @@ -7,6 +7,8 @@
>   * Copyright (C) 2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
>   * Inspired by the MOXA ART driver from Jonas Jensen:
>   * Copyright (C) 2013 Jonas Jensen <jonas.jensen@gmail.com>
> + * Inspired by the Aspeed driver from Joel Stanley <joel@jms.id.au>:
> + * Copyright 2016 IBM Corporation
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -32,7 +34,9 @@
>  #define FTWDT010_WDCR		0xC
>  
>  #define WDRESTART_MAGIC		0x5AB9
> +#define ASPEED_MAGIC		0x4755
>  
> +#define ASPEED_RESET_FULL_CHIP	BIT(5)
>  #define WDCR_EXTCLK		BIT(4)
>  #define WDCR_WDEXT		BIT(3)
>  #define WDCR_WDINTR		BIT(2)
> @@ -48,6 +52,7 @@ struct ftwdt010_wdt {
>  	struct clk		*extclk;
>  	unsigned int		clk_freq;
>  	bool			use_extclk;
> +	u32			magic;
>  };
>  
>  static inline
> @@ -63,7 +68,7 @@ static int ftwdt010_wdt_restart(struct watchdog_device *wdd,
>  	u32 enable;
>  
>  	writel(1, gwdt->base + FTWDT010_WDLOAD);
> -	writel(WDRESTART_MAGIC, gwdt->base + FTWDT010_WDRESTART);
> +	writel(gwdt->magic, gwdt->base + FTWDT010_WDRESTART);
>  	enable = WDCR_SYS_RST | WDCR_ENABLE;
>  	if (gwdt->use_extclk)
>  		enable |= WDCR_EXTCLK;
> @@ -78,7 +83,7 @@ static int ftwdt010_wdt_start(struct watchdog_device *wdd)
>  	u32 enable;
>  
>  	writel(wdd->timeout * gwdt->clk_freq, gwdt->base + FTWDT010_WDLOAD);
> -	writel(WDRESTART_MAGIC, gwdt->base + FTWDT010_WDRESTART);
> +	writel(gwdt->magic, gwdt->base + FTWDT010_WDRESTART);
>  	/* set clock before enabling */
>  	enable = WDCR_SYS_RST;
>  	if (gwdt->use_extclk)
> @@ -105,7 +110,7 @@ static int ftwdt010_wdt_ping(struct watchdog_device *wdd)
>  {
>  	struct ftwdt010_wdt *gwdt = to_ftwdt010_wdt(wdd);
>  
> -	writel(WDRESTART_MAGIC, gwdt->base + FTWDT010_WDRESTART);
> +	writel(gwdt->magic, gwdt->base + FTWDT010_WDRESTART);
>  
>  	return 0;
>  }
> @@ -153,6 +158,7 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	struct ftwdt010_wdt *gwdt;
>  	unsigned int reg;
> +	bool is_aspeed;
>  	int irq;
>  	int ret;
>  
> @@ -167,6 +173,10 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
>  
>  	gwdt->use_extclk = of_property_read_bool(np, "faraday,use-extclk");
>  
> +	/* We want to know if we are aspeed */
> +	is_aspeed = of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
> +		of_device_is_compatible(np, "aspeed,ast2500-wdt");
> +
>  	gwdt->pclk = devm_clk_get(dev, "PCLK");
>  	if (!IS_ERR(gwdt->pclk)) {
>  		ret = clk_prepare_enable(gwdt->pclk);
> @@ -198,6 +208,11 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
>  			gwdt->use_extclk = true;
>  			dev_info(dev, "assume 5MHz EXTCLK on Gemini\n");
>  		}
> +		if (is_aspeed) {
> +			gwdt->clk_freq = 1000000;
> +			gwdt->use_extclk = true;
> +			dev_info(dev, "assume 1MHz EXTCLK on Aspeed\n");
> +		}
>  	}
>  
>  	if (gwdt->clk_freq == 0) {
> @@ -211,6 +226,10 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
>  	gwdt->wdd.min_timeout = 1;
>  	gwdt->wdd.max_timeout = UINT_MAX / gwdt->clk_freq;
>  	gwdt->wdd.parent = dev;
> +	if (is_aspeed)
> +		gwdt->magic = ASPEED_MAGIC;
> +	else
> +		gwdt->magic = WDRESTART_MAGIC;
>  
>  	/*
>  	 * If 'timeout-sec' unspecified in devicetree, assume a 13 second
> -- 
> 2.13.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
