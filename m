Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41059 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdAUXGQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 21 Jan 2017 18:06:16 -0500
Subject: Re: [PATCH v3 3/3] watchdog: zx2967: add watchdog controller driver
 for ZTE's zx2967 family
To: Baoyou Xie <baoyou.xie@linaro.org>, jun.nie@linaro.org,
        wim@iguana.be, robh+dt@kernel.org, mark.rutland@arm.com
References: <1484917398-15604-1-git-send-email-baoyou.xie@linaro.org>
 <1484917398-15604-3-git-send-email-baoyou.xie@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn,
        wang.qiang01@zte.com.cn
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <cdb27525-bcf2-9ad5-08b2-d454c8d51e10@roeck-us.net>
Date: Sat, 21 Jan 2017 15:06:07 -0800
MIME-Version: 1.0
In-Reply-To: <1484917398-15604-3-git-send-email-baoyou.xie@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/20/2017 05:03 AM, Baoyou Xie wrote:
> This patch adds watchdog controller driver for ZTE's zx2967 family.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  drivers/watchdog/Kconfig      |  10 ++
>  drivers/watchdog/Makefile     |   1 +
>  drivers/watchdog/zx2967_wdt.c | 376 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 387 insertions(+)
>  create mode 100644 drivers/watchdog/zx2967_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index acb00b5..05093a2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -714,6 +714,16 @@ config ASPEED_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called aspeed_wdt.
>
> +config ZX2967_WATCHDOG
> +	tristate "ZTE zx2967 SoCs watchdog support"
> +	depends on ARCH_ZX
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the watchdog timer
> +	  in ZTE zx2967 SoCs.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called zx2967_wdt.
> +
>  # AVR32 Architecture
>
>  config AT32AP700X_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 0c3d35e..bf2d296 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -82,6 +82,7 @@ obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
>  obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
>  obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
>  obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
> +obj-$(CONFIG_ZX2967_WATCHDOG) += zx2967_wdt.o
>
>  # AVR32 Architecture
>  obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> diff --git a/drivers/watchdog/zx2967_wdt.c b/drivers/watchdog/zx2967_wdt.c
> new file mode 100644
> index 0000000..a5656d0
> --- /dev/null
> +++ b/drivers/watchdog/zx2967_wdt.c
> @@ -0,0 +1,376 @@
> +/*
> + * watchdog driver for ZTE's zx2967 family
> + *
> + * Copyright (C) 2017 ZTE Ltd.
> + *
> + * Author: Baoyou Xie <baoyou.xie@linaro.org>
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/watchdog.h>
> +
> +#define ZX2967_WDT_CFG_REG			0x4
> +#define ZX2967_WDT_LOAD_REG			0x8
> +#define ZX2967_WDT_REFRESH_REG			0x18
> +#define ZX2967_WDT_START_REG			0x1c
> +
> +#define ZX2967_WDT_REFRESH_MASK			0x3f
> +
> +#define ZX2967_WDT_CFG_DIV(n)			((((n) & 0xff) - 1) << 8)
> +#define ZX2967_WDT_START_EN			0x1
> +
> +#define ZX2967_WDT_WRITEKEY			0x12340000
> +
> +#define ZX2967_WDT_DIV_DEFAULT			16
> +#define ZX2967_WDT_DEFAULT_TIMEOUT		32
> +#define ZX2967_WDT_MIN_TIMEOUT			1
> +#define ZX2967_WDT_MAX_TIMEOUT			500

Is that based on a real limit or an arbitrary value ?

> +#define ZX2967_WDT_MAX_COUNT			0xffff
> +
> +#define ZX2967_WDT_FLAG_REBOOT_MON		(1 << 0)

BIT ?

> +
> +struct zx2967_wdt {
> +	struct device		*dev;
> +	struct clk		*clock;
> +	void __iomem		*reg_base;
> +	unsigned int		conf;
> +	unsigned int		load;
> +	unsigned int		flags;
> +	struct watchdog_device	wdt_device;
> +	struct notifier_block	restart_handler;
> +	struct notifier_block	reboot_handler;
> +};
> +
> +static inline u32 zx2967_wdt_readl(struct zx2967_wdt *wdt, u16 reg)
> +{
> +	return readl_relaxed(wdt->reg_base + reg);
> +}
> +
> +static inline void zx2967_wdt_writel(struct zx2967_wdt *wdt, u16 reg, u32 val)
> +{
> +	writel_relaxed(val | ZX2967_WDT_WRITEKEY, wdt->reg_base + reg);
> +}
> +
> +static void zx2967_wdt_refresh(struct zx2967_wdt *wdt)
> +{
> +	u32 val;
> +
> +	val = zx2967_wdt_readl(wdt, ZX2967_WDT_REFRESH_REG);
> +	val ^= ZX2967_WDT_REFRESH_MASK;
> +	zx2967_wdt_writel(wdt, ZX2967_WDT_REFRESH_REG, val);
> +}
> +
> +static unsigned int
> +__zx2967_wdt_set_timeout(struct zx2967_wdt *wdt, unsigned int timeout)
> +{
> +	unsigned int freq = clk_get_rate(wdt->clock);

The clock frequency is set to 32 kHz. It seems unnecessary to re-read it
whenever the timeout changes. Also, ...

> +	unsigned int divisor = ZX2967_WDT_DIV_DEFAULT;
> +	unsigned int count;
> +
> +	count = timeout * freq;
> +	if (count > divisor * ZX2967_WDT_MAX_COUNT)
> +		divisor = DIV_ROUND_UP(count, ZX2967_WDT_MAX_COUNT);
> +	count = DIV_ROUND_UP(count, divisor);
> +	zx2967_wdt_writel(wdt, ZX2967_WDT_CFG_REG, ZX2967_WDT_CFG_DIV(divisor));
> +	zx2967_wdt_writel(wdt, ZX2967_WDT_LOAD_REG, count);
> +	zx2967_wdt_refresh(wdt);
> +	wdt->load = count;
> +
> +	return (count * divisor) / freq;

... if you think it can change from underneath you, you'll also need to make sure
it is not 0, to avoid a nasty surprise here. Of course, if it does change, you'll
have no idea what the actual timeout is at any given time, and the driver won't work.

> +}
> +
> +static int zx2967_wdt_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int timeout)
> +{
> +	struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	if (watchdog_timeout_invalid(&wdt->wdt_device, timeout)) {
> +		dev_err(wdt->dev, "timeout %d is invalid\n", timeout);
> +		return -EINVAL;
> +	}

This function is called from the infrastructure. Let's trust the infrastructure
to check the valid range before calling this code.
> +
> +	wdd->timeout = __zx2967_wdt_set_timeout(wdt, timeout);
> +
> +	return 0;
> +}
> +
> +static void __zx2967_wdt_start(struct zx2967_wdt *wdt)
> +{
> +	u32 val;
> +
> +	val = zx2967_wdt_readl(wdt, ZX2967_WDT_START_REG);
> +	val |= ZX2967_WDT_START_EN;
> +	zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, val);
> +}
> +
> +static void __zx2967_wdt_stop(struct zx2967_wdt *wdt)
> +{
> +	u32 val;
> +
> +	val = zx2967_wdt_readl(wdt, ZX2967_WDT_START_REG);
> +	val &= ~ZX2967_WDT_START_EN;
> +	zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, val);
> +}
> +
> +static int zx2967_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	__zx2967_wdt_stop(wdt);
> +	zx2967_wdt_set_timeout(wdd, wdd->timeout);

This seems inconsistent. First, the watchdog should not already be
started when this function is called. Second, if it is in fact necessary
to stop the watchdog before updating its timeout, you might want to
consider stopping it in the set_timeout function, because that
function _will_ be called if the timeout is updated while the
watchdog is running.

> +	__zx2967_wdt_start(wdt);
> +
> +	return 0;
> +}
> +
> +static int zx2967_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	__zx2967_wdt_stop(wdt);
> +
> +	return 0;
> +}
> +
> +static int zx2967_wdt_keepalive(struct watchdog_device *wdd)
> +{
> +	struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	zx2967_wdt_refresh(wdt);
> +
> +	return 0;
> +}
> +
> +#define ZX2967_WDT_OPTIONS \
> +	(WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
> +static const struct watchdog_info zx2967_wdt_ident = {
> +	.options          =     ZX2967_WDT_OPTIONS,
> +	.firmware_version =	0,
> +	.identity         =	"zx2967 watchdog",
> +};
> +
> +static struct watchdog_ops zx2967_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = zx2967_wdt_start,
> +	.stop = zx2967_wdt_stop,
> +	.ping = zx2967_wdt_keepalive,
> +	.set_timeout = zx2967_wdt_set_timeout,
> +};
> +
> +static void zx2967_wdt_fix_sysdown(struct zx2967_wdt *wdt)
> +{
> +	__zx2967_wdt_stop(wdt);
> +	__zx2967_wdt_set_timeout(wdt, 15);
> +	__zx2967_wdt_start(wdt);
> +}

I am really not at all in favor of this code. It force-sets a watchdog
to 15 seconds later, if it was enabled or not.

I don't necessarily oppose the idea in general, but it would have to be
configurable and part of the infrastructure.

> +
> +static int zx2967_wdt_notify_sys(struct notifier_block *this,
> +			     unsigned long code, void *unused)
> +{
> +	struct zx2967_wdt *wdt = container_of(this, struct zx2967_wdt,
> +					      reboot_handler);
> +
> +	wdt->flags |= ZX2967_WDT_FLAG_REBOOT_MON;
> +	switch (code) {
> +	case SYS_HALT:
> +	case SYS_POWER_OFF:
> +	case SYS_RESTART:
> +		zx2967_wdt_fix_sysdown(wdt);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int zx2967_wdt_restart(struct notifier_block *this,
> +			      unsigned long mode, void *cmd)
> +{
> +	struct zx2967_wdt *wdt;
> +
> +	wdt = container_of(this, struct zx2967_wdt, restart_handler);
> +
> +	zx2967_wdt_stop(&wdt->wdt_device);
> +
> +	zx2967_wdt_writel(wdt, ZX2967_WDT_LOAD_REG, 0x80);
> +	zx2967_wdt_refresh(wdt);
> +	zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, ZX2967_WDT_START_EN);
> +
> +	zx2967_wdt_start(&wdt->wdt_device);
> +	/* wait for reset*/
> +	mdelay(500);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static void zx2967_wdt_reset_sysctrl(struct device *dev)
> +{
> +	int ret;
> +	struct device_node *np = NULL;
> +	void __iomem *regmap;
> +	unsigned int offset, mask, config;
> +	struct of_phandle_args out_args;
> +
> +	ret = of_parse_phandle_with_fixed_args(dev->of_node,
> +			"zte,wdt-reset-sysctrl", 3, 0, &out_args);
> +	if (ret) {
> +		dev_info(dev, "failed to parse zte,wdt-reset-sysctrl");

Why this message ? The property is optional. There is no "failure".

Repeating the information in the devicetree description:

	zte,wdt-reset-sysctrl : Directs how to reset system by the watchdog.

Given the context, and the provided implementation, I can only assume that
this is supposed to mean which action shall be taken when the watchdog triggers,
and that the bit mask provided is supposed to configure that action. If so,
that should be explained in the devicetree description, and not be hidden
in magic register values.

> +		return;
> +	}
> +	offset = out_args.args[0];
> +	config = out_args.args[1];
> +	mask = out_args.args[2];
> +
> +	regmap = syscon_node_to_regmap(out_args.np);
> +	if (IS_ERR(regmap))
> +		goto out;
> +
> +	regmap_update_bits(regmap, offset, mask, config);


I don't really see the value of the local variables.

> +out:
> +	of_node_put(np);

I don't really see where np is set to anything but NULL.

> +}
> +
> +static int zx2967_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	struct zx2967_wdt *wdt;
> +	struct resource *base;
> +	int ret = 0;

