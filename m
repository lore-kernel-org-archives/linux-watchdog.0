Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55108 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757411AbaKTRXq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 20 Nov 2014 12:23:46 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XrVSL-002vlM-Lb
	for linux-watchdog@vger.kernel.org; Thu, 20 Nov 2014 17:23:45 +0000
Date: Thu, 20 Nov 2014 09:23:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio_wdt: Add "always_running" feature to GPIO watchdog
Message-ID: <20141120172329.GA10673@roeck-us.net>
References: <1416489377-13633-1-git-send-email-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1416489377-13633-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Nov 20, 2014 at 02:16:17PM +0100, Mike Looijmans wrote:
> On some chips, like the TPS386000, the trigger cannot be disabled
> and the CPU must keep toggling the line at all times. Add a switch
> "always_running" to keep toggling the GPIO line regardless of the
> state of the soft part of the watchdog. The "armed" member keeps
> track of whether a timeout must also cause a reset.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  drivers/watchdog/gpio_wdt.c |   20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index 220a9e0..921ee67 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -31,6 +31,8 @@ struct gpio_wdt_priv {
>  	int			gpio;
>  	bool			active_low;
>  	bool			state;
> +	bool		always_running;
> +	bool		armed;
>  	unsigned int		hw_algo;
>  	unsigned int		hw_margin;
>  	unsigned long		last_jiffies;
> @@ -56,6 +58,7 @@ static int gpio_wdt_start(struct watchdog_device *wdd)
>  	gpio_direction_output(priv->gpio, priv->state);
>  	priv->last_jiffies = jiffies;
>  	mod_timer(&priv->timer, priv->last_jiffies + priv->hw_margin);
> +	priv->armed = true;
>  
>  	return 0;
>  }
> @@ -64,8 +67,11 @@ static int gpio_wdt_stop(struct watchdog_device *wdd)
>  {
>  	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
>  
> -	mod_timer(&priv->timer, 0);
> -	gpio_wdt_disable(priv);
> +	priv->armed = false;
> +	if (!priv->always_running) {
> +		mod_timer(&priv->timer, 0);
> +		gpio_wdt_disable(priv);
> +	}
>  
>  	return 0;
>  }
> @@ -91,7 +97,7 @@ static void gpio_wdt_hwping(unsigned long data)
>  	struct watchdog_device *wdd = (struct watchdog_device *)data;
>  	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
>  
> -	if (time_after(jiffies, priv->last_jiffies +
> +	if (priv->armed && time_after(jiffies, priv->last_jiffies +
>  		       msecs_to_jiffies(wdd->timeout * 1000))) {
>  		dev_crit(wdd->dev, "Timer expired. System will reboot soon!\n");
>  		return;
> @@ -197,6 +203,9 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>  	/* Use safe value (1/2 of real timeout) */
>  	priv->hw_margin = msecs_to_jiffies(hw_margin / 2);
>  
> +	priv->always_running = of_property_read_bool(pdev->dev.of_node,
> +				"always_running");

That will need to be documented in a devicetree bindings document, and be
reviewed by the fdt maintainers. I may be wrong, but I think devicetree
properties commonly use '-', not '_'.

Guenter

> +
>  	watchdog_set_drvdata(&priv->wdd, priv);
>  
>  	priv->wdd.info		= &gpio_wdt_ident;
> @@ -218,6 +227,11 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>  	if (ret)
>  		watchdog_unregister_device(&priv->wdd);
>  
> +	if (priv->always_running) {
> +		gpio_wdt_start(&priv->wdd);
> +		priv->armed = false;
> +	}
> +
>  	return ret;
>  }
>  
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
