Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:58555 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752471Ab3HUTzN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 21 Aug 2013 15:55:13 -0400
Date: Wed, 21 Aug 2013 21:55:02 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Barry Song <21cnbao@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com,
	Xianglong Du <Xianglong.Du@csr.com>,
	Barry Song <Baohua.Song@csr.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: sirf: add watchdog driver of CSR SiRFprimaII and SiRFatlasVI
Message-ID: <20130821195502.GA815@spo001.leaseweb.com>
References: <1368536872-2189-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1368536872-2189-1-git-send-email-21cnbao@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Barry,

> From: Xianglong Du <Xianglong.Du@csr.com>
> 
> On CSR SiRFprimaII and SiRFatlasVI, the 6th timer can act as a Watchdog timer
> when the Watchdog mode is enabled.
> 
> watchdog occur when TIMER watchdog counter matches the value software set, when
> this event occur, the effect is the same as system software reset.
> 
> Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  .../devicetree/bindings/watchdog/sirfsoc_wdt.txt   |   15 ++
>  arch/arm/boot/dts/atlas6.dtsi                      |    2 +-
>  arch/arm/boot/dts/prima2.dtsi                      |    2 +-
>  arch/arm/configs/prima2_defconfig                  |    3 +-
>  drivers/watchdog/Kconfig                           |    8 +
>  drivers/watchdog/Makefile                          |    1 +
>  drivers/watchdog/sirfsoc_wdt.c                     |  250 ++++++++++++++++++++
>  7 files changed, 278 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
>  create mode 100644 drivers/watchdog/sirfsoc_wdt.c
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt b/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
> new file mode 100644
> index 0000000..b2af5fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
> @@ -0,0 +1,15 @@
> +SiRFSoC Timer and Watchdog Timer(WDT) Controller
> +
> +Required properties:
> +- compatible: "sirf,prima2-tick", "sirf,prima2-wdt"
> +- reg: Address range of tick timer/WDT register set
> +- interrupts: interrupt number to the cpu
> +
> +Example:
> +
> +timer@b0020000 {
> +	compatible = "sirf,prima2-tick", "sirf,prima2-wdt";
> +	reg = <0xb0020000 0x1000>;
> +	interrupts = <0>;
> +};
> +
> diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
> index 7d1a279..c101f3e 100644
> --- a/arch/arm/boot/dts/atlas6.dtsi
> +++ b/arch/arm/boot/dts/atlas6.dtsi
> @@ -155,7 +155,7 @@
>  			       <0x56000000 0x56000000 0x1b00000>;
>  
>  			timer@b0020000 {
> -				compatible = "sirf,prima2-tick";
> +				compatible = "sirf,prima2-tick", "sirf,prima2-wdt";
>  				reg = <0xb0020000 0x1000>;
>  				interrupts = <0>;
>  			};
> diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
> index 3329719..3c76dc2 100644
> --- a/arch/arm/boot/dts/prima2.dtsi
> +++ b/arch/arm/boot/dts/prima2.dtsi
> @@ -172,7 +172,7 @@
>  			ranges = <0xb0000000 0xb0000000 0x180000>;
>  
>  			timer@b0020000 {
> -				compatible = "sirf,prima2-tick";
> +				compatible = "sirf,prima2-tick", "sirf,prima2-wdt";
>  				reg = <0xb0020000 0x1000>;
>  				interrupts = <0>;
>  			};
> diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
> index 002a1ce..a1d7c67 100644
> --- a/arch/arm/configs/prima2_defconfig
> +++ b/arch/arm/configs/prima2_defconfig
> @@ -1,4 +1,3 @@
> -CONFIG_EXPERIMENTAL=y
>  CONFIG_NO_HZ=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_RELAY=y
> @@ -39,6 +38,8 @@ CONFIG_SPI=y
>  CONFIG_SPI_SIRF=y
>  CONFIG_SPI_SPIDEV=y
>  # CONFIG_HWMON is not set
> +CONFIG_WATCHDOG=y
> +CONFIG_WATCHDOG_CORE=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_MASS_STORAGE=m
>  CONFIG_MMC=y
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index e89fc31..fe005a8 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -391,6 +391,14 @@ config RETU_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called retu_wdt.
>  
> +config SIRFSOC_WATCHDOG
> +	tristate "SiRFSOC watchdog"
> +	depends on ARCH_SIRF

You are missing a:
	select WATCHDOG_CORE
here.

> +	default y
> +	help
> +	  Support for CSR SiRFprimaII and SiRFatlasVI watchdog. When
> +	  the watchdog triggers the system will be reset.
> +
>  # AVR32 Architecture
>  
>  config AT32AP700X_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index a300b94..9064f6a 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
>  obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
>  obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
>  obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
> +obj-$(CONFIG_SIRFSOC_WATCHDOG) += sirfsoc_wdt.o
>  
>  # AVR32 Architecture
>  obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
> new file mode 100644
> index 0000000..ab3dd42
> --- /dev/null
> +++ b/drivers/watchdog/sirfsoc_wdt.c
> @@ -0,0 +1,250 @@
> +/*
> + * Watchdog driver for CSR SiRFprimaII and SiRFatlasVI
> + *
> + * Copyright (c) 2013 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/miscdevice.h>
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
> +static unsigned int default_timeout = SIRFSOC_WDT_DEFAULT_TIMEOUT;
> +module_param(default_timeout, uint, 0);
> +MODULE_PARM_DESC(default_timeout, "Default watchdog timeout (in seconds)");

Preferred module parameter name is timeout .

> +static unsigned int sirfsoc_wdt_gettimeleft(struct watchdog_device *wdd)
> +{
> +	u32 counter, match;
> +	int time_left;
> +
> +	counter = readl(watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_COUNTER_LO);
> +	match = readl(watchdog_get_drvdata(wdd) +
> +		SIRFSOC_TIMER_MATCH_0 + (SIRFSOC_TIMER_WDT_INDEX << 2));
> +
> +	if (match >= counter) {
> +		time_left = match-counter;
> +	} else {
> +		/* rollover */
> +		time_left = (0xffffffffUL - counter) + match;
> +	}

