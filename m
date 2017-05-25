Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46944 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034024AbdEYAxY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 24 May 2017 20:53:24 -0400
Subject: Re: [PATCH v5 1/3] watchdog: introduce watchdog_worker_should_ping
 helper
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        esben.haabendal@gmail.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1495462000-28979-2-git-send-email-rasmus.villemoes@prevas.dk>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2360adb8-ad7b-9b9f-d83c-db994dec00c9@roeck-us.net>
Date: Wed, 24 May 2017 17:53:21 -0700
MIME-Version: 1.0
In-Reply-To: <1495462000-28979-2-git-send-email-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/22/2017 07:06 AM, Rasmus Villemoes wrote:
> This will be useful when the condition becomes slightly more
> complicated in the next patch.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/watchdog_dev.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index d5d2bbd..caa4b90 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -192,18 +192,23 @@ static int watchdog_ping(struct watchdog_device *wdd)
>   	return __watchdog_ping(wdd);
>   }
>   
> +static bool watchdog_worker_should_ping(struct watchdog_core_data *wd_data)
> +{
> +	struct watchdog_device *wdd = wd_data->wdd;
> +
> +	return wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd));
> +}
> +
>   static void watchdog_ping_work(struct work_struct *work)
>   {
>   	struct watchdog_core_data *wd_data;
> -	struct watchdog_device *wdd;
>   
>   	wd_data = container_of(to_delayed_work(work), struct watchdog_core_data,
>   			       work);
>   
>   	mutex_lock(&wd_data->lock);
> -	wdd = wd_data->wdd;
> -	if (wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd)))
> -		__watchdog_ping(wdd);
> +	if (watchdog_worker_should_ping(wd_data))
> +		__watchdog_ping(wd_data->wdd);
>   	mutex_unlock(&wd_data->lock);
>   }
>   
> 

