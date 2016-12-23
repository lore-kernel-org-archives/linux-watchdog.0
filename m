Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56361 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938699AbcLWBxy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 22 Dec 2016 20:53:54 -0500
Subject: Re: [PATCH 6/6] watchdog: ts4600: add driver for TS-4600 watchdog
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com
References: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com>
 <20161214231237.17496-7-sebastien.bourdelin@savoirfairelinux.com>
Cc: mark@embeddedarm.com, kris@embeddedarm.com,
        horms+renesas@verge.net.au, treding@nvidia.com,
        jonathanh@nvidia.com, f.fainelli@gmail.com, fabio.estevam@nxp.com,
        kernel@pengutronix.de, shawnguo@kernel.org, linux@armlinux.org.uk,
        wim@iguana.be, mark.rutland@arm.com, robh+dt@kernel.org,
        damien.riegel@savoirfairelinux.com,
        lucile.quirion@savoirfairelinux.com, olof@lixom.net, arnd@arndb.de,
        suzuki.poulose@arm.com, linus.walleij@linaro.org,
        will.deacon@arm.com, yamada.masahiro@socionext.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <846414c0-f3b3-62ae-960b-56ae9edeeac8@roeck-us.net>
Date: Thu, 22 Dec 2016 17:53:17 -0800
MIME-Version: 1.0
In-Reply-To: <20161214231237.17496-7-sebastien.bourdelin@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/14/2016 03:12 PM, Sebastien Bourdelin wrote:
> This watchdog is instantiated in a FPGA and can only be access using a
> GPIOs bit-banged bus, called the NBUS by Technologic Systems.
> The watchdog is made of only one register, called the feed register.
> Writing to this register will re-arm the watchdog for a given time (and
> enable it if it was disable). It can be disabled by writing a special
> value into it.
>
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> ---
>  .../devicetree/bindings/watchdog/ts4600-wdt.txt    |  16 ++
>  arch/arm/boot/dts/imx28-ts4600-common.dtsi         |   5 +
>  drivers/watchdog/Kconfig                           |  10 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/ts4600_wdt.c                      | 213 +++++++++++++++++++++
>  5 files changed, 245 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt
>  create mode 100644 drivers/watchdog/ts4600_wdt.c
>
> diff --git a/Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt b/Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt
> new file mode 100644
> index 0000000..61d620e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt
> @@ -0,0 +1,16 @@
> +TS-4600 Technologic Systems Watchdog
> +
> +Required properties:
> +- compatible: must be "technologic,ts4600-wdt"
> +- reg: offset to the FPGA's watchdog register
> +
> +Optional property:
> +- timeout-sec: contains the watchdog timeout in seconds.
> +
> +Example:
> +
> +wdt {
> +	compatible = "technologic,ts4600-wdt";
> +	reg = <0x2a>;
> +	timeout-sec = <10>;
> +};
> diff --git a/arch/arm/boot/dts/imx28-ts4600-common.dtsi b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
> index b668933..dd7318c 100644
> --- a/arch/arm/boot/dts/imx28-ts4600-common.dtsi
> +++ b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
> @@ -116,6 +116,11 @@
>  		strobe-gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
>  		ale-gpios    = <&gpio0 26 GPIO_ACTIVE_HIGH>;
>  		rdy-gpios    = <&gpio0 21 GPIO_ACTIVE_HIGH>;
> +
> +		wdt@2a {
> +			compatible = "technologic,ts4600-wdt";
> +			reg = <0x2a>;
> +		};
>  	};
>
>  };
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 3eb58cb..7a8e176 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -500,6 +500,16 @@ config NUC900_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nuc900_wdt.
>
> +config TS4600_WATCHDOG
> +	tristate "TS-4600 Watchdog"
> +	depends on HAS_IOMEM && OF
> +	depends on SOC_IMX28 || COMPILE_TEST

Asd 0day reports, this does not work.

