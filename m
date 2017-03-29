Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37555 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbdC2DPT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Mar 2017 23:15:19 -0400
Subject: Re: [PATCH v3 2/5] drivers: watchdog: Add STM32 IWDG driver
To: Yannick Fertre <yannick.fertre@st.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
References: <1490195083-25117-1-git-send-email-yannick.fertre@st.com>
 <1490195083-25117-3-git-send-email-yannick.fertre@st.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philippe Cornu <philippe.cornu@st.com>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ac425e69-2d3c-2257-7183-115fbe9eb2b0@roeck-us.net>
Date: Tue, 28 Mar 2017 20:15:15 -0700
MIME-Version: 1.0
In-Reply-To: <1490195083-25117-3-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/22/2017 08:04 AM, Yannick Fertre wrote:
> This patch adds IWDG (Independent WatchDoG) support for STM32 platform.
>
> Change-Id: Iab218745fc25566f12558fae7f52e2f8c21db74e

No gerrit tags, please.

> Signed-off-by: Yannick FERTRE <yannick.fertre@st.com>
> ---
>  drivers/watchdog/Kconfig      |  11 ++
>  drivers/watchdog/Makefile     |   1 +
>  drivers/watchdog/stm32_iwdg.c | 289 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 301 insertions(+)
>  create mode 100644 drivers/watchdog/stm32_iwdg.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 52a70ee..d9745a5 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -744,6 +744,17 @@ config ZX2967_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called zx2967_wdt.
>
> +config STM32_WATCHDOG
> +	tristate "STM32 Independent WatchDoG (IWDG) support"
> +	depends on ARCH_STM32
> +	select WATCHDOG_CORE
> +	default y
> +	help
> +	  Say Y here to include Watchdog timer support.

