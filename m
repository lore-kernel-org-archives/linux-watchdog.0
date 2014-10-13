Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39229 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbaJMQmV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 13 Oct 2014 12:42:21 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XdihR-002jxS-5i
	for linux-watchdog@vger.kernel.org; Mon, 13 Oct 2014 16:42:21 +0000
Message-ID: <543C00E2.2090806@roeck-us.net>
Date: Mon, 13 Oct 2014 09:42:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
CC: Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] clocksource: tegra: Register watchdog device
References: <1413201922-4210-1-git-send-email-thierry.reding@gmail.com> <1413201922-4210-2-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1413201922-4210-2-git-send-email-thierry.reding@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/13/2014 05:05 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The watchdog timer is part of the timer controller block on Tegra. In
> order to avoid access to the same registers from two drivers, register
> the watchdog device from the clocksource driver.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Does that really make sense ?

A couple of callbacks into the clock driver to implement register accesses
might be a better approach.

Guenter

> ---
>   drivers/clocksource/tegra20_timer.c | 236 +++++++++++++++++++++++++++-
>   drivers/watchdog/Makefile           |   1 -
>   drivers/watchdog/tegra_wdt.c        | 302 ------------------------------------
>   3 files changed, 228 insertions(+), 311 deletions(-)
>   delete mode 100644 drivers/watchdog/tegra_wdt.c
>
> diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
> index b576091ce37a..ee6e885b880b 100644
> --- a/drivers/clocksource/tegra20_timer.c
> +++ b/drivers/clocksource/tegra20_timer.c
> @@ -25,10 +25,12 @@
>   #include <linux/clk.h>
>   #include <linux/io.h>
>   #include <linux/of_address.h>
> +#include <linux/of_device.h>
>   #include <linux/of_irq.h>
>   #include <linux/platform_device.h>
>   #include <linux/sched_clock.h>
>   #include <linux/delay.h>
> +#include <linux/watchdog.h>
>
>   #include <asm/mach/time.h>
>   #include <asm/smp_twd.h>
> @@ -54,6 +56,49 @@
>   #define TIMER_PCR 0x4
>   #define  TIMER_PCR_INTR_CLR (1 << 30)
>
> +/*
> + * Register base of the timer that's selected for pairing with the watchdog.
> + * This driver arbitrarily uses timer 5, which is currently unused by
> + * other drivers (in particular, the Tegra clocksource driver).  If this
> + * needs to change, take care that the new timer is not used by the
> + * clocksource driver.
> + */
> +#define WDT_TIMER_BASE 0x60
> +#define WDT_TIMER_ID 5
> +
> +/* WDT registers */
> +#define WDT_BASE 0x100
> +
> +#define WDT_CFG				0x0
> +#define  WDT_CFG_PERIOD_SHIFT		4
> +#define  WDT_CFG_PERIOD_MASK		0xff
> +#define  WDT_CFG_INT_EN			(1 << 12)
> +#define  WDT_CFG_PMC2CAR_RST_EN		(1 << 15)
> +
> +#define WDT_STS				0x4
> +#define  WDT_STS_COUNT_SHIFT		4
> +#define  WDT_STS_COUNT_MASK		0xff
> +#define  WDT_STS_EXP_SHIFT		12
> +#define  WDT_STS_EXP_MASK		0x3
> +
> +#define WDT_CMD				0x8
> +#define  WDT_CMD_START_COUNTER		(1 << 0)
> +#define  WDT_CMD_DISABLE_COUNTER	(1 << 1)
> +
> +#define WDT_UNLOCK			0xc
> +#define WDT_UNLOCK_PATTERN		(0xc45a << 0)
> +
> +struct tegra_wdt {
> +	struct watchdog_device wdd;
> +	void __iomem *timer;
> +	void __iomem *base;
> +};
> +
> +static inline struct tegra_wdt *to_tegra_wdt(struct watchdog_device *wdd)
> +{
> +	return container_of(wdd, struct tegra_wdt, wdd);
> +}
> +
>   struct tegra_timer {
>   	void __iomem *base;
>   	struct clk *clk;
> @@ -62,6 +107,8 @@ struct tegra_timer {
>   	struct clock_event_device clockevent;
>   	struct delay_timer delay;
>
> +	struct tegra_wdt *wdt;
> +
>   	u32 usec_cfg;
>   };
>
> @@ -296,16 +343,183 @@ static void __init tegra20_init_rtc(struct device_node *np)
>   }
>   CLOCKSOURCE_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
>
> +static const struct watchdog_info tegra_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
> +	.identity = "Tegra Watchdog",
> +};
> +
> +static int tegra_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct tegra_wdt *wdt = to_tegra_wdt(wdd);
> +	u32 value;
> +
> +	/*
> +	 * This thing has a fixed 1MHz clock.  Normally, we would set the
> +	 * period to 1 second by writing 1000000ul, but the watchdog system
> +	 * reset actually occurs on the 4th expiration of this counter,
> +	 * so we set the period to 1/4 of this amount.
> +	 */
> +	value = TIMER_PTV_ENABLE | TIMER_PTV_PERIODIC | (USEC_PER_SEC / 4);
> +	writel(value, wdt->timer + TIMER_PTV);
> +
> +	/*
> +	 * Set number of periods and start counter.
> +	 *
> +	 * Interrupt handler is not required for user space
> +	 * WDT accesses, since the caller is responsible to ping the
> +	 * WDT to reset the counter before expiration, through ioctls.
> +	 */
> +	value = WDT_TIMER_ID | (wdd->timeout << WDT_CFG_PERIOD_SHIFT) |
> +		WDT_CFG_PMC2CAR_RST_EN;
> +	writel(value, wdt->base + WDT_CFG);
> +
> +	writel(WDT_CMD_START_COUNTER, wdt->base + WDT_CMD);
> +
> +	return 0;
> +}
> +
> +static int tegra_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct tegra_wdt *wdt = to_tegra_wdt(wdd);
> +
> +	writel(WDT_UNLOCK_PATTERN, wdt->base + WDT_UNLOCK);
> +	writel(WDT_CMD_DISABLE_COUNTER, wdt->base + WDT_CMD);
> +	writel(0, wdt->timer + TIMER_PTV);
> +
> +	return 0;
> +}
> +
> +static int tegra_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct tegra_wdt *wdt = to_tegra_wdt(wdd);
> +
> +	writel(WDT_CMD_START_COUNTER, wdt->base + WDT_CMD);
> +
> +	return 0;
> +}
> +
> +static int tegra_wdt_set_timeout(struct watchdog_device *wdd,
> +				 unsigned int timeout)
> +{
> +	wdd->timeout = timeout;
> +
> +	if (watchdog_active(wdd))
> +		return tegra_wdt_start(wdd);
> +
> +	return 0;
> +}
> +
> +static unsigned int tegra_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct tegra_wdt *wdt = to_tegra_wdt(wdd);
> +	unsigned int count, exp;
> +	u32 value;
> +
> +	value = readl(wdt->base + WDT_STS);
> +
> +	/* Current countdown (from timeout) */
> +	count = (value >> WDT_STS_COUNT_SHIFT) & WDT_STS_COUNT_MASK;
> +
> +	/* Number of expirations (we are waiting for the 4th expiration) */
> +	exp = (value >> WDT_STS_EXP_SHIFT) & WDT_STS_EXP_MASK;
> +
> +	/*
> +	 * The entire thing is divided by 4 because we are ticking down 4 times
> +	 * faster due to needing to wait for the 4th expiration.
> +	 */
> +	return (((3 - exp) * wdd->timeout) + count) / 4;
> +}
> +
> +static const struct watchdog_ops tegra_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = tegra_wdt_start,
> +	.stop = tegra_wdt_stop,
> +	.ping = tegra_wdt_ping,
> +	.set_timeout = tegra_wdt_set_timeout,
> +	.get_timeleft = tegra_wdt_get_timeleft,
> +};
> +
> +static struct tegra_wdt *tegra_wdt_probe(struct device *dev, void __iomem *base)
> +{
> +	struct tegra_wdt *wdt;
> +	int err;
> +
> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	wdt->timer = base + TIMER5_BASE;
> +	wdt->base = base + WDT_BASE;
> +
> +	wdt->wdd.info = &tegra_wdt_info;
> +	wdt->wdd.ops = &tegra_wdt_ops;
> +	wdt->wdd.min_timeout = 1;
> +	wdt->wdd.max_timeout = 255;
> +	wdt->wdd.timeout = 120;
> +
> +	watchdog_set_nowayout(&wdt->wdd, WATCHDOG_NOWAYOUT);
> +	watchdog_set_drvdata(&wdt->wdd, timer);
> +
> +	err = watchdog_register_device(&wdt->wdd);
> +	if (err < 0)
> +		return ERR_PTR(err);
> +
> +	return wdt;
> +}
> +
> +struct tegra_timer_soc {
> +	bool has_watchdog;
> +};
> +
> +/*
> + * Tegra20 has a watchdog but it is different from the one found on Tegra30
> + * and later. Most of it is implemented in the clock and reset controller, but
> + * it relies on either timer 1 or timer 2 as source.
> + *
> + * For now don't register a watchdog device on Tegra20 until it has been. Even
> + * if it was implemented at some point in the future it would most likely be
> + * registered from the clock and reset controller driver.
> + */
> +static const struct tegra_timer_soc tegra20_timer_soc = {
> +	.has_watchdog = false,
> +};
> +
> +static const struct tegra_timer_soc tegra30_timer_soc = {
> +	.has_watchdog = true,
> +};
> +
> +static const struct of_device_id tegra_timer_of_match[] = {
> +	{ .compatible = "nvidia,tegra124-timer", .data = &tegra30_timer_soc },
> +	{ .compatible = "nvidia,tegra114-timer", .data = &tegra30_timer_soc },
> +	{ .compatible = "nvidia,tegra30-timer", .data = &tegra30_timer_soc },
> +	{ .compatible = "nvidia,tegra20-timer", .data = &tegra20_timer_soc },
> +	{ }
> +};
> +
>   static int tegra_timer_probe(struct platform_device *pdev)
>   {
> +	const struct tegra_timer_soc *soc;
> +	const struct of_device_id *match;
>   	struct resource *regs;
>   	void __iomem *base;
>
> +	match = of_match_device(tegra_timer_of_match, &pdev->dev);
> +	if (!match)
> +		return -ENODEV;
> +
> +	soc = match->data;
> +
>   	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	base = devm_ioremap_resource(&pdev->dev, regs);
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>
> +	if (IS_ENABLED(CONFIG_TEGRA_WATCHDOG) && soc->has_watchdog) {
> +		timer->wdt = tegra_wdt_probe(&pdev->dev, base);
> +		if (IS_ERR(timer->wdt))
> +			return PTR_ERR(timer->wdt);
> +	}
> +
>   	platform_set_drvdata(pdev, timer);
>   	timer->base = base;
>
> @@ -317,6 +531,13 @@ static int tegra_timer_suspend(struct device *dev)
>   {
>   	struct tegra_timer *timer = dev_get_drvdata(dev);
>
> +	if (IS_ENABLED(CONFIG_TEGRA_WATCHDOG) && timer->wdt) {
> +		struct watchdog_device *wdd = &timer->wdt->wdd;
> +
> +		if (watchdog_active(wdd))
> +			tegra_wdt_stop(wdd);
> +	}
> +
>   	timer->usec_cfg = timer_readl(timer, TIMERUS_USEC_CFG);
>
>   	return 0;
> @@ -328,6 +549,13 @@ static int tegra_timer_resume(struct device *dev)
>
>   	timer_writel(timer, timer->usec_cfg, TIMERUS_USEC_CFG);
>
> +	if (IS_ENABLED(CONFIG_TEGRA_WATCHDOG) && timer->wdt) {
> +		struct watchdog_device *wdd = &timer->wdt->wdd;
> +
> +		if (watchdog_active(wdd))
> +			tegra_wdt_start(wdd);
> +	}
> +
>   	return 0;
>   }
>   #endif
> @@ -335,14 +563,6 @@ static int tegra_timer_resume(struct device *dev)
>   static SIMPLE_DEV_PM_OPS(tegra_timer_pm_ops, tegra_timer_suspend,
>   			 tegra_timer_resume);
>
> -static const struct of_device_id tegra_timer_of_match[] = {
> -	{ .compatible = "nvidia,tegra124-timer", },
> -	{ .compatible = "nvidia,tegra114-timer", },
> -	{ .compatible = "nvidia,tegra30-timer", },
> -	{ .compatible = "nvidia,tegra20-timer", },
> -	{ }
> -};
> -
>   static struct platform_driver tegra_timer_driver = {
>   	.driver = {
>   		.name = "tegra-timer",
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index c569ec8f8a76..ca6cd5513efa 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -61,7 +61,6 @@ obj-$(CONFIG_MOXART_WDT) += moxart_wdt.o
>   obj-$(CONFIG_SIRFSOC_WATCHDOG) += sirfsoc_wdt.o
>   obj-$(CONFIG_QCOM_WDT) += qcom-wdt.o
>   obj-$(CONFIG_BCM_KONA_WDT) += bcm_kona_wdt.o
> -obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
>   obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
>
>   # AVR32 Architecture
> diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
> deleted file mode 100644
> index 750e2a26cb12..000000000000
> --- a/drivers/watchdog/tegra_wdt.c
> +++ /dev/null
> @@ -1,302 +0,0 @@
> -/*
> - * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU General Public License,
> - * version 2, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/io.h>
> -#include <linux/of.h>
> -#include <linux/platform_device.h>
> -#include <linux/watchdog.h>
> -
> -/* minimum and maximum watchdog trigger timeout, in seconds */
> -#define MIN_WDT_TIMEOUT			1
> -#define MAX_WDT_TIMEOUT			255
> -
> -/*
> - * Base of the WDT registers, from the timer base address.  There are
> - * actually 5 watchdogs that can be configured (by pairing with an available
> - * timer), at bases 0x100 + (WDT ID) * 0x20, where WDT ID is 0 through 4.
> - * This driver only configures the first watchdog (WDT ID 0).
> - */
> -#define WDT_BASE			0x100
> -#define WDT_ID				0
> -
> -/*
> - * Register base of the timer that's selected for pairing with the watchdog.
> - * This driver arbitrarily uses timer 5, which is currently unused by
> - * other drivers (in particular, the Tegra clocksource driver).  If this
> - * needs to change, take care that the new timer is not used by the
> - * clocksource driver.
> - */
> -#define WDT_TIMER_BASE			0x60
> -#define WDT_TIMER_ID			5
> -
> -/* WDT registers */
> -#define WDT_CFG				0x0
> -#define WDT_CFG_PERIOD_SHIFT		4
> -#define WDT_CFG_PERIOD_MASK		0xff
> -#define WDT_CFG_INT_EN			(1 << 12)
> -#define WDT_CFG_PMC2CAR_RST_EN		(1 << 15)
> -#define WDT_STS				0x4
> -#define WDT_STS_COUNT_SHIFT		4
> -#define WDT_STS_COUNT_MASK		0xff
> -#define WDT_STS_EXP_SHIFT		12
> -#define WDT_STS_EXP_MASK		0x3
> -#define WDT_CMD				0x8
> -#define WDT_CMD_START_COUNTER		(1 << 0)
> -#define WDT_CMD_DISABLE_COUNTER		(1 << 1)
> -#define WDT_UNLOCK			(0xc)
> -#define WDT_UNLOCK_PATTERN		(0xc45a << 0)
> -
> -/* Timer registers */
> -#define TIMER_PTV			0x0
> -#define TIMER_EN			(1 << 31)
> -#define TIMER_PERIODIC			(1 << 30)
> -
> -struct tegra_wdt {
> -	struct watchdog_device	wdd;
> -	void __iomem		*wdt_regs;
> -	void __iomem		*tmr_regs;
> -};
> -
> -#define WDT_HEARTBEAT 120
> -static int heartbeat = WDT_HEARTBEAT;
> -module_param(heartbeat, int, 0);
> -MODULE_PARM_DESC(heartbeat,
> -	"Watchdog heartbeats in seconds. (default = "
> -	__MODULE_STRING(WDT_HEARTBEAT) ")");
> -
> -static bool nowayout = WATCHDOG_NOWAYOUT;
> -module_param(nowayout, bool, 0);
> -MODULE_PARM_DESC(nowayout,
> -	"Watchdog cannot be stopped once started (default="
> -	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> -
> -static int tegra_wdt_start(struct watchdog_device *wdd)
> -{
> -	struct tegra_wdt *wdt = watchdog_get_drvdata(wdd);
> -	u32 val;
> -
> -	/*
> -	 * This thing has a fixed 1MHz clock.  Normally, we would set the
> -	 * period to 1 second by writing 1000000ul, but the watchdog system
> -	 * reset actually occurs on the 4th expiration of this counter,
> -	 * so we set the period to 1/4 of this amount.
> -	 */
> -	val = 1000000ul / 4;
> -	val |= (TIMER_EN | TIMER_PERIODIC);
> -	writel(val, wdt->tmr_regs + TIMER_PTV);
> -
> -	/*
> -	 * Set number of periods and start counter.
> -	 *
> -	 * Interrupt handler is not required for user space
> -	 * WDT accesses, since the caller is responsible to ping the
> -	 * WDT to reset the counter before expiration, through ioctls.
> -	 */
> -	val = WDT_TIMER_ID |
> -	      (wdd->timeout << WDT_CFG_PERIOD_SHIFT) |
> -	      WDT_CFG_PMC2CAR_RST_EN;
> -	writel(val, wdt->wdt_regs + WDT_CFG);
> -
> -	writel(WDT_CMD_START_COUNTER, wdt->wdt_regs + WDT_CMD);
> -
> -	return 0;
> -}
> -
> -static int tegra_wdt_stop(struct watchdog_device *wdd)
> -{
> -	struct tegra_wdt *wdt = watchdog_get_drvdata(wdd);
> -
> -	writel(WDT_UNLOCK_PATTERN, wdt->wdt_regs + WDT_UNLOCK);
> -	writel(WDT_CMD_DISABLE_COUNTER, wdt->wdt_regs + WDT_CMD);
> -	writel(0, wdt->tmr_regs + TIMER_PTV);
> -
> -	return 0;
> -}
> -
> -static int tegra_wdt_ping(struct watchdog_device *wdd)
> -{
> -	struct tegra_wdt *wdt = watchdog_get_drvdata(wdd);
> -
> -	writel(WDT_CMD_START_COUNTER, wdt->wdt_regs + WDT_CMD);
> -
> -	return 0;
> -}
> -
> -static int tegra_wdt_set_timeout(struct watchdog_device *wdd,
> -				 unsigned int timeout)
> -{
> -	wdd->timeout = timeout;
> -
> -	if (watchdog_active(wdd))
> -		return tegra_wdt_start(wdd);
> -
> -	return 0;
> -}
> -
> -static unsigned int tegra_wdt_get_timeleft(struct watchdog_device *wdd)
> -{
> -	struct tegra_wdt *wdt = watchdog_get_drvdata(wdd);
> -	u32 val;
> -	int count;
> -	int exp;
> -
> -	val = readl(wdt->wdt_regs + WDT_STS);
> -
> -	/* Current countdown (from timeout) */
> -	count = (val >> WDT_STS_COUNT_SHIFT) & WDT_STS_COUNT_MASK;
> -
> -	/* Number of expirations (we are waiting for the 4th expiration) */
> -	exp = (val >> WDT_STS_EXP_SHIFT) & WDT_STS_EXP_MASK;
> -
> -	/*
> -	 * The entire thing is divided by 4 because we are ticking down 4 times
> -	 * faster due to needing to wait for the 4th expiration.
> -	 */
> -	return (((3 - exp) * wdd->timeout) + count) / 4;
> -}
> -
> -static const struct watchdog_info tegra_wdt_info = {
> -	.options	= WDIOF_SETTIMEOUT |
> -			  WDIOF_MAGICCLOSE |
> -			  WDIOF_KEEPALIVEPING,
> -	.firmware_version = 0,
> -	.identity	= "Tegra Watchdog",
> -};
> -
> -static struct watchdog_ops tegra_wdt_ops = {
> -	.owner = THIS_MODULE,
> -	.start = tegra_wdt_start,
> -	.stop = tegra_wdt_stop,
> -	.ping = tegra_wdt_ping,
> -	.set_timeout = tegra_wdt_set_timeout,
> -	.get_timeleft = tegra_wdt_get_timeleft,
> -};
> -
> -static int tegra_wdt_probe(struct platform_device *pdev)
> -{
> -	struct watchdog_device *wdd;
> -	struct tegra_wdt *wdt;
> -	struct resource *res;
> -	void __iomem *regs;
> -	int ret;
> -
> -	/* This is the timer base. */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	regs = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(regs))
> -		return PTR_ERR(regs);
> -
> -	/*
> -	 * Allocate our watchdog driver data, which has the
> -	 * struct watchdog_device nested within it.
> -	 */
> -	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> -	if (!wdt)
> -		return -ENOMEM;
> -
> -	/* Initialize struct tegra_wdt. */
> -	wdt->wdt_regs = regs + WDT_BASE;
> -	wdt->tmr_regs = regs + WDT_TIMER_BASE;
> -
> -	/* Initialize struct watchdog_device. */
> -	wdd = &wdt->wdd;
> -	wdd->timeout = heartbeat;
> -	wdd->info = &tegra_wdt_info;
> -	wdd->ops = &tegra_wdt_ops;
> -	wdd->min_timeout = MIN_WDT_TIMEOUT;
> -	wdd->max_timeout = MAX_WDT_TIMEOUT;
> -
> -	watchdog_set_drvdata(wdd, wdt);
> -
> -	watchdog_set_nowayout(wdd, nowayout);
> -
> -	ret = watchdog_register_device(wdd);
> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"failed to register watchdog device\n");
> -		return ret;
> -	}
> -
> -	platform_set_drvdata(pdev, wdt);
> -
> -	dev_info(&pdev->dev,
> -		 "initialized (heartbeat = %d sec, nowayout = %d)\n",
> -		 heartbeat, nowayout);
> -
> -	return 0;
> -}
> -
> -static int tegra_wdt_remove(struct platform_device *pdev)
> -{
> -	struct tegra_wdt *wdt = platform_get_drvdata(pdev);
> -
> -	tegra_wdt_stop(&wdt->wdd);
> -
> -	watchdog_unregister_device(&wdt->wdd);
> -
> -	dev_info(&pdev->dev, "removed wdt\n");
> -
> -	return 0;
> -}
> -
> -#ifdef CONFIG_PM_SLEEP
> -static int tegra_wdt_runtime_suspend(struct device *dev)
> -{
> -	struct tegra_wdt *wdt = dev_get_drvdata(dev);
> -
> -	if (watchdog_active(&wdt->wdd))
> -		tegra_wdt_stop(&wdt->wdd);
> -
> -	return 0;
> -}
> -
> -static int tegra_wdt_runtime_resume(struct device *dev)
> -{
> -	struct tegra_wdt *wdt = dev_get_drvdata(dev);
> -
> -	if (watchdog_active(&wdt->wdd))
> -		tegra_wdt_start(&wdt->wdd);
> -
> -	return 0;
> -}
> -#endif
> -
> -static const struct of_device_id tegra_wdt_of_match[] = {
> -	{ .compatible = "nvidia,tegra30-timer", },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, tegra_wdt_of_match);
> -
> -static const struct dev_pm_ops tegra_wdt_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(tegra_wdt_runtime_suspend,
> -				tegra_wdt_runtime_resume)
> -};
> -
> -static struct platform_driver tegra_wdt_driver = {
> -	.probe		= tegra_wdt_probe,
> -	.remove		= tegra_wdt_remove,
> -	.driver		= {
> -		.owner	= THIS_MODULE,
> -		.name	= "tegra-wdt",
> -		.pm	= &tegra_wdt_pm_ops,
> -		.of_match_table = tegra_wdt_of_match,
> -	},
> -};
> -module_platform_driver(tegra_wdt_driver);
> -
> -MODULE_AUTHOR("NVIDIA Corporation");
> -MODULE_DESCRIPTION("Tegra Watchdog Driver");
> -MODULE_LICENSE("GPL v2");
>

