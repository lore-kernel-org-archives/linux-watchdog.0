Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46797 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbeH3Ubx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 30 Aug 2018 16:31:53 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so16445113oie.13
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Aug 2018 09:28:56 -0700 (PDT)
Date: Thu, 30 Aug 2018 09:28:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc: linux-watchdog@vger.kernel.org, wim@linux-watchdog.org
Subject: Re: [PATCH 1/2] watchdog: Add support for Armada 37xx CPU watchdog
Message-ID: <20180830162853.GA27086@roeck-us.net>
References: <20180830142243.12153-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830142243.12153-1-marek.behun@nic.cz>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 30, 2018 at 04:22:42PM +0200, Marek Behún wrote:
> This adds support for the CPU watchdog found on Marvell Armada 37xx
> SoCs.
> 
> There are 4 counters which can be set as CPU watchdog counters.
> This driver uses the second counter (ID 1, counting from 0)
> (Marvell's Linux also uses second counter by default).
> In the future it could be adapted to use other counters, with
> definition in the device tree.
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/watchdog/armada-37xx-wdt.txt          |  23 ++

Deviceptree properties need to be in a separate patch and have to be approved by
devicetree maintainers.

>  drivers/watchdog/Kconfig                           |  11 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/armada_37xx_wdt.c                 | 353 +++++++++++++++++++++
>  4 files changed, 388 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
>  create mode 100644 drivers/watchdog/armada_37xx_wdt.c
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt b/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
> new file mode 100644
> index 000000000000..4ba9e40ad386
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
> @@ -0,0 +1,23 @@
> +* Armada 37xx CPU Watchdog Timer Controller
> +
> +Required properties:
> +- compatible : must be "marvell,armada-3700-wdt"
> +- reg : base physical address of the controller and length of memory mapped
> +	region.
> +- clocks : the clock feeding the watchdog timer. See clock-bindings.txt
> +- marvell,system-controller : reference to syscon node for the CPU Miscellaneous
> +	Registers
> +
> +Example:
> +
> +	cpu_misc: system-controller@d000 {
> +		compatible = "syscon", "simple-mfd";
> +		reg = <0xd000 0x1000>;
> +	};
> +
> +	wdt: watchdog-timer@8300 {
> +		compatible = "marvell,armada-3700-wdt";
> +		reg = <0x8300 0x40>;
> +		marvell,system-controller = <&cpu_misc>;
> +		clocks = <&xtalclk>;
> +	};
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 5ea8909a41f9..df710ac9a6ff 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -273,6 +273,17 @@ config ARM_SBSA_WATCHDOG
>  	  To compile this driver as module, choose M here: The module
>  	  will be called sbsa_gwdt.
>  
> +config ARMADA_37XX_WATCHDOG
> +	tristate "Armada 37xx watchdog"
> +	depends on ARCH_MVEBU || COMPILE_TEST

Did you test this with a couple of architectures ?

> +	select MFD_SYSCON
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the watchdog timer found on
> +	  Marvell Armada 37xx SoCs.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called armada_37xx_wdt.
> +
>  config ASM9260_WATCHDOG
>  	tristate "Alphascale ASM9260 watchdog"
>  	depends on MACH_ASM9260 || COMPILE_TEST
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index bf92e7bf9ce0..f69cdff5ad7f 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
>  # ARM Architecture
>  obj-$(CONFIG_ARM_SP805_WATCHDOG) += sp805_wdt.o
>  obj-$(CONFIG_ARM_SBSA_WATCHDOG) += sbsa_gwdt.o
> +obj-$(CONFIG_ARMADA_37XX_WATCHDOG) += armada_37xx_wdt.o
>  obj-$(CONFIG_ASM9260_WATCHDOG) += asm9260_wdt.o
>  obj-$(CONFIG_AT91RM9200_WATCHDOG) += at91rm9200_wdt.o
>  obj-$(CONFIG_AT91SAM9X_WATCHDOG) += at91sam9_wdt.o
> diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
> new file mode 100644
> index 000000000000..83ba4ce40d2f
> --- /dev/null
> +++ b/drivers/watchdog/armada_37xx_wdt.c
> @@ -0,0 +1,353 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Watchdog driver for Marvell Armada 37xx SoCs
> + *
> + * Author: Marek Behun <marek.behun@nic.cz>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +
> +/*
> + * There are four counters that can be used for watchdog on Armada 37xx.
> + * The addresses for counter control registers are register base plus ID*0x10,
> + * where ID is 0, 1, 2 or 3.
> + * In this driver we use ID 1. Marvell's Linux also uses this ID by default,
> + * and the U-Boot driver written simultaneosly by the same author as this
> + * driver also uses ID 1.
> + * Maybe in the future we could change this driver to support other counters,
> + * depending on the device tree, but I don't think this is necessary.
> + *
> + * Note that CNTR_ID cannot be 3, because the third counter is an increment
> + * counter, and this driver is written to support decrementing counters only.
> + */
> +
> +/* relative to cpu_misc */
> +#define WDT_TIMER_SELECT		0x64
> +#define WDT_TIMER_SELECT_MASK		0xf
> +#define WDT_TIMER_SELECT_VAL		BIT(CNTR_ID)
> +
> +/* relative to reg */
> +#define CNTR_ID				1
> +
> +#define CNTR_CTRL			(CNTR_ID * 0x10)
> +#define CNTR_CTRL_ENABLE		0x0001
> +#define CNTR_CTRL_ACTIVE		0x0002
> +#define CNTR_CTRL_MODE_MASK		0x000c
> +#define CNTR_CTRL_MODE_ONESHOT		0x0000
> +#define CNTR_CTRL_PRESCALE_MASK		0xff00
> +#define CNTR_CTRL_PRESCALE_MIN		2
> +#define CNTR_CTRL_PRESCALE_SHIFT	8
> +
> +#define CNTR_COUNT_LOW			(CNTR_CTRL + 0x4)
> +#define CNTR_COUNT_HIGH			(CNTR_CTRL + 0x8)
> +
> +#define WATCHDOG_TIMEOUT		120
> +
> +static unsigned int timeout = WATCHDOG_TIMEOUT;

This defeats the purpose of using watchdog_init_timeout() to get a value
from devicetree. That value will never be used.

> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
> +			  __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +			   __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +struct armada_37xx_watchdog {
> +	struct watchdog_device wdt;
> +	struct regmap *cpu_misc;
> +	void __iomem *reg;
> +	u64 timeout; /* in clock ticks */
> +	unsigned long clk_rate;
> +	struct clk *clk;
> +};
> +
> +static u64 get_counter_value(struct armada_37xx_watchdog *dev)
> +{
> +	u64 val;
> +
> +	val = readl(dev->reg + CNTR_COUNT_HIGH);
> +	val = (val << 32) | readl(dev->reg + CNTR_COUNT_LOW);

Is this guaranteed to be consistent ? What happens if there is a 32-bit
wrap between those two operations ?

> +
> +	return val;
> +}
> +
> +static void set_counter_value(struct armada_37xx_watchdog *dev)
> +{
> +	writel(dev->timeout & 0xffffffff, dev->reg + CNTR_COUNT_LOW);
> +	writel(dev->timeout >> 32, dev->reg + CNTR_COUNT_HIGH);
> +}
> +
> +static void armada_37xx_wdt_counter_enable(struct armada_37xx_watchdog *dev)
> +{
> +	u32 reg;
> +
> +	reg = readl(dev->reg + CNTR_CTRL);
> +	reg |= CNTR_CTRL_ENABLE;
> +	writel(reg, dev->reg + CNTR_CTRL);
> +}
> +
> +static void armada_37xx_wdt_counter_disable(struct armada_37xx_watchdog *dev)
> +{
> +	u32 reg;
> +
> +	reg = readl(dev->reg + CNTR_CTRL);
> +	reg &= ~CNTR_CTRL_ENABLE;
> +	writel(reg, dev->reg + CNTR_CTRL);
> +}
> +
> +static int armada_37xx_wdt_ping(struct watchdog_device *wdt)
> +{
> +	struct armada_37xx_watchdog *dev = watchdog_get_drvdata(wdt);
> +
> +	armada_37xx_wdt_counter_disable(dev);
> +	set_counter_value(dev);
> +	armada_37xx_wdt_counter_enable(dev);
> +

Is it really necessary to stop the watchdog for each ping ? That leaves
the system in a vulnerable state. Or does CNTR_CTRL_ENABLE only enable
writing into the counter register ?

> +	return 0;
> +}
> +
> +static unsigned int armada_37xx_wdt_get_timeleft(struct watchdog_device *wdt)
> +{
> +	struct armada_37xx_watchdog *dev = watchdog_get_drvdata(wdt);
> +	unsigned int res;
> +
> +	res = get_counter_value(dev) * CNTR_CTRL_PRESCALE_MIN / dev->clk_rate;
> +
> +	return res;
> +}
> +
> +static int armada_37xx_wdt_set_timeout(struct watchdog_device *wdt,
> +				       unsigned int timeout)
> +{
> +	struct armada_37xx_watchdog *dev = watchdog_get_drvdata(wdt);
> +
> +	wdt->timeout = timeout;
> +
> +	/*
> +	 * Compute the timeout in clock rate. We use smallest possible
> +	 * prescaler, which divides the clock rate by 2
> +	 * (CNTR_CTRL_PRESCALE_MIN).
> +	 */
> +	dev->timeout = (u64)dev->clk_rate * timeout / CNTR_CTRL_PRESCALE_MIN;
> +
> +	return 0;
> +}
> +
> +static bool armada_37xx_wdt_is_running(struct armada_37xx_watchdog *dev)
> +{
> +	u32 reg;
> +
> +	regmap_read(dev->cpu_misc, WDT_TIMER_SELECT, &reg);
> +	if ((reg & WDT_TIMER_SELECT_MASK) != WDT_TIMER_SELECT_VAL)
> +		return false;
> +
> +	reg = readl(dev->reg + CNTR_CTRL);
> +	return !!(reg & CNTR_CTRL_ACTIVE);
> +}
> +
> +static int armada_37xx_wdt_start(struct watchdog_device *wdt)
> +{
> +	struct armada_37xx_watchdog *dev = watchdog_get_drvdata(wdt);
> +	u32 reg;
> +
> +	reg = readl(dev->reg + CNTR_CTRL);
> +
> +	if (reg & CNTR_CTRL_ACTIVE)
> +		return -EBUSY;

This is highly unusual. What problem are you solving here ?

> +
> +	/* set mode */
> +	reg = (reg & ~CNTR_CTRL_MODE_MASK) | CNTR_CTRL_MODE_ONESHOT;
> +
> +	/* set prescaler to the min value of 2 */
> +	reg &= ~CNTR_CTRL_PRESCALE_MASK;
> +	reg |= CNTR_CTRL_PRESCALE_MIN << CNTR_CTRL_PRESCALE_SHIFT;
> +
> +	writel(reg, dev->reg + CNTR_CTRL);
> +
> +	set_counter_value(dev);
> +
> +	regmap_write(dev->cpu_misc, WDT_TIMER_SELECT, WDT_TIMER_SELECT_VAL);
> +	armada_37xx_wdt_counter_enable(dev);
> +
> +	return 0;
> +}
> +
> +static int armada_37xx_wdt_stop(struct watchdog_device *wdt)
> +{
> +	struct armada_37xx_watchdog *dev = watchdog_get_drvdata(wdt);
> +
> +	armada_37xx_wdt_counter_disable(dev);
> +	regmap_write(dev->cpu_misc, WDT_TIMER_SELECT, 0);
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info armada_37xx_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	.identity = "Armada 37xx Watchdog",
> +};
> +
> +static const struct watchdog_ops armada_37xx_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = armada_37xx_wdt_start,
> +	.stop = armada_37xx_wdt_stop,
> +	.ping = armada_37xx_wdt_ping,
> +	.set_timeout = armada_37xx_wdt_set_timeout,
> +	.get_timeleft = armada_37xx_wdt_get_timeleft,
> +};
> +
> +static int armada_37xx_wdt_probe(struct platform_device *pdev)
> +{
> +	struct armada_37xx_watchdog *dev;
> +	struct resource *res;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	dev = devm_kzalloc(&pdev->dev, sizeof(struct armada_37xx_watchdog),
> +			   GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->wdt.info = &armada_37xx_wdt_info;
> +	dev->wdt.ops = &armada_37xx_wdt_ops;
> +	dev->wdt.min_timeout = 1;
> +
> +	regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +						 "marvell,system-controller");
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +	dev->cpu_misc = regmap;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +	dev->reg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +
> +	/* init clock */
> +	dev->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);
> +
> +	ret = clk_prepare_enable(dev->clk);
> +	if (ret)
> +		return ret;
> +
> +	dev->clk_rate = clk_get_rate(dev->clk);