... for <pick your text>.

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called stm32_iwdg.
> +
>  # AVR32 Architecture
>
>  config AT32AP700X_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index a2126e2..a35e423 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
>  obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
>  obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
>  obj-$(CONFIG_ZX2967_WATCHDOG) += zx2967_wdt.o
> +obj-$(CONFIG_STM32_WATCHDOG) += stm32_iwdg.o
>
>  # AVR32 Architecture
>  obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> new file mode 100644
> index 0000000..507dfc4
> --- /dev/null
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -0,0 +1,289 @@
> +/*
> + * Driver for STM32 Independent Watchdog
> + *
> + * Copyright (C) Yannick Fertre 2017
> + * Author: Yannick Fertre <yannick.fertre@st.com>
> + *
> + * This driver is based on tegra_wdt.c
> + *
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +
> +/* minimum watchdog trigger timeout, in seconds */
> +#define MIN_WDT_TIMEOUT	1
> +
> +/* IWDG registers */
> +#define IWDG_KR		0x00 /* Key register */
> +#define IWDG_PR		0x04 /* Prescaler Register */
> +#define IWDG_RLR	0x08 /* ReLoad Register */
> +#define IWDG_SR		0x0C /* Status Register */
> +#define IWDG_WINR	0x10 /* Windows Register */
> +
> +/* IWDG_KR register bit mask */
> +#define KR_KEY_RELOAD	0xAAAA /* reload counter enable */
> +#define KR_KEY_ENABLE	0xCCCC /* peripheral enable */
> +#define KR_KEY_EWA	0x5555 /* write access enable */
> +#define KR_KEY_DWA	0x0000 /* write access disable */
> +
> +/* IWDG_PR register bit values */
> +#define PR_4    0x00 /* prescaler set to 4 */
> +#define PR_8    0x01 /* prescaler set to 8 */
> +#define PR_16   0x02 /* prescaler set to 16 */
> +#define PR_32   0x03 /* prescaler set to 32 */
> +#define PR_64   0x04 /* prescaler set to 64 */
> +#define PR_128  0x05 /* prescaler set to 128 */
> +#define PR_256	0x06 /* prescaler set to 256 */
> +
> +/* IWDG_RLR register values */
> +#define RLR_MAX		0xFFF /* max value supported by reload register */
> +
> +/* IWDG_SR register bit mask */
> +#define FLAG_PVU	BIT(0) /* Watchdog prescaler value update */
> +#define FLAG_RVU	BIT(1) /* Watchdog counter reload value update */
> +
> +/* set timeout to 100000 us */
> +#define TIMEOUT_US	100000
> +#define SLEEP_US	1000
> +
> +struct stm32_iwdg {
> +	struct watchdog_device	wdd;
> +	struct device		*dev;
> +	void __iomem		*regs;
> +	struct clk		*clk;
> +	unsigned int		rate;
> +};
> +
> +static int heartbeat = MIN_WDT_TIMEOUT;
> +module_param(heartbeat, int, 0x0);
> +MODULE_PARM_DESC(heartbeat,
> +		 "Watchdog heartbeats in seconds. (default = "
> +		 __MODULE_STRING(WDT_HEARTBEAT) ")");
> +
> +static inline u32 reg_read(void __iomem *base, u32 reg)
> +{
> +	return readl_relaxed(base + reg);
> +}
> +
> +static inline void reg_write(void __iomem *base, u32 reg, u32 val)
> +{
> +	writel_relaxed(val, base + reg);
> +}
> +
> +static int stm32_iwdg_start(struct watchdog_device *wdd)
> +{
> +	struct stm32_iwdg *wdt = watchdog_get_drvdata(wdd);
> +	u32 val = FLAG_PVU | FLAG_RVU;
> +	u32 reload;
> +	int ret;
> +
> +	dev_dbg(wdt->dev, "%s\n", __func__);
> +
> +	/* prescaler fixed to 256 */
> +	reload = (wdd->timeout * wdt->rate) / 256;
> +	if (reload > RLR_MAX + 1) {
> +		dev_err(wdt->dev,
> +			"Watchdog doesn't support reload value: %d\n", reload);
> +		return -EINVAL;
> +	}

This should not happen if min_timeout and max_timeout are set properly.

> +
> +	/* enable watchdog */
> +	reg_write(wdt->regs, IWDG_KR, KR_KEY_ENABLE);
> +
> +	/* set prescaler & reload registers */
> +	reg_write(wdt->regs, IWDG_KR, KR_KEY_EWA);
> +	reg_write(wdt->regs, IWDG_PR, PR_256); /* prescaler fix to 256 */
> +	reg_write(wdt->regs, IWDG_RLR, reload - 1);
> +
> +	/* wait for the registers to be updated (max 100ms) */
> +	ret = readl_relaxed_poll_timeout(wdt->regs + IWDG_SR, val,
> +					 !(val & (FLAG_PVU | FLAG_RVU)),
> +					 SLEEP_US, TIMEOUT_US);
> +	if (ret) {
> +		dev_err(wdt->dev,
> +			"Fail to set prescaler or reload registers\n");
> +		return -EINVAL;

Any reason for overriding the return value ?

> +	}
> +
> +	/* reload watchdog */
> +	reg_write(wdt->regs, IWDG_KR, KR_KEY_RELOAD);
> +
> +	return 0;
> +}
> +
> +static int stm32_iwdg_stop(struct watchdog_device *wdd)
> +{
> +	struct stm32_iwdg *wdt = watchdog_get_drvdata(wdd);
> +
> +	if (watchdog_active(wdd)) {
> +		dev_err(wdt->dev,
> +			"Watchdog can't be stopped once started(no way out)\n");
> +		return -EPERM;

The infrastructure takes care of this. Don't provide a stop function, and provide
the maximum hardware timeout.

> +	}
> +
> +	return 0;
> +}
> +
> +static int stm32_iwdg_ping(struct watchdog_device *wdd)
> +{
> +	struct stm32_iwdg *wdt = watchdog_get_drvdata(wdd);
> +
> +	dev_dbg(wdt->dev, "%s\n", __func__);
> +
> +	reg_write(wdt->regs, IWDG_KR, KR_KEY_RELOAD);
> +
> +	return 0;
> +}
> +
> +static int stm32_iwdg_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int timeout)
> +{
> +	struct stm32_iwdg *wdt = watchdog_get_drvdata(wdd);
> +
> +	dev_dbg(wdt->dev, "%s timeout: %d sec\n", __func__, timeout);
> +
> +	wdd->timeout = timeout;
> +
> +	if (watchdog_active(wdd))
> +		return stm32_iwdg_start(wdd);
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info stm32_iwdg_info = {
> +	.options	= WDIOF_SETTIMEOUT |
> +			  WDIOF_MAGICCLOSE |
> +			  WDIOF_KEEPALIVEPING,
> +	.identity	= "STM32 Independent Watchdog",
> +};
> +
> +static struct watchdog_ops stm32_iwdg_ops = {
> +	.owner		= THIS_MODULE,
> +	.start		= stm32_iwdg_start,
> +	.stop		= stm32_iwdg_stop,
> +	.ping		= stm32_iwdg_ping,
> +	.set_timeout	= stm32_iwdg_set_timeout,
> +};
> +
> +static int stm32_iwdg_probe(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdd;
> +	struct stm32_iwdg *wdt;
> +	struct resource *res;
> +	void __iomem *regs;
> +	struct clk *clk;
> +	int max_wdt_timeout;
> +	int ret;
> +
> +	/* This is the timer base. */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(regs)) {
> +		dev_err(&pdev->dev, "Could not get resource\n");
> +		return PTR_ERR(regs);
> +	}
> +
> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "Unable to get clock\n");
> +		return PTR_ERR(clk);
> +	}
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to prepare clock %p\n", clk);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Allocate our watchdog driver data, which has the
> +	 * struct watchdog_device nested within it.
> +	 */
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	/* Initialize struct stm32_iwdg. */
> +	wdt->regs = regs;
> +	wdt->dev = &pdev->dev;
> +	wdt->clk = clk;
> +	/*
> +	 * iwdg is clocked by its own dedicated low-speed clock (LSI)
> +	 * at 32khz.
> +	 */
> +	wdt->rate = 32 * 1024;

