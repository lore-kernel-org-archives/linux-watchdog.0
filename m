Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58958 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161815AbbKTD1N (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 19 Nov 2015 22:27:13 -0500
Subject: Re: [PATCH 5/7] watchdog: gpio_wdt: use core reboot notifier
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
References: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1447880542-19320-6-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com,
	Mike Looijmans <mike.looijmans@topic.nl>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564E930C.3000501@roeck-us.net>
Date: Thu, 19 Nov 2015 19:27:08 -0800
MIME-Version: 1.0
In-Reply-To: <1447880542-19320-6-git-send-email-damien.riegel@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/18/2015 01:02 PM, Damien Riegel wrote:
> Get rid of the custom reboot notifier block registration and use the one
> provided by the watchdog core.
>
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>
> ---
>   drivers/watchdog/gpio_wdt.c | 35 ++---------------------------------
>   1 file changed, 2 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index 1a3c6e8..035c238 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -12,10 +12,8 @@
>   #include <linux/err.h>
>   #include <linux/delay.h>
>   #include <linux/module.h>
> -#include <linux/notifier.h>
>   #include <linux/of_gpio.h>
>   #include <linux/platform_device.h>
> -#include <linux/reboot.h>
>   #include <linux/watchdog.h>
>
>   #define SOFT_TIMEOUT_MIN	1
> @@ -36,7 +34,6 @@ struct gpio_wdt_priv {
>   	unsigned int		hw_algo;
>   	unsigned int		hw_margin;
>   	unsigned long		last_jiffies;
> -	struct notifier_block	notifier;
>   	struct timer_list	timer;
>   	struct watchdog_device	wdd;
>   };
> @@ -126,26 +123,6 @@ static int gpio_wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
>   	return gpio_wdt_ping(wdd);
>   }
>
> -static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long code,
> -			       void *unused)
> -{
> -	struct gpio_wdt_priv *priv = container_of(nb, struct gpio_wdt_priv,
> -						  notifier);
> -
> -	mod_timer(&priv->timer, 0);
> -
> -	switch (code) {
> -	case SYS_HALT:
> -	case SYS_DOWN:
> -		gpio_wdt_disable(priv);
> -		break;
> -	default:
> -		break;
> -	}
> -
Slight difference in semantics here: The stop function only stops the watchdog
if the 'always_running' flag is not set. The notifier here always stops it,
or at least tries to stop it. Not really sure what that means, since the
always_running flag is supposed to mean "the watchdog can not be stopped".

Copying Mike Looijmans, who added the always-running flag, for input.

Thanks,
Guenter

> -	return NOTIFY_DONE;
> -}
> -
>   static const struct watchdog_info gpio_wdt_ident = {
>   	.options	= WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING |
>   			  WDIOF_SETTIMEOUT,
> @@ -224,23 +201,16 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>
>   	setup_timer(&priv->timer, gpio_wdt_hwping, (unsigned long)&priv->wdd);
>
> +	watchdog_stop_on_reboot(&priv->wdd);
> +
>   	ret = watchdog_register_device(&priv->wdd);
>   	if (ret)
>   		return ret;
>
> -	priv->notifier.notifier_call = gpio_wdt_notify_sys;
> -	ret = register_reboot_notifier(&priv->notifier);
> -	if (ret)
> -		goto error_unregister;
> -
>   	if (priv->always_running)
>   		gpio_wdt_start_impl(priv);
>
>   	return 0;
> -
> -error_unregister:
> -	watchdog_unregister_device(&priv->wdd);
> -	return ret;
>   }
>
>   static int gpio_wdt_remove(struct platform_device *pdev)
> @@ -248,7 +218,6 @@ static int gpio_wdt_remove(struct platform_device *pdev)
>   	struct gpio_wdt_priv *priv = platform_get_drvdata(pdev);
>
>   	del_timer_sync(&priv->timer);
> -	unregister_reboot_notifier(&priv->notifier);
>   	watchdog_unregister_device(&priv->wdd);
>
>   	return 0;
>

