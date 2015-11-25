Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55504 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbbKYCUP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 21:20:15 -0500
Subject: Re: [PATCH v2 1/2] watchdog: core: call device_destroy before
 watchdog_dev_unregister
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
References: <1448408745-26719-1-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56551ADB.3000107@roeck-us.net>
Date: Tue, 24 Nov 2015 18:20:11 -0800
MIME-Version: 1.0
In-Reply-To: <1448408745-26719-1-git-send-email-damien.riegel@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/24/2015 03:45 PM, Damien Riegel wrote:
> device_create is called after watchdog_dev_register, so it makes more
> sense to call the cleanup functions in reverse order, ie. device_destroy
> before watchdog_dev_unregister.
>
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/watchdog_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 551af04..e70b6e8 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -264,8 +264,8 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>   		if (ret) {
>   			dev_err(wdd->dev, "Cannot register reboot notifier (%d)\n",
>   				ret);
> -			watchdog_dev_unregister(wdd);
>   			device_destroy(watchdog_class, devno);
> +			watchdog_dev_unregister(wdd);
>   			ida_simple_remove(&watchdog_ida, wdd->id);
>   			wdd->dev = NULL;
>   			return ret;
> @@ -324,10 +324,10 @@ static void __watchdog_unregister_device(struct watchdog_device *wdd)
>   		unregister_reboot_notifier(&wdd->reboot_nb);
>
>   	devno = wdd->cdev.dev;
> +	device_destroy(watchdog_class, devno);
>   	ret = watchdog_dev_unregister(wdd);
>   	if (ret)
>   		pr_err("error unregistering /dev/watchdog (err=%d)\n", ret);
> -	device_destroy(watchdog_class, devno);
>   	ida_simple_remove(&watchdog_ida, wdd->id);
>   	wdd->dev = NULL;
>   }
>

