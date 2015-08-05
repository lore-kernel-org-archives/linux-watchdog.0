Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59064 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbHEGOg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 5 Aug 2015 02:14:36 -0400
Message-ID: <55C1A9C2.5070808@roeck-us.net>
Date: Tue, 04 Aug 2015 23:14:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Wenyou Yang <wenyou.yang@atmel.com>, wim@iguana.be,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
CC: sylvain.rochet@finsecur.com, nicolas.ferre@atmel.com,
	boris.brezillon@free-electrons.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] drivers: watchdog: add a driver to support SAMA5D4
 watchdog timer
References: <1438742130-2089-1-git-send-email-wenyou.yang@atmel.com> <1438742130-2089-2-git-send-email-wenyou.yang@atmel.com>
In-Reply-To: <1438742130-2089-2-git-send-email-wenyou.yang@atmel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/04/2015 07:35 PM, Wenyou Yang wrote:
>>From SAMA5D4, the watchdog timer is upgrated with a new feature,
> which is describled as in the datasheet, "WDT_MR can be written
> until a LOCKMR command is issued in WDT_CR".
> That is to say, as long as the bootstrap and u-boot don't issue
> a LOCKMR command, WDT_MR can be written more than once in the driver.
>
> So the SAMA5D4 watchdog driver's implementation is different from
> the previous: the user application open the device file to enable

Which previous ? Please let the reader know which one you refer to.

> the watchdog timer hardware, and close to disable it, and set the
> watchdog timer timeout by seting WDV and WDD fields of WDT_MR register,
> and ping the watchdog by issuing WDRSTT command to WDT_CR register
> with hard-coded key.
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>   drivers/watchdog/Kconfig        |    9 ++
>   drivers/watchdog/Makefile       |    1 +
>   drivers/watchdog/at91sam9_wdt.h |    4 +
>   drivers/watchdog/atmel_wdt.c    |  290 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 304 insertions(+)
>   create mode 100644 drivers/watchdog/atmel_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index e5e7c55..4425813 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -152,6 +152,15 @@ config ARM_SP805_WATCHDOG
>   	  ARM Primecell SP805 Watchdog timer. This will reboot your system when
>   	  the timeout is reached.
>
> +config ATMEL_WATCHDOG
> +	tristate "Atmel SAMA5D4 Watchdog Timer"
> +	depends on ARCH_AT91
> +	select WATCHDOG_CORE
> +	help
> +	  Atmel watchdog timer embedded into SAMA5D4 chips. Its Watchdog Timer
> +	  Mode Register(WDT_MR) can be written more than once.
> +	  This will reboot your system when the timeout is reached.
> +

ATMEL is highly generic. Can you find a more specific name ?
If this is part of the AT91 family, it could be something
like AT91SAMAD54, for example.

Same goes for the driver name.

>   config AT91RM9200_WATCHDOG
>   	tristate "AT91RM9200 watchdog"
>   	depends on SOC_AT91RM9200 && MFD_SYSCON
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 5c19294..c24a8fc 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
>
>   # ARM Architecture
>   obj-$(CONFIG_ARM_SP805_WATCHDOG) += sp805_wdt.o
> +obj-$(CONFIG_ATMEL_WATCHDOG) += atmel_wdt.o
>   obj-$(CONFIG_AT91RM9200_WATCHDOG) += at91rm9200_wdt.o
>   obj-$(CONFIG_AT91SAM9X_WATCHDOG) += at91sam9_wdt.o
>   obj-$(CONFIG_CADENCE_WATCHDOG) += cadence_wdt.o
> diff --git a/drivers/watchdog/at91sam9_wdt.h b/drivers/watchdog/at91sam9_wdt.h
> index c6fbb2e6..79add4f 100644
> --- a/drivers/watchdog/at91sam9_wdt.h
> +++ b/drivers/watchdog/at91sam9_wdt.h
> @@ -22,11 +22,15 @@
>
>   #define AT91_WDT_MR		0x04			/* Watchdog Mode Register */
>   #define		AT91_WDT_WDV		(0xfff << 0)		/* Counter Value */
> +#define			AT91_WDT_WDV_MSK	(0xfff)

The ( ) is not necessary. AT91_WDT_WDV is already used as mask.
You should not need a second one.

> +#define			AT91_WDT_WDV_(x)	(((x) & AT91_WDT_WDV_MSK) << 0)

Please no '_' at the end of the macro name; find another name that isn't
as close to AT91_WDT_WDV.

>   #define		AT91_WDT_WDFIEN		(1     << 12)		/* Fault Interrupt Enable */
>   #define		AT91_WDT_WDRSTEN	(1     << 13)		/* Reset Processor */
>   #define		AT91_WDT_WDRPROC	(1     << 14)		/* Timer Restart */
>   #define		AT91_WDT_WDDIS		(1     << 15)		/* Watchdog Disable */
>   #define		AT91_WDT_WDD		(0xfff << 16)		/* Delta Value */
> +#define			AT91_WDT_WDD_MSK	(0xfff)

