Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57855 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbcBSF1I (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Feb 2016 00:27:08 -0500
Subject: Re: [PATCH v2] watchdog: ni9x3x_wdt: Add NI 903x/913x watchdog driver
To: Kyle Roeschley <kyle.roeschley@ni.com>, wim@iguana.be
References: <1455837991-9704-1-git-send-email-kyle.roeschley@ni.com>
Cc: linux-watchdog@vger.kernel.org, joshc@ni.com, david.madden@ni.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56C6A7A9.7090105@roeck-us.net>
Date: Thu, 18 Feb 2016 21:27:05 -0800
MIME-Version: 1.0
In-Reply-To: <1455837991-9704-1-git-send-email-kyle.roeschley@ni.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/18/2016 03:26 PM, Kyle Roeschley wrote:
> Add support for the watchdog timer on NI cRIO-903x and cDAQ-913x real-
> time controllers.
>
> Signed-off-by: Jeff Westfahl <jeff.westfahl@ni.com>
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> ---

This would be an optimal place for a change log.

[ if any of my comments are duplicates, sorry, but a change log
   would help avoiding that ]

>   Documentation/watchdog/watchdog-parameters.txt |   5 +
>   drivers/watchdog/Kconfig                       |  11 +
>   drivers/watchdog/Makefile                      |   1 +
>   drivers/watchdog/ni9x3x_wdt.c                  | 274 +++++++++++++++++++++++++

The name and context make me wonder: Is this driver going to support
all watchdog devices for NI9[0-9]3[0-9] ?

If not, it may be better to select one supported device,
whatever that may be, for the name, and describe in Kconfig
and the documentation which devices the driver is known to support.

>   4 files changed, 291 insertions(+)
>   create mode 100644 drivers/watchdog/ni9x3x_wdt.c
>
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 9f9ec9f..5273346 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -200,6 +200,11 @@ mv64x60_wdt:
>   nowayout: Watchdog cannot be stopped once started
>   	(default=kernel config parameter)
>   -------------------------------------------------
> +ni9x3x_wdt:
> +timeout: Intial watchdog timeout in seconds (0<timeout<516, default=60)
> +nowayout: Watchdog cannot be stopped once started
> +	(default=kernel config parameter)
> +-------------------------------------------------
>   nuc900_wdt:
>   heartbeat: Watchdog heartbeats in seconds.
>   	(default = 15)
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0f6d851..18bd13a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1214,6 +1214,17 @@ config SBC_EPX_C3_WATCHDOG
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called sbc_epx_c3.
>
> +config NI9X3X_WDT
> +	tristate "NI 903x/913x Watchdog"

So is it NI9[01]3[0-9] ?

What if NI923x requires a different driver ?

> +	depends on X86 && ACPI
> +	select WATCHDOG_CORE
> +	---help---
> +	  This is the driver for the watchdog timer on the National Instruments
> +	  903x/913x real-time controllers.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ni9x3x_wdt.
> +
>   # M32R Architecture
>
>   # M68K Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index f566753..527978b 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -126,6 +126,7 @@ obj-$(CONFIG_MACHZ_WDT) += machzwd.o
>   obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
>   obj-$(CONFIG_INTEL_SCU_WATCHDOG) += intel_scu_watchdog.o
>   obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
> +obj-$(CONFIG_NI9X3X_WDT) += ni9x3x_wdt.o
>
>   # M32R Architecture
>
> diff --git a/drivers/watchdog/ni9x3x_wdt.c b/drivers/watchdog/ni9x3x_wdt.c
> new file mode 100644
> index 0000000..efc8dc6
> --- /dev/null
> +++ b/drivers/watchdog/ni9x3x_wdt.c
> @@ -0,0 +1,274 @@
> +/*
> + * Copyright (C) 2013 National Instruments Corp.
> + *
2013 ? Sure you don't want to add 2016 ?

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
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/watchdog.h>
> +
> +#define NIWD_CONTROL	0x01
> +#define NIWD_COUNTER2	0x02
> +#define NIWD_COUNTER1	0x03
> +#define NIWD_COUNTER0	0x04
> +#define NIWD_SEED2	0x05
> +#define NIWD_SEED1	0x06
> +#define NIWD_SEED0	0x07
> +
> +#define NIWD_IO_SIZE	0x08
> +
> +#define NIWD_CONTROL_MODE		0x80
> +#define NIWD_CONTROL_PROC_RESET		0x20
> +#define NIWD_CONTROL_PET		0x10
> +#define NIWD_CONTROL_RUNNING		0x08
> +#define NIWD_CONTROL_CAPTURECOUNTER	0x04
> +#define NIWD_CONTROL_RESET		0x02
> +#define NIWD_CONTROL_ALARM		0x01
> +
> +#define NIWD_PERIOD_NS		30720
> +#define NIWD_MIN_TIMEOUT	1
> +#define NIWD_MAX_TIMEOUT	515
> +#define NIWD_DEFAULT_TIMEOUT	60
> +
> +#define NIWD_NAME		"ni9x3x_wdt"
> +
> +struct ni9x3x_wdt {
> +	struct device *dev;
> +	u16 io_base;
> +	struct watchdog_device wdd;
> +};
> +
> +static unsigned int timeout;
> +module_param(timeout, uint, 0);
> +MODULE_PARM_DESC(timeout,
> +		 "Watchdog timeout in seconds. (default="
> +		 __MODULE_STRING(NIWD_DEFAULT_TIMEOUT) ")");
> +
> +static int nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, int, S_IRUGO);
> +MODULE_PARM_DESC(nowayout,
> +		 "Watchdog cannot be stopped once started (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static void ni9x3x_start(struct ni9x3x_wdt *wdt)
> +{
> +	u8 control = inb(wdt->io_base + NIWD_CONTROL);
> +
> +	outb(control | NIWD_CONTROL_RESET, wdt->io_base + NIWD_CONTROL);
> +	outb(control | NIWD_CONTROL_PET, wdt->io_base + NIWD_CONTROL);

Using inb/outb asks for including linux/io.h.

> +}
> +
> +static int ni9x3x_wdd_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int timeout)
> +{
> +	struct ni9x3x_wdt *wdt = watchdog_get_drvdata(wdd);
> +	u32 counter = timeout * (1000000000 / NIWD_PERIOD_NS);
> +
> +	outb(((0x00FF0000 & counter) >> 16), wdt->io_base + NIWD_SEED2);
> +	outb(((0x0000FF00 & counter) >> 8), wdt->io_base + NIWD_SEED1);
> +	outb((0x000000FF & counter), wdt->io_base + NIWD_SEED0);
> +
> +	wdd->timeout = (counter * (u64)NIWD_PERIOD_NS) / 1000000000;

Unless I am missing something, this should result in a link time failure
when building for 32 bit. Either use div_u64(), or something like

	wdd->timeout = counter / (1000000000 / NIWD_PERIOD_NS)

Though wouldn't that be the same as 'timeout' ? Are you trying to work around
some rounding error here ?

> +
> +	return 0;
> +}
> +
> +static unsigned int ni9x3x_wdd_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct ni9x3x_wdt *wdt = watchdog_get_drvdata(wdd);
> +	u8 control, counter0, counter1, counter2;
> +	u32 counter;
> +
> +	control = inb(wdt->io_base + NIWD_CONTROL);
> +	control |= NIWD_CONTROL_CAPTURECOUNTER;
> +	outb(control, wdt->io_base + NIWD_CONTROL);
> +
> +	counter2 = inb(wdt->io_base + NIWD_COUNTER2);
> +	counter1 = inb(wdt->io_base + NIWD_COUNTER1);
> +	counter0 = inb(wdt->io_base + NIWD_COUNTER0);
> +
> +	counter = (counter2 << 16) | (counter1 << 8) | counter0;
> +	counter = (counter * (u64)NIWD_PERIOD_NS) / 1000000000;
> +

Same here. You have to be careful when using 64 bit arithmetic.

> +	return counter;
> +}
> +
> +static int ni9x3x_wdd_ping(struct watchdog_device *wdd)
> +{
> +	struct ni9x3x_wdt *wdt = watchdog_get_drvdata(wdd);
> +	u8 control;
> +
> +	control = inb(wdt->io_base + NIWD_CONTROL);
> +	outb(control | NIWD_CONTROL_PET, wdt->io_base + NIWD_CONTROL);
> +
> +	return 0;
> +}
> +
> +static int ni9x3x_wdd_start(struct watchdog_device *wdd)
> +{
> +	struct ni9x3x_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	outb(NIWD_CONTROL_RESET | NIWD_CONTROL_PROC_RESET,
> +	     wdt->io_base + NIWD_CONTROL);
> +
> +	ni9x3x_wdd_set_timeout(wdd, wdd->timeout);
> +	ni9x3x_start(wdt);
> +
> +	return 0;
> +}
> +
> +static int ni9x3x_wdd_stop(struct watchdog_device *wdd)
> +{
> +	struct ni9x3x_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	outb(NIWD_CONTROL_RESET, wdt->io_base + NIWD_CONTROL);
> +
> +	return 0;
> +}
> +
> +static acpi_status ni9x3x_resources(struct acpi_resource *res, void *data)
> +{
> +	struct ni9x3x_wdt *wdt = data;
> +	u16 io_size;
> +
> +	switch (res->type) {
> +	case ACPI_RESOURCE_TYPE_IO:
> +		if (wdt->io_base != 0) {
> +			dev_err(wdt->dev, "too many IO resources\n");

dev__err and similar functions are declared in linux/device.h,
which should be included.

> +			return AE_ERROR;
> +		}
> +
> +		wdt->io_base = res->data.io.minimum;
> +		io_size = res->data.io.address_length;
> +

What if io_size is less than NIWD_IO_SIZE ?

> +		if (!devm_request_region(wdt->dev, wdt->io_base, io_size,

linux/ioport.h

> +					 NIWD_NAME)) {
> +			dev_err(wdt->dev, "failed to get memory region\n");
> +			return -EBUSY;

Shouldn't this return AE_ERROR ?

> +		}
> +
> +		return AE_OK;
> +
> +	case ACPI_RESOURCE_TYPE_IRQ:
> +		/* Discard IRQ resource since we don't use it */
> +	case ACPI_RESOURCE_TYPE_END_TAG:
> +		return AE_OK;
> +
> +	default:
> +		dev_err(wdt->dev, "unsupported resource type %d\n", res->type);

I am wondering ... who cares ? Is there a reason for reporting an error
in this case, instead of just ignoring the unknown field ?

> +		return AE_ERROR;
> +	}
> +
> +	return AE_OK;
> +}
> +
> +static const struct watchdog_info ni9x3x_wdd_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,

