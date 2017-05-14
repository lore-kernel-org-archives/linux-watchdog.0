Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34279 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754730AbdENOkn (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 May 2017 10:40:43 -0400
Subject: Re: [PATCH v3 6/6] watchdog: ts4600: add driver for TS-4600 watchdog
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com, robh@kernel.org,
        linus.walleij@linaro.org, shawnguo@kernel.org
References: <20170505193259.16517-1-sebastien.bourdelin@savoirfairelinux.com>
 <20170505193259.16517-7-sebastien.bourdelin@savoirfairelinux.com>
Cc: fabio.estevam@nxp.com, mark@embeddedarm.com, kris@embeddedarm.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <158eee74-0031-967a-a7ea-f6e08defa96f@roeck-us.net>
Date: Sun, 14 May 2017 07:40:38 -0700
MIME-Version: 1.0
In-Reply-To: <20170505193259.16517-7-sebastien.bourdelin@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/05/2017 12:32 PM, Sebastien Bourdelin wrote:
> This watchdog is instantiated in a FPGA and can only be access using a
> GPIOs bit-banged bus, called the NBUS by Technologic Systems.
> The watchdog is made of only one register, called the feed register.
> Writing to this register will re-arm the watchdog for a given time (and
> enable it if it was disable). It can be disabled by writing a special
> value into it.
>
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

When you send v4, please retain unless you make other changes.

Thanks,
Guenter

> ---
> Changes v2 -> v3:
>   - rebase on master
>   - remove the timeout table to simplify the logic (suggested by
>   Guenter Roeck)
>   - fix the set_timeout function (suggested by Guenter Roeck)
>   - hardcode the max_hw_heartbeat_ms value based on the ts4600 max
>   timeout value supported (suggested by Guenter Roeck)
>   - remove the max_timeout usage and set a default timeout value
> (suggested by Guenter Roeck)
>   - use the devm_watchdog_register_device function instead of
>   watchdog_register_device (suggested by Guenter Roeck)
>
> Changes v1 -> v2:
>   - rebase on master
>   - retrieve the ts_nbus instantiated by the parent node (suggested by
>   Linus Walleij)
>   - rename the wdt by watchdog in the device tree and in the
>   documentation (suggested by Rob Herring)
>   - add a dependency to the TS_NBUS driver in the Kconfig (suggested by
>   Guenter Roeck)
>   - simplify the set_timeout function (suggested by Guenter Roeck)
>   - use the max_hw_heartbeat_ms callback instead of the max_timeout
>   callback (suggested by Guenter Roeck)
> ---
>  .../devicetree/bindings/watchdog/ts4600-wdt.txt    |  16 ++
>  arch/arm/boot/dts/imx28-ts4600-common.dtsi         |   5 +
>  drivers/watchdog/Kconfig                           |  11 ++
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/ts4600_wdt.c                      | 185 +++++++++++++++++++++
>  5 files changed, 218 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt
>  create mode 100644 drivers/watchdog/ts4600_wdt.c
>
> diff --git a/Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt b/Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt
> new file mode 100644
> index 000000000000..7de00ceae341
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
> +watchdog {
> +	compatible = "technologic,ts4600-wdt";
> +	reg = <0x2a>;
> +	timeout-sec = <10>;
> +};
> diff --git a/arch/arm/boot/dts/imx28-ts4600-common.dtsi b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
> index c6282d5479de..092c2eed0fe7 100644
> --- a/arch/arm/boot/dts/imx28-ts4600-common.dtsi
> +++ b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
> @@ -116,6 +116,11 @@
>  		ts-strobe-gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
>  		ts-ale-gpios    = <&gpio0 26 GPIO_ACTIVE_HIGH>;
>  		ts-rdy-gpios    = <&gpio0 21 GPIO_ACTIVE_HIGH>;
> +
> +		watchdog@2a {
> +			compatible = "technologic,ts4600-wdt";
> +			reg = <0x2a>;
> +		};
>  	};
>
>  };
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 52a70ee6014f..408ad7c92cb3 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -520,6 +520,17 @@ config NUC900_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nuc900_wdt.
>
> +config TS4600_WATCHDOG
> +	tristate "TS-4600 Watchdog"
> +	depends on TS_NBUS
> +	depends on HAS_IOMEM && OF
> +	depends on SOC_IMX28 || COMPILE_TEST
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
> index a2126e2a99ae..19553f27061a 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_RN5T618_WATCHDOG) += rn5t618_wdt.o
>  obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
>  obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) += stmp3xxx_rtc_wdt.o
>  obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
> +obj-$(CONFIG_TS4600_WATCHDOG) += ts4600_wdt.o
>  obj-$(CONFIG_TS4800_WATCHDOG) += ts4800_wdt.o
>  obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
>  obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
> diff --git a/drivers/watchdog/ts4600_wdt.c b/drivers/watchdog/ts4600_wdt.c
> new file mode 100644
> index 000000000000..ed530dd2f800
> --- /dev/null
> +++ b/drivers/watchdog/ts4600_wdt.c
> @@ -0,0 +1,185 @@
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
> +/*
> + * TS-4600 supports the following timeout values:
> + *
> + *   value desc
> + *   ---------------------
> + *     0    feed for 338ms
> + *     1    feed for 2.706s
> + *     2    feed for 10.824s
> + *     3    disable watchdog
> + */
> +#define TS4600_WDT_FEED_2S       0x1
> +#define TS4600_WDT_FEED_10S      0x2
> +#define TS4600_WDT_DISABLE       0x3
> +
> +struct ts4600_wdt {
> +	struct watchdog_device  wdd;
> +	struct ts_nbus		*ts_nbus;
> +	u32                     feed_offset;
> +	u32                     feed_val;
> +};
> +
> +static void ts4600_write_feed(struct ts4600_wdt *wdt, u32 val)
> +{
> +	ts_nbus_write(wdt->ts_nbus, wdt->feed_offset, val);
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
> +
> +	if (timeout <= 2) {
> +		wdd->timeout = 2;
> +		wdt->feed_val = TS4600_WDT_FEED_2S;
> +	} else {
> +		wdd->timeout = timeout < 10 ? 10 : timeout;
> +		wdt->feed_val = TS4600_WDT_FEED_10S;
> +	}
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
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct ts_nbus *ts_nbus;
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
> +	/* allocate memory for watchdog struct */
> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	/* set offset to know where to write */
> +	wdt->feed_offset = reg;
> +
> +	/* keep a pointer to the ts_nbus instanciated by the parent node */
> +	ts_nbus = dev_get_drvdata(dev->parent);
> +	if (!ts_nbus) {
> +		dev_err(dev, "missing ts-nbus compatible parent node\n");
> +		return PTR_ERR(ts_nbus);
> +	}
> +	wdt->ts_nbus = ts_nbus;
> +
> +	/* Initialize struct watchdog_device */
> +	wdd = &wdt->wdd;
> +	wdd->parent = dev;
> +	wdd->info = &ts4600_wdt_info;
> +	wdd->ops = &ts4600_wdt_ops;
> +	wdd->min_timeout = 2;
> +	wdd->max_hw_heartbeat_ms = 10824;
> +	wdd->timeout = 30;
> +
> +	watchdog_set_drvdata(wdd, wdt);
> +	watchdog_set_nowayout(wdd, nowayout);
> +	watchdog_init_timeout(wdd, 0, dev);
> +
> +	ts4600_wdt_set_timeout(wdd, wdd->timeout);
> +
> +	/*
> +	 * The feed register is write-only, so it is not possible to determine
> +	 * watchdog's state. Disable it to be in a known state.
> +	 */
> +	ts4600_wdt_stop(wdd);
> +
> +	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
> +	if (ret) {
> +		dev_err(dev, "failed to register watchdog device\n");
> +		return ret;
> +	}
> +
> +	dev_info(dev, "initialized (timeout = %d sec, nowayout = %d)\n",
> +		 wdd->timeout, nowayout);
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

