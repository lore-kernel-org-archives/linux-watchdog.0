Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45245 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbeH1RtR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 13:49:17 -0400
Subject: Re: [PATCH 1/2] watchdog: core: fix null pointer dereference when
 releasing cdev
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
References: <20180828101348.12443-1-wsa+renesas@sang-engineering.com>
 <20180828101348.12443-2-wsa+renesas@sang-engineering.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4a64ef9b-ab5e-c8a5-e9d9-67431ee40046@roeck-us.net>
Date: Tue, 28 Aug 2018 06:57:27 -0700
MIME-Version: 1.0
In-Reply-To: <20180828101348.12443-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/28/2018 03:13 AM, Wolfram Sang wrote:
> watchdog_stop() calls watchdog_update_worker() which needs a valid
> wdd->wd_data pointer. So, when unregistering the cdev, clear the
> pointers after we call watchdog_stop(), not before.
> 
> Fixes: bb292ac1c602 ("watchdog: Introduce watchdog_stop_on_unregister helper")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/watchdog_dev.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index ffbdc4642ea5..f6c24b22b37c 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -1019,16 +1019,16 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
>   		old_wd_data = NULL;
>   	}
>   
> -	mutex_lock(&wd_data->lock);
> -	wd_data->wdd = NULL;
> -	wdd->wd_data = NULL;
> -	mutex_unlock(&wd_data->lock);
> -
>   	if (watchdog_active(wdd) &&
>   	    test_bit(WDOG_STOP_ON_UNREGISTER, &wdd->status)) {
>   		watchdog_stop(wdd);
>   	}
>   
> +	mutex_lock(&wd_data->lock);
> +	wd_data->wdd = NULL;
> +	wdd->wd_data = NULL;
> +	mutex_unlock(&wd_data->lock);
> +
>   	hrtimer_cancel(&wd_data->timer);
>   	kthread_cancel_work_sync(&wd_data->work);
>   
> 
