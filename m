Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51106 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbcENVfE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 14 May 2016 17:35:04 -0400
Subject: Re: [PATCH v2 2/2] watchdog: Add Aspeed watchdog driver
To: Joel Stanley <joel@jms.id.au>, wim@iguana.be
References: <1462797277-14969-1-git-send-email-joel@jms.id.au>
 <1463062631-16432-1-git-send-email-joel@jms.id.au>
 <1463062631-16432-3-git-send-email-joel@jms.id.au>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jk@ozlabs.org,
	benh@kernel.crashing.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <573799FA.7090207@roeck-us.net>
Date: Sat, 14 May 2016 14:34:50 -0700
MIME-Version: 1.0
In-Reply-To: <1463062631-16432-3-git-send-email-joel@jms.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/12/2016 07:17 AM, Joel Stanley wrote:
> Provides generic watchdog features as well as reboot support for the
> Apeed SoC.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   drivers/watchdog/Kconfig      |  13 +++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/aspeed_wdt.c | 209 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 223 insertions(+)
>   create mode 100644 drivers/watchdog/aspeed_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index fb947655badd..4f0e2ded4785 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -661,6 +661,19 @@ config ATLAS7_WATCHDOG
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called atlas7_wdt.
>
> +config ASPEED_WATCHDOG
> +	tristate "Aspeed watchdog support"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the watchdog timer
> +	  in Apseed BMC SoCs.
> +
> +	  This driver is required to reboot the SoC.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called aspeed_wdt.
> +
>   # AVR32 Architecture
>
>   config AT32AP700X_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index feb6270fdbde..36855375e0ce 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
>   obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
>   obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
>   obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
> +obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
>
>   # AVR32 Architecture
>   obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> new file mode 100644
> index 000000000000..f7ae41ef4121
> --- /dev/null
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -0,0 +1,209 @@
> +/*
> + * Copyright 2016 IBM Corporation
> + *
> + * Joel Stanley <joel@jms.id.au>
> + *
> + * Based on the qcom-watchdog driver
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/watchdog.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +struct aspeed_wdt {
> +	struct watchdog_device	wdd;
> +	unsigned long		rate;

I still don't see why you need this variable. Why not just use
WDT_1MHZ_CLOCK directly ?

> +	void __iomem		*base;
> +	u32			ctrl;
> +};
> +
> +static const struct of_device_id aspeed_wdt_of_table[] = {
> +	{ .compatible = "aspeed,ast2400-wdt" },
> +	{ .compatible = "aspeed,ast2500-wdt" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
> +
> +#define WDT_STATUS		0x00
> +#define WDT_RELOAD_VALUE	0x04
> +#define WDT_RESTART		0x08
> +#define WDT_CTRL		0x0C
> +#define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
> +#define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
> +#define   WDT_CTRL_1MHZ_CLK		BIT(4)
> +#define   WDT_CTRL_WDT_EXT		BIT(3)
> +#define   WDT_CTRL_WDT_INTR		BIT(2)
> +#define   WDT_CTRL_RESET_SYSTEM		BIT(1)
> +#define   WDT_CTRL_ENABLE		BIT(0)
> +
> +#define WDT_RESTART_MAGIC	0x4755
> +
> +#define WDT_MIN_TIMEOUT		1
> +/* 32 bits at 1MHz, in milliseconds */
> +#define WDT_MAX_TIMEOUT_MS	4294967
> +#define WDT_DEFAULT_TIMEOUT	30
> +#define WDT_1MHZ_CLOCK		1000000
> +
> +static struct aspeed_wdt *to_aspeed_wdt(struct watchdog_device *wdd)
> +{
> +	return container_of(wdd, struct aspeed_wdt, wdd);
> +}
> +
> +static void aspeed_wdt_enable(struct aspeed_wdt *wdt, int count)
> +{
> +	wdt->ctrl |= WDT_CTRL_ENABLE;
> +
> +	writel(0, wdt->base + WDT_CTRL);
> +	writel(count, wdt->base + WDT_RELOAD_VALUE);
> +	writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
> +	writel(wdt->ctrl, wdt->base + WDT_CTRL);
> +}
> +
> +static int aspeed_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
> +
> +	aspeed_wdt_enable(wdt, wdd->timeout * wdt->rate);
> +
> +	return 0;
> +}
> +
> +static int aspeed_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
> +
> +	wdt->ctrl &= ~WDT_CTRL_ENABLE;
> +	writel(wdt->ctrl, wdt->base + WDT_CTRL);
> +
> +	return 0;
> +}
> +
> +static int aspeed_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
> +
> +	writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
> +
> +	return 0;
> +}
> +
> +static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int timeout)
> +{
> +	wdd->timeout = timeout;
> +
> +	return aspeed_wdt_start(wdd);

The watchdog can be stopped here (with WDIOC_SETOPTIONS/WDIOS_DISABLECARD).
An implicit enable is not really a good idea; neither the infrastructure
nor user space would in this case be aware that the watchdog is running.

> +}
> +
> +static int aspeed_wdt_restart(struct watchdog_device *wdd,
> +			      unsigned long action, void *data)
> +{
> +	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
> +
> +	aspeed_wdt_enable(wdt, 128 * wdt->rate / 1000);
> +

Is that the smallest accepted value, or is there some other reason
not to make it smaller ?

It is also quite common to wait here to let the reset 'catch'
before returning. This would ensure that the system doesn't trigger
a lower priority reset.

> +	return 0;
> +}
> +
> +static const struct watchdog_ops aspeed_wdt_ops = {
> +	.start		= aspeed_wdt_start,
> +	.stop		= aspeed_wdt_stop,
> +	.ping		= aspeed_wdt_ping,
> +	.set_timeout	= aspeed_wdt_set_timeout,
> +	.restart	= aspeed_wdt_restart,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static const struct watchdog_info aspeed_wdt_info = {
> +	.options	= WDIOF_KEEPALIVEPING
> +			| WDIOF_MAGICCLOSE
> +			| WDIOF_SETTIMEOUT,
> +	.identity	= KBUILD_MODNAME,
> +};
> +
> +static int aspeed_wdt_remove(struct platform_device *pdev)
> +{
> +	struct aspeed_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static int aspeed_wdt_probe(struct platform_device *pdev)
> +{
> +	struct aspeed_wdt *wdt;
> +	struct resource *res;
> +	int ret;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	wdt->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(wdt->base))
> +		return PTR_ERR(wdt->base);
> +
> +	/*
> +	 * The ast2400 wdt can run at PCLK, or 1MHz. The ast2500 only
> +	 * runs at 1MHz. We chose to always run at 1MHz, as there's no
> +	 * good reason to have a faster watchdog counter.
> +	 */
> +	wdt->rate = WDT_1MHZ_CLOCK;
> +	wdt->wdd.info = &aspeed_wdt_info;
> +	wdt->wdd.ops = &aspeed_wdt_ops;
> +	wdt->wdd.min_timeout = WDT_MIN_TIMEOUT;
> +	wdt->wdd.max_hw_heartbeat_ms = WDT_MAX_TIMEOUT_MS;
> +	wdt->wdd.parent = &pdev->dev;
> +
> +	wdt->wdd.timeout = WDT_DEFAULT_TIMEOUT;
> +	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
> +
> +	/*
> +	 * Control reset on a per-device basis to ensure the
> +	 * host is not affected by a BMC reboot, so only reset
> +	 * the SOC and not the full chip
> +	 */
> +	wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
> +		WDT_CTRL_1MHZ_CLK |
> +		WDT_CTRL_RESET_SYSTEM;
> +
> +	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
> +		aspeed_wdt_start(&wdt->wdd);
> +		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> +	}
> +
> +	ret = watchdog_register_device(&wdt->wdd);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register\n");
> +		return ret;
> +	}
> +
> +	dev_info(&pdev->dev, "rate %lu, max timeout %u, timeout %d\n",
> +		 wdt->rate, wdt->wdd.max_timeout, wdt->wdd.timeout);
> +

'rate 1000000' doesn't seem very informative. All it does is to expose
an implementation detail which no one really cares about. Even if you
were to add 'Hz', I would argue that no one will even understand
what it means without looking into the driver, but then it will be
understood without the message.

> +	platform_set_drvdata(pdev, wdt);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver aspeed_watchdog_driver = {
> +	.probe = aspeed_wdt_probe,
> +	.remove = aspeed_wdt_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = of_match_ptr(aspeed_wdt_of_table),
> +	},
> +};
> +module_platform_driver(aspeed_watchdog_driver);
> +
> +MODULE_DESCRIPTION("Aspeed Watchdog Driver");
> +MODULE_LICENSE("GPL");
>

