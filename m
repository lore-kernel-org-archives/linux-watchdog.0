Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36256 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753731AbdJIBlB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 8 Oct 2017 21:41:01 -0400
Received: by mail-pf0-f196.google.com with SMTP id z11so6532047pfk.3
        for <linux-watchdog@vger.kernel.org>; Sun, 08 Oct 2017 18:41:00 -0700 (PDT)
Subject: Re: [PATCH 2/2 v2] watchdog: gpio: Convert to use GPIO descriptors
To: Linus Walleij <linus.walleij@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
References: <20171008232847.7358-1-linus.walleij@linaro.org>
 <20171008232847.7358-2-linus.walleij@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57ed2f70-fcc3-c8aa-119c-ed1947cd0f15@roeck-us.net>
Date: Sun, 8 Oct 2017 18:40:57 -0700
MIME-Version: 1.0
In-Reply-To: <20171008232847.7358-2-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/08/2017 04:28 PM, Linus Walleij wrote:
> This converts the GPIO watchdog driver to use GPIO descriptors
> instead of relying on the old method to read out GPIO numbers
> from the device tree and then using those with the old GPIO
> API.
> 
> The descriptor API keeps track of whether the line is active
> low so we can remove all active low handling and rely on the
> GPIO descriptor to deal with this for us.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> ChangeLog v1->v2:
> - Fix a logic error spotted by Guenther: we have to drive
>    the ping line HIGH when disabling the watchdog, so nothing
>    fires. Constantly feeding the wdog. Got it backwards :/
> ---
>   drivers/watchdog/gpio_wdt.c | 41 +++++++++++++++++------------------------
>   1 file changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index 448e6c3ba73c..b077c88a5ceb 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -12,7 +12,8 @@
>   #include <linux/err.h>
>   #include <linux/delay.h>
>   #include <linux/module.h>
> -#include <linux/of_gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/of.h>
>   #include <linux/platform_device.h>
>   #include <linux/watchdog.h>
>   
> @@ -25,8 +26,7 @@ enum {
>   };
>   
>   struct gpio_wdt_priv {
> -	int			gpio;
> -	bool			active_low;
> +	struct gpio_desc	*gpiod;
>   	bool			state;
>   	bool			always_running;
>   	unsigned int		hw_algo;
> @@ -35,11 +35,12 @@ struct gpio_wdt_priv {
>   
>   static void gpio_wdt_disable(struct gpio_wdt_priv *priv)
>   {
> -	gpio_set_value_cansleep(priv->gpio, !priv->active_low);
> +	/* Eternal ping */
> +	gpiod_set_value_cansleep(priv->gpiod, 1);
>   
>   	/* Put GPIO back to tristate */
>   	if (priv->hw_algo == HW_ALGO_TOGGLE)
> -		gpio_direction_input(priv->gpio);
> +		gpiod_direction_input(priv->gpiod);
>   }
>   
>   static int gpio_wdt_ping(struct watchdog_device *wdd)
> @@ -50,13 +51,13 @@ static int gpio_wdt_ping(struct watchdog_device *wdd)
>   	case HW_ALGO_TOGGLE:
>   		/* Toggle output pin */
>   		priv->state = !priv->state;
> -		gpio_set_value_cansleep(priv->gpio, priv->state);
> +		gpiod_set_value_cansleep(priv->gpiod, priv->state);
>   		break;
>   	case HW_ALGO_LEVEL:
>   		/* Pulse */
> -		gpio_set_value_cansleep(priv->gpio, !priv->active_low);
> +		gpiod_set_value_cansleep(priv->gpiod, 1);
>   		udelay(1);
> -		gpio_set_value_cansleep(priv->gpio, priv->active_low);
> +		gpiod_set_value_cansleep(priv->gpiod, 0);
>   		break;
>   	}
>   	return 0;
> @@ -66,8 +67,8 @@ static int gpio_wdt_start(struct watchdog_device *wdd)
>   {
>   	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
>   
> -	priv->state = priv->active_low;
> -	gpio_direction_output(priv->gpio, priv->state);
> +	priv->state = 0;
> +	gpiod_direction_output(priv->gpiod, priv->state);
>   
>   	set_bit(WDOG_HW_RUNNING, &wdd->status);
>   
> @@ -104,9 +105,8 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
>   	struct gpio_wdt_priv *priv;
> -	enum of_gpio_flags flags;
> +	enum gpiod_flags gflags;
>   	unsigned int hw_margin;
> -	unsigned long f = 0;
>   	const char *algo;
>   	int ret;
>   
> @@ -116,29 +116,22 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, priv);
>   
> -	priv->gpio = of_get_gpio_flags(np, 0, &flags);
> -	if (!gpio_is_valid(priv->gpio))
> -		return priv->gpio;
> -
> -	priv->active_low = flags & OF_GPIO_ACTIVE_LOW;
> -
>   	ret = of_property_read_string(np, "hw_algo", &algo);
>   	if (ret)
>   		return ret;
>   	if (!strcmp(algo, "toggle")) {
>   		priv->hw_algo = HW_ALGO_TOGGLE;
> -		f = GPIOF_IN;
> +		gflags = GPIOD_IN;
>   	} else if (!strcmp(algo, "level")) {
>   		priv->hw_algo = HW_ALGO_LEVEL;
> -		f = priv->active_low ? GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
> +		gflags = GPIOD_OUT_LOW;
>   	} else {
>   		return -EINVAL;
>   	}
>   
> -	ret = devm_gpio_request_one(dev, priv->gpio, f,
> -				    dev_name(dev));
> -	if (ret)
> -		return ret;
> +	priv->gpiod = devm_gpiod_get(dev, NULL, gflags);
> +	if (IS_ERR(priv->gpiod))
> +		return PTR_ERR(priv->gpiod);
>   
>   	ret = of_property_read_u32(np,
>   				   "hw_margin_ms", &hw_margin);
> 