should be:
	if (match >= counter)
		time_left = match-counter;
	else
		/* rollover */
		time_left = (0xffffffffUL - counter) + match;

according to coding style.

> +
> +	return time_left / CLOCK_TICK_RATE;
> +}
> +
> +static int sirfsoc_wdt_updatetimeout(struct watchdog_device *wdd)
> +{
> +	u32 counter, timeout_ticks;
> +
> +	timeout_ticks = wdd->timeout * CLOCK_TICK_RATE;
> +
> +	/* Enable the latch before reading the LATCH_LO register */
> +	writel(1, watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_LATCH);
> +
> +	/* Set the TO value */
> +	counter = readl(watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_LATCHED_LO);
> +
> +	if ((0xffffffffUL - counter) >= timeout_ticks) {
> +		counter += timeout_ticks;
> +	} else {
> +		/* Rollover */
> +		counter = timeout_ticks - (0xffffffffUL - counter);
> +	}

Same here (coding style).

> +	writel(counter, watchdog_get_drvdata(wdd) +
> +		SIRFSOC_TIMER_MATCH_0 + (SIRFSOC_TIMER_WDT_INDEX << 2));
> +
> +	return 0;
> +}
> +
> +static int sirfsoc_wdt_enable(struct watchdog_device *wdd)
> +{
> +	sirfsoc_wdt_updatetimeout(wdd);
> +
> +	/*
> +	 * NOTE: If interrupt is not enabled
> +	 * then WD-Reset doesn't get generated at all.
> +	 */
> +	writel(readl(watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_INT_EN)
> +		| (1 << SIRFSOC_TIMER_WDT_INDEX),
> +		watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_INT_EN);
> +	writel(1, watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_WATCHDOG_EN);

Wouldn't it be better to define a local variable first that get's the value
of watchdog_get_drvdata(wdd)? This would definitely improve readability.
Goes also for other functions (like sirfsoc_wdt_gettimeleft and 
sirfsoc_wdt_disable).

> +
> +	return 0;
> +}
> +
> +static int sirfsoc_wdt_disable(struct watchdog_device *wdd)
> +{
> +	writel(0, watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_WATCHDOG_EN);
> +	writel(readl(watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_INT_EN)
> +		& (~(1 << SIRFSOC_TIMER_WDT_INDEX)),
> +		watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_INT_EN);
> +
> +	return 0;
> +}
> +
> +static int sirfsoc_wdt_settimeout(struct watchdog_device *wdd, unsigned int to)
> +{
> +	if (to < SIRFSOC_WDT_MIN_TIMEOUT)
> +		to = SIRFSOC_WDT_MIN_TIMEOUT;
> +	if (to > SIRFSOC_WDT_MAX_TIMEOUT)
> +		to = SIRFSOC_WDT_MAX_TIMEOUT;

Hmm, since SIRFSOC_WDT_MIN_TIMEOUT and SIRFSOC_WDT_MAX_TIMEOUT are defined:
setting the timeout will call watchdog_set_timeout and that function will do a:
if (watchdog_timeout_invalid(wddev, timeout))
                return -EINVAL;

with watchdog_timeout_invalid returning:
        ((wdd->max_timeout != 0) && (t < wdd->min_timeout || t > wdd->max_timeout));

So this will never happen...


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
> +	/* reserve static register mappings */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "sirfsoc wdt: could not get mem resources\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (!base) {
> +		dev_err(&pdev->dev, "sirfsoc wdt: could not remap the mem\n");
> +		ret = -EADDRNOTAVAIL;
> +		goto out;
> +	}
> +	watchdog_set_drvdata(&sirfsoc_wdd, base);
> +
> +	sirfsoc_wdd.timeout = default_timeout;

You can consider using watchdog_init_timeout here.
I would also advice to add watchdog_set_nowayout and use the nowayout functionality.

> +
> +	ret = watchdog_register_device(&sirfsoc_wdd);
> +	if (!!ret)
> +		goto out;
> +
> +	platform_set_drvdata(pdev, &sirfsoc_wdd);
> +
> +	return 0;
> +
> +out:
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
> +	.suspend = sirfsoc_wdt_suspend,
> +	.resume = sirfsoc_wdt_resume,
> +};
> +
> +static const struct of_device_id sirfsoc_wdt_of_match[] = {
> +	{ .compatible = "sirf,prima2-wdt"},
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
> +MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);

This alias can be removed if you have the platform alias (like listed in the following line).

> +MODULE_ALIAS("platform:sirfsoc-wdt");
> -- 
> 1.7.4.1

Kind regards,
Wim.

