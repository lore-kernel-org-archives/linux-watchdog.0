Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47845 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdCDPQa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 4 Mar 2017 10:16:30 -0500
Subject: Re: [PATCH v5 1/3] watchdog: add rza_wdt driver
To: Chris Brandt <chris.brandt@renesas.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20170303173201.5597-1-chris.brandt@renesas.com>
 <20170303173201.5597-2-chris.brandt@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <64cc8948-1940-f219-fb87-800b3d617030@roeck-us.net>
Date: Sat, 4 Mar 2017 07:14:57 -0800
MIME-Version: 1.0
In-Reply-To: <20170303173201.5597-2-chris.brandt@renesas.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/03/2017 09:31 AM, Chris Brandt wrote:
> Adds a watchdog timer driver for the Renesas RZ/A Series SoCs. A reset
> handler is also included since a WDT overflow is the only method for
> restarting an RZ/A SoC.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
> v2:
> * removed extra lines from file header comments
> * changed (1<<#) to BIT(#)
> * changed #define WTSCR_CKS(i) i to (i)
> * changed format to #define SOMETHING<tab>value (and align values)
> * now check if clock rate < 16384
> * added space before and after '/' for "(1000 * U8_MAX) / rate"
> * changed dev_info to dev_dbg for printing max_hw_heartbeat_ms
> * added watchdog_init_timeout() for user to set timeout in DT
> * switched to using devm_watchdog_register_device()
> * added error message if register fails
> * simplified rza_wdt_probe() return
> * removed function rza_wdt_remove()
> ---
>  drivers/watchdog/Kconfig   |   8 ++
>  drivers/watchdog/Makefile  |   1 +
>  drivers/watchdog/rza_wdt.c | 199 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 208 insertions(+)
>  create mode 100644 drivers/watchdog/rza_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index acb00b5..123c516 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -701,6 +701,14 @@ config RENESAS_WDT
>  	  This driver adds watchdog support for the integrated watchdogs in the
>  	  Renesas R-Car and other SH-Mobile SoCs (usually named RWDT or SWDT).
>
> +config RENESAS_RZAWDT
> +	tristate "Renesas RZ/A WDT Watchdog"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	select WATCHDOG_CORE
> +	help
> +	  This driver adds watchdog support for the integrated watchdogs in the
> +	  Renesas RZ/A SoCs. These watchdogs can be used to reset a system.
> +
>  config ASPEED_WATCHDOG
>  	tristate "Aspeed 2400 watchdog support"
>  	depends on ARCH_ASPEED || COMPILE_TEST
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 0c3d35e..84b897c 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -81,6 +81,7 @@ obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
>  obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
>  obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
>  obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
> +obj-$(CONFIG_RENESAS_RZAWDT) += rza_wdt.o
>  obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
>
>  # AVR32 Architecture
> diff --git a/drivers/watchdog/rza_wdt.c b/drivers/watchdog/rza_wdt.c
> new file mode 100644
> index 0000000..76a9c1f
> --- /dev/null
> +++ b/drivers/watchdog/rza_wdt.c
> @@ -0,0 +1,199 @@
> +/*
> + * Renesas RZ/A Series WDT Driver
> + *
> + * Copyright (C) 2017 Renesas Electronics America, Inc.
> + * Copyright (C) 2017 Chris Brandt
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/delay.h>
> +#include <linux/watchdog.h>
> +#include <linux/clk.h>
> +

Also needs to include <linux/bitops.h>. While at it, please order include
files alphabetically.

> +#define DEFAULT_TIMEOUT		30
> +
> +/* Watchdog Timer Registers */
> +#define WTCSR			0
> +#define WTCSR_MAGIC		0xA500
> +#define WTSCR_WT		BIT(6)
> +#define WTSCR_TME		BIT(5)
> +#define WTSCR_CKS(i)		(i)
> +
> +#define WTCNT			2
> +#define WTCNT_MAGIC		0x5A00
> +
> +#define WRCSR			4
> +#define WRCSR_MAGIC		0x5A00
> +#define WRCSR_RSTE		BIT(6)
> +#define WRCSR_CLEAR_WOVF	0xA500	/* special value */
> +
> +struct rza_wdt {
> +	struct watchdog_device wdev;
> +	void __iomem *base;
> +	struct clk *clk;
> +};
> +
> +static int rza_wdt_start(struct watchdog_device *wdev)
> +{
> +	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
> +
> +	/* Stop timer */
> +	writew(WTCSR_MAGIC | 0, priv->base + WTCSR);
> +
> +	/* Must dummy read WRCSR:WOVF at least once before clearing */
> +	readb(priv->base + WRCSR);
> +	writew(WRCSR_CLEAR_WOVF, priv->base + WRCSR);
> +
> +	/*
> +	 * Start timer with slowest clock source and reset option enabled.
> +	 */
> +	writew(WRCSR_MAGIC | WRCSR_RSTE, priv->base + WRCSR);
> +	writew(WTCNT_MAGIC | 0, priv->base + WTCNT);
> +	writew(WTCSR_MAGIC | WTSCR_WT | WTSCR_TME | WTSCR_CKS(7),
> +	       priv->base + WTCSR);
> +
> +	return 0;
> +}
> +
> +static int rza_wdt_stop(struct watchdog_device *wdev)
> +{
> +	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
> +
> +	writew(WTCSR_MAGIC | 0, priv->base + WTCSR);
> +
> +	return 0;
> +}
> +
> +static int rza_wdt_ping(struct watchdog_device *wdev)
> +{
> +	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
> +
> +	writew(WTCNT_MAGIC | 0, priv->base + WTCNT);
> +
> +	return 0;
> +}
> +
> +static int rza_wdt_restart(struct watchdog_device *wdev, unsigned long action,
> +			    void *data)
> +{
> +	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
> +
> +	/* Stop timer */
> +	writew(WTCSR_MAGIC | 0, priv->base + WTCSR);
> +
> +	/* Must dummy read WRCSR:WOVF at least once before clearing */
> +	readb(priv->base + WRCSR);
> +	writew(WRCSR_CLEAR_WOVF, priv->base + WRCSR);
> +
> +	/*
> +	 * Start timer with fastest clock source and only 1 clock left before
> +	 * overflow with reset option enabled.
> +	 */
> +	writew(WRCSR_MAGIC | WRCSR_RSTE, priv->base + WRCSR);
> +	writew(WTCNT_MAGIC | 255, priv->base + WTCNT);
> +	writew(WTCSR_MAGIC | WTSCR_WT | WTSCR_TME, priv->base + WTCSR);
> +
> +	/*
> +	 * Actually make sure the above sequence hits hardware before sleeping.
> +	 */
> +	wmb();
> +
> +	/* Wait for WDT overflow (reset) */
> +	udelay(20);
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info rza_wdt_ident = {
> +	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
> +	.identity = "Renesas RZ/A WDT Watchdog",
> +};
> +
> +static const struct watchdog_ops rza_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = rza_wdt_start,
> +	.stop = rza_wdt_stop,
> +	.ping = rza_wdt_ping,
> +	.restart = rza_wdt_restart,
> +};
> +
> +static int rza_wdt_probe(struct platform_device *pdev)
> +{
> +	struct rza_wdt *priv;
> +	struct resource *res;
> +	unsigned long rate;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	rate = clk_get_rate(priv->clk);
> +	if (rate < 16384) {
> +		dev_err(&pdev->dev, "invalid clock rate (%ld)\n", rate);
> +		return -ENOENT;
> +	}
> +
> +	/* Assume slowest clock rate possible (CKS=7) */
> +	rate /= 16384;
> +
> +	priv->wdev.info = &rza_wdt_ident,
> +	priv->wdev.ops = &rza_wdt_ops,
> +	priv->wdev.parent = &pdev->dev;
> +
> +	/*
> +	 * Since the max possible timeout of our 8-bit count register is less
> +	 * than a second, we must use max_hw_heartbeat_ms.
> +	 */
> +	priv->wdev.max_hw_heartbeat_ms = (1000 * U8_MAX) / rate;
> +	dev_dbg(&pdev->dev, "max hw timeout of %dms\n",
> +		 priv->wdev.max_hw_heartbeat_ms);
> +
> +	priv->wdev.min_timeout = 1;
> +	priv->wdev.timeout = DEFAULT_TIMEOUT;
> +
> +	platform_set_drvdata(pdev, priv);

This is now unnecessary.

> +	watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
> +	watchdog_set_drvdata(&priv->wdev, priv);
> +
> +	ret = devm_watchdog_register_device(&pdev->dev, &priv->wdev);
> +	if (ret)
> +		dev_err(&pdev->dev, "Cannot register watchdog device\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id rza_wdt_of_match[] = {
> +	{ .compatible = "renesas,rza-wdt", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rza_wdt_of_match);
> +
> +static struct platform_driver rza_wdt_driver = {
> +	.probe = rza_wdt_probe,
> +	.driver = {
> +		.name = "rza_wdt",
> +		.of_match_table = rza_wdt_of_match,
> +	},
> +};
> +
> +module_platform_driver(rza_wdt_driver);
> +
> +MODULE_DESCRIPTION("Renesas RZ/A WDT Driver");
> +MODULE_AUTHOR("Chris Brandt <chris.brandt@renesas.com>");
> +MODULE_LICENSE("GPL v2");
>

