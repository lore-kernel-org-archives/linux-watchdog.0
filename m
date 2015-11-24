Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35070 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754701AbbKXUpx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 15:45:53 -0500
Date: Tue, 24 Nov 2015 12:45:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH] watchdog: core: factorize register error paths
Message-ID: <20151124204548.GA14059@roeck-us.net>
References: <1448396135-21649-1-git-send-email-damien.riegel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448396135-21649-1-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Damien,

On Tue, Nov 24, 2015 at 03:15:35PM -0500, Damien Riegel wrote:
> The commit adding the reboot notifier in the core introduced a new error
> path in __watchdog_register_device, making error paths quite redondant.
> 
s/redondant/redundant/

> This commit factorizes all error paths that do some cleanup.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>  drivers/watchdog/watchdog_core.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 551af04..aff17b1 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -241,20 +241,16 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>  		wdd->id = id;
>  
>  		ret = watchdog_dev_register(wdd);
> -		if (ret) {
> -			ida_simple_remove(&watchdog_ida, id);
> -			return ret;
> -		}
> +		if (ret)
> +			goto remove_ida;
>  	}
>  
>  	devno = wdd->cdev.dev;
>  	wdd->dev = device_create(watchdog_class, wdd->parent, devno,
>  					wdd, "watchdog%d", wdd->id);
>  	if (IS_ERR(wdd->dev)) {
> -		watchdog_dev_unregister(wdd);
> -		ida_simple_remove(&watchdog_ida, id);
>  		ret = PTR_ERR(wdd->dev);
> -		return ret;
> +		goto unregister_device;
>  	}
>  
>  	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status)) {
> @@ -264,11 +260,7 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>  		if (ret) {
>  			dev_err(wdd->dev, "Cannot register reboot notifier (%d)\n",
>  				ret);
> -			watchdog_dev_unregister(wdd);
> -			device_destroy(watchdog_class, devno);
> -			ida_simple_remove(&watchdog_ida, wdd->id);
> -			wdd->dev = NULL;
> -			return ret;
> +			goto unregister_device;
>  		}
>  	}
>  
> @@ -282,6 +274,17 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>  	}
>  
>  	return 0;
> +
> +unregister_device:
> +	watchdog_dev_unregister(wdd);
> +	if (!IS_ERR(wdd->dev)) {
> +		device_destroy(watchdog_class, devno);
> +		wdd->dev = NULL;

Oddly enough this leaves wdd->dev in place if it is an ERR_PTR.
While that was the case before, it might be better and more
consistent to always set it to NULL.

I also wonder if it is really necessary to call watchdog_dev_unregister()
first. Something like

destroy_device:
	device_destroy(watchdog_class, devno);
unregister_watchdog:
	wdd->dev = NULL;
	watchdog_dev_unregister(wdd);

would be cleaner. Wonder why it isn't done in that order to start with.
It should be possible; after all, the device is created only after 
watchdog_dev_register() succeeded, so one should think that it makes
sense to remove it first. Any idea ?

Thanks,
Guenter

> +	}
> +remove_ida:
> +	ida_simple_remove(&watchdog_ida, id);
> +
> +	return ret;
>  }
>  
>  /**
> -- 
> 2.5.0
> 
