Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45994 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbbKWFdU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 00:33:20 -0500
Subject: Re: [PATCH 1/2] watchdog: gpio-wdt: Rename notifier to
 reboot_notifier
To: Alexander Stein <alexander.stein@systec-electronic.com>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1447062944-12296-1-git-send-email-alexander.stein@systec-electronic.com>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5652A51C.2030509@roeck-us.net>
Date: Sun, 22 Nov 2015 21:33:16 -0800
MIME-Version: 1.0
In-Reply-To: <1447062944-12296-1-git-send-email-alexander.stein@systec-electronic.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/09/2015 01:55 AM, Alexander Stein wrote:
> This is a preparation before adding a panic notifier.
>
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Fyi, we are going to have an infrastructure change which will make this patch unnecessary.

See http://patchwork.roeck-us.net/patch/451/ and http://patchwork.roeck-us.net/patch/452/
for details.

Thanks,
Guenter

> ---
>   drivers/watchdog/gpio_wdt.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index 90d59d3f..c7b8a06 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -36,7 +36,7 @@ struct gpio_wdt_priv {
>   	unsigned int		hw_algo;
>   	unsigned int		hw_margin;
>   	unsigned long		last_jiffies;
> -	struct notifier_block	notifier;
> +	struct notifier_block	reboot_notifier;
>   	struct timer_list	timer;
>   	struct watchdog_device	wdd;
>   };
> @@ -130,7 +130,7 @@ static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long code,
>   			       void *unused)
>   {
>   	struct gpio_wdt_priv *priv = container_of(nb, struct gpio_wdt_priv,
> -						  notifier);
> +						  reboot_notifier);
>
>   	mod_timer(&priv->timer, 0);
>
> @@ -228,8 +228,8 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>
> -	priv->notifier.notifier_call = gpio_wdt_notify_sys;
> -	ret = register_reboot_notifier(&priv->notifier);
> +	priv->reboot_notifier.notifier_call = gpio_wdt_notify_sys;
> +	ret = register_reboot_notifier(&priv->reboot_notifier);
>   	if (ret)
>   		goto error_unregister;
>
> @@ -248,7 +248,7 @@ static int gpio_wdt_remove(struct platform_device *pdev)
>   	struct gpio_wdt_priv *priv = platform_get_drvdata(pdev);
>
>   	del_timer_sync(&priv->timer);
> -	unregister_reboot_notifier(&priv->notifier);
> +	unregister_reboot_notifier(&priv->reboot_notifier);
>   	watchdog_unregister_device(&priv->wdd);
>
>   	return 0;
>

