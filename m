Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34467 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbbAXQdY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 24 Jan 2015 11:33:24 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YF3eG-001nmq-SY
	for linux-watchdog@vger.kernel.org; Sat, 24 Jan 2015 16:33:25 +0000
Message-ID: <54C3C950.3060001@roeck-us.net>
Date: Sat, 24 Jan 2015 08:33:20 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH V2] watchdog: bcm47xx_wdt.c: add restart handler support
References: <1422107244-32097-1-git-send-email-zajec5@gmail.com> <1422107918-8043-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1422107918-8043-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/24/2015 05:58 AM, Rafał Miłecki wrote:
> Just like in case of other watchdog drivers, use the new kernel core
> API to provide restart support.
>
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
> V2: Include changes to include/linux/bcm47xx_wdt.h
> ---
>   drivers/watchdog/bcm47xx_wdt.c | 22 ++++++++++++++++++++--
>   include/linux/bcm47xx_wdt.h    |  1 +
>   2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
> index 9816485..dac3c5d 100644
> --- a/drivers/watchdog/bcm47xx_wdt.c
> +++ b/drivers/watchdog/bcm47xx_wdt.c
> @@ -169,6 +169,17 @@ static int bcm47xx_wdt_notify_sys(struct notifier_block *this,
>   	return NOTIFY_DONE;
>   }
>
> +static int bcm47xx_wdt_restart(struct notifier_block *this, unsigned long mode,
> +			       void *cmd)
> +{
> +	struct bcm47xx_wdt *wdt;
> +
> +	wdt = container_of(this, struct bcm47xx_wdt, restart_handler);
> +	wdt->timer_set(wdt, 1);
> +
> +	return NOTIFY_DONE;
> +}
> +
>   static struct watchdog_ops bcm47xx_wdt_soft_ops = {
>   	.owner		= THIS_MODULE,
>   	.start		= bcm47xx_wdt_soft_start,
> @@ -204,20 +215,27 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
>   	watchdog_set_nowayout(&wdt->wdd, nowayout);
>
>   	wdt->notifier.notifier_call = &bcm47xx_wdt_notify_sys;
> -

Unnecessary whitespace change.

Guenter

>   	ret = register_reboot_notifier(&wdt->notifier);
>   	if (ret)
>   		goto err_timer;
>
> -	ret = watchdog_register_device(&wdt->wdd);
> +	wdt->restart_handler.notifier_call = &bcm47xx_wdt_restart;
> +	wdt->restart_handler.priority = 128;
> +	ret = register_restart_handler(&wdt->restart_handler);
>   	if (ret)
>   		goto err_notifier;
>
> +	ret = watchdog_register_device(&wdt->wdd);
> +	if (ret)
> +		goto err_handler;
> +
>   	dev_info(&pdev->dev, "BCM47xx Watchdog Timer enabled (%d seconds%s%s)\n",
>   		timeout, nowayout ? ", nowayout" : "",
>   		soft ? ", Software Timer" : "");
>   	return 0;
>
> +err_handler:
> +	unregister_restart_handler(&wdt->restart_handler);
>   err_notifier:
>   	unregister_reboot_notifier(&wdt->notifier);
>   err_timer:
> diff --git a/include/linux/bcm47xx_wdt.h b/include/linux/bcm47xx_wdt.h
> index b708786..5582c21 100644
> --- a/include/linux/bcm47xx_wdt.h
> +++ b/include/linux/bcm47xx_wdt.h
> @@ -16,6 +16,7 @@ struct bcm47xx_wdt {
>
>   	struct watchdog_device wdd;
>   	struct notifier_block notifier;
> +	struct notifier_block restart_handler;
>
>   	struct timer_list soft_timer;
>   	atomic_t soft_ticks;
>