> +	select WATCHDOG_CORE
> +	help
> +	  Technologic Systems TS-4600 has watchdog timer implemented in
> +	  an external FPGA. Say Y here if you want to support for the
> +	  watchdog timer on TS-4600 board.
> +
>  config TS4800_WATCHDOG
>  	tristate "TS-4800 Watchdog"
>  	depends on HAS_IOMEM && OF
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index caa9f4a..d4b4bd2 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_RN5T618_WATCHDOG) += rn5t618_wdt.o
>  obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
>  obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) += stmp3xxx_rtc_wdt.o
>  obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
> +obj-$(CONFIG_TS4600_WATCHDOG) += ts4600_wdt.o
>  obj-$(CONFIG_TS4800_WATCHDOG) += ts4800_wdt.o
>  obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
>  obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
> diff --git a/drivers/watchdog/ts4600_wdt.c b/drivers/watchdog/ts4600_wdt.c
> new file mode 100644
> index 0000000..db91b40
> --- /dev/null
> +++ b/drivers/watchdog/ts4600_wdt.c
> @@ -0,0 +1,213 @@
> +/*
> + * Watchdog driver for TS-4600 based boards
> + *
> + * Copyright (c) 2016 - Savoir-faire Linux
> + * Author: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * The watchdog on the TS-4600 based boards is in an FPGA and can only be
> + * accessed using a GPIO bit-banged bus called the NBUS by Technologic Systems.
> + * The logic for the watchdog is the same then for the TS-4800 SoM, only the way
> + * to access it change, therefore this driver is heavely based on the ts4800_wdt
> + * driver from Damien Riegel <damien.riegel@savoirfairelinux.com>.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/ts-nbus.h>
> +#include <linux/watchdog.h>
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +	"Watchdog cannot be stopped once started (default="
> +	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +/* possible feed values */
> +#define TS4600_WDT_FEED_2S       0x1
> +#define TS4600_WDT_FEED_10S      0x2
> +#define TS4600_WDT_DISABLE       0x3
> +
> +struct ts4600_wdt {
> +	struct watchdog_device  wdd;
> +	u32                     feed_offset;
> +	u32                     feed_val;
> +};
> +
> +/*
> + * TS-4600 supports the following timeout values:
> + *
> + *   value desc
> + *   ---------------------
> + *     0    feed for 338ms
> + *     1    feed for 2.706s
> + *     2    feed for 10.824s
> + *     3    disable watchdog
> + *
> + * Keep the regmap/timeout map ordered by timeout
> + */
> +static const struct {
> +	const int timeout;
> +	const int regval;
> +} ts4600_wdt_map[] = {
> +	{ 2,  TS4600_WDT_FEED_2S },
> +	{ 10, TS4600_WDT_FEED_10S },
> +};
> +
> +#define MAX_TIMEOUT_INDEX       (ARRAY_SIZE(ts4600_wdt_map) - 1)
> +
> +static void ts4600_write_feed(struct ts4600_wdt *wdt, u32 val)
> +{
> +	ts_nbus_write(wdt->feed_offset, val);
> +}
> +
> +static int ts4600_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct ts4600_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	ts4600_write_feed(wdt, wdt->feed_val);
> +
> +	return 0;
> +}
> +
> +static int ts4600_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct ts4600_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	ts4600_write_feed(wdt, TS4600_WDT_DISABLE);
> +	return 0;
> +}
> +
> +static int ts4600_wdt_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int timeout)
> +{
> +	struct ts4600_wdt *wdt = watchdog_get_drvdata(wdd);
> +	int i;
> +
> +	for (i = 0; i < MAX_TIMEOUT_INDEX; i++) {
> +		if (ts4600_wdt_map[i].timeout >= timeout)
> +			break;
> +	}

An if/else would be much simpler here.

> +
> +	wdd->timeout = ts4600_wdt_map[i].timeout;
> +	wdt->feed_val = ts4600_wdt_map[i].regval;
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_ops ts4600_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = ts4600_wdt_start,
> +	.stop = ts4600_wdt_stop,
> +	.set_timeout = ts4600_wdt_set_timeout,
> +};
> +
> +static const struct watchdog_info ts4600_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
> +	.identity = "TS-4600 Watchdog",
> +};
> +
> +static int ts4600_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct watchdog_device *wdd;
> +	struct ts4600_wdt *wdt;
> +	u32 reg;
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "reg", &reg);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "missing reg property\n");
> +		return ret;
> +	}
> +
> +	/* check for the NBUS state and defer the probing if it is not ready */
> +	if (!ts_nbus_is_ready())
> +		return -EPROBE_DEFER;
> +
> +	/* allocate memory for watchdog struct */
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	/* set offset to know where to write */
> +	wdt->feed_offset = reg;
> +
> +	/* Initialize struct watchdog_device */
> +	wdd = &wdt->wdd;
> +	wdd->parent = &pdev->dev;
> +	wdd->info = &ts4600_wdt_info;
> +	wdd->ops = &ts4600_wdt_ops;
> +	wdd->min_timeout = ts4600_wdt_map[0].timeout;
> +	wdd->max_timeout = ts4600_wdt_map[MAX_TIMEOUT_INDEX].timeout;
> +

Your call, but it might be better and more flexible to just use a single
hardware timeout (such as the 2.x second one), provide it here as
max_hw_heartbeat_ms, and let the kernel handle the actual (and larger)
timeouts.

> +	watchdog_set_drvdata(wdd, wdt);
> +	watchdog_set_nowayout(wdd, nowayout);
> +	watchdog_init_timeout(wdd, 0, &pdev->dev);
> +
> +	/*
> +	 * As this watchdog supports only a few values, ts4600_wdt_set_timeout
> +	 * must be called to initialize timeout and feed_val with valid values.
> +	 * Default to maximum timeout if none, or an invalid one, is provided in
> +	 * device tree.
> +	 */
> +	if (!wdd->timeout)
> +		wdd->timeout = wdd->max_timeout;
> +	ts4600_wdt_set_timeout(wdd, wdd->timeout);
> +
> +	/*
> +	 * The feed register is write-only, so it is not possible to determine
> +	 * watchdog's state. Disable it to be in a known state.
> +	 */
> +	ts4600_wdt_stop(wdd);
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
> +static int ts4600_wdt_remove(struct platform_device *pdev)
> +{
> +	struct ts4600_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ts4600_wdt_of_match[] = {
> +	{ .compatible = "technologic,ts4600-wdt", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ts4600_wdt_of_match);
> +
> +static struct platform_driver ts4600_wdt_driver = {
> +	.probe		= ts4600_wdt_probe,
> +	.remove		= ts4600_wdt_remove,
> +	.driver		= {
> +		.name	= "ts4600_wdt",
> +		.of_match_table = ts4600_wdt_of_match,
> +	},
> +};
> +
> +module_platform_driver(ts4600_wdt_driver);
> +
> +MODULE_AUTHOR("Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:ts4600_wdt");
>

