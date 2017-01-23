Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:36769 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdAWQnw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 23 Jan 2017 11:43:52 -0500
Received: by mail-it0-f43.google.com with SMTP id c7so67072318itd.1
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Jan 2017 08:42:53 -0800 (PST)
Date: Mon, 23 Jan 2017 09:42:48 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: jun.nie@linaro.org, wim@iguana.be, linux@roeck-us.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn,
        wang.qiang01@zte.com.cn
Subject: Re: [PATCH v4 3/3] watchdog: zx2967: add watchdog controller driver
 for ZTE's zx2967 family
Message-ID: <20170123164248.GA25079@linaro.org>
References: <1485073008-26699-1-git-send-email-baoyou.xie@linaro.org>
 <1485073008-26699-3-git-send-email-baoyou.xie@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485073008-26699-3-git-send-email-baoyou.xie@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Jan 22, 2017 at 04:16:48PM +0800, Baoyou Xie wrote:
> This patch adds watchdog controller driver for ZTE's zx2967 family.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Hello Baoyou,

Please see comments below.

Thanks,
Mathieu

> ---
>  drivers/watchdog/Kconfig      |  10 ++
>  drivers/watchdog/Makefile     |   1 +
>  drivers/watchdog/zx2967_wdt.c | 282 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 293 insertions(+)
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
> index 0000000..7340605
> --- /dev/null
> +++ b/drivers/watchdog/zx2967_wdt.c
> @@ -0,0 +1,282 @@
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
> +#define ZX2967_WDT_MAX_COUNT			0xffff
> +
> +#define ZX2967_WDT_CLK_FREQ			0x8000
> +
> +#define ZX2967_WDT_FLAG_REBOOT_MON		BIT(0)
> +

Please use proper kernel documentation for structures.

> +struct zx2967_wdt {
> +	struct clk		*clock;
> +	void __iomem		*reg_base;
> +	unsigned int		conf;
> +	unsigned int		load;
> +	unsigned int		flags;
> +	struct watchdog_device	wdt_device;
> +	struct notifier_block	restart_handler;
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
> +static int
> +zx2967_wdt_set_timeout(struct watchdog_device *wdd, unsigned int timeout)
> +{
> +	struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
> +	unsigned int divisor = ZX2967_WDT_DIV_DEFAULT;
> +	unsigned int count;
> +
> +	count = timeout * ZX2967_WDT_CLK_FREQ;
> +	if (count > divisor * ZX2967_WDT_MAX_COUNT)
> +		divisor = DIV_ROUND_UP(count, ZX2967_WDT_MAX_COUNT);
> +	count = DIV_ROUND_UP(count, divisor);
> +	zx2967_wdt_writel(wdt, ZX2967_WDT_CFG_REG, ZX2967_WDT_CFG_DIV(divisor));
> +	zx2967_wdt_writel(wdt, ZX2967_WDT_LOAD_REG, count);
> +	zx2967_wdt_refresh(wdt);
> +	wdt->load = count;
> +	wdd->timeout =  (count * divisor) / ZX2967_WDT_CLK_FREQ;
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
> +	zx2967_wdt_set_timeout(wdd, wdd->timeout);
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
> +	if (ret)
> +		return;
> +
> +	offset = out_args.args[0];
> +	config = out_args.args[1];
> +	mask = out_args.args[2];
> +
> +	regmap = syscon_node_to_regmap(out_args.np);
> +	if (IS_ERR(regmap))
> +		goto out;
> +
> +	regmap_update_bits(regmap, offset, mask, config);
> +out:
> +	of_node_put(np);

Unless I'm missing something variable 'np' is always NULL.  Given the comment
[1] for function of_parse_phandle_with_fixed_args(), I am guessing your
intention was to do something with &out_args->np.

[1]. http://lxr.free-electrons.com/source/drivers/of/base.c#L1786 


> +}
> +
> +static int zx2967_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct zx2967_wdt *wdt;
> +	struct resource *base;
> +	int ret;
> +	struct reset_control *rstc;
> +
> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, wdt);
> +
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
> +	clk_set_rate(wdt->clock, ZX2967_WDT_CLK_FREQ);
> +
> +	rstc = devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(rstc)) {
> +		dev_err(dev, "failed to get rstc");
> +		ret = PTR_ERR(rstc);
> +		goto fail_get_reset_control;

Shouldn't you be going to "fail_register:" ?

> +	}
> +
> +	reset_control_assert(rstc);
> +	mdelay(10);

We can't do better than this?  There is no register to probe?

> +	reset_control_deassert(rstc);
> +
> +	watchdog_set_drvdata(&wdt->wdt_device, wdt);
> +	watchdog_set_nowayout(&wdt->wdt_device, WATCHDOG_NOWAYOUT);
> +
> +	ret = watchdog_register_device(&wdt->wdt_device);
> +	if (ret)
> +		goto fail_register;
> +
> +	dev_info(dev, "watchdog enabled (timeout=%d sec, nowayout=%d)",
> +		 wdt->wdt_device.timeout, WATCHDOG_NOWAYOUT);
> +
> +	return 0;
> +
> +fail_get_reset_control:
> +	watchdog_unregister_device(&wdt->wdt_device);

Not sure you need the above.

> +fail_register:
> +	clk_disable_unprepare(wdt->clock);
> +	return ret;
> +}
> +
> +static int zx2967_wdt_remove(struct platform_device *pdev)
> +{
> +	struct zx2967_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&wdt->wdt_device);
> +	clk_disable_unprepare(wdt->clock);
> +
> +	return 0;
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
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
