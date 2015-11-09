Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54527 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbKIPTM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Nov 2015 10:19:12 -0500
Subject: Re: [PATCH 2/2] watchdog: gpio-wdt: Add panic notifier
To: Alexander Stein <alexander.stein@systec-electronic.com>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1447062944-12296-1-git-send-email-alexander.stein@systec-electronic.com>
 <1447062944-12296-2-git-send-email-alexander.stein@systec-electronic.com>
Cc: linux-watchdog@vger.kernel.org,
	=?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5640B96D.6010408@roeck-us.net>
Date: Mon, 9 Nov 2015 07:19:09 -0800
MIME-Version: 1.0
In-Reply-To: <1447062944-12296-2-git-send-email-alexander.stein@systec-electronic.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/09/2015 01:55 AM, Alexander Stein wrote:
> This notifier is required when the watchdog is configured as always running
> because in this case the watchdog will be triggered when the kernel panics
> at boot before any application could open the device, e.g. because the
> rootfs is broken. This should result in a resetting system. Thus we
> register a panic notifier which stops triggering the watchdog.
>

Shouldn't the timer be stopped instead ?

Copying Uwe for additional input.

Thanks,
Guenter

> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>   drivers/watchdog/gpio_wdt.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index c7b8a06..aaa0815 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -37,6 +37,7 @@ struct gpio_wdt_priv {
>   	unsigned int		hw_margin;
>   	unsigned long		last_jiffies;
>   	struct notifier_block	reboot_notifier;
> +	struct notifier_block	panic_notifier;
>   	struct timer_list	timer;
>   	struct watchdog_device	wdd;
>   };
> @@ -146,6 +147,17 @@ static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long code,
>   	return NOTIFY_DONE;
>   }
>
> +static int gpio_wdt_notify_panic(struct notifier_block *nb, unsigned long code,
> +			       void *unused)
> +{
> +	struct gpio_wdt_priv *priv = container_of(nb, struct gpio_wdt_priv,
> +						  panic_notifier);
> +
> +	gpio_wdt_disable(priv);
> +
> +	return NOTIFY_DONE;
> +}
> +
>   static const struct watchdog_info gpio_wdt_ident = {
>   	.options	= WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING |
>   			  WDIOF_SETTIMEOUT,
> @@ -233,11 +245,19 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto error_unregister;
>
> +	priv->panic_notifier.notifier_call = gpio_wdt_notify_panic;
> +	ret = atomic_notifier_chain_register(&panic_notifier_list,
> +					     &priv->panic_notifier);
> +	if (ret)
> +		goto error_unregister_notify;
> +
>   	if (priv->always_running)
>   		gpio_wdt_start_impl(priv);
>
>   	return 0;
>
> +error_unregister_notify:
> +	unregister_reboot_notifier(&priv->reboot_notifier);
>   error_unregister:
>   	watchdog_unregister_device(&priv->wdd);
>   	return ret;
>

