Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43893 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdJVQHc (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 12:07:32 -0400
Date: Sun, 22 Oct 2017 09:07:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eric Long <eric.long@spreadtrum.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, baolin.wang@linaro.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2,2/2] watchdog: Add Spreadtrum watchdog driver
Message-ID: <20171022160729.GA26629@roeck-us.net>
References: <48f1e10c508b4c174f2c41a6cef84011b65ff9b5.1505216059.git.eric.long@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48f1e10c508b4c174f2c41a6cef84011b65ff9b5.1505216059.git.eric.long@spreadtrum.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Sep 12, 2017 at 07:40:09PM +0800, Eric Long wrote:
> This patch adds the watchdog driver for Spreadtrum SC9860 platform.
> 
> Signed-off-by: Eric Long <eric.long@spreadtrum.com>
> ---
> Changes since v1:
>  - Use pretimeout instead of own implementation.
>  - Fix timeout loop when loading timeout values.
>  - use the infrastructure to read and set "timeout-sec" property.
>  - Add conditions when start or stop watchdog.
>  - Change the position of enabling watchdog.
>  - Other optimization.
> ---
>  drivers/watchdog/Kconfig    |   8 +
>  drivers/watchdog/Makefile   |   1 +
>  drivers/watchdog/sprd_wdt.c | 384 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 393 insertions(+)
>  create mode 100644 drivers/watchdog/sprd_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c722cbf..ea07718 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -787,6 +787,14 @@ config UNIPHIER_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called uniphier_wdt.
>  
> +config SPRD_WATCHDOG
> +	tristate "Spreadtrum watchdog support"
> +	depends on ARCH_SPRD
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support watchdog timer embedded
> +	  into the Spreadtrum system.
> +
>  # AVR32 Architecture
>  
>  config AT32AP700X_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 56adf9f..187cca2 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
>  obj-$(CONFIG_ZX2967_WATCHDOG) += zx2967_wdt.o
>  obj-$(CONFIG_STM32_WATCHDOG) += stm32_iwdg.o
>  obj-$(CONFIG_UNIPHIER_WATCHDOG) += uniphier_wdt.o
> +obj-$(CONFIG_SPRD_WATCHDOG) += sprd_wdt.o
>  
>  # AVR32 Architecture
>  obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
> new file mode 100644
> index 0000000..dedbca6fd
> --- /dev/null
> +++ b/drivers/watchdog/sprd_wdt.c
> @@ -0,0 +1,384 @@
> +/*
> + * Spreadtrum watchdog driver
> + * Copyright (C) 2017 Spreadtrum - http://www.spreadtrum.com
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +
> +#define WDT_LOAD_LOW		0x0
> +#define WDT_LOAD_HIGH		0x4
> +#define WDT_CTRL		0x8
> +#define WDT_INT_CLR		0xc
> +#define WDT_INT_RAW		0x10
> +#define WDT_INT_MSK		0x14
> +#define WDT_CNT_LOW		0x18
> +#define WDT_CNT_HIGH		0x1c
> +#define WDT_LOCK		0x20
> +#define WDT_IRQ_LOAD_LOW	0x2c
> +#define WDT_IRQ_LOAD_HIGH	0x30
> +
> +/* WDT_CTRL */
> +#define WDT_INT_EN_BIT		BIT(0)
> +#define WDT_CNT_EN_BIT		BIT(1)
> +#define WDT_NEW_VER_EN		BIT(2)
> +#define WDT_RST_EN_BIT		BIT(3)
> +
> +/* WDT_INT_CLR */
> +#define WDT_INT_CLEAR_BIT	BIT(0)
> +#define WDT_RST_CLEAR_BIT	BIT(3)
> +
Requires include of bitops.h.

> +/* WDT_INT_RAW */
> +#define WDT_INT_RAW_BIT		BIT(0)
> +#define WDT_RST_RAW_BIT		BIT(3)
> +#define WDT_LD_BUSY_BIT		BIT(4)
> +
> +#define WDT_CLK			32768

Would it make sense to use clk_get_rate() instead ?