WDIOF_MAGICCLOSE ?

> +	.identity = "NI Watchdog",
> +};
> +
> +static const struct watchdog_ops ni9x3x_wdd_ops = {
> +	.owner = THIS_MODULE,
> +	.start = ni9x3x_wdd_start,
> +	.stop = ni9x3x_wdd_stop,
> +	.ping = ni9x3x_wdd_ping,
> +	.set_timeout = ni9x3x_wdd_set_timeout,
> +	.get_timeleft = ni9x3x_wdd_get_timeleft,
> +};
> +
> +static int ni9x3x_acpi_add(struct acpi_device *device)
> +{
> +	struct device *dev = &device->dev;
> +	struct watchdog_device *wdd;
> +	struct ni9x3x_wdt *wdt;
> +	acpi_status status;
> +	int ret;
> +
> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);

linux/device.h, already mentioned.

> +	if (!wdt) {
> +		dev_err(dev, "failed to allocate memory\n");

Unnecessary (duplicate) error message; devm_kzalloc() already creates one.

> +		return -ENOMEM;
> +	}
> +
> +	device->driver_data = wdt;
> +	wdt->dev = dev;
> +
> +	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +				     ni9x3x_resources, wdt);
> +	if (ACPI_FAILURE(status) || wdt->io_base == 0) {
> +		dev_err(dev, "failed to get resources\n");
> +		return -ENODEV;
> +	}
> +
> +	wdd = &wdt->wdd;
> +	wdd->info = &ni9x3x_wdd_info;
> +	wdd->ops = &ni9x3x_wdd_ops;
> +	wdd->min_timeout = NIWD_MIN_TIMEOUT;
> +	wdd->max_timeout = NIWD_MAX_TIMEOUT;
> +	wdd->timeout = NIWD_DEFAULT_TIMEOUT;
> +	wdd->parent = dev;
> +	watchdog_set_drvdata(wdd, wdt);
> +	watchdog_set_nowayout(wdd, nowayout);
> +	ret = watchdog_init_timeout(wdd, timeout, dev);
> +	if (ret) {
> +		dev_err(dev, "unable to set timeout value\n");

Sure you want to abort here, instead of using the default ?

> +		return ret;
> +	}
> +
> +	ret = watchdog_register_device(wdd);
> +	if (ret) {
> +		dev_err(dev, "failed to register watchdog\n");
> +		return ret;
> +	}
> +
> +	/* Switch from boot mode to user mode */
> +	outb(NIWD_CONTROL_RESET | NIWD_CONTROL_MODE,
> +	     wdt->io_base + NIWD_CONTROL);
> +
> +	dev_dbg(dev, "io_base=0x%04X, timeout=%u, nowayout=%s\n",
> +		wdt->io_base, timeout, nowayout ? "true" : "false");
> +
This would be the first driver to display true/false instead of 0/1.
Let's stick with 0/1 for simplicity and consistency.

