Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57180 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932537AbcEYRbH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 13:31:07 -0400
Date: Wed, 25 May 2016 10:30:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 3/7] watchdog: softdog: consistently use softdog_ prefix
Message-ID: <20160525173057.GE19545@roeck-us.net>
References: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
 <1464158269-2447-4-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464158269-2447-4-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 25, 2016 at 08:37:45AM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> And move module_init/exit to the proper place while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/softdog.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
> index a9ad27dd46502b..0a29f5a0833787 100644
> --- a/drivers/watchdog/softdog.c
> +++ b/drivers/watchdog/softdog.c
> @@ -54,12 +54,12 @@ module_param(soft_panic, int, 0);
>  MODULE_PARM_DESC(soft_panic,
>  	"Softdog action, set to 1 to panic, 0 to reboot (default=0)");
>  
> -static void watchdog_fire(unsigned long);
> +static void softdog_fire(unsigned long);
>  
> -static struct timer_list watchdog_ticktock =
> -		TIMER_INITIALIZER(watchdog_fire, 0, 0);
> +static struct timer_list softdog_ticktock =
> +		TIMER_INITIALIZER(softdog_fire, 0, 0);
>  
> -static void watchdog_fire(unsigned long data)
> +static void softdog_fire(unsigned long data)
>  {
>  	module_put(THIS_MODULE);
>  	if (soft_noboot)
> @@ -76,14 +76,14 @@ static void watchdog_fire(unsigned long data)
>  
>  static int softdog_ping(struct watchdog_device *w)
>  {
> -	if (!mod_timer(&watchdog_ticktock, jiffies+(w->timeout*HZ)))
> +	if (!mod_timer(&softdog_ticktock, jiffies+(w->timeout*HZ)))
>  		__module_get(THIS_MODULE);
>  	return 0;
>  }
>  
>  static int softdog_stop(struct watchdog_device *w)
>  {
> -	if (del_timer(&watchdog_ticktock))
> +	if (del_timer(&softdog_ticktock))
>  		module_put(THIS_MODULE);
>  
>  	return 0;
> @@ -115,7 +115,7 @@ static struct watchdog_device softdog_dev = {
>  	.timeout = TIMER_MARGIN,
>  };
>  
> -static int __init watchdog_init(void)
> +static int __init softdog_init(void)
>  {
>  	int ret;
>  
> @@ -132,14 +132,13 @@ static int __init watchdog_init(void)
>  
>  	return 0;
>  }
> +module_init(softdog_init);
>  
> -static void __exit watchdog_exit(void)
> +static void __exit softdog_exit(void)
>  {
>  	watchdog_unregister_device(&softdog_dev);
>  }
> -
> -module_init(watchdog_init);
> -module_exit(watchdog_exit);
> +module_exit(softdog_exit);
>  
>  MODULE_AUTHOR("Alan Cox");
>  MODULE_DESCRIPTION("Software Watchdog Device Driver");
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
