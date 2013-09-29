Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:58432 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270Ab3I2RUK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 29 Sep 2013 13:20:10 -0400
Message-ID: <52486146.50402@roeck-us.net>
Date: Sun, 29 Sep 2013 10:20:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>, wim@iguana.be,
	linux-watchdog@vger.kernel.org
CC: workgroup.linux@csr.com, Xianglong Du <Xianglong.Du@csr.com>,
	Barry Song <Baohua.Song@csr.com>,
	Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: [PATCH v5] watchdog: sirf: add watchdog driver of CSR SiRFprimaII
 and SiRFatlasVI
References: <1380461966-8869-1-git-send-email-Baohua.Song@csr.com>
In-Reply-To: <1380461966-8869-1-git-send-email-Baohua.Song@csr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/29/2013 06:39 AM, Barry Song wrote:
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
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
>   -v5: don't print error information after devm_ioremap_resource() fails as
>   devm_ioremap_resource() has printed it
>
>   .../devicetree/bindings/watchdog/sirfsoc_wdt.txt   |  15 ++
>   arch/arm/configs/prima2_defconfig                  |   1 +
>   drivers/watchdog/Kconfig                           |   9 +
>   drivers/watchdog/Makefile                          |   1 +
>   drivers/watchdog/sirfsoc_wdt.c                     | 230 +++++++++++++++++++++
>   5 files changed, 256 insertions(+)
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
> index 0000000..ca0b026
> --- /dev/null
> +++ b/drivers/watchdog/sirfsoc_wdt.c
> @@ -0,0 +1,230 @@
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
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	watchdog_set_drvdata(&sirfsoc_wdd, base);
> +
> +	watchdog_init_timeout(&sirfsoc_wdd, timeout, &pdev->dev);
> +	watchdog_set_nowayout(&sirfsoc_wdd, nowayout);
> +
> +	ret = watchdog_register_device(&sirfsoc_wdd);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, &sirfsoc_wdd);
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
> +
> +static int sirfsoc_wdt_remove(struct platform_device *pdev)
> +{
> +	sirfsoc_wdt_shutdown(pdev);
> +	return 0;
> +}
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
> +static SIMPLE_DEV_PM_OPS(sirfsoc_wdt_pm_ops,
> +		sirfsoc_wdt_suspend, sirfsoc_wdt_resume);
> +

Looking into the PM API some more, turns out suspend and resume
functions as used here are only needed and used in conjunction
with CONFIG_PM_SLEEP. Look at other users of SIMPLE_DEV_PM_OPS
for examples.

That means you should use #ifdef CONFIG_PM_SLEEP, and you don't
need the else case defining the suspend and resume functions as NULL.

Thanks,
Guenter

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
> +		.pm = &sirfsoc_wdt_pm_ops,
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

