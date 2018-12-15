Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37126 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbeLOQ2z (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 15 Dec 2018 11:28:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so4150944plr.4
        for <linux-watchdog@vger.kernel.org>; Sat, 15 Dec 2018 08:28:53 -0800 (PST)
Date: Sat, 15 Dec 2018 08:28:52 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: watchdog: mena21_wdt: Convert to GPIO descriptors
Message-ID: <20181215162852.GA10029@roeck-us.net>
References: <20181202110410.17562-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202110410.17562-1-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Dec 02, 2018 at 12:04:10PM +0100, Linus Walleij wrote:
> This drops the old OF API use to look up global GPIO
> numbers and replace it with the GPIO descriptor API.
> 
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Johannes Thumshirn <morbidrsa@gmail.com>
> Cc: Johannes Thumshirn <jth@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Johannes Thumshirn <jthumshirn@suse.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

... though I do wonder if anyone tested this. Guess we'll see.

Guenter

> ---
>  drivers/watchdog/mena21_wdt.c | 73 +++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
> index 0be7f50e8ff9..6db69883ece6 100644
> --- a/drivers/watchdog/mena21_wdt.c
> +++ b/drivers/watchdog/mena21_wdt.c
> @@ -13,10 +13,10 @@
>  #include <linux/platform_device.h>
>  #include <linux/watchdog.h>
>  #include <linux/uaccess.h>
> -#include <linux/gpio.h>
> -#include <linux/of_gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/delay.h>
>  #include <linux/bitops.h>
> +#include <linux/of.h>
>  
>  #define NUM_GPIOS 6
>  
> @@ -31,7 +31,7 @@ enum a21_wdt_gpios {
>  
>  struct a21_wdt_drv {
>  	struct watchdog_device wdt;
> -	unsigned gpios[NUM_GPIOS];
> +	struct gpio_desc *gpios[NUM_GPIOS];
>  };
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -43,9 +43,9 @@ static unsigned int a21_wdt_get_bootstatus(struct a21_wdt_drv *drv)
>  {
>  	int reset = 0;
>  
> -	reset |= gpio_get_value(drv->gpios[GPIO_WD_RST0]) ? (1 << 0) : 0;
> -	reset |= gpio_get_value(drv->gpios[GPIO_WD_RST1]) ? (1 << 1) : 0;
> -	reset |= gpio_get_value(drv->gpios[GPIO_WD_RST2]) ? (1 << 2) : 0;
> +	reset |= gpiod_get_value(drv->gpios[GPIO_WD_RST0]) ? (1 << 0) : 0;
> +	reset |= gpiod_get_value(drv->gpios[GPIO_WD_RST1]) ? (1 << 1) : 0;
> +	reset |= gpiod_get_value(drv->gpios[GPIO_WD_RST2]) ? (1 << 2) : 0;
>  
>  	return reset;
>  }
> @@ -54,7 +54,7 @@ static int a21_wdt_start(struct watchdog_device *wdt)
>  {
>  	struct a21_wdt_drv *drv = watchdog_get_drvdata(wdt);
>  
> -	gpio_set_value(drv->gpios[GPIO_WD_ENAB], 1);
> +	gpiod_set_value(drv->gpios[GPIO_WD_ENAB], 1);
>  
>  	return 0;
>  }
> @@ -63,7 +63,7 @@ static int a21_wdt_stop(struct watchdog_device *wdt)
>  {
>  	struct a21_wdt_drv *drv = watchdog_get_drvdata(wdt);
>  
> -	gpio_set_value(drv->gpios[GPIO_WD_ENAB], 0);
> +	gpiod_set_value(drv->gpios[GPIO_WD_ENAB], 0);
>  
>  	return 0;
>  }
> @@ -72,9 +72,9 @@ static int a21_wdt_ping(struct watchdog_device *wdt)
>  {
>  	struct a21_wdt_drv *drv = watchdog_get_drvdata(wdt);
>  
> -	gpio_set_value(drv->gpios[GPIO_WD_TRIG], 0);
> +	gpiod_set_value(drv->gpios[GPIO_WD_TRIG], 0);
>  	ndelay(10);
> -	gpio_set_value(drv->gpios[GPIO_WD_TRIG], 1);
> +	gpiod_set_value(drv->gpios[GPIO_WD_TRIG], 1);
>  
>  	return 0;
>  }
> @@ -96,9 +96,9 @@ static int a21_wdt_set_timeout(struct watchdog_device *wdt,
>  	}
>  
>  	if (timeout == 1)
> -		gpio_set_value(drv->gpios[GPIO_WD_FAST], 1);
> +		gpiod_set_value(drv->gpios[GPIO_WD_FAST], 1);
>  	else
> -		gpio_set_value(drv->gpios[GPIO_WD_FAST], 0);
> +		gpiod_set_value(drv->gpios[GPIO_WD_FAST], 0);
>  
>  	wdt->timeout = timeout;
>  
> @@ -127,7 +127,6 @@ static struct watchdog_device a21_wdt = {
>  
>  static int a21_wdt_probe(struct platform_device *pdev)
>  {
> -	struct device_node *node;
>  	struct a21_wdt_drv *drv;
>  	unsigned int reset = 0;
>  	int num_gpios;
> @@ -138,40 +137,40 @@ static int a21_wdt_probe(struct platform_device *pdev)
>  	if (!drv)
>  		return -ENOMEM;
>  
> -	/* Fill GPIO pin array */
> -	node = pdev->dev.of_node;
> -
> -	num_gpios = of_gpio_count(node);
> +	num_gpios = gpiod_count(&pdev->dev, NULL);
>  	if (num_gpios != NUM_GPIOS) {
>  		dev_err(&pdev->dev, "gpios DT property wrong, got %d want %d",
>  			num_gpios, NUM_GPIOS);
>  		return -ENODEV;
>  	}
>  
> -	for (i = 0; i < num_gpios; i++) {
> -		int val;
> -
> -		val = of_get_gpio(node, i);
> -		if (val < 0)
> -			return val;
> -
> -		drv->gpios[i] = val;
> -	}
> -
>  	/* Request the used GPIOs */
>  	for (i = 0; i < num_gpios; i++) {
> -		ret = devm_gpio_request(&pdev->dev, drv->gpios[i],
> -					"MEN A21 Watchdog");
> -		if (ret)
> -			return ret;
> +		enum gpiod_flags gflags;
>  
>  		if (i < GPIO_WD_RST0)
> -			ret = gpio_direction_output(drv->gpios[i],
> -						gpio_get_value(drv->gpios[i]));
> -		else		/* GPIO_WD_RST[0..2] are inputs */
> -			ret = gpio_direction_input(drv->gpios[i]);
> -		if (ret)
> +			gflags = GPIOD_ASIS;
> +		else
> +			gflags = GPIOD_IN;
> +		drv->gpios[i] = devm_gpiod_get_index(&pdev->dev, NULL, i,
> +						     gflags);
> +		if (IS_ERR(drv->gpios[i])) {
> +			ret = PTR_ERR(drv->gpios[i]);
>  			return ret;
> +		}
> +
> +		gpiod_set_consumer_name(drv->gpios[i], "MEN A21 Watchdog");
> +
> +		/*
> +		 * Retrieve the initial value from the GPIOs that should be
> +		 * output, then set up the line as output with that value.
> +		 */
> +		if (i < GPIO_WD_RST0) {
> +			int val;
> +
> +			val = gpiod_get_value(drv->gpios[i]);
> +			gpiod_direction_output(drv->gpios[i], val);
> +		}
>  	}
>  
>  	watchdog_init_timeout(&a21_wdt, 30, &pdev->dev);
> @@ -207,7 +206,7 @@ static void a21_wdt_shutdown(struct platform_device *pdev)
>  {
>  	struct a21_wdt_drv *drv = dev_get_drvdata(&pdev->dev);
>  
> -	gpio_set_value(drv->gpios[GPIO_WD_ENAB], 0);
> +	gpiod_set_value(drv->gpios[GPIO_WD_ENAB], 0);
>  }
>  
>  static const struct of_device_id a21_wdt_ids[] = {
