Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:51052 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab3IVPIX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 22 Sep 2013 11:08:23 -0400
Message-ID: <523F07E4.8090801@roeck-us.net>
Date: Sun, 22 Sep 2013 08:08:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: wim@iguana.be, linux-watchdog@vger.kernel.org,
	workgroup.linux@csr.com, Xianglong Du <Xianglong.Du@csr.com>,
	Barry Song <Baohua.Song@csr.com>,
	Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: [PATCH v3] watchdog: sirf: add watchdog driver of CSR SiRFprimaII
 and SiRFatlasVI
References: <1379832237-3833-1-git-send-email-Baohua.Song@csr.com>
In-Reply-To: <1379832237-3833-1-git-send-email-Baohua.Song@csr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/21/2013 11:43 PM, Barry Song wrote:
> From: Xianglong Du <Xianglong.Du@csr.com>
>
> On CSR SiRFprimaII and SiRFatlasVI, the 6th timer can act as a watchdog
> timer when the Watchdog mode is enabled.
>
> watchdog occur when TIMER watchdog counter matches the value software
> pre-set, when this event occurs, the effect is the same as the system
> software reset.
>
> Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Cc: Romain Izard <romain.izard.pro@gmail.com>
> ---
>   -v3: cleanup according to feedback from Romain Izard, thanks!
>   .../devicetree/bindings/watchdog/sirfsoc_wdt.txt   |  15 ++
>   arch/arm/configs/prima2_defconfig                  |   1 +
>   drivers/watchdog/Kconfig                           |   9 +
>   drivers/watchdog/Makefile                          |   1 +
>   drivers/watchdog/sirfsoc_wdt.c                     | 242 +++++++++++++++++++++
>   5 files changed, 268 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
>   create mode 100644 drivers/watchdog/sirfsoc_wdt.c
>
> diff --git a/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt b/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
> new file mode 100644
> index 0000000..7d11960
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
> @@ -0,0 +1,15 @@
> +SiRFSoC Timer and Watchdog Timer(WDT) Controller
> +
> +Required properties:
> +- compatible: "sirf,prima2-tick"
> +- reg: Address range of tick timer/WDT register set
> +- interrupts: interrupt number to the cpu
> +
> +Example:
> +
> +timer@b0020000 {
> +	compatible = "sirf,prima2-tick";
> +	reg = <0xb0020000 0x1000>;
> +	interrupts = <0>;
> +};
> +
> diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
> index 002a1ce..23591db 100644
> --- a/arch/arm/configs/prima2_defconfig
> +++ b/arch/arm/configs/prima2_defconfig
> @@ -39,6 +39,7 @@ CONFIG_SPI=y
>   CONFIG_SPI_SIRF=y
>   CONFIG_SPI_SPIDEV=y
>   # CONFIG_HWMON is not set
> +CONFIG_WATCHDOG=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_MASS_STORAGE=m
>   CONFIG_MMC=y
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index d1d53f3..98fb560 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -392,6 +392,15 @@ config RETU_WATCHDOG
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called retu_wdt.
>
> +config SIRFSOC_WATCHDOG
> +	tristate "SiRFSOC watchdog"
> +	depends on ARCH_SIRF
> +	select WATCHDOG_CORE
> +	default y
> +	help
> +	  Support for CSR SiRFprimaII and SiRFatlasVI watchdog. When
> +	  the watchdog triggers the system will be reset.
> +

You might add "To compile this driver as a module ..."; this would
help the user to know how the module is named, and have the nice side
effect of silencing the watchdog warning.

