Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56656 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdFTUzI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Jun 2017 16:55:08 -0400
Date: Tue, 20 Jun 2017 13:55:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, yamada.masahiro@socionext.com,
        hayashi.kunihiko@socionext.com, owada.kiyoshi@socionext.com
Subject: Re: [PATCH V4 2/3] watchdog: uniphier: add UniPhier watchdog driver
Message-ID: <20170620205505.GC28761@roeck-us.net>
References: <1497426825-25450-1-git-send-email-hayashibara.keiji@socionext.com>
 <1497426825-25450-3-git-send-email-hayashibara.keiji@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497426825-25450-3-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 14, 2017 at 04:53:44PM +0900, Keiji Hayashibara wrote:
> Add a watchdog driver for Socionext UniPhier series SoC.
> Note that the timeout value for this device must be a power
> of 2 because of the specification.
> 
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/watchdog/watchdog-parameters.txt |   6 +
>  drivers/watchdog/Kconfig                       |  12 ++
>  drivers/watchdog/Makefile                      |   1 +
>  drivers/watchdog/uniphier_wdt.c                | 268 +++++++++++++++++++++++++
>  4 files changed, 287 insertions(+)
>  create mode 100644 drivers/watchdog/uniphier_wdt.c
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 4f7d86d..6f9d7b4 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -369,6 +369,12 @@ timeout: Watchdog timeout in seconds. (0<timeout<N, default=60)
>  nowayout: Watchdog cannot be stopped once started
>  	(default=kernel config parameter)
>  -------------------------------------------------
> +uniphier_wdt:
> +timeout: Watchdog timeout in power of two seconds.
> +	(1 <= timeout <= 128, default=64)
> +nowayout: Watchdog cannot be stopped once started
> +	(default=kernel config parameter)
> +-------------------------------------------------
>  w83627hf_wdt:
>  wdt_io: w83627hf/thf WDT io port (default 0x2E)
>  timeout: Watchdog timeout in seconds. 1 <= timeout <= 255, default=60.
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 52a70ee..b83759d 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -744,6 +744,18 @@ config ZX2967_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called zx2967_wdt.
>  
> +config UNIPHIER_WATCHDOG
> +	tristate "UniPhier watchdog support"
> +	depends on ARCH_UNIPHIER || COMPILE_TEST
> +	depends on OF && MFD_SYSCON
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support watchdog timer embedded
> +	  into the UniPhier system.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called uniphier_wdt.
> +
>  # AVR32 Architecture
>  
>  config AT32AP700X_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index a2126e2..0928dac 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
>  obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
>  obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
>  obj-$(CONFIG_ZX2967_WATCHDOG) += zx2967_wdt.o
> +obj-$(CONFIG_UNIPHIER_WATCHDOG) += uniphier_wdt.o
>  
>  # AVR32 Architecture
>  obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
> new file mode 100644
> index 0000000..0ea2339
> --- /dev/null
> +++ b/drivers/watchdog/uniphier_wdt.c
> @@ -0,0 +1,268 @@
> +/*
> + * Watchdog driver for the UniPhier watchdog timer
> + *
> + * (c) Copyright 2014 Panasonic Corporation
> + * (c) Copyright 2016 Socionext Inc.
> + * All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/watchdog.h>
> +
> +/* WDT timer setting register */
> +#define WDTTIMSET			0x3004
> +#define   WDTTIMSET_PERIOD_MASK		(0xf << 0)
> +#define   WDTTIMSET_PERIOD_1_SEC	(0x3 << 0)
> +
> +/* WDT reset selection register */
> +#define WDTRSTSEL			0x3008
> +#define   WDTRSTSEL_RSTSEL_MASK		(0x3 << 0)
> +#define   WDTRSTSEL_RSTSEL_BOTH		(0x0 << 0)
> +#define   WDTRSTSEL_RSTSEL_IRQ_ONLY	(0x2 << 0)
> +
> +/* WDT control register */
> +#define WDTCTRL				0x300c
> +#define   WDTCTRL_STATUS		BIT(8)
> +#define   WDTCTRL_CLEAR			BIT(1)
> +#define   WDTCTRL_ENABLE		BIT(0)
> +
> +#define SEC_TO_WDTTIMSET_PRD(sec) \
> +		(ilog2(sec) + WDTTIMSET_PERIOD_1_SEC)
> +
> +#define WDTST_TIMEOUT			1000 /* usec */
> +
> +#define WDT_DEFAULT_TIMEOUT		64   /* Default is 64 seconds */
> +#define WDT_PERIOD_MIN			1
> +#define WDT_PERIOD_MAX			128
> +
> +static unsigned int timeout = 0;
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +
> +struct uniphier_wdt_dev {
> +	struct watchdog_device wdt_dev;
> +	struct regmap	*regmap;
> +};
> +
> +/*
> + * UniPhier Watchdog operations
> + */
> +static int uniphier_watchdog_ping(struct watchdog_device *w)
> +{
> +	struct uniphier_wdt_dev *wdev = watchdog_get_drvdata(w);
> +	unsigned int val;
> +	int ret;
> +
> +	/* Clear counter */
> +	ret = regmap_write_bits(wdev->regmap, WDTCTRL,
> +				WDTCTRL_CLEAR, WDTCTRL_CLEAR);
> +	if (!ret)
> +		/*
> +		 * As SoC specification, after clear counter,
> +		 * it needs to wait until counter status is 1.
> +		 */
> +		ret = regmap_read_poll_timeout(wdev->regmap, WDTCTRL, val,
> +					       (val & WDTCTRL_STATUS),
> +					       0, WDTST_TIMEOUT);
> +
> +	return ret;
> +}
> +
> +static int __uniphier_watchdog_start(struct regmap *regmap, unsigned int sec)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read_poll_timeout(regmap, WDTCTRL, val,
> +				       !(val & WDTCTRL_STATUS),
> +				       0, WDTST_TIMEOUT);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup period */
> +	ret = regmap_write(regmap, WDTTIMSET,
> +			   SEC_TO_WDTTIMSET_PRD(sec));
> +	if (ret)
> +		return ret;
> +
> +	/* Enable and clear watchdog */
> +	ret = regmap_write(regmap, WDTCTRL, WDTCTRL_ENABLE | WDTCTRL_CLEAR);
> +	if (!ret)
> +		/*
> +		 * As SoC specification, after clear counter,
> +		 * it needs to wait until counter status is 1.
> +		 */
> +		ret = regmap_read_poll_timeout(regmap, WDTCTRL, val,
> +					       (val & WDTCTRL_STATUS),
> +					       0, WDTST_TIMEOUT);
> +
> +	return ret;
> +}
> +
> +static int __uniphier_watchdog_stop(struct regmap *regmap)
> +{
> +	/* Disable and stop watchdog */
> +	return regmap_write_bits(regmap, WDTCTRL, WDTCTRL_ENABLE, 0);
> +}
> +
> +static int __uniphier_watchdog_restart(struct regmap *regmap, unsigned int sec)
> +{
> +	int ret;
> +
> +	ret = __uniphier_watchdog_stop(regmap);
> +	if (ret)
> +		return ret;
> +
> +	return __uniphier_watchdog_start(regmap, sec);
> +}
> +
> +static int uniphier_watchdog_start(struct watchdog_device *w)
> +{
> +	struct uniphier_wdt_dev *wdev = watchdog_get_drvdata(w);
> +	unsigned int tmp_timeout;
> +
> +	tmp_timeout = roundup_pow_of_two(w->timeout);
> +
> +	return __uniphier_watchdog_start(wdev->regmap, tmp_timeout);
> +}
> +
> +static int uniphier_watchdog_stop(struct watchdog_device *w)
> +{
> +	struct uniphier_wdt_dev *wdev = watchdog_get_drvdata(w);
> +
> +	return __uniphier_watchdog_stop(wdev->regmap);
> +}
> +
> +static int uniphier_watchdog_set_timeout(struct watchdog_device *w,
> +					 unsigned int t)
> +{
> +	struct uniphier_wdt_dev *wdev = watchdog_get_drvdata(w);
> +	unsigned int tmp_timeout;
> +	int ret;
> +
> +	tmp_timeout = roundup_pow_of_two(t);
> +	if (tmp_timeout == w->timeout)
> +		return 0;
> +
> +	if (watchdog_active(w)) {
> +		ret = __uniphier_watchdog_restart(wdev->regmap, tmp_timeout);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	w->timeout = tmp_timeout;
> +
> +	return 0;
> +}
> +
> +/*
> + * Kernel Interfaces
> + */
> +static const struct watchdog_info uniphier_wdt_info = {
> +	.identity	= "uniphier-wdt",
> +	.options	= WDIOF_SETTIMEOUT |
> +			  WDIOF_KEEPALIVEPING |
> +			  WDIOF_MAGICCLOSE |
> +			  WDIOF_OVERHEAT,
> +};
> +
> +static const struct watchdog_ops uniphier_wdt_ops = {
> +	.owner		= THIS_MODULE,
> +	.start		= uniphier_watchdog_start,
> +	.stop		= uniphier_watchdog_stop,
> +	.ping		= uniphier_watchdog_ping,
> +	.set_timeout	= uniphier_watchdog_set_timeout,
> +};
> +
> +static int uniphier_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uniphier_wdt_dev *wdev;
> +	struct regmap *regmap;
> +	struct device_node *parent;
> +	int ret;
> +
> +	wdev = devm_kzalloc(dev, sizeof(*wdev), GFP_KERNEL);
> +	if (!wdev)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, wdev);
> +
> +	parent = of_get_parent(dev->of_node); /* parent should be syscon node */
> +	regmap = syscon_node_to_regmap(parent);
> +	of_node_put(parent);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	wdev->regmap = regmap;
> +	wdev->wdt_dev.info = &uniphier_wdt_info;
> +	wdev->wdt_dev.ops = &uniphier_wdt_ops;
> +	wdev->wdt_dev.max_timeout = WDT_PERIOD_MAX;
> +	wdev->wdt_dev.min_timeout = WDT_PERIOD_MIN;
> +	wdev->wdt_dev.parent = dev;
> +
> +	if (watchdog_init_timeout(&wdev->wdt_dev, timeout, dev) < 0) {
> +		wdev->wdt_dev.timeout = WDT_DEFAULT_TIMEOUT;
> +	}
> +	watchdog_set_nowayout(&wdev->wdt_dev, nowayout);
> +	watchdog_stop_on_reboot(&wdev->wdt_dev);
> +
> +	watchdog_set_drvdata(&wdev->wdt_dev, wdev);
> +
> +	uniphier_watchdog_stop(&wdev->wdt_dev);
> +	ret = regmap_write(wdev->regmap, WDTRSTSEL, WDTRSTSEL_RSTSEL_BOTH);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_watchdog_register_device(dev, &wdev->wdt_dev);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "watchdog driver (timeout=%d sec, nowayout=%d)\n",
> +		 wdev->wdt_dev.timeout, nowayout);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id uniphier_wdt_dt_ids[] = {
> +	{ .compatible = "socionext,uniphier-wdt" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, uniphier_wdt_dt_ids);
> +
> +static struct platform_driver uniphier_wdt_driver = {
> +	.probe		= uniphier_wdt_probe,
> +	.driver		= {
> +		.name		= "uniphier-wdt",
> +		.of_match_table	= uniphier_wdt_dt_ids,
> +	},
> +};
> +
> +module_platform_driver(uniphier_wdt_driver);
> +
> +module_param(timeout, uint, 0000);
> +MODULE_PARM_DESC(timeout,
> +	"Watchdog timeout seconds in power of 2. (0 < timeout < 128, default="
> +				__MODULE_STRING(WDT_DEFAULT_TIMEOUT) ")");
> +
> +module_param(nowayout, bool, 0000);
> +MODULE_PARM_DESC(nowayout,
> +	"Watchdog cannot be stopped once started (default="
> +				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +MODULE_AUTHOR("Keiji Hayashibara <hayashibara.keiji@socionext.com>");
> +MODULE_DESCRIPTION("UniPhier Watchdog Device Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 
