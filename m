Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35565 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbbKKX2M (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 11 Nov 2015 18:28:12 -0500
Date: Wed, 11 Nov 2015 17:28:07 -0600
From: Rob Herring <robh@kernel.org>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH 2/4] watchdog: ts4800: add new driver for TS-4800 watchdog
Message-ID: <20151111232807.GA6751@rob-hp-laptop>
References: <1445978021-13961-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1445978021-13961-3-git-send-email-damien.riegel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445978021-13961-3-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 27, 2015 at 04:33:39PM -0400, Damien Riegel wrote:
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>  .../devicetree/bindings/watchdog/ts4800-wdt.txt    |  12 ++

For the binding:

Acked-by: Rob Herring <robh@kernel.org>


>  drivers/watchdog/Kconfig                           |   9 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/ts4800_wdt.c                      | 212 +++++++++++++++++++++
>  4 files changed, 234 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
>  create mode 100644 drivers/watchdog/ts4800_wdt.c
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> new file mode 100644
> index 0000000..06bdb5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> @@ -0,0 +1,12 @@
> +Technologic Systems Watchdog
> +
> +Required properties:
> +- compatible : must be "ts,ts4800-wdt"
> +- reg : physical base address and length of memory mapped region
> +
> +Example:
> +
> +wdt1: wdt@b0010000 {
> +	compatible = "ts,ts4800-wdt";
> +	reg = <0xb0010000 0x1000>;
> +};
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 241fafd..cf30f3b 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -417,6 +417,15 @@ config NUC900_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nuc900_wdt.
>  
> +config TS4800_WATCHDOG
> +	tristate "TS-4800 Watchdog"
> +	depends on SOC_IMX51
> +	select WATCHDOG_CORE
> +	help
> +	  Technologic Systems TS-4800 has watchdog timer implemented in
> +	  an external FPGA. Say Y here if you want to support for the
> +	  watchdog timer on TS-4800 board.
> +
>  config TS72XX_WATCHDOG
>  	tristate "TS-72XX SBC Watchdog"
>  	depends on MACH_TS72XX
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 59ea9a1..435fc93 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_RN5T618_WATCHDOG) += rn5t618_wdt.o
>  obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
>  obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) += stmp3xxx_rtc_wdt.o
>  obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
> +obj-$(CONFIG_TS4800_WATCHDOG) += ts4800_wdt.o
>  obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
>  obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
>  obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
> diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
> new file mode 100644
> index 0000000..bf3badf
> --- /dev/null
> +++ b/drivers/watchdog/ts4800_wdt.c
> @@ -0,0 +1,212 @@
> +/*
> + * ts4800_wdt.c - Watchdog driver for TS-4800 based boards
> + *
> + * Copyright (c) 2015 - Savoir-faire Linux
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/watchdog.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +	"Watchdog cannot be stopped once started (default="
> +	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +
> +/* feed register is at base + 0xE */
> +#define TS4800_WTD_FEED		0xE
> +
> +/* possible feed values */
> +#define TS4800_WTD_FEED_2S	0x1
> +#define TS4800_WTD_FEED_10S	0x2
> +#define TS4800_WTD_DISABLE	0x3
> +
> +
> +struct ts4800_wdt {
> +	struct watchdog_device  wdd;
> +	void __iomem            *base;
> +	u16                     feed_val;
> +};
> +
> +/* TS-4800 supports the following timeout values:
> + *
> + *   value desc
> + *   ---------------------
> + *     0    feed for 338ms
> + *     1    feed for 2.706s
> + *     2    feed for 10.824s
> + *     3    disable watchd
> + *
> + * Keep the regmap/timeout map ordered by timeout
> + */
> +static const struct {
> +	const int timeout;
> +	const int regval;
> +} ts4800_wdt_map[] = {
> +	{ 2, 1 },
> +	{ 10, 2 },
> +};
> +
> +static int timeout_to_regval(struct watchdog_device *wdd, int new_timeout)
> +{
> +	int i;
> +
> +	new_timeout = clamp_val(new_timeout,
> +				wdd->min_timeout, wdd->max_timeout);
> +
> +	for (i = 0; i < ARRAY_SIZE(ts4800_wdt_map); i++) {
> +		if (ts4800_wdt_map[i].timeout >= new_timeout)
> +			return ts4800_wdt_map[i].timeout;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void ts4800_write_feed(struct ts4800_wdt *wdt, u16 val)
> +{
> +	__raw_writew(val, wdt->base + TS4800_WTD_FEED);
> +}
> +
> +static int ts4800_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct ts4800_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	ts4800_write_feed(wdt, wdt->feed_val);
> +	return 0;
> +}
> +
> +static int ts4800_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct ts4800_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	ts4800_write_feed(wdt, TS4800_WTD_DISABLE);
> +	return 0;
> +}
> +
> +static int ts4800_wdt_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int new_timeout)
> +{
> +	struct ts4800_wdt *wdt = watchdog_get_drvdata(wdd);
> +	int val = timeout_to_regval(wdd, new_timeout);
> +
> +	if (val < 0)
> +		return val;
> +
> +	wdt->feed_val = (u16) val;
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_ops ts4800_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	/*
> +	 * pinging the watchdog enables it, so use same function
> +	 * for pinging and starting the watchdog
> +	 */
> +	.start = ts4800_wdt_ping,
> +	.stop = ts4800_wdt_stop,
> +	.ping = ts4800_wdt_ping,
> +	.set_timeout = ts4800_wdt_set_timeout,
> +};
> +
> +static const struct watchdog_info ts4800_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
> +	.identity = "TS-4800 Watchdog",
> +};
> +
> +static int ts4800_wdt_probe(struct platform_device *pdev)
> +{
> +	int max_timeout_index = ARRAY_SIZE(ts4800_wdt_map) - 1;
> +	struct watchdog_device *wdd;
> +	struct ts4800_wdt *wdt;
> +	struct resource *res;
> +	void __iomem *regs;
> +	int ret;
> +
> +	/* get watchdog base addr */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	/* allocate memory for watchdog struct */
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	/* set watchdog base addr */
> +	wdt->base = regs;
> +
> +	/* Initialize struct watchdog_device */
> +	wdd = &wdt->wdd;
> +	wdd->info = &ts4800_wdt_info;
> +	wdd->ops = &ts4800_wdt_ops;
> +	wdd->min_timeout = ts4800_wdt_map[0].timeout;
> +	wdd->max_timeout = ts4800_wdt_map[max_timeout_index].timeout;
> +	wdd->timeout = wdd->max_timeout;
> +	wdt->feed_val = ts4800_wdt_map[max_timeout_index].regval;
> +
> +	watchdog_set_drvdata(wdd, wdt);
> +	watchdog_set_nowayout(wdd, nowayout);
> +
> +	/*
> +	 * Must be called after watchdog_set_drvdata to dereference a valid
> +	 * pointer. The feed register is write-only, so it is not possible to
> +	 * determine if watchdog is already started or not. Disable it to be in
> +	 * a known state.
> +	 */
> +	ts4800_wdt_stop(wdd);
> +
> +	ret = watchdog_register_device(wdd);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"failed to register watchdog device\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	dev_info(&pdev->dev,
> +		 "initialized (timeout = %d sec, nowayout = %d)\n",
> +		 wdd->timeout, nowayout);
> +
> +	return 0;
> +}
> +
> +static int ts4800_wdt_remove(struct platform_device *pdev)
> +{
> +	struct ts4800_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ts4800_wdt_of_match[] = {
> +	{ .compatible = "ts,ts4800-wdt", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ts4800_wdt_of_match);
> +
> +static struct platform_driver ts4800_wdt_driver = {
> +	.probe		= ts4800_wdt_probe,
> +	.remove		= ts4800_wdt_remove,
> +	.driver		= {
> +		.name	= "ts4800_wdt",
> +		.of_match_table = ts4800_wdt_of_match,
> +	},
> +};
> +
> +module_platform_driver(ts4800_wdt_driver);
> +
> +MODULE_AUTHOR("Damien Riegel <damien.riegel@savoirfairelinux.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:ts4800_wdt");
> -- 
> 2.5.0
> 