> +	return 0;
> +}
> +
> +static int ni9x3x_acpi_remove(struct acpi_device *device)
> +{
> +	struct ni9x3x_wdt *wdt = acpi_driver_data(device);
> +
> +	ni9x3x_wdd_stop(&wdt->wdd);
> +	watchdog_unregister_device(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id ni9x3x_device_ids[] = {
> +	{"NIC775C", 0},
> +	{"", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, ni9x3x_device_ids);
> +
> +static struct acpi_driver ni9x3x_acpi_driver = {
> +	.name = NIWD_NAME,
> +	.ids = ni9x3x_device_ids,
> +	.ops = {
> +		.add = ni9x3x_acpi_add,
> +		.remove = ni9x3x_acpi_remove,
> +		},

Indentation - closing bracket should align with .ops

> +};
> +
> +module_acpi_driver(ni9x3x_acpi_driver);
> +
> +MODULE_DESCRIPTION("NI Watchdog");
> +MODULE_AUTHOR("Jeff Westfahl <jeff.westfahl@ni.com>");
> +MODULE_AUTHOR("Kyle Roeschley <kyle.roeschley@ni.com>");
> +MODULE_LICENSE("GPL v2");
>
Text above is more generic. Please either change the text to
limit the license to GPL v2, or change the MODULE_LICENSE to GPL.