>   # AVR32 Architecture
>
>   config AT32AP700X_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 6c5bb27..1a1300d 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
>   obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
>   obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
>   obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o
> +obj-$(CONFIG_SIRFSOC_WATCHDOG) += sirfsoc_wdt.o
>
>   # AVR32 Architecture
>   obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
> new file mode 100644
> index 0000000..464495d
> --- /dev/null
> +++ b/drivers/watchdog/sirfsoc_wdt.c
> @@ -0,0 +1,242 @@
> +/*
> + * Watchdog driver for CSR SiRFprimaII and SiRFatlasVI
> + *
> + * Copyright (c) 2013 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/watchdog.h>
> +#include <linux/platform_device.h>
> +#include <linux/moduleparam.h>
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <linux/uaccess.h>
> +
> +#define SIRFSOC_TIMER_COUNTER_LO	0x0000
> +#define SIRFSOC_TIMER_MATCH_0		0x0008
> +#define SIRFSOC_TIMER_INT_EN		0x0024
> +#define SIRFSOC_TIMER_WATCHDOG_EN	0x0028
> +#define SIRFSOC_TIMER_LATCH		0x0030
> +#define SIRFSOC_TIMER_LATCHED_LO	0x0034
> +
> +#define SIRFSOC_TIMER_WDT_INDEX		5
> +
> +#define SIRFSOC_WDT_MIN_TIMEOUT		30		/* 30 secs */
> +#define SIRFSOC_WDT_MAX_TIMEOUT		(10 * 60)	/* 10 mins */
> +#define SIRFSOC_WDT_DEFAULT_TIMEOUT	30		/* 30 secs */
> +
> +
> +static unsigned int timeout = SIRFSOC_WDT_DEFAULT_TIMEOUT;
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +
> +module_param(timeout, uint, 0);
> +module_param(nowayout, bool, 0);
> +
> +MODULE_PARM_DESC(timeout, "Default watchdog timeout (in seconds)");
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static unsigned int sirfsoc_wdt_gettimeleft(struct watchdog_device *wdd)
> +{
> +	u32 counter, match;
> +	void __iomem *wdt_base;
> +	int time_left;
> +
> +	wdt_base = watchdog_get_drvdata(wdd);
> +	counter = readl(wdt_base + SIRFSOC_TIMER_COUNTER_LO);
> +	match = readl(wdt_base +
> +		SIRFSOC_TIMER_MATCH_0 + (SIRFSOC_TIMER_WDT_INDEX << 2));
> +
> +	time_left = match - counter;
> +
> +	return time_left / CLOCK_TICK_RATE;
> +}
> +
> +static int sirfsoc_wdt_updatetimeout(struct watchdog_device *wdd)
> +{
> +	u32 counter, timeout_ticks;
> +	void __iomem *wdt_base;
> +
> +	timeout_ticks = wdd->timeout * CLOCK_TICK_RATE;
> +	wdt_base = watchdog_get_drvdata(wdd);
> +
> +	/* Enable the latch before reading the LATCH_LO register */
> +	writel(1, wdt_base + SIRFSOC_TIMER_LATCH);
> +
> +	/* Set the TO value */
> +	counter = readl(wdt_base + SIRFSOC_TIMER_LATCHED_LO);
> +
> +	counter += timeout_ticks;
> +
> +	writel(counter, wdt_base +
> +		SIRFSOC_TIMER_MATCH_0 + (SIRFSOC_TIMER_WDT_INDEX << 2));
> +
> +	return 0;
> +}
> +
> +static int sirfsoc_wdt_enable(struct watchdog_device *wdd)
> +{
> +	void __iomem *wdt_base = watchdog_get_drvdata(wdd);
> +	sirfsoc_wdt_updatetimeout(wdd);
> +
> +	/*
> +	 * NOTE: If interrupt is not enabled
> +	 * then WD-Reset doesn't get generated at all.
> +	 */
> +	writel(readl(wdt_base + SIRFSOC_TIMER_INT_EN)
> +		| (1 << SIRFSOC_TIMER_WDT_INDEX),
> +		wdt_base + SIRFSOC_TIMER_INT_EN);
> +	writel(1, wdt_base + SIRFSOC_TIMER_WATCHDOG_EN);
> +
> +	return 0;
> +}
> +
> +static int sirfsoc_wdt_disable(struct watchdog_device *wdd)
> +{
> +	void __iomem *wdt_base = watchdog_get_drvdata(wdd);
> +
> +	writel(0, wdt_base + SIRFSOC_TIMER_WATCHDOG_EN);
> +	writel(readl(wdt_base + SIRFSOC_TIMER_INT_EN)
> +		& (~(1 << SIRFSOC_TIMER_WDT_INDEX)),
> +		wdt_base + SIRFSOC_TIMER_INT_EN);
> +
> +	return 0;
> +}
> +
> +static int sirfsoc_wdt_settimeout(struct watchdog_device *wdd, unsigned int to)
> +{
> +	wdd->timeout = to;
> +	sirfsoc_wdt_updatetimeout(wdd);
> +
> +	return 0;
> +}
> +
> +#define OPTIONS (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
> +
> +static const struct watchdog_info sirfsoc_wdt_ident = {
> +	.options          =     OPTIONS,
> +	.firmware_version =	0,
> +	.identity         =	"SiRFSOC Watchdog",
> +};
> +
> +static struct watchdog_ops sirfsoc_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = sirfsoc_wdt_enable,
> +	.stop = sirfsoc_wdt_disable,
> +	.get_timeleft = sirfsoc_wdt_gettimeleft,
> +	.ping = sirfsoc_wdt_updatetimeout,
> +	.set_timeout = sirfsoc_wdt_settimeout,
> +};
> +
> +static struct watchdog_device sirfsoc_wdd = {
> +	.info = &sirfsoc_wdt_ident,
> +	.ops = &sirfsoc_wdt_ops,
> +	.timeout = SIRFSOC_WDT_DEFAULT_TIMEOUT,
> +	.min_timeout = SIRFSOC_WDT_MIN_TIMEOUT,
> +	.max_timeout = SIRFSOC_WDT_MAX_TIMEOUT,
> +};
> +
> +static int sirfsoc_wdt_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int ret;
> +	void __iomem *base;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (!base) {
> +		dev_err(&pdev->dev, "sirfsoc wdt: could not remap the mem\n");
> +		ret = -EADDRNOTAVAIL;

This is a socket call error code, which does not apply here.
devm_iomap_resource returns a valid error code, so checking for NULL is wrong.
The function already displays an error message, so another one is unnecessary.

Use
	if (IS_ERR())
		return PTR_ERR();

> +		goto out;
> +	}
> +	watchdog_set_drvdata(&sirfsoc_wdd, base);
> +
> +	watchdog_init_timeout(&sirfsoc_wdd, timeout, &pdev->dev);
> +	watchdog_set_nowayout(&sirfsoc_wdd, nowayout);
> +
> +	ret = watchdog_register_device(&sirfsoc_wdd);
> +	if (!!ret)
> +		goto out;
> +