Unnecessary initialization.

> +
> +	struct reset_control *rstc;

No empty lines between variable declarations, please.

> +
> +	dev = &pdev->dev;

Can be initialized above.

> +
> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	wdt->dev = dev;

This is only used by an error message in the set_timeout function,
which is unnecessary.

> +	wdt->wdt_device.info = &zx2967_wdt_ident;
> +	wdt->wdt_device.ops = &zx2967_wdt_ops;
> +	wdt->wdt_device.timeout = ZX2967_WDT_DEFAULT_TIMEOUT;
> +	wdt->wdt_device.max_timeout = ZX2967_WDT_MAX_TIMEOUT;
> +	wdt->wdt_device.min_timeout = ZX2967_WDT_MIN_TIMEOUT;
> +	wdt->wdt_device.parent = &pdev->dev;
> +
> +	base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	wdt->reg_base = devm_ioremap_resource(dev, base);
> +	if (IS_ERR(wdt->reg_base)) {
> +		dev_err(dev, "ioremap failed\n");
> +		return PTR_ERR(wdt->reg_base);
> +	}
> +
> +	zx2967_wdt_reset_sysctrl(dev);
> +
> +	wdt->reboot_handler.notifier_call = zx2967_wdt_notify_sys;
> +	register_reboot_notifier(&wdt->reboot_handler);