Why not clk_get_rate() ?

> +
> +	/* get max timeout & set heartbeat */
> +	max_wdt_timeout = ((RLR_MAX + 1) * 256) / wdt->rate;
> +	heartbeat = max_wdt_timeout;

What is the value of overwriting this variable ? Why don't you just use max_wdt_timeout,
and what is the point of making heartbeat configurable if you overwrite it anyway ?

I would suggest to use watchdog_init_timeout() to set optional non-default
timeout values, especially since this also enables getting the timeout value from
devicetree.

> +
> +	/* Initialize struct watchdog_device. */
> +	wdd = &wdt->wdd;
> +	wdd->timeout = heartbeat;
> +	wdd->info = &stm32_iwdg_info;
> +	wdd->ops = &stm32_iwdg_ops;
> +	wdd->min_timeout = MIN_WDT_TIMEOUT;
> +	wdd->max_timeout = max_wdt_timeout;

You might want to consider setting max_hw_heartbeat_ms instead and drop the stop function.

> +	watchdog_set_drvdata(wdd, wdt);
> +	watchdog_set_nowayout(wdd, true);
> +
> +	ret = watchdog_register_device(wdd);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"failed to register watchdog device\n");
> +		goto err;
> +	}
> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	dev_info(&pdev->dev,
> +		 "initialized (heartbeat = %d sec)\n", heartbeat);
> +	return 0;
> +
> +err:
> +	clk_disable_unprepare(clk);
> +	return ret;
> +}
> +
> +static int stm32_iwdg_remove(struct platform_device *pdev)
> +{
> +	struct stm32_iwdg *wdt = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&wdt->wdd);
> +	clk_disable_unprepare(wdt->clk);
> +
> +	dev_info(&pdev->dev, "removed watchdog device\n");

Is this message really useful ? I think it is just noise.

> +	return 0;
> +}
> +
> +static const struct of_device_id stm32_iwdg_of_match[] = {
> +	{ .compatible = "st,stm32-iwdg" },
> +	{ /* end node */ }
> +};
> +MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
> +
> +static struct platform_driver stm32_iwdg_driver = {
> +	.probe		= stm32_iwdg_probe,
> +	.remove		= stm32_iwdg_remove,
> +	.driver = {
> +		.name	= "iwdg",
> +		.of_match_table = stm32_iwdg_of_match,
> +	},
> +};
> +module_platform_driver(stm32_iwdg_driver);
> +
> +MODULE_AUTHOR("Yannick Fertre <yannick.fertre@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics STM32 Independent Watchdog Driver");
> +MODULE_LICENSE("GPL v2");
>