Some clock drivers can return 0 here, which would result in a division by 0
later. It is prudent to check the return value.

> +
> +	/*
> +	 * Since the timeout in seconds is given as 32 bit unsigned int, and
> +	 * the counters hold 64 bit values, even after multiplication by clock
> +	 * rate the counter can hold timeout of UINT_MAX seconds.
> +	 */
> +	dev->wdt.min_timeout = 0;

That value is set to 1 above, which makes more sense. What is the point of
setting it to 0 here, and what is the impact of setting the actual timeout
to 0 ? Are you sure that doesn't result in an immediate reboot ?

> +	dev->wdt.max_timeout = UINT_MAX;
> +	dev->wdt.parent = &pdev->dev;
> +
> +	/* default value, possibly override by module parameter or dtb */
> +	dev->wdt.timeout = WATCHDOG_TIMEOUT;
> +	watchdog_init_timeout(&dev->wdt, timeout, &pdev->dev);
> +
> +	platform_set_drvdata(pdev, &dev->wdt);
> +	watchdog_set_drvdata(&dev->wdt, dev);
> +
> +	armada_37xx_wdt_set_timeout(&dev->wdt, dev->wdt.timeout);
> +
> +	if (armada_37xx_wdt_is_running(dev))
> +		set_bit(WDOG_HW_RUNNING, &dev->wdt.status);
> +	else
> +		armada_37xx_wdt_stop(&dev->wdt);