Without ever unregistering it ? Did you try to unload the driver and reboot ?

> +	wdt->clock = devm_clk_get(dev, NULL);
> +	if (IS_ERR(wdt->clock)) {
> +		dev_err(dev, "failed to find watchdog clock source\n");
> +		return PTR_ERR(wdt->clock);
> +	}
> +
> +	ret = clk_prepare_enable(wdt->clock);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable clock\n");
> +		return ret;
> +	}
> +	clk_set_rate(wdt->clock, 32768);
> +
> +	rstc = devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(rstc)) {
> +		dev_err(dev, "failed to get rstc");
> +		ret = PTR_ERR(rstc);
> +		goto fail_get_reset_control;
> +	}
> +
> +	reset_control_assert(rstc);
> +	mdelay(10);
> +	reset_control_deassert(rstc);

There is this reset, and the reset in reset_sysctrl above.
Are they both necessary ?

> +	watchdog_set_drvdata(&wdt->wdt_device, wdt);
> +
> +	watchdog_init_timeout(&wdt->wdt_device,
> +			      ZX2967_WDT_DEFAULT_TIMEOUT, dev);

What is the purpose of this call ? It sets the timeout to the default timeout,
which is already set, and it does not use the value from devicetree since the
value passed is != 0.

> +	watchdog_set_nowayout(&wdt->wdt_device, WATCHDOG_NOWAYOUT);
> +
> +	zx2967_wdt_stop(&wdt->wdt_device);

