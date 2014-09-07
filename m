Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59018 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbaIGRrB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 7 Sep 2014 13:47:01 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XQgC0-003Cnk-7p
	for linux-watchdog@vger.kernel.org; Sun, 07 Sep 2014 17:24:00 +0000
Message-ID: <540C94A5.3030603@roeck-us.net>
Date: Sun, 07 Sep 2014 10:23:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Evgeny Boger <boger@contactless.ru>,
	linux-watchdog@vger.kernel.org,
	Alexander Shiyan <shc_work@mail.ru>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] Add support for always enabled watchdog timers to
 gpio_wdt driver
References: <53F8CC58.2030406@roeck-us.net> <1410022064-15308-1-git-send-email-boger@contactless.ru>
In-Reply-To: <1410022064-15308-1-git-send-email-boger@contactless.ru>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/06/2014 09:47 AM, Evgeny Boger wrote:
> From: Evgeny Boger <boger@contactless.ru>
>
> Add option to use with watchdog timers which are always enabled
> in hardware, i.e. there is no way to enable/disable it via GPIO pin.
> The driver will start pinging WDT immediately upon loading
> and will continue to do so even after stopping the watchdog.
>
> Signed-off-by: Evgeny Boger <boger@contactless.ru>
> ---
>

Overall looks good to me, though we really need feedback from the DT folks
on the binding. There is a parallel effort to add this functionality into
the watchdog core, meaning the proposed binding "'always-enabled' will
very likely find its way into other drivers. We'll also need a separate
binding to express "watchdog can not be stopped after started once".
That is a separate issue, but important to keep in mind when discussing
the bindings.

Thanks,
Guenter

> Changes since v1:
> * fixed typos and indentation
> * gpio_wdt_start_timer renamed to gpio_wdt_start_hwping.
>    This function actually starts the timer to ping hardware.
>    I personally find both proposed gpio_wdt_enable and __gpio_wdt_start
>    names discouraging in this context.
> * fixed broken error handling for register_reboot_notifier
>
>   .../devicetree/bindings/watchdog/gpio-wdt.txt      | 14 ++++++-
>   drivers/watchdog/gpio_wdt.c                        | 46 +++++++++++++++++-----
>   2 files changed, 50 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> index 37afec1..047fe3f 100644
> --- a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> @@ -12,8 +12,11 @@ Required Properties:
>       the opposite level disables the WDT. Active level is determined
>       by the GPIO flags.
>   - hw_margin_ms: Maximum time to reset watchdog circuit (milliseconds).
> +- always-enabled: Use with watchdog timer which is always enabled
> +  in hardware, i.e. there is no way to enable/disable it via GPIO pin.
> +  Driver will start pinging WDT immediately upon loading.
>
> -Example:
> +Examples:
>   	watchdog: watchdog {
>   		/* ADM706 */
>   		compatible = "linux,wdt-gpio";
> @@ -21,3 +24,12 @@ Example:
>   		hw_algo = "toggle";
>   		hw_margin_ms = <1600>;
>   	};
> +
> +	watchdog: watchdog {
> +		/* TPS3813 */
> +		compatible = "linux,wdt-gpio";
> +		gpios = <&gpio3 9 GPIO_ACTIVE_LOW>;
> +		hw_algo = "toggle";
> +		hw_margin_ms = <10000>;
> +		always-enabled;
> +	};
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index 220a9e0..b6ab6e7 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -37,6 +37,8 @@ struct gpio_wdt_priv {
>   	struct notifier_block	notifier;
>   	struct timer_list	timer;
>   	struct watchdog_device	wdd;
> +	bool		always_enabled;
> +	bool		started;
>   };
>
>   static void gpio_wdt_disable(struct gpio_wdt_priv *priv)
> @@ -48,10 +50,8 @@ static void gpio_wdt_disable(struct gpio_wdt_priv *priv)
>   		gpio_direction_input(priv->gpio);
>   }
>
> -static int gpio_wdt_start(struct watchdog_device *wdd)
> +static int gpio_wdt_start_hwping(struct gpio_wdt_priv *priv)
>   {
> -	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
> -
>   	priv->state = priv->active_low;
>   	gpio_direction_output(priv->gpio, priv->state);
>   	priv->last_jiffies = jiffies;
> @@ -60,12 +60,30 @@ static int gpio_wdt_start(struct watchdog_device *wdd)
>   	return 0;
>   }
>
> +static int gpio_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
> +
> +	priv->started = true;
> +	if (priv->always_enabled) {
> +		/* hardware ping timer is already enabled */
> +		priv->last_jiffies = jiffies;
> +	} else {
> +		gpio_wdt_start_hwping(priv);
> +	}
> +
> +	return 0;
> +}
> +
>   static int gpio_wdt_stop(struct watchdog_device *wdd)
>   {
>   	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
>
> -	mod_timer(&priv->timer, 0);
> -	gpio_wdt_disable(priv);
> +	priv->started = false;
> +	if (!priv->always_enabled) {
> +		mod_timer(&priv->timer, 0);
> +		gpio_wdt_disable(priv);
> +	}
>
>   	return 0;
>   }
> @@ -91,8 +109,9 @@ static void gpio_wdt_hwping(unsigned long data)
>   	struct watchdog_device *wdd = (struct watchdog_device *)data;
>   	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
>
> -	if (time_after(jiffies, priv->last_jiffies +
> -		       msecs_to_jiffies(wdd->timeout * 1000))) {
> +	if (priv->started &&
> +		time_after(jiffies, priv->last_jiffies +
> +			       msecs_to_jiffies(wdd->timeout * 1000))) {
>   		dev_crit(wdd->dev, "Timer expired. System will reboot soon!\n");
>   		return;
>   	}
> @@ -197,6 +216,9 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>   	/* Use safe value (1/2 of real timeout) */
>   	priv->hw_margin = msecs_to_jiffies(hw_margin / 2);
>
> +	priv->always_enabled = of_property_read_bool(pdev->dev.of_node,
> +						"always-enabled");
> +
>   	watchdog_set_drvdata(&priv->wdd, priv);
>
>   	priv->wdd.info		= &gpio_wdt_ident;
> @@ -207,6 +229,7 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>   	if (watchdog_init_timeout(&priv->wdd, 0, &pdev->dev) < 0)
>   		priv->wdd.timeout = SOFT_TIMEOUT_DEF;
>
> +	priv->started = false;
>   	setup_timer(&priv->timer, gpio_wdt_hwping, (unsigned long)&priv->wdd);
>
>   	ret = watchdog_register_device(&priv->wdd);
> @@ -215,10 +238,15 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>
>   	priv->notifier.notifier_call = gpio_wdt_notify_sys;
>   	ret = register_reboot_notifier(&priv->notifier);
> -	if (ret)
> +	if (ret) {
>   		watchdog_unregister_device(&priv->wdd);
> +		return ret;
> +	}
>
> -	return ret;
> +	if (priv->always_enabled)
> +		gpio_wdt_start_hwping(priv);
> +
> +	return 0;
>   }
>
>   static int gpio_wdt_remove(struct platform_device *pdev)
>