( ) is unnecessary. Also, AT91_WDT_WDD is already used as mask.
No need to specify a second one.

> +#define			AT91_WDT_WDD_(x)	(((x) & AT91_WDT_WDD_MSK) << 16)

Again, please no '_' at the end of the macro name.

>   #define		AT91_WDT_WDDBGHLT	(1     << 28)		/* Debug Halt */
>   #define		AT91_WDT_WDIDLEHLT	(1     << 29)		/* Idle Halt */
>
> diff --git a/drivers/watchdog/atmel_wdt.c b/drivers/watchdog/atmel_wdt.c
> new file mode 100644
> index 0000000..e1cdc84
> --- /dev/null
> +++ b/drivers/watchdog/atmel_wdt.c
> @@ -0,0 +1,290 @@
> +/*
> + * Driver for Atmel SAMA5D4 Watchdog Timer
> + *
> + * Copyright (C) 2015 Atmel Corporation
> + *
> + * Licensed under GPLv2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <linux/reboot.h>

Please use alphabetic order for include files. That makes
it easier to find files, and simplifies later additions.

> +
> +#include "at91sam9_wdt.h"
> +
> +/* minimum and maximum watchdog timeout, in seconds */
> +#define MIN_WDT_TIMEOUT		1
> +#define MAX_WDT_TIMEOUT		16
> +#define WDT_DEFAULT_TIMEOUT	MAX_WDT_TIMEOUT
> +
> +#define WDT_MAX_WDV		0xFFF
> +
> +#define WDT_SEC2TICKS(s)	((s) ? (((s) << 8) - 1) : 0)
> +
> +struct atmel_wdt {
> +	struct watchdog_device	wdd;
> +	void __iomem		*reg_base;
> +	u32	config;
> +};
> +
> +static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +
> +module_param(wdt_timeout, int, 0);
> +MODULE_PARM_DESC(wdt_timeout,
> +	"Watchdog wdt_timeout in seconds. (default = "
> +	__MODULE_STRING(WDT_DEFAULT_TIMEOUT) ")");
> +
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +	"Watchdog cannot be stopped once started (default="
> +	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +#define wdt_read(wdt, field) \
> +	readl_relaxed((wdt)->reg_base + (field))
> +
> +#define wdt_write(wtd, field, val) \
> +	writel_relaxed((val), (wdt)->reg_base + (field))
> +
> +static int atmel_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct atmel_wdt *wdt = watchdog_get_drvdata(wdd);
> +	u32 reg;
> +
> +	reg = wdt_read(wdt, AT91_WDT_MR);
> +	reg &= ~AT91_WDT_WDDIS;
> +	wdt_write(wdt, AT91_WDT_MR, reg);
> +
> +	return 0;
> +}
> +
> +static int atmel_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct atmel_wdt *wdt = watchdog_get_drvdata(wdd);
> +	u32 reg;
> +
> +	reg = wdt_read(wdt, AT91_WDT_MR);
> +	reg |= AT91_WDT_WDDIS;
> +	wdt_write(wdt, AT91_WDT_MR, reg);
> +
> +	return 0;
> +}
> +
> +static int atmel_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct atmel_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	wdt_write(wdt, AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
> +
> +	return 0;
> +}
> +
> +static int atmel_wdt_set_timeout(struct watchdog_device *wdd,
> +				 unsigned int timeout)
> +{
> +	struct atmel_wdt *wdt = watchdog_get_drvdata(wdd);
> +	u32 reg, value;
> +
> +	value = WDT_SEC2TICKS(timeout);
> +	if (value > WDT_MAX_WDV)
> +		return -EINVAL;
> +
Unnecessary check.

> +	reg = wdt_read(wdt, AT91_WDT_MR);
> +	reg &= ~AT91_WDT_WDV;
> +	reg &= ~AT91_WDT_WDD;
> +	reg |= AT91_WDT_WDV_(value);
> +	reg |= AT91_WDT_WDD_(value);
> +	wdt_write(wdt, AT91_WDT_MR, reg);
> +
> +	wdd->timeout = timeout;
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info atmel_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
> +	.firmware_version = 0,
> +	.identity = "Atmel SAMA5D4 Watchdog",
> +};
> +
> +static struct watchdog_ops atmel_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = atmel_wdt_start,
> +	.stop = atmel_wdt_stop,
> +	.ping = atmel_wdt_ping,
> +	.set_timeout = atmel_wdt_set_timeout,
> +};
> +
> +static irqreturn_t atmel_wdt_irq_handler(int irq, void *dev_id)
> +{
> +	struct atmel_wdt *wdt = platform_get_drvdata(dev_id);
> +
> +	if (wdt_read(wdt, AT91_WDT_SR)) {
> +		pr_crit("Atmel Watchdog Software Reset\n");
> +		emergency_restart();
> +		pr_crit("Reboot didn't ?????\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int of_atmel_wdt_init(struct device_node *np, struct atmel_wdt *wdt)
> +{
> +	const char *tmp;
> +
> +	wdt->config = AT91_WDT_WDDIS;
> +
> +	if (!of_property_read_string(np, "atmel,watchdog-type", &tmp) &&
> +	    !strcmp(tmp, "software"))
> +		wdt->config |= AT91_WDT_WDFIEN;
> +	else
> +		wdt->config |= AT91_WDT_WDRSTEN;
> +
> +	if (of_property_read_bool(np, "atmel,idle-halt"))
> +		wdt->config |= AT91_WDT_WDIDLEHLT;
> +
> +	if (of_property_read_bool(np, "atmel,dbg-halt"))
> +		wdt->config |= AT91_WDT_WDDBGHLT;
> +
> +	return 0;
> +}
> +
> +static int atmel_wdt_init(struct atmel_wdt *wdt)
> +{
> +	struct watchdog_device *wdd = &wdt->wdd;
> +	u32 value, timeout;
> +
> +	timeout = WDT_SEC2TICKS(wdd->timeout);
> +	if (timeout > WDT_MAX_WDV)
> +		return -1;
> +

Unnecessary range check.

> +	/*
> +	 * Because the fields WDV and WDD must not be modified when the WDDIS
> +	 * bit is set, so clear the WDDIS bit before writing the WDT_MR.
> +	 */
> +	value = wdt_read(wdt, AT91_WDT_MR);
> +	value &= ~AT91_WDT_WDDIS;
> +	wdt_write(wdt, AT91_WDT_MR, value);
> +
> +	value = wdt->config;
> +	value |= AT91_WDT_WDD_(timeout);
> +	value |= AT91_WDT_WDV_(timeout);
> +
> +	wdt_write(wdt, AT91_WDT_MR, value);
> +
> +	return 0;
> +}
> +
> +static int atmel_wdt_probe(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdd;
> +	struct atmel_wdt *wdt;
> +	struct resource *res;
> +	void __iomem *regs;
> +	int ret, irq = -1;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdd = &wdt->wdd;
> +	wdd->timeout = wdt_timeout;
> +	wdd->info = &atmel_wdt_info;
> +	wdd->ops = &atmel_wdt_ops;
> +	wdd->min_timeout = MIN_WDT_TIMEOUT;
> +	wdd->max_timeout = MAX_WDT_TIMEOUT;
> +
> +	watchdog_set_drvdata(wdd, wdt);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	wdt->reg_base = regs;
> +
> +	if (pdev->dev.of_node) {
> +		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +		if (!irq)
> +			dev_warn(&pdev->dev, "the IRQ NOT specify from DT\n");

"failed to get IRQ from DT" would be a better message.
This leaves irq set to 0 in the error case, and cause the code below
to request an interrupt.

> +
> +		ret = of_atmel_wdt_init(pdev->dev.of_node, wdt);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if ((wdt->config & AT91_WDT_WDFIEN) && (irq >= 0)) {

Second ( ) is unnecessary.

> +		ret = devm_request_irq(&pdev->dev, irq, atmel_wdt_irq_handler,
> +				       0, pdev->name, pdev);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"cannot register interrupt handler\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = watchdog_init_timeout(wdd, wdt_timeout, &pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to set timeout value\n");
> +		return ret;

I would suggest to set the default timeout in this case, as done by other drivers.

> +	}
> +
> +	ret = atmel_wdt_init(wdt);
> +	if (ret)
> +		return ret;
> +
> +	watchdog_set_nowayout(wdd, nowayout);
> +
> +	ret = watchdog_register_device(wdd);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register watchdog device\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	dev_info(&pdev->dev, "initialized (timeout = %d sec, nowayout = %d)\n",
> +		 wdt_timeout, nowayout);
> +
> +	return 0;
> +}
> +
> +static int atmel_wdt_remove(struct platform_device *pdev)
> +{
> +	struct atmel_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	atmel_wdt_stop(&wdt->wdd);
> +
> +	watchdog_unregister_device(&wdt->wdd);
> +
> +	dev_info(&pdev->dev, "removed wdt\n");
> +
Unnecessary message.

> +	return 0;
> +}
> +
> +static const struct of_device_id atmel_wdt_of_match[] = {
> +	{ .compatible = "atmel,sama5d4-wdt", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, atmel_wdt_of_match);
> +
> +static struct platform_driver atmel_wdt_driver = {
> +	.probe		= atmel_wdt_probe,
> +	.remove		= atmel_wdt_remove,
> +	.driver		= {
> +		.name	= "atmel-wdt",
> +		.of_match_table = atmel_wdt_of_match,
> +	},
> +};
> +module_platform_driver(atmel_wdt_driver);
> +
> +MODULE_ALIAS("platform:atmel-wdt");
> +MODULE_AUTHOR("Atmel Corporation");
> +MODULE_DESCRIPTION("Atmel SAMA5D4 Watchdog Timer driver");
> +MODULE_LICENSE("GPL v2");
>