The watchdog was reset twice above. Is this call really necessary ?

> +
> +	ret = watchdog_register_device(&wdt->wdt_device);
> +	if (ret)
> +		goto fail_register;
> +
> +	wdt->restart_handler.notifier_call = zx2967_wdt_restart;
> +	wdt->restart_handler.priority = 128;
> +	ret = register_restart_handler(&wdt->restart_handler);
> +	if (ret) {
> +		dev_err(dev, "cannot register restart handler, %d\n", ret);
> +		goto fail_restart;
> +	}
> +
Why not use the infrastructure ?

> +	dev_info(dev, "watchdog enabled (timeout=%d sec, nowayout=%d)",
> +		 wdt->wdt_device.timeout, WATCHDOG_NOWAYOUT);
> +
> +	return 0;
> +
> +fail_get_reset_control:
> +fail_restart:

Please no double labels to the same code.

> +	watchdog_unregister_device(&wdt->wdt_device);
> +fail_register:
> +	clk_disable_unprepare(wdt->clock);
> +	return ret;
> +}
> +
> +static int zx2967_wdt_remove(struct platform_device *pdev)
> +{
> +	struct zx2967_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	unregister_restart_handler(&wdt->restart_handler);
> +	watchdog_unregister_device(&wdt->wdt_device);
> +	clk_disable_unprepare(wdt->clock);
> +
> +	return 0;
> +}
> +
> +static void zx2967_wdt_shutdown(struct platform_device *pdev)
> +{
> +	struct zx2967_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	if (!(wdt->flags & ZX2967_WDT_FLAG_REBOOT_MON))
> +		zx2967_wdt_stop(&wdt->wdt_device);

As mentioned before, the whole reboot handling is highly unusual.

I don't really like the idea of bypassing the infrastructure
(such as watchdog_stop_on_reboot()) for driver specific special behavior.
If such behavior is useful, it should be useful for all watchdog drivers,
and be defined in the infrastructure.

> +}
> +
> +static const struct of_device_id zx2967_wdt_match[] = {
> +	{ .compatible = "zte,zx296718-wdt", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, zx2967_wdt_match);
> +
> +static struct platform_driver zx2967_wdt_driver = {
> +	.probe		= zx2967_wdt_probe,
> +	.remove		= zx2967_wdt_remove,
> +	.shutdown	= zx2967_wdt_shutdown,
> +	.driver		= {
> +		.name	= "zx2967-wdt",
> +		.of_match_table	= of_match_ptr(zx2967_wdt_match),
> +	},
> +};
> +module_platform_driver(zx2967_wdt_driver);
> +
> +MODULE_AUTHOR("Baoyou Xie <baoyou.xie@linaro.org>");
> +MODULE_DESCRIPTION("ZTE zx2967 Watchdog Device Driver");
> +MODULE_LICENSE("GPL v2");
>