> +#define WDT_UNLOCK_KEY		0xe551
> +#define WDT_DEFAULT_PRETMROUT	3
> +
> +#define WDT_CNT_VALUE_SIZE	16
> +#define WDT_CNT_VALUE_MASK	GENMASK(15, 0)
> +#define WDT_LOAD_TIMEOUT_NUM	10000
> +
> +struct sprd_wdt {
> +	void __iomem *base;
> +	struct watchdog_device wdd;
> +	struct clk *enable;
> +	struct clk *rtc_enable;
> +	unsigned int irq;
> +};
> +
> +static inline struct sprd_wdt *to_sprd_wdt(struct watchdog_device *wdd)
> +{
> +	return container_of(wdd, struct sprd_wdt, wdd);
> +}
> +
> +static inline void sprd_wdt_lock(void __iomem *addr)
> +{
> +	writel_relaxed(0x0, addr + WDT_LOCK);
> +}
> +
> +static inline void sprd_wdt_unlock(void __iomem *addr)
> +{
> +	writel_relaxed(WDT_UNLOCK_KEY, addr + WDT_LOCK);
> +}
> +
> +static inline bool sprd_wdt_is_running(struct sprd_wdt *wdt)
> +{
> +	u32 val;
> +
> +	val = readl_relaxed(wdt->base + WDT_CTRL);
> +	return val & WDT_NEW_VER_EN;
> +}
> +
> +static irqreturn_t sprd_wdt_isr(int irq, void *dev_id)
> +{
> +	struct sprd_wdt *wdt = (struct sprd_wdt *)dev_id;
> +
> +	sprd_wdt_unlock(wdt->base);
> +	writel_relaxed(WDT_INT_CLEAR_BIT, wdt->base + WDT_INT_CLR);
> +	sprd_wdt_lock(wdt->base);
> +	watchdog_notify_pretimeout(&wdt->wdd);
> +	return IRQ_HANDLED;
> +}
> +
> +static u32 sprd_wdt_get_cnt_value(struct sprd_wdt *wdt)
> +{
> +	u32 val;
> +
> +	val = readl_relaxed(wdt->base + WDT_CNT_HIGH) << WDT_CNT_VALUE_SIZE;
> +	val |= readl_relaxed(wdt->base + WDT_CNT_LOW) & WDT_CNT_VALUE_MASK;
> +
> +	return val;
> +}
> +
> +static int sprd_wdt_load_value(struct sprd_wdt *wdt, u32 timeout,
> +			       u32 pretimeout)
> +{
> +	u32 val, cnt = 0;
> +
> +	if (timeout < pretimeout)
> +		return -EINVAL;
> +

This is the wrong place to check if the timeout is valid.
The core should know about limits and perform the checks.

> +	if (!pretimeout)
> +		pretimeout = WDT_DEFAULT_PRETMROUT;
> +

If pretimeout was 0 and timeout < 3, this will accept the timeout. If the
pretimeout is mandatory, it should be enforced, and the minimum timeout
should be larger than the miniumum pretimeout.

> +	sprd_wdt_unlock(wdt->base);
> +	writel_relaxed(((timeout * WDT_CLK) >> WDT_CNT_VALUE_SIZE) &
> +		       WDT_CNT_VALUE_MASK, wdt->base + WDT_LOAD_HIGH);

This can overflow. The maximum timeout must be <= 0xffffffff / WDT_CLK.

> +	writel_relaxed(((timeout * WDT_CLK) & WDT_CNT_VALUE_MASK),
> +		       wdt->base + WDT_LOAD_LOW);
> +	writel_relaxed(((pretimeout * WDT_CLK) >> WDT_CNT_VALUE_SIZE) &
> +			WDT_CNT_VALUE_MASK, wdt->base + WDT_IRQ_LOAD_HIGH);

Same for pretimeout.

> +	writel_relaxed((pretimeout * WDT_CLK) & WDT_CNT_VALUE_MASK,
> +		       wdt->base + WDT_IRQ_LOAD_LOW);
> +	sprd_wdt_lock(wdt->base);
> +
> +	/*
> +	 * Waiting the load value operation done,
> +	 * it needs two or three RTC clock cycles.
> +	 */
> +	do {
> +		val = readl_relaxed(wdt->base + WDT_INT_RAW);
> +		if (!(val & WDT_LD_BUSY_BIT))
> +			break;
> +
> +		cpu_relax();
> +	} while (cnt++ < WDT_LOAD_TIMEOUT_NUM);
> +
> +	if (cnt >= WDT_LOAD_TIMEOUT_NUM)
> +		return -EBUSY;
> +	return 0;
> +}
> +
> +static void sprd_wdt_enable(struct sprd_wdt *wdt)
> +{
> +	u32 val;
> +
> +	clk_prepare_enable(wdt->enable);
> +	clk_prepare_enable(wdt->rtc_enable);

Both functions can fail.

> +
> +	sprd_wdt_unlock(wdt->base);
> +	val = readl_relaxed(wdt->base + WDT_CTRL);
> +	val |= WDT_NEW_VER_EN;
> +	writel_relaxed(val, wdt->base + WDT_CTRL);
> +	sprd_wdt_lock(wdt->base);
> +	set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);