This double-bang is really unnecessary. Just use ret.


> +	platform_set_drvdata(pdev, &sirfsoc_wdd);
> +
> +	return 0;
> +
> +out:

Jumping to a label just to return is unnecessary and confusing.
It leads one to assume that there is an error handling, which
is not the case here. Returning directly in this case is specifically
permitted by CodingStyle.

> +	return ret;
> +}
> +
> +static int sirfsoc_wdt_remove(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
> +
> +	sirfsoc_wdt_disable(wdd);
> +
> +	return 0;
> +}
> +
> +static void sirfsoc_wdt_shutdown(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
> +
> +	sirfsoc_wdt_disable(wdd);
> +}

The above two functions duplicate the same code.

> +
> +#ifdef	CONFIG_PM
> +
> +static int sirfsoc_wdt_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int sirfsoc_wdt_resume(struct device *dev)
> +{
> +	struct watchdog_device *wdd = dev_get_drvdata(dev);
> +
> +	/*
> +	 * NOTE: Since timer controller registers settings are saved
> +	 * and restored back by the timer-prima2.c, so we need not
> +	 * update WD settings except refreshing timeout.
> +	 */
> +	sirfsoc_wdt_updatetimeout(wdd);
> +
> +	return 0;
> +}
> +
> +#else
> +#define	sirfsoc_wdt_suspend		NULL
> +#define	sirfsoc_wdt_resume		NULL
> +#endif
> +
> +static const struct dev_pm_ops sirfsoc_wdt_pm_ops = {

Consider using SIMPLE_DEV_PM_OPS to support both suspend to RAM and hibernation.

> +	.suspend = sirfsoc_wdt_suspend,
> +	.resume = sirfsoc_wdt_resume,
> +};
> +
> +static const struct of_device_id sirfsoc_wdt_of_match[] = {
> +	{ .compatible = "sirf,prima2-tick"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sirfsoc_wdt_of_match);
> +
> +static struct platform_driver sirfsoc_wdt_driver = {
> +	.driver = {
> +		.name = "sirfsoc-wdt",
> +		.owner = THIS_MODULE,
> +#ifdef CONFIG_PM
> +		.pm = &sirfsoc_wdt_pm_ops,
> +#endif

sirfsoc_wdt_pm_ops is declared unconditionally, so this ifdef
around the assignment is unnecessary and should be dropped.

> +		.of_match_table	= of_match_ptr(sirfsoc_wdt_of_match),
> +	},
> +	.probe = sirfsoc_wdt_probe,
> +	.remove = sirfsoc_wdt_remove,
> +	.shutdown = sirfsoc_wdt_shutdown,
> +};
> +module_platform_driver(sirfsoc_wdt_driver);
> +
> +MODULE_DESCRIPTION("SiRF SoC watchdog driver");
> +MODULE_AUTHOR("Xianglong Du <Xianglong.Du@csr.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:sirfsoc-wdt");
>

