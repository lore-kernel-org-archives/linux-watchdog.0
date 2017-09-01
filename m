Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36555 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbdIAQWD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 1 Sep 2017 12:22:03 -0400
Subject: Re: [PATCH 2/3] watchdog: Add Realtek RTD1295
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>,
        =?UTF-8?B?6JKL5Li955C0?= <jiang.liqin@geniatech.com>
References: <20170828113532.32627-1-afaerber@suse.de>
 <20170828113532.32627-3-afaerber@suse.de>
From: Guenter Roeck <guenter@roeck-us.net>
Message-ID: <4bb73834-e548-f1db-7aa4-dbc9a1019894@roeck-us.net>
Date: Fri, 1 Sep 2017 09:22:00 -0700
MIME-Version: 1.0
In-Reply-To: <20170828113532.32627-3-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/28/2017 04:35 AM, Andreas Färber wrote:
> Add a watchdog driver for the Realtek RTD1295 SoC.
> 
> Based on QNAP's arch/arm/mach-rtk119x/driver/rtk_watchdog.c code and
> mach-rtk119x/driver/dc2vo/fpga/include/iso_reg.h register defines.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>   drivers/watchdog/Kconfig       |  10 +++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/rtd119x_wdt.c | 152 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 163 insertions(+)
>   create mode 100644 drivers/watchdog/rtd119x_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c722cbfdc7e6..8fa81518c3fa 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -787,6 +787,16 @@ config UNIPHIER_WATCHDOG
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called uniphier_wdt.
>   
> +config RTD119X_WATCHDOG
> +	bool "Realtek RTD119x/RTD129x watchdog support"
> +	depends on ARCH_REALTEK || COMPILE_TEST
> +	depends on OF
> +	select WATCHDOG_CORE
> +	default ARCH_REALTEK
> +	help
> +	  Say Y here to include support for the watchdog timer in
> +	  Realtek RTD1295 SoCs.
> +
>   # AVR32 Architecture
>   
>   config AT32AP700X_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 56adf9fa67d0..63cb3ed8117d 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
>   obj-$(CONFIG_ZX2967_WATCHDOG) += zx2967_wdt.o
>   obj-$(CONFIG_STM32_WATCHDOG) += stm32_iwdg.o
>   obj-$(CONFIG_UNIPHIER_WATCHDOG) += uniphier_wdt.o
> +obj-$(CONFIG_RTD119X_WATCHDOG) += rtd119x_wdt.o
>   
>   # AVR32 Architecture
>   obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> diff --git a/drivers/watchdog/rtd119x_wdt.c b/drivers/watchdog/rtd119x_wdt.c
> new file mode 100644
> index 000000000000..1bd2e86509a7
> --- /dev/null
> +++ b/drivers/watchdog/rtd119x_wdt.c
> @@ -0,0 +1,152 @@
> +/*
> + * Realtek RTD129x watchdog
> + *
> + * Copyright (c) 2017 Andreas Färber
> + *
> + * SPDX-License-Identifier: GPL-2.0+
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +
> +#define RTD_TCWCR		0x0
> +#define RTD_TCWTR		0x4
> +#define RTD_TCWOV		0xc
> +
> +#define RTD_TCWCR_WDEN_DISABLED		0xa5
> +#define RTD_TCWCR_WDEN_ENABLED		0xff
> +#define RTD_TCWCR_WDEN_MASK		0xff
> +
> +#define RTD_TCWTR_WDCLR			BIT(0)
> +

need to include bitops.h.

> +struct rtd119x_watchdog_device {
> +	struct watchdog_device wdt_dev;
> +	void __iomem *base;
> +	struct clk *clk;
> +};
> +
> +static int rtd119x_wdt_start(struct watchdog_device *wdev)
> +{
> +	struct rtd119x_watchdog_device *data = watchdog_get_drvdata(wdev);
> +	u32 val;
> +
> +	val = readl_relaxed(data->base + RTD_TCWCR);
> +	val &= ~RTD_TCWCR_WDEN_MASK;
> +	val |= RTD_TCWCR_WDEN_ENABLED;
> +	writel(val, data->base + RTD_TCWCR);
> +
> +	return 0;
> +}
> +
> +static int rtd119x_wdt_stop(struct watchdog_device *wdev)
> +{
> +	struct rtd119x_watchdog_device *data = watchdog_get_drvdata(wdev);
> +	u32 val;
> +
> +	val = readl_relaxed(data->base + RTD_TCWCR);
> +	val &= ~RTD_TCWCR_WDEN_MASK;
> +	val |= RTD_TCWCR_WDEN_DISABLED;
> +	writel(val, data->base + RTD_TCWCR);
> +
> +	return 0;
> +}
> +
> +static int rtd119x_wdt_ping(struct watchdog_device *wdev)
> +{
> +	struct rtd119x_watchdog_device *data = watchdog_get_drvdata(wdev);
> +
> +	writel_relaxed(RTD_TCWTR_WDCLR, data->base + RTD_TCWTR);
> +
> +	return rtd119x_wdt_start(wdev);
> +}
> +
> +static int rtd119x_wdt_set_timeout(struct watchdog_device *wdev, unsigned int val)
> +{
> +	struct rtd119x_watchdog_device *data = watchdog_get_drvdata(wdev);
> +
> +	writel(val * 27000000, data->base + RTD_TCWOV);
> +

This also needs to set wdev->timeout.

> +	return 0;
> +}
> +
> +static const struct watchdog_ops rtd119x_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start		= rtd119x_wdt_start,
> +	.stop		= rtd119x_wdt_stop,
> +	.ping		= rtd119x_wdt_ping,
> +	.set_timeout	= rtd119x_wdt_set_timeout,
> +};
> +
> +static const struct watchdog_info rtd119x_wdt_info = {
> +	.identity = "rtd119x-wdt",
> +	.options = 0,
> +};
> +
> +static const struct of_device_id rtd_wdt_dt_ids[] = {
> +	 { .compatible = "realtek,rtd1295-watchdog" },
> +	 { }
> +};
> +
> +static int rtd_wdt_probe(struct platform_device *pdev)
> +{
> +	struct rtd119x_watchdog_device *data;
> +	struct resource *res;
> +	int ret;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->base))
> +		return PTR_ERR(data->base);
> +
> +	data->clk = of_clk_get(pdev->dev.of_node, 0);
> +	if (IS_ERR(data->clk))
> +		return PTR_ERR(data->clk);
> +
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret) {
> +		clk_put(data->clk);
> +		return ret;
> +	}
> +
> +	data->wdt_dev.info = &rtd119x_wdt_info;
> +	data->wdt_dev.ops = &rtd119x_wdt_ops;
> +	data->wdt_dev.timeout = 120;
> +	data->wdt_dev.max_timeout = 0xffffffff / clk_get_rate(data->clk);
> +	data->wdt_dev.min_timeout = 1;
> +	data->wdt_dev.parent = &pdev->dev;
> +
> +	watchdog_stop_on_reboot(&data->wdt_dev);
> +	watchdog_set_drvdata(&data->wdt_dev, data);
> +	platform_set_drvdata(pdev, data);
> +
Not needed since there is no remove function.

> +	writel_relaxed(RTD_TCWTR_WDCLR, data->base + RTD_TCWTR);
> +	rtd119x_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
> +	rtd119x_wdt_stop(&data->wdt_dev);
> +
> +	ret = devm_watchdog_register_device(&pdev->dev, &data->wdt_dev);
> +	if (ret) {
> +		clk_disable_unprepare(data->clk);
> +		clk_put(data->clk);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver rtd_wdt_driver = {
> +	.probe = rtd_wdt_probe,
> +	.driver = {
> +		.name = "rtd1295-watchdog",
> +		.of_match_table	= rtd_wdt_dt_ids,
> +	},
> +};
> +builtin_platform_driver(rtd_wdt_driver);
> 