Why stop it if it isn't running ?

> +
> +	watchdog_set_nowayout(&dev->wdt, nowayout);
> +	ret = watchdog_register_device(&dev->wdt);
> +	if (ret)
> +		goto disable_clk;
> +
> +	dev_info(&pdev->dev, "Initial timeout %d sec%s\n",
> +		 dev->wdt.timeout, nowayout ? ", nowayout" : "");
> +
> +	return 0;
> +
> +disable_clk:
> +	clk_disable_unprepare(dev->clk);
> +	return ret;
> +}
> +
> +static int armada_37xx_wdt_remove(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdt = platform_get_drvdata(pdev);
> +	struct armada_37xx_watchdog *dev = watchdog_get_drvdata(wdt);
> +
> +	watchdog_unregister_device(wdt);
> +	clk_disable_unprepare(dev->clk);
> +	return 0;
> +}
> +
> +static void armada_37xx_wdt_shutdown(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdt = platform_get_drvdata(pdev);
> +
> +	armada_37xx_wdt_stop(wdt);
> +}
> +
> +static int __maybe_unused armada_37xx_wdt_suspend(struct device *dev)
> +{
> +	struct watchdog_device *wdt = dev_get_drvdata(dev);
> +
> +	return armada_37xx_wdt_stop(wdt);
> +}
> +
> +static int __maybe_unused armada_37xx_wdt_resume(struct device *dev)
> +{
> +	struct watchdog_device *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(wdt))
> +		return armada_37xx_wdt_start(wdt);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops armada_37xx_wdt_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(armada_37xx_wdt_suspend,
> +				armada_37xx_wdt_resume)
> +};
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id armada_37xx_wdt_match[] = {
> +	{ .compatible = "marvell,armada-3700-wdt", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, armada_37xx_wdt_match);
> +#endif
> +
> +static struct platform_driver armada_37xx_wdt_driver = {
> +	.probe		= armada_37xx_wdt_probe,
> +	.remove		= armada_37xx_wdt_remove,
> +	.shutdown	= armada_37xx_wdt_shutdown,
> +	.driver		= {
> +		.name	= "armada_37xx_wdt",
> +		.of_match_table = of_match_ptr(armada_37xx_wdt_match),
> +		.pm = &armada_37xx_wdt_dev_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(armada_37xx_wdt_driver);
> +
> +MODULE_AUTHOR("Marek Behun <marek.behun@nic.cz>");
> +MODULE_DESCRIPTION("Armada 37xx CPU Watchdog");
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:armada_37xx_wdt");
> -- 
> 2.16.4
> 
