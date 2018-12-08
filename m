Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42409 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeLHRHQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 8 Dec 2018 12:07:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so3387863pfr.9
        for <linux-watchdog@vger.kernel.org>; Sat, 08 Dec 2018 09:07:15 -0800 (PST)
Subject: Re: [PATCH] watchdog: tqmx86: Add watchdog driver for the IO
 controller
To: Andrew Lunn <andrew@lunn.ch>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org
References: <1544285615-23965-1-git-send-email-andrew@lunn.ch>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d0481103-6240-0ad3-7ccc-2424c3cf107d@roeck-us.net>
Date: Sat, 8 Dec 2018 09:07:13 -0800
MIME-Version: 1.0
In-Reply-To: <1544285615-23965-1-git-send-email-andrew@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/8/18 8:13 AM, Andrew Lunn wrote:
> Some TQ-Systems ComExpress modules have an IO controller with a
> watchdog time.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>   drivers/watchdog/Kconfig      |  12 +++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/tqmx86_wdt.c | 157 ++++++++++++++++++++++++++++++++++
>   3 files changed, 170 insertions(+)
>   create mode 100644 drivers/watchdog/tqmx86_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 2d64333f4782..1c99238c2f32 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1308,6 +1308,18 @@ config SMSC37B787_WDT
>   
>   	  Most people will say N.
>   
> +config TQMX86_WDT
> +	tristate "TQ-Systems TQMX86 Watchdog Timer"
> +	depends on X86
> +	help
> +	This is the driver for the hardware watchdog timer in the TQMN86 IO
> +	on controller found on some of their ComExpress Modules.

"on controller" ? Should that be just "controller" ?

> +
> +	To compile this driver as a module, choose M here; the module
> +	will be called via_wdt.

via_wdt ?

> +
> +	Most people will say N.
> +
>   config VIA_WDT
>   	tristate "VIA Watchdog Timer"
>   	depends on X86 && PCI
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index f69cdff5ad7f..b077e35414e2 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -129,6 +129,7 @@ obj-$(CONFIG_SBC7240_WDT) += sbc7240_wdt.o
>   obj-$(CONFIG_CPU5_WDT) += cpu5wdt.o
>   obj-$(CONFIG_SMSC_SCH311X_WDT) += sch311x_wdt.o
>   obj-$(CONFIG_SMSC37B787_WDT) += smsc37b787_wdt.o
> +obj-$(CONFIG_TQMX86_WDT) += tqmx86_wdt.o
>   obj-$(CONFIG_VIA_WDT) += via_wdt.o
>   obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
>   obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
> diff --git a/drivers/watchdog/tqmx86_wdt.c b/drivers/watchdog/tqmx86_wdt.c
> new file mode 100644
> index 000000000000..9f5d4612b97a
> --- /dev/null
> +++ b/drivers/watchdog/tqmx86_wdt.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Watchdog driver for TQMx86 PLD.
> + *
> + * The watchdog supports power of 2 timeouts from 1 to 4096sec.
> + * Once started, it cannot be stopped.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/watchdog.h>
> +#include <linux/timer.h>
> +#include <linux/io.h>
> +#include <linux/log2.h>
> +

Alphabetic order, please.

> +/* default timeout (secs) */
> +#define WDT_TIMEOUT 32
> +
> +static unsigned int timeout = WDT_TIMEOUT;

Please set to 0 (ie don't set it) and use watchdog_init_timeout() in the probe
function to override the default.

> +module_param(timeout, uint, 0);
> +MODULE_PARM_DESC(timeout,
> +	"Watchdog timeout in seconds. (1<=timeout<=4096, default="
> +				__MODULE_STRING(WDT_TIMEOUT) ")");
> +struct tqmx86_wdt {
> +	struct watchdog_device wdd;
> +	void __iomem *io_base;
> +};
> +
> +#define TQMX86_WDCFG	0x00 /* Watchdog Configuration Register */
> +#define TQMX86_WDCS	0x01 /* Watchdog Config/Status Register */
> +
> +static int tqmx86_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct tqmx86_wdt *priv = watchdog_get_drvdata(wdd);
> +
> +	iowrite8(0x81, priv->io_base + TQMX86_WDCS);
> +
> +	return 0;
> +}
> +
> +static int tqmx86_wdt_stop(struct watchdog_device *wdd)
> +{
> +	return -EINVAL;
> +}

