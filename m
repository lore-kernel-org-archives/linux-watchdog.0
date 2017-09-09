Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38174 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753201AbdIIDcx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 8 Sep 2017 23:32:53 -0400
Subject: Re: [PATCH 2/2] watchdog: Add Spreadtrum watchdog driver
To: Eric Long <eric.long@spreadtrum.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: baolin.wang@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f3daa0f85dda0672c4b057e7f37c690365652e39.1504580649.git.eric.long@spreadtrum.com>
 <89f16b00247c8db0d33d7572e83770aeae23e4f2.1504580649.git.eric.long@spreadtrum.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <bf1f02cb-5813-fdc0-90a4-6466913fbe43@roeck-us.net>
Date: Fri, 8 Sep 2017 20:32:48 -0700
MIME-Version: 1.0
In-Reply-To: <89f16b00247c8db0d33d7572e83770aeae23e4f2.1504580649.git.eric.long@spreadtrum.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/05/2017 10:38 PM, Eric Long wrote:
> This patch adds the watchdog driver for Spreadtrum SC9860 platform.
> 
> Signed-off-by: Eric Long <eric.long@spreadtrum.com>
> ---
>   drivers/watchdog/Kconfig    |   8 +
>   drivers/watchdog/Makefile   |   1 +
>   drivers/watchdog/sprd_wdt.c | 366 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 375 insertions(+)
>   create mode 100644 drivers/watchdog/sprd_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c722cbf..ea07718 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -787,6 +787,14 @@ config UNIPHIER_WATCHDOG
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called uniphier_wdt.
>   
> +config SPRD_WATCHDOG
> +	tristate "Spreadtrum watchdog support"
> +	depends on ARCH_SPRD
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support watchdog timer embedded
> +	  into the Spreadtrum system.
> +
>   # AVR32 Architecture
>   
>   config AT32AP700X_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 56adf9f..187cca2 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
>   obj-$(CONFIG_ZX2967_WATCHDOG) += zx2967_wdt.o
>   obj-$(CONFIG_STM32_WATCHDOG) += stm32_iwdg.o
>   obj-$(CONFIG_UNIPHIER_WATCHDOG) += uniphier_wdt.o
> +obj-$(CONFIG_SPRD_WATCHDOG) += sprd_wdt.o
>   
>   # AVR32 Architecture
>   obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
> new file mode 100644
> index 0000000..6006bb4
> --- /dev/null
> +++ b/drivers/watchdog/sprd_wdt.c
> @@ -0,0 +1,366 @@
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
> +/* WDT_INT_RAW */
> +#define WDT_INT_RAW_BIT		BIT(0)
> +#define WDT_RST_RAW_BIT		BIT(3)
> +#define WDT_LD_BUSY_BIT		BIT(4)
> +
> +#define WDT_CLK			32768
> +#define WDT_UNLOCK_KEY		0xe551
> +#define WDT_IRQ_TMROUT_OFFSET	0x3
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
> +	u32 irq_tmr_out;
> +	u32 rst_tmr_out;
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
> +static int sprd_wdt_load_value(struct sprd_wdt *wdt, u32 rst_value,
> +			       u32 irq_value)
> +{
> +	u32 val, cnt = 0;
> +
> +	sprd_wdt_unlock(wdt->base);
> +	writel_relaxed((rst_value >> WDT_CNT_VALUE_SIZE) & WDT_CNT_VALUE_MASK,
> +		       wdt->base + WDT_LOAD_HIGH);
> +	writel_relaxed((rst_value & WDT_CNT_VALUE_MASK),
> +		       wdt->base + WDT_LOAD_LOW);
> +	writel_relaxed((irq_value >> WDT_CNT_VALUE_SIZE) & WDT_CNT_VALUE_MASK,
> +		       wdt->base + WDT_IRQ_LOAD_HIGH);
> +	writel_relaxed(irq_value & WDT_CNT_VALUE_MASK,
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

This loop aborts when cnt >= WDT_LOAD_TIMEOUT_NUM, then increases cnt by 1.

> +
> +	if (cnt == WDT_LOAD_TIMEOUT_NUM)

... meaning this condition will never be met.

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
> +
> +	sprd_wdt_unlock(wdt->base);
> +	val = readl_relaxed(wdt->base + WDT_CTRL);
> +	val |= WDT_NEW_VER_EN;
> +	writel_relaxed(val, wdt->base + WDT_CTRL);
> +	sprd_wdt_lock(wdt->base);
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
> +}
> +
> +static int sprd_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct sprd_wdt *wdt = to_sprd_wdt(wdd);
> +	u32 val;
> +	int ret;
> +
> +	ret = sprd_wdt_load_value(wdt, wdt->rst_tmr_out * WDT_CLK,
> +			(wdt->rst_tmr_out - wdt->irq_tmr_out) * WDT_CLK);
> +	if (ret)
> +		return ret;
> +
> +	sprd_wdt_unlock(wdt->base);
> +	val = readl_relaxed(wdt->base + WDT_CTRL);
> +	val |= WDT_CNT_EN_BIT | WDT_INT_EN_BIT | WDT_RST_EN_BIT;
> +	writel_relaxed(val, wdt->base + WDT_CTRL);
> +	sprd_wdt_lock(wdt->base);
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
> +	if (timeout < wdt->irq_tmr_out) {
> +		dev_err(wdd->parent, "wrong timeout value\n");
> +		return -EINVAL;
> +	}
> +
If there is a minimum timeout, the probe function should set min_timeout accordingly.
This function should not have to check the range, and it should not set a range error.

Also, wdd->timeout needs to be set here.

> +	return sprd_wdt_load_value(wdt, timeout * WDT_CLK,
> +			  (timeout - wdt->irq_tmr_out) * WDT_CLK);
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
> +	.get_timeleft = sprd_wdt_get_timeleft,
> +};
> +
> +static const struct watchdog_info sprd_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
> +	.identity = "Spreadtrum Watchdog Timer",
> +};
> +
> +static int sprd_wdt_probe(struct platform_device *pdev)
> +{
> +	struct resource *wdt_res;
> +	struct sprd_wdt *wdt;
> +	u32 rst_tmr_out;
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
> +	if (!wdt->base)
> +		return -ENOMEM;
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "timeout-sec",
> +				 &rst_tmr_out)) {
> +		dev_err(&pdev->dev, "can't get reset timeout\n");
> +		return -EINVAL;
> +	}

