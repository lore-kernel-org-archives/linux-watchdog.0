Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49030 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933709AbcAYReU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Jan 2016 12:34:20 -0500
Subject: Re: [PATCH v2] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
To: William Breathitt Gray <vilhelm.gray@gmail.com>, wim@iguana.be
References: <20160125165311.GA27188@sophia>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A65C98.1050704@roeck-us.net>
Date: Mon, 25 Jan 2016 09:34:16 -0800
MIME-Version: 1.0
In-Reply-To: <20160125165311.GA27188@sophia>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/25/2016 08:53 AM, William Breathitt Gray wrote:
> The WinSystems EBC-C384 has an onboard watchdog timer. The timeout range
> supported by the watchdog timer is 1 second to 255 minutes. Timeouts
> under 256 seconds have a 1 second resolution, while the rest have a 1
> minute resolution.
>
> This driver adds watchdog timer support for this onboard watchdog timer.
> The timeout may be configured via the timeout module parameter.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Almost there. Couple of comments below.

Thanks,
Guenter

> ---
> Changes in v2:
>    - Reimplement the start and set_timeout callback to reflect the
>      watchdog API
>    - Remove unnecessary synchronization locks
>    - Fix typo in timer hardware configuration (second/minute resolution
>      commands were swapped)
>    - Use preprocessor defines for global constants
>    - Check for motherboard name in DMI table to verify correct hardware
>    - Use devm_request_region over request_region
>    - Remove redundant information (e.g. device name) from error messages
>    - Relax timeout initialization code by warning instead of failing when
>      initial timeout value requested is invalid
>    - Call watchdog_unregister_device when finished
>    - Clarify module license description
>    - Add MODULE_ALIAS
>
>   MAINTAINERS                     |   6 ++
>   drivers/watchdog/Kconfig        |   9 ++
>   drivers/watchdog/Makefile       |   1 +
>   drivers/watchdog/ebc-c384_wdt.c | 190 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 206 insertions(+)
>   create mode 100644 drivers/watchdog/ebc-c384_wdt.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b1e3da7..c058abf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11629,6 +11629,12 @@ M:	David Härdeman <david@hardeman.nu>
>   S:	Maintained
>   F:	drivers/media/rc/winbond-cir.c
>
> +WINSYSTEMS EBC-C384 WATCHDOG DRIVER
> +M:	William Breathitt Gray <vilhelm.gray@gmail.com>
> +L:	linux-watchdog@vger.kernel.org
> +S:	Maintained
> +F:	drivers/watchdog/ebc-c384_wdt.c
> +
>   WIMAX STACK
>   M:	Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
>   M:	linux-wimax@intel.com
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 4f0e7be..b5b1353 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -711,6 +711,15 @@ config ALIM7101_WDT
>
>   	  Most people will say N.
>
> +config EBC_C386_WDT
> +	tristate "WinSystems EBC-C384 Watchdog Timer"
> +	depends on X86
> +	select WATCHDOG_CORE
> +	help
> +	  Enables watchdog timer support for the watchdog timer on the
> +	  WinSystems EBC-C384 motherboard. The timeout may be configured via
> +	  the timeout module parameter.
> +
>   config F71808E_WDT
>   	tristate "Fintek F71808E, F71862FG, F71869, F71882FG and F71889FG Watchdog"
>   	depends on X86
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index f566753..1522316 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -88,6 +88,7 @@ obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
>   obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
>   obj-$(CONFIG_ALIM1535_WDT) += alim1535_wdt.o
>   obj-$(CONFIG_ALIM7101_WDT) += alim7101_wdt.o
> +obj-$(CONFIG_EBC_C386_WDT) += ebc-c384_wdt.o
>   obj-$(CONFIG_F71808E_WDT) += f71808e_wdt.o
>   obj-$(CONFIG_SP5100_TCO) += sp5100_tco.o
>   obj-$(CONFIG_GEODE_WDT) += geodewdt.o
> diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
> new file mode 100644
> index 0000000..4c41141
> --- /dev/null
> +++ b/drivers/watchdog/ebc-c384_wdt.c
> @@ -0,0 +1,190 @@
> +/*
> + * Watchdog timer driver for the WinSystems EBC-C384
> + * Copyright (C) 2016 William Breathitt Gray
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +#include <linux/device.h>
> +#include <linux/dmi.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +
> +#define MODULE_NAME "ebc-c384_wdt"
> +#define WATCHDOG_TIMEOUT 60
> +#define BASE_ADDR 0x564
> +#define ADDR_EXTENT 5
> +#define CFG_ADDR (BASE_ADDR + 1)
> +#define PET_ADDR (BASE_ADDR + 2)
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static unsigned timeout = WATCHDOG_TIMEOUT;

You don't need to pre-initialize this variable. The watchdog core understands that
timeout == 0 means that the module parameter is not set, and won't return an error
in this case.

> +module_param(timeout, uint, 0);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
> +	__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
> +
> +static int ebc_c384_wdt_start(struct watchdog_device *wdev)
> +{
> +	unsigned t = wdev->timeout;
> +
> +	/* resolution is in minutes for timeouts greater than 255 seconds */
> +	if (t > 255)
> +		t /= 60;
> +
> +	outb(t, PET_ADDR);
> +
> +	return 0;
> +}
> +
> +static int ebc_c384_wdt_stop(struct watchdog_device *wdev)
> +{
> +	outb(0x00, PET_ADDR);
> +
> +	return 0;
> +}
> +
> +static int ebc_c384_wdt_set_timeout(struct watchdog_device *wdev, unsigned t)
> +{
> +	/* resolution is in minutes for timeouts greater than 255 seconds */
> +	if (t > 255) {
> +		/* truncate second resolution to minute resolution */
> +		t /= 60;
> +		wdev->timeout = t * 60;
> +
> +		/* set watchdog timer for minutes */
> +		outb(0x00, CFG_ADDR);
> +	} else {
> +		wdev->timeout = t;
> +
> +		/* set watchdog timer for seconds */
> +		outb(0x80, CFG_ADDR);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_ops ebc_c384_wdt_ops = {
> +	.start = ebc_c384_wdt_start,
> +	.stop = ebc_c384_wdt_stop,
> +	.set_timeout = ebc_c384_wdt_set_timeout
> +};
> +
> +static const struct watchdog_info ebc_c384_wdt_info = {
> +	.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT,
> +	.identity = MODULE_NAME
> +};
> +
> +static int __init ebc_c384_wdt_probe(struct platform_device *pdev)
> +{
> +	const char *const ebc_c384_dmi_name = "EBC-C384 SBC";
> +	struct device *dev = &pdev->dev;
> +	struct watchdog_device *wdd;
> +
> +	if (!dmi_match(DMI_BOARD_NAME, ebc_c384_dmi_name)) {

I would suggest to use "EBC-C384 SBC" directly. It makes it easier to grep
for dmi_match and find the affected boards.

> +		dev_err(dev, "DMI board name \"%s\" not found\n",
> +			ebc_c384_dmi_name);

Please no error message here. This is considered normal operation.
The user will be alerted by the failing modprobe.

You should consider moving this code into the top of the init function.
There is no need to instantiate the device or the driver if the board
name does not match.

> +		return -ENODEV;
> +	}
> +
> +	if (!devm_request_region(dev, BASE_ADDR, ADDR_EXTENT, dev_name(dev))) {
> +		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
> +			BASE_ADDR, BASE_ADDR + ADDR_EXTENT);
> +		return -EBUSY;
> +	}
> +
> +	wdd = devm_kzalloc(dev, sizeof(*wdd), GFP_KERNEL);
> +	if (!wdd)
> +		return -ENOMEM;
> +
> +	wdd->info = &ebc_c384_wdt_info;
> +	wdd->ops = &ebc_c384_wdt_ops;
> +	wdd->timeout = WATCHDOG_TIMEOUT;
> +	wdd->min_timeout = 1;
> +	wdd->max_timeout = 15300;

Might be useful to use a define (eg WATCHDOG_MAX_TIMEOUT) for this and explain
why the maximum is 15300.

> +
> +	watchdog_set_nowayout(wdd, nowayout);
> +
> +	if (watchdog_init_timeout(wdd, timeout, dev))
> +		dev_warn(dev, "Invalid timeout (%u seconds), using default (%u seconds)\n",
> +			timeout, WATCHDOG_TIMEOUT);
> +
> +	dev_set_drvdata(dev, wdd);
> +
Since you use platform_get_drvdata() below, you should use platform_set_drvdata()
here.

> +	return watchdog_register_device(wdd);
> +}
> +
> +static int ebc_c384_wdt_remove(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(wdd);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ebc_c384_wdt_driver = {
> +	.driver = {
> +		.name = MODULE_NAME
> +	},
> +	.remove = ebc_c384_wdt_remove
> +};
> +
> +static struct platform_device *ebc_c384_wdt_device;
> +
> +static int __init ebc_c384_wdt_init(void)
> +{
> +	int err;
> +
> +	ebc_c384_wdt_device = platform_device_alloc(
> +		ebc_c384_wdt_driver.driver.name, -1);

Please just use MODULE_NAME here. Leave it up to the compiler
to fold the strings.

> +	if (!ebc_c384_wdt_device)
> +		return -ENOMEM;
> +
> +	err = platform_device_add(ebc_c384_wdt_device);
> +	if (err)
> +		goto err_platform_device;
> +
> +	err = platform_driver_probe(&ebc_c384_wdt_driver, ebc_c384_wdt_probe);
> +	if (err)
> +		goto err_platform_driver;
> +
> +	return 0;
> +
> +err_platform_driver:
> +	platform_device_del(ebc_c384_wdt_device);
> +err_platform_device:
> +	platform_device_put(ebc_c384_wdt_device);
> +	return err;
> +
> +	return 0;

Duplicate return statement.

> +}
> +
> +static void __exit ebc_c384_wdt_exit(void)
> +{
> +	platform_device_unregister(ebc_c384_wdt_device);
> +	platform_driver_unregister(&ebc_c384_wdt_driver);
> +}
> +
> +module_init(ebc_c384_wdt_init);
> +module_exit(ebc_c384_wdt_exit);
> +
> +MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> +MODULE_DESCRIPTION("WinSystems EBC-C384 watchdog timer driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" MODULE_NAME);
>

