Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48689 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbbKQR4t (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 Nov 2015 12:56:49 -0500
Subject: Re: [PATCH v3 3/5] watchdog: ts4800: add driver for TS-4800 watchdog
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
References: <1447700814-5391-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1447700814-5391-4-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	robh+dt@kernel.org, sameo@linux.intel.com, lee.jones@linaro.org,
	dinh.linux@gmail.com, kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564B6A5C.8020400@roeck-us.net>
Date: Tue, 17 Nov 2015 09:56:44 -0800
MIME-Version: 1.0
In-Reply-To: <1447700814-5391-4-git-send-email-damien.riegel@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/16/2015 11:06 AM, Damien Riegel wrote:
> This watchdog is instantiated in a FPGA that is memory mapped. It is
> made of only one register, called the feed register. Writing to this
> register will re-arm the watchdog for a given time (and enable it if it
> was disable). It can be disabled by writing a special value into it.
>
> It is part of a syscon block, and the watchdog register offset in this
> block varies from board to board. This offset is passed in the syscon
> property after the phandle to the syscon node.
>
> This watchdog is present on several of Technologic Systems' boards, and
> having a kernel driver allows to use these boards without relying on a
> userspace tool to ping their watchdog.
>

Last part should be obvious.

> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>   .../devicetree/bindings/watchdog/ts4800-wdt.txt    |  21 ++
>   drivers/watchdog/Kconfig                           |  10 +
>   drivers/watchdog/Makefile                          |   1 +
>   drivers/watchdog/ts4800_wdt.c                      | 219 +++++++++++++++++++++
>   4 files changed, 251 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
>   create mode 100644 drivers/watchdog/ts4800_wdt.c
>
> diff --git a/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> new file mode 100644
> index 0000000..7d5dcfb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> @@ -0,0 +1,21 @@
> +Technologic Systems Watchdog
> +
> +Required properties:
> +- compatible: must be "technologic,ts4800-wdt"
> +- syscon: phandle / integer array that points to the syscon node which
> +          describes the FPGA's syscon registers.
> +          - phandle to FPGA's syscon
> +          - offset to the watchdog register
> +
> +Example:
> +
> +syscon: syscon@b0010000 {
> +	compatible = "syscon", "simple-mfd";
> +	reg = <0xb0010000 0x3d>;
> +	bus-width = <16>;
> +
> +	wdt@e {
> +		compatible = "technologic,ts4800-wdt";
> +		syscon = <&syscon 0xe>;
> +	};
> +}
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 79e1aa1..2914594 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -426,6 +426,16 @@ config NUC900_WATCHDOG
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called nuc900_wdt.
>
> +config TS4800_WATCHDOG
> +	tristate "TS-4800 Watchdog"
> +	depends on OF
> +	select WATCHDOG_CORE
> +	select MFD_SYSCON
> +	help
> +	  Technologic Systems TS-4800 has watchdog timer implemented in
> +	  an external FPGA. Say Y here if you want to support for the
> +	  watchdog timer on TS-4800 board.
> +
>   config TS72XX_WATCHDOG
>   	tristate "TS-72XX SBC Watchdog"
>   	depends on MACH_TS72XX
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 0c616e3..3863ce0 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_RN5T618_WATCHDOG) += rn5t618_wdt.o
>   obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
>   obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) += stmp3xxx_rtc_wdt.o
>   obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
> +obj-$(CONFIG_TS4800_WATCHDOG) += ts4800_wdt.o
>   obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
>   obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
>   obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
> diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
> new file mode 100644
> index 0000000..658d0ca
> --- /dev/null
> +++ b/drivers/watchdog/ts4800_wdt.c
> @@ -0,0 +1,219 @@
> +/*
> + * Watchdog driver for TS-4800 based boards
> + *
> + * Copyright (c) 2015 - Savoir-faire Linux
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/watchdog.h>
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +	"Watchdog cannot be stopped once started (default="
> +	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +/* possible feed values */
> +#define TS4800_WDT_FEED_2S       0x1
> +#define TS4800_WDT_FEED_10S      0x2
> +#define TS4800_WDT_DISABLE       0x3
> +
> +struct ts4800_wdt {
> +	struct watchdog_device  wdd;
> +	struct regmap           *regmap;
> +	u32                     feed_offset;
> +	u16                     feed_val;

u16 doesn't save you anything here. In many cases it actually makes
the code more complex. Might as well use u32.

> +};
> +
> +/*
> + * TS-4800 supports the following timeout values:
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
> +} ts4800_wdt_map[] = {
> +	{ 2,  TS4800_WDT_FEED_2S },
> +	{ 10, TS4800_WDT_FEED_10S },
> +};
> +
> +static int timeout_to_regval(struct watchdog_device *wdd, int new_timeout)
> +{
> +	int i;
> +
> +	new_timeout = clamp_val(new_timeout,
> +				wdd->min_timeout, wdd->max_timeout);
> +
This should not be necessary. The value is already checked by the infrastructure.

> +	for (i = 0; i < ARRAY_SIZE(ts4800_wdt_map); i++) {
> +		if (ts4800_wdt_map[i].timeout >= new_timeout)
> +			return ts4800_wdt_map[i].timeout;
> +	}
> +
> +	return -EINVAL;

I think it would be easier here to just return TS4800_WDT_FEED_10S.

Overall, there are three "defenses" against bad values:
The infrastructure code, the clamp_val above, and the error return here.
One should be enough.

> +}
> +
> +static void ts4800_write_feed(struct ts4800_wdt *wdt, u16 val)
> +{
> +	regmap_write(wdt->regmap, wdt->feed_offset, val);
> +}
> +
> +static int ts4800_wdt_start(struct watchdog_device *wdd)
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
> +	ts4800_write_feed(wdt, TS4800_WDT_DISABLE);
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
This should never happen, since the range was already verified by the infrastructure.
Another reason to not return an error from timeout_to_regval().

> +	wdt->feed_val = (u16) val;
> +
Then you could just make this

	wdt->feed_val = timeout_to_regval(wdd, new_timeout);

Also, you need to set the timeout value in the wdd structure to the actually
selected timeout, to let user space know which timeout was selected.

	wdt->timeout = ???;

This can be important in situations where the requested timeout is, say,
3 seconds, but the code actually sets it to 10 seconds. User space might
need to know about that.

> +	return 0;
> +}
> +
> +static const struct watchdog_ops ts4800_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = ts4800_wdt_start,
> +	.stop = ts4800_wdt_stop,
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
> +	const int max_timeout_index = ARRAY_SIZE(ts4800_wdt_map) - 1;

Might as well use

#define MAX_TIMEOUT_INDEX	(ARRAY_SIZE(ts4800_wdt_map) - 1)

and reduce runtime complexity.

> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *syscon_np;
> +	struct watchdog_device *wdd;
> +	struct ts4800_wdt *wdt;
> +	u32 reg;
> +	int ret;
> +
> +	syscon_np = of_parse_phandle(np, "syscon", 0);
> +	if (!syscon_np) {
> +		dev_err(&pdev->dev, "no syscon property\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_property_read_u32_index(np, "syscon", 1, &reg);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "no offset in syscon\n");
> +		return -EINVAL;

return -EINVAL or ret ? I think some static checkers may complain
if you don't return ret.

> +	}
> +
> +	/* allocate memory for watchdog struct */
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	/* set regmap and offset to know where to write */
> +	wdt->feed_offset = reg;
> +	wdt->regmap = syscon_node_to_regmap(syscon_np);
> +	if (!wdt->regmap) {

syscon_node_to_regmap() returns an error pointer.

> +		dev_err(&pdev->dev, "cannot get parent's regmap\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Initialize struct watchdog_device */
> +	wdd = &wdt->wdd;
> +	wdd->parent = &pdev->dev;
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

Calling watchdog_init_timeout() might be useful as well, to get a timeout value
from devicetree if provided.

> +	/*
> +	 * Must be called after watchdog_set_drvdata to dereference a valid
> +	 * pointer. The feed register is write-only, so it is not possible to
> +	 * determine if watchdog is already started or not. Disable it to be in
> +	 * a known state.

Annoying :-(. I keep wondering who comes up with those HW implementations.

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
> +	{ .compatible = "technologic,ts4800-wdt", },
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
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:ts4800_wdt");
>