Please use the infrastructure to read and set this property.

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
> +	wdt->rst_tmr_out = rst_tmr_out;
> +	wdt->irq_tmr_out = rst_tmr_out - WDT_IRQ_TMROUT_OFFSET;

Seems to me this is equivalent to pretimeout. Why not use the infrastructure ?
Besides, this can currently get negative (if timeout is set to 1 or 2 seconds.

> +	wdt->wdd.info = &sprd_wdt_info;
> +	wdt->wdd.ops = &sprd_wdt_ops;
> +	wdt->wdd.min_timeout = 1;
> +	wdt->wdd.max_timeout = rst_tmr_out;
> +	wdt->wdd.parent = &pdev->dev;
> +	set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);

Is it ? The clocks are not enabled (yet), and the start function hasn't been called.

Presumably the idea is to start the watchdog unconditionally, but then it is stopped
after being opened and closed again, so I don't really understand the logic.

> +	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
> +
> +	ret = watchdog_register_device(&wdt->wdd);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register watchdog\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	sprd_wdt_enable(wdt);
> +

This is racy; at least in theory user space can open the watchdog device
immediately after it was registered, meaning the watchdog can be enabled
before this code is executed. Maybe that is safe, but it may as well result
in an error or hang since the clocks are still disabled.

Even more, WDOG_HW_RUNNING is set above, meaning the watchdog core will
schedule an immediate ping (or start since there is no ping function),
making this even more likely.

> +	return 0;
> +}
> +
> +static int sprd_wdt_remove(struct platform_device *pdev)
> +{
> +	struct sprd_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&wdt->wdd);
> +

If the watchdog ws never opened, this won't stop the clocks.

> +	return 0;
> +}
> +
> +static int __maybe_unused sprd_wdt_pm_suspend(struct device *dev)
> +{
> +	struct sprd_wdt *wdt = dev_get_drvdata(dev);
> +
> +	sprd_wdt_stop(&wdt->wdd);

Why stop the watchdog if it isn't running ?

> +	sprd_wdt_disable(wdt);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused sprd_wdt_pm_resume(struct device *dev)
> +{
> +	struct sprd_wdt *wdt = dev_get_drvdata(dev);
> +
> +	sprd_wdt_enable(wdt);
> +	sprd_wdt_start(&wdt->wdd);

So on resume the watchdog is started unconditionally, even if it was
not running before ?

> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops sprd_wdt_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(
> +		sprd_wdt_pm_suspend,
> +		sprd_wdt_pm_resume)
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
> 

