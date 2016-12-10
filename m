Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57018 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbcLJRWQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 10 Dec 2016 12:22:16 -0500
Subject: Re: [PATCH v3] watchdog: nic7018_wdt: Add NIC7018 watchdog driver
To: Hui Chun Ong <hui.chun.ong@ni.com>, wim@iguana.be, corbet@lwn.net
References: <1481365545-49894-1-git-send-email-hui.chun.ong@ni.com>
Cc: linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
        jonathan.hearn@ni.com, julia.cartwright@ni.com, rjw@rjwysocki.net,
        mika.westerberg@linux.intel.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5f137b29-b90b-df10-ca8f-0059f1c556c1@roeck-us.net>
Date: Sat, 10 Dec 2016 09:22:11 -0800
MIME-Version: 1.0
In-Reply-To: <1481365545-49894-1-git-send-email-hui.chun.ong@ni.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/10/2016 02:25 AM, Hui Chun Ong wrote:
> Add support for the watchdog timer on PXI Embedded Controller.
>
> Signed-off-by: Hui Chun Ong <hui.chun.ong@ni.com>
> ---
> v2: Remove mutex lock and platform_device *pdev fields from struct nic7018_wdt.
>     Update config NIC7018_WDT description.
>     Update nic7018_get_config() to never return error.
>     Remove checking for IO resource size in nic7018_probe().
>
> v1: Remove non-standard attributes.
>     Change from acpi_driver to platform_driver.
>     Rename driver from ni7018_wdt to nic7018_wdt.
> ---
>  Documentation/watchdog/watchdog-parameters.txt |   5 +
>  drivers/watchdog/Kconfig                       |  10 +
>  drivers/watchdog/Makefile                      |   1 +
>  drivers/watchdog/nic7018_wdt.c                 | 277 +++++++++++++++++++++++++
>  4 files changed, 293 insertions(+)
>  create mode 100644 drivers/watchdog/nic7018_wdt.c
>
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index a8d3642..bd142fa 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -209,6 +209,11 @@ timeout: Initial watchdog timeout in seconds (0<timeout<516, default=60)
>  nowayout: Watchdog cannot be stopped once started
>  	(default=kernel config parameter)
>  -------------------------------------------------
> +nic7018_wdt:
> +timeout: Initial watchdog timeout in seconds (0<timeout<464, default=80)
> +nowayout: Watchdog cannot be stopped once started
> +	(default=kernel config parameter)
> +-------------------------------------------------
>  nuc900_wdt:
>  heartbeat: Watchdog heartbeats in seconds.
>  	(default = 15)
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index fdd3228..baa79825 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1325,6 +1325,16 @@ config NI903X_WDT
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ni903x_wdt.
>
> +config NIC7018_WDT
> +	tristate "NIC7018 Watchdog"
> +	depends on X86 && ACPI
> +	select WATCHDOG_CORE
> +	---help---
> +	  Support for National Instruments NIC7018 Watchdog.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called nic7018_wdt.
> +
>  # M32R Architecture
>
>  # M68K Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index caa9f4a..bd88e2e 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -139,6 +139,7 @@ obj-$(CONFIG_INTEL_SCU_WATCHDOG) += intel_scu_watchdog.o
>  obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
>  obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
>  obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
> +obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
>
>  # M32R Architecture
>
> diff --git a/drivers/watchdog/nic7018_wdt.c b/drivers/watchdog/nic7018_wdt.c
> new file mode 100644
> index 0000000..9b7b8d3
> --- /dev/null
> +++ b/drivers/watchdog/nic7018_wdt.c
> @@ -0,0 +1,277 @@
> +/*
> + * Copyright (C) 2016 National Instruments Corp.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +
> +#define LOCK			0xA5
> +#define UNLOCK			0x5A
> +
> +#define WDT_CTRL_RESET_EN	BIT(7)
> +#define WDT_RELOAD_PORT_EN	BIT(7)
> +
> +#define WDT_CTRL		1
> +#define WDT_RELOAD_CTRL		2
> +#define WDT_PRESET_PRESCALE	4
> +#define WDT_REG_LOCK		5
> +#define WDT_COUNT		6
> +#define WDT_RELOAD_PORT		7
> +
> +#define WDT_MIN_TIMEOUT		1
> +#define WDT_MAX_TIMEOUT		464
> +#define WDT_DEFAULT_TIMEOUT	80
> +
> +#define WDT_MAX_COUNTER		15
> +
> +static unsigned int timeout;
> +module_param(timeout, uint, 0);
> +MODULE_PARM_DESC(timeout,
> +		 "Watchdog timeout in seconds. (default="
> +		 __MODULE_STRING(WDT_DEFAULT_TIMEOUT) ")");
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +		 "Watchdog cannot be stopped once started. (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +struct nic7018_wdt {
> +	u16 io_base;
> +	u32 period_ms;
> +	struct watchdog_device wdd;
> +};
> +
> +struct nic7018_config {
> +	u32 period_ms;
> +	u8 divider;
> +};
> +
> +static const struct nic7018_config nic7018_configs[] = {
> +	{   125, 3 },

The maximum timeout is (125 * 15) - 62, or 1813 ms. This will never be selected,
since with a timeout of 2s count will be 17 below, and the entry will be skipped.
With a timeout of 1000, the second table entry will be used as well since the
timeout with the first entry is not exactly 1 second.

Given that, you might as well drop this entry.


> +	{  2000, 4 },
> +	{ 32000, 5 },
> +};
> +
> +static inline u32 nic7018_timeout_ms(u32 period_ms, u8 counter)
> +{
> +	return period_ms * counter - period_ms / 2;
> +}
> +
> +static const struct nic7018_config *nic7018_get_config(u32 timeout_ms,
> +						       u8 *counter)
> +{
> +	u32 delta, i, best_delta = U32_MAX;
> +	const struct nic7018_config *config, *best_config = NULL;
> +	u8 count;
> +	*counter = WDT_MAX_COUNTER;
> +
> +	for (i = 0; i < ARRAY_SIZE(nic7018_configs); i++) {
> +		config = &nic7018_configs[i];
> +
> +		count = DIV_ROUND_UP(timeout_ms + config->period_ms / 2,
> +				     config->period_ms);
> +
> +		if (count > WDT_MAX_COUNTER)
> +			continue;
> +
> +		delta = nic7018_timeout_ms(config->period_ms, count) -
> +			timeout_ms;
> +
> +		if (delta < best_delta) {
> +			best_delta = delta;
> +			best_config = config;
> +			*counter = count;
> +		}
> +	}
> +
> +	return (!best_config) ? config : best_config;

Unecessary (), and
	return best_config ? : config;
works without the '!'.

Also, given the above, it seems to me that

	if (timeout < 30 && timeout != 16) {
		config = &nic7018_configs[0];
		count = timeout / 2 + 1;
	} else {
		config = &nic7018_configs[1];
		count = DIV_ROUND_UP(timeout + 16, 32);
		if (count > WDT_MAX_COUNTER;
			count = WDT_MAX_COUNTER;
	}
	*counter = count;
	return config;

would accomplish the same as your code and be much less complex and easier
to understand. As a side effect, you could keep all timeouts in seconds
and would not have to deal with milliseconds at all.

> +}
> +
> +static int nic7018_set_timeout(struct watchdog_device *wdd,
> +			       unsigned int timeout)
> +{
> +	struct nic7018_wdt *wdt = watchdog_get_drvdata(wdd);
> +	const struct nic7018_config *config;
> +	u8 counter;
> +
> +	config = nic7018_get_config(timeout * 1000, &counter);
> +
> +	outb(counter << 4 | config->divider,
> +	     wdt->io_base + WDT_PRESET_PRESCALE);
> +
> +	wdd->timeout = nic7018_timeout_ms(config->period_ms, counter) / 1000;
> +	wdt->period_ms = config->period_ms;
> +
> +	return 0;
> +}
> +
> +static int nic7018_start(struct watchdog_device *wdd)
> +{
> +	struct nic7018_wdt *wdt = watchdog_get_drvdata(wdd);
> +	u8 control;
> +
> +	nic7018_set_timeout(wdd, wdd->timeout);
> +
> +	control = inb(wdt->io_base + WDT_RELOAD_CTRL);
> +	outb(control | WDT_RELOAD_PORT_EN, wdt->io_base + WDT_RELOAD_CTRL);
> +
> +	outb(1, wdt->io_base + WDT_RELOAD_PORT);
> +
> +	control = inb(wdt->io_base + WDT_CTRL);
> +	outb(control | WDT_CTRL_RESET_EN, wdt->io_base + WDT_CTRL);
> +
> +	return 0;
> +}
> +
> +static int nic7018_stop(struct watchdog_device *wdd)
> +{
> +	struct nic7018_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	outb(0, wdt->io_base + WDT_CTRL);
> +	outb(0, wdt->io_base + WDT_RELOAD_CTRL);
> +	outb(0xF0, wdt->io_base + WDT_PRESET_PRESCALE);
> +
> +	return 0;
> +}
> +
> +static int nic7018_ping(struct watchdog_device *wdd)
> +{
> +	struct nic7018_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	outb(1, wdt->io_base + WDT_RELOAD_PORT);
> +
> +	return 0;
> +}
> +
> +static unsigned int nic7018_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct nic7018_wdt *wdt = watchdog_get_drvdata(wdd);
> +	u8 count;
> +
> +	count = inb(wdt->io_base + WDT_COUNT) & 0xF;
> +
> +	if (!count)
> +		return 0;
> +
> +	return nic7018_timeout_ms(wdt->period_ms, count) / 1000;
> +}
> +
> +static const struct watchdog_info nic7018_wdd_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	.identity = "NIC7018 Watchdog",
> +};
> +
> +static const struct watchdog_ops nic7018_wdd_ops = {
> +	.owner = THIS_MODULE,
> +	.start = nic7018_start,
> +	.stop = nic7018_stop,
> +	.ping = nic7018_ping,
> +	.set_timeout = nic7018_set_timeout,
> +	.get_timeleft = nic7018_get_timeleft,
> +};
> +
> +static int nic7018_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct watchdog_device *wdd;
> +	struct nic7018_wdt *wdt;
> +	struct resource *io_rc;
> +	int ret;
> +
> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	io_rc = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (!io_rc) {
> +		dev_err(dev, "missing IO resources\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!devm_request_region(dev, io_rc->start, resource_size(io_rc),
> +				 KBUILD_MODNAME)) {
> +		dev_err(dev, "failed to get IO region\n");
> +		return -EBUSY;
> +	}
> +
> +	wdt->io_base = io_rc->start;
> +	wdd = &wdt->wdd;
> +	wdd->info = &nic7018_wdd_info;
> +	wdd->ops = &nic7018_wdd_ops;
> +	wdd->min_timeout = WDT_MIN_TIMEOUT;
> +	wdd->max_timeout = WDT_MAX_TIMEOUT;
> +	wdd->timeout = WDT_DEFAULT_TIMEOUT;
> +	wdd->parent = dev;
> +
> +	watchdog_set_drvdata(wdd, wdt);
> +	watchdog_set_nowayout(wdd, nowayout);
> +
> +	ret = watchdog_init_timeout(wdd, timeout, dev);
> +	if (ret)
> +		dev_warn(dev, "unable to set timeout value, using default\n");
> +
> +	ret = watchdog_register_device(wdd);
> +	if (ret) {
> +		dev_err(dev, "failed to register watchdog\n");
> +		return ret;
> +	}
> +
> +	/* Unlock WDT register */
> +	outb(UNLOCK, wdt->io_base + WDT_REG_LOCK);
> +
The watchdog driver may be opened right after the call to watchdog_register_device(),
meaning this is racy since the open may already have happened. You'll need to set
this before the call to watchdog_register_device().

> +	dev_dbg(dev, "io_base=0x%04X, timeout=%d, nowayout=%d\n",
> +		wdt->io_base, timeout, nowayout);
> +	return 0;
> +}
> +
> +static int nic7018_remove(struct platform_device *pdev)
> +{
> +	struct nic7018_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	nic7018_stop(&wdt->wdd);
> +	watchdog_unregister_device(&wdt->wdd);
> +
> +	/* Lock WDT register */
> +	outb(LOCK, wdt->io_base + WDT_REG_LOCK);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id nic7018_device_ids[] = {
> +	{"NIC7018", 0},
> +	{"", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, nic7018_device_ids);
> +
> +static struct platform_driver watchdog_driver = {
> +	.probe = nic7018_probe,
> +	.remove = nic7018_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.acpi_match_table = ACPI_PTR(nic7018_device_ids),
> +	},
> +};
> +
> +module_platform_driver(watchdog_driver);
> +
> +MODULE_DESCRIPTION("National Instruments NIC7018 Watchdog driver");
> +MODULE_AUTHOR("Hui Chun Ong <hui.chun.ong@ni.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