Why ? The watchdog isn't started here.

> +}
> +
> +static void sprd_wdt_disable(struct sprd_wdt *wdt)
> +{
> +	sprd_wdt_unlock(wdt->base);
> +	writel_relaxed(0x0, wdt->base + WDT_CTRL);
> +	sprd_wdt_lock(wdt->base);
> +
> +	clk_disable(wdt->enable);
> +	clk_disable(wdt->rtc_enable);

clk_prepare_enable but no matching clk_disable_unprepare ?

> +}
> +
> +static int sprd_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct sprd_wdt *wdt = to_sprd_wdt(wdd);
> +	u32 val;
> +	int ret;
> +
> +	ret = sprd_wdt_load_value(wdt, wdd->timeout, wdd->pretimeout);
> +	if (ret)
> +		return ret;
> +
> +	sprd_wdt_unlock(wdt->base);
> +	val = readl_relaxed(wdt->base + WDT_CTRL);
> +	val |= WDT_CNT_EN_BIT | WDT_INT_EN_BIT | WDT_RST_EN_BIT;
> +	writel_relaxed(val, wdt->base + WDT_CTRL);
> +	sprd_wdt_lock(wdt->base);
> +	set_bit(WDOG_HW_RUNNING, &wdd->status);
> +
> +	return 0;
> +}
> +
> +static int sprd_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct sprd_wdt *wdt = to_sprd_wdt(wdd);
> +	u32 val;
> +
> +	sprd_wdt_unlock(wdt->base);
> +	val = readl_relaxed(wdt->base + WDT_CTRL);
> +	val &= ~(WDT_CNT_EN_BIT | WDT_RST_EN_BIT | WDT_INT_EN_BIT);
> +	writel_relaxed(val, wdt->base + WDT_CTRL);
> +	sprd_wdt_lock(wdt->base);
> +	return 0;
> +}
> +
> +static int sprd_wdt_set_timeout(struct watchdog_device *wdd,
> +				u32 timeout)
> +{
> +	struct sprd_wdt *wdt = to_sprd_wdt(wdd);
> +
> +	wdd->timeout = timeout;
> +
> +	return sprd_wdt_load_value(wdt, timeout, wdd->pretimeout);

Even on error, this accepts the new (bad) timeout.

> +}
> +
> +static int sprd_wdt_set_pretimeout(struct watchdog_device *wdd,
> +				   u32 new_pretimeout)
> +{
> +	struct sprd_wdt *wdt = to_sprd_wdt(wdd);
> +
> +	wdd->pretimeout = new_pretimeout;
> +
> +	return sprd_wdt_load_value(wdt, wdd->timeout, new_pretimeout);

Even on error, this accepts the new (bad) pretimeout.

> +}
> +
> +static u32 sprd_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct sprd_wdt *wdt = to_sprd_wdt(wdd);
> +	u32 val;
> +
> +	val = sprd_wdt_get_cnt_value(wdt);
> +	val = val / WDT_CLK;
> +
> +	return val;
> +}
> +
> +static const struct watchdog_ops sprd_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = sprd_wdt_start,
> +	.stop = sprd_wdt_stop,
> +	.set_timeout = sprd_wdt_set_timeout,
> +	.set_pretimeout = sprd_wdt_set_pretimeout,
> +	.get_timeleft = sprd_wdt_get_timeleft,
> +};
> +
> +static const struct watchdog_info sprd_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT |
> +		   WDIOF_PRETIMEOUT |
> +		   WDIOF_MAGICCLOSE |
> +		   WDIOF_KEEPALIVEPING,
> +	.identity = "Spreadtrum Watchdog Timer",
> +};
> +
> +static int sprd_wdt_probe(struct platform_device *pdev)
> +{
> +	struct resource *wdt_res;
> +	struct sprd_wdt *wdt;
> +	int ret;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!wdt_res) {
> +		dev_err(&pdev->dev, "failed to memory resource\n");
> +		return -ENOMEM;
> +	}
> +
> +	wdt->base = devm_ioremap_nocache(&pdev->dev, wdt_res->start,
> +					 resource_size(wdt_res));

