Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:37443 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095Ab3GNTn6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 14 Jul 2013 15:43:58 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so10525965pbc.25
        for <linux-watchdog@vger.kernel.org>; Sun, 14 Jul 2013 12:43:58 -0700 (PDT)
Date: Sun, 14 Jul 2013 12:43:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [RFC] watchdog: GPIO-controlled watchdog
Message-ID: <20130714194356.GA29771@roeck-us.net>
References: <1373814599-6040-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1373814599-6040-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Jul 14, 2013 at 07:09:59PM +0400, Alexander Shiyan wrote:
> This patch adds a watchdog driver for devices controlled through GPIO,
> (Analog Devices ADM706, for example). Driver written for DT-based systems
> only. No description for Documentation/devicetree yet.
> Comments are welcome.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/watchdog/Kconfig    |   8 +++
>  drivers/watchdog/Makefile   |   1 +
>  drivers/watchdog/gpio_wdt.c | 121 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+)
>  create mode 100644 drivers/watchdog/gpio_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 3eb1cc6..811030c 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -87,6 +87,14 @@ config DA9055_WATCHDOG
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called da9055_wdt.
>  
> +config GPIO_WATCHDOG
> +	tristate "Watchdog device controlled through GPIO-line"
> +	depends on OF_GPIO
> +	select WATCHDOG_CORE
> +	help
> +	  If you say yes here you get support for watchdog device
> +	  controlled through GPIO-line.
> +
>  config WM831X_WATCHDOG
>  	tristate "WM831x watchdog"
>  	depends on MFD_WM831X
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index ec26899..ca85cbd 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -168,6 +168,7 @@ obj-$(CONFIG_XEN_WDT) += xen_wdt.o
>  # Architecture Independent
>  obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
>  obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
> +obj-$(CONFIG_GPIO_WATCHDOG)	+= gpio_wdt.o
>  obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
>  obj-$(CONFIG_WM8350_WATCHDOG) += wm8350_wdt.o
>  obj-$(CONFIG_MAX63XX_WATCHDOG) += max63xx_wdt.o
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> new file mode 100644
> index 0000000..ee4ffba
> --- /dev/null
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -0,0 +1,121 @@
> +/*
> + * Driver for watchdog device controlled through GPIO-line
> + *
> + * Author: 2013, Alexander Shiyan <shc_work@mail.ru>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +
> +struct gpio_wdt_priv {
> +	int			gpio;
> +	struct watchdog_device	wdd;
> +};
> +
> +static int gpio_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct gpio_wdt_priv *priv =
> +		container_of(wdd, struct gpio_wdt_priv, wdd);
> +
> +	/* Toggle output */
> +	gpio_set_value(priv->gpio, !gpio_get_value(priv->gpio));
> +

Lots of context knowledge here. For a generic driver, how does one know
that toggling the output value triggers the ping ?

Also, there is no mention that the toggle has to occur within 1.6 seconds.
Linux expects that watchdogs support much larger timeouts. I think it would
make sense to implement a soft-dog which actually triggers the ping,
and handles the higher level ping received from applications.
There are several other watchdog drivers implementing this approach.

Overall, I think this should be a watchdog driver specifically for
ADM705/706/707/708.

> +	return 0;
> +}
> +
> +static int gpio_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct gpio_wdt_priv *priv =
> +		container_of(wdd, struct gpio_wdt_priv, wdd);
> +
> +	/* Enable watchdog by set output to logic level */
> +	gpio_direction_output(priv->gpio, 0);
> +	gpio_set_value(priv->gpio, 1);
> +
> +	return 0;
> +}
> +
> +static int gpio_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct gpio_wdt_priv *priv =
> +		container_of(wdd, struct gpio_wdt_priv, wdd);
> +
> +	/* Disable watchdog by set output to tristate */
> +	return gpio_direction_input(priv->gpio);
> +}
> +
> +static const struct watchdog_info gpio_wdt_ident = {
> +	.options	= WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
> +	.identity	= "GPIO Watchdog",
> +};
> +
> +static const struct watchdog_ops gpio_wdt_ops = {
> +	.owner	= THIS_MODULE,
> +	.ping	= gpio_wdt_ping,
> +	.start	= gpio_wdt_start,
> +	.stop	= gpio_wdt_stop,
> +};
> +
> +static int gpio_wdt_probe(struct platform_device *pdev)
> +{
> +	struct gpio_wdt_priv *priv;
> +	bool nowayout;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->gpio = of_get_gpio(pdev->dev.of_node, 0);
> +	if (priv->gpio < 0)
> +		return priv->gpio;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->wdd.info = &gpio_wdt_ident;
> +	priv->wdd.ops = &gpio_wdt_ops;
> +
> +	nowayout = of_property_read_bool(pdev->dev.of_node, "wdt,nowayout");
> +	if (!nowayout)
> +		nowayout = WATCHDOG_NOWAYOUT;

I don't think it is a good idea to introduce a driver specific
devicetreee property like this one.

First, it is a configuration parameter and does not describe the hardware. as
such, a module parameter as implemented by other drivers would be more
appropriate. Second, even if a devicetree property was used, it should be
implemented in the watchdog core code and not in drivers.

> +	watchdog_set_nowayout(&priv->wdd, nowayout);
> +
> +	return watchdog_register_device(&priv->wdd);
> +}
> +
> +static int gpio_wdt_remove(struct platform_device *pdev)
> +{
> +	struct gpio_wdt_priv *priv = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&priv->wdd);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id gpio_wdt_dt_ids[] = {
> +	{ .compatible = "linux,wdt-gpio", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gpio_wdt_dt_ids);
> +
> +static struct platform_driver gpio_wdt_driver = {
> +	.driver	= {
> +		.name		= "gpio-wdt",
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= of_match_ptr(gpio_wdt_dt_ids),
> +	},
> +	.probe	= gpio_wdt_probe,
> +	.remove	= gpio_wdt_remove,
> +};
> +module_platform_driver(gpio_wdt_driver);
> +
> +MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
> +MODULE_DESCRIPTION("GPIO Watchdog");
> +MODULE_LICENSE("GPL");
> -- 
> 1.8.1.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