This is quite pointless. If there is no means to stop the watchdog,
just don't provide a stop function.

> +
> +static int tqmx86_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct tqmx86_wdt *priv = watchdog_get_drvdata(wdd);
> +
> +	iowrite8(0x81, priv->io_base + TQMX86_WDCS);
> +

If the start and the ping function are the same, the ping function
can be omitted.

> +	return 0;
> +}
> +
> +static int tqmx86_wdt_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int new_timeout)
> +{
> +	struct tqmx86_wdt *priv = watchdog_get_drvdata(wdd);
> +	u8 val;
> +
> +	if (new_timeout < 1 || new_timeout > 4096) {
> +		dev_info(wdd->parent, "Timeout must be between 1 and 4096\n");
> +		return -EINVAL;
> +	}

Not necessary; checked by infrastructure.

> +
> +	timeout = roundup_pow_of_two(new_timeout);
> +	val = ilog2(timeout) | 0x90;
> +	val += 3; /* vallues 0,1,2 correspond to 0.125,0.25,0.5s timeouts */

values

> +	iowrite8(val, priv->io_base + TQMX86_WDCFG);
> +
> +	wdd->timeout = timeout;
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info tqmx86_wdt_info = {
> +	.options	= WDIOF_SETTIMEOUT |
> +			  WDIOF_KEEPALIVEPING,
> +	.identity	= "TQMx86 Watchdog",
> +};
> +
> +static struct watchdog_ops tqmx86_wdt_ops = {
> +	.owner		= THIS_MODULE,
> +	.start		= tqmx86_wdt_start,
> +	.stop		= tqmx86_wdt_stop,
> +	.ping		= tqmx86_wdt_ping,
> +	.set_timeout	= tqmx86_wdt_set_timeout,
> +};
> +
> +static int tqmx86_wdt_probe(struct platform_device *pdev)
> +{
> +	struct tqmx86_wdt *priv;
> +	struct resource *res;
> +	int err;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (IS_ERR(res))
> +		return PTR_ERR(res);
> +
> +	priv->io_base = devm_ioport_map(&pdev->dev, res->start,
> +					resource_size(res));
> +	if (IS_ERR(priv->io_base))
> +		return PTR_ERR(priv->io_base);
> +
> +	if (timeout < 1 || timeout > 4096) {
> +		timeout = WDT_TIMEOUT;
> +		dev_warn(&pdev->dev,
> +			"timeout value must be 1<=x<=4096, using %d\n",
> +			timeout);
> +	}
> +
You should set the default in the wdd structure and call watchdog_init_timeout()
to update it.

> +	platform_set_drvdata(pdev, priv);
> +	watchdog_set_drvdata(&priv->wdd, priv);
> +
> +	tqmx86_wdt_set_timeout(&priv->wdd, timeout);
> +
> +	priv->wdd.parent = &pdev->dev;
> +	priv->wdd.info = &tqmx86_wdt_info;
> +	priv->wdd.ops = &tqmx86_wdt_ops;
> +
You should also specify minimum and maximum timeout
to enable boundary checking by the watchdog core.

> +	watchdog_set_nowayout(&priv->wdd, 1);

Why not use CONFIG_WATCHDOG_NOWAYOUT and WATCHDOG_NOWAYOUT ?

> +
> +	err = watchdog_register_device(&priv->wdd);
> +	if (err)
> +		return err;
> +
> +	dev_info(&pdev->dev, "TQMx86 watchdog\n");
> +
> +	return 0;
> +}
> +
> +static int tqmx86_wdt_remove(struct platform_device *pdev)
> +{
> +	struct tqmx86_wdt *priv = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&priv->wdd);
> +	return 0;

If the remove function only removes the watchdog, you can use
devm_watchdog_register_device() to register it and drop the remove function.

> +}
> +
> +static struct platform_driver tqmx86_wdt_driver = {
> +	.driver		= {
> +		.name	= "tqmx86-wdt",
> +	},
> +	.probe		= tqmx86_wdt_probe,
> +	.remove		= tqmx86_wdt_remove,
> +};
> +
> +module_platform_driver(tqmx86_wdt_driver);
> +
> +MODULE_AUTHOR("Vadim V.Vlasov <vvlasov@dev.rtsoft.ru>");
> +MODULE_DESCRIPTION("TQMx86 Watchdog");
> +MODULE_ALIAS("platform:tqmx86-wdt");
> +MODULE_LICENSE("GPL");
> 