Consider using devm_ioremap_resource().

> +	if (!wdt->base)
> +		return -ENOMEM;
> +
> +	wdt->enable = devm_clk_get(&pdev->dev, "enable");
> +	if (IS_ERR(wdt->enable)) {
> +		dev_err(&pdev->dev, "can't get the enable clock\n");
> +		return PTR_ERR(wdt->enable);
> +	}
> +
> +	wdt->rtc_enable = devm_clk_get(&pdev->dev, "rtc_enable");
> +	if (IS_ERR(wdt->rtc_enable)) {
> +		dev_err(&pdev->dev, "can't get the rtc enable clock\n");
> +		return PTR_ERR(wdt->rtc_enable);
> +	}
> +
> +	wdt->irq = platform_get_irq(pdev, 0);
> +	if (wdt->irq < 0) {
> +		dev_err(&pdev->dev, "failed to get IRQ resource\n");
> +		return wdt->irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, wdt->irq, sprd_wdt_isr,
> +			       IRQF_NO_SUSPEND, "sprd-wdt", (void *)wdt);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register irq\n");
> +		return ret;
> +	}
> +
> +	wdt->wdd.info = &sprd_wdt_info;
> +	wdt->wdd.ops = &sprd_wdt_ops;
> +	wdt->wdd.parent = &pdev->dev;
> +

This should also set limits for min/max to let the core validate ranges.
If the minimum pretimeout is 3 seconds, the lower limit for timeout should
be set accordingly.

> +	sprd_wdt_enable(wdt);
> +
> +	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
> +
> +	ret = watchdog_register_device(&wdt->wdd);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register watchdog\n");

No wdt disable on error ?

> +		return ret;
> +	}
> +	platform_set_drvdata(pdev, wdt);
> +
> +	return 0;
> +}
> +
> +static int sprd_wdt_remove(struct platform_device *pdev)
> +{
> +	struct sprd_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	if (sprd_wdt_is_running(wdt)) {
> +		sprd_wdt_stop(&wdt->wdd);
> +		sprd_wdt_disable(wdt);
> +	}

I assume you understand that this defeats NOWAYOUT.

> +	watchdog_unregister_device(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused sprd_wdt_pm_suspend(struct device *dev)
> +{
> +	struct sprd_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (sprd_wdt_is_running(wdt)) {

if (watchdog_active()) should work here.

> +		sprd_wdt_stop(&wdt->wdd);
> +		sprd_wdt_disable(wdt);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused sprd_wdt_pm_resume(struct device *dev)
> +{
> +	struct watchdog_device *wdd = dev_get_drvdata(dev);
> +	struct sprd_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(wdd) && !sprd_wdt_is_running(wdt)) {

sprd_wdt_is_running() should not be needed.

> +		sprd_wdt_enable(wdt);
> +		sprd_wdt_start(&wdt->wdd);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops sprd_wdt_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(sprd_wdt_pm_suspend,
> +				sprd_wdt_pm_resume)
> +};
> +
> +static const struct of_device_id sprd_wdt_match_table[] = {
> +	{ .compatible = "sprd,sp9860-wdt", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sprd_wdt_match_table);
> +
> +static struct platform_driver sprd_watchdog_driver = {
> +	.probe	= sprd_wdt_probe,
> +	.remove	= sprd_wdt_remove,
> +	.driver	= {
> +		.name = "sprd-wdt",
> +		.of_match_table = sprd_wdt_match_table,
> +		.pm = &sprd_wdt_pm_ops,
> +	},
> +};
> +module_platform_driver(sprd_watchdog_driver);
> +
> +MODULE_AUTHOR("Eric Long <eric.long@spreadtrum.com>");
> +MODULE_DESCRIPTION("Spreadtrum Watchdog Timer Controller Driver");
> +MODULE_LICENSE("GPL v2");
