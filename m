Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56949 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbcEYRax (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 13:30:53 -0400
Date: Wed, 25 May 2016 10:30:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 2/7] watchdog: softdog: use watchdog core to init timeout
 value
Message-ID: <20160525173048.GD19545@roeck-us.net>
References: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
 <1464158269-2447-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464158269-2447-3-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 25, 2016 at 08:37:44AM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Error string and comment say we fall back to a default, but in reality
> we bailed out. Refactor the code to use the core helper which then
> matches the described behaviour. While updating the init message anyhow,
> shorten it while we are here; no need for versioning there as well and
> the name is already given via pr_fmt.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/softdog.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
> index 8bc0b164afc94b..a9ad27dd46502b 100644
> --- a/drivers/watchdog/softdog.c
> +++ b/drivers/watchdog/softdog.c
> @@ -111,22 +111,15 @@ static struct watchdog_device softdog_dev = {
>  	.info = &softdog_info,
>  	.ops = &softdog_ops,
>  	.min_timeout = 1,
> -	.max_timeout = 0xFFFF
> +	.max_timeout = 65535,
> +	.timeout = TIMER_MARGIN,
>  };
>  
>  static int __init watchdog_init(void)
>  {
>  	int ret;
>  
> -	/* Check that the soft_margin value is within it's range;
> -	   if not reset to the default */
> -	if (soft_margin < 1 || soft_margin > 65535) {
> -		pr_info("soft_margin must be 0 < soft_margin < 65536, using %d\n",
> -			TIMER_MARGIN);
> -		return -EINVAL;
> -	}
> -	softdog_dev.timeout = soft_margin;
> -
> +	watchdog_init_timeout(&softdog_dev, soft_margin, NULL);
>  	watchdog_set_nowayout(&softdog_dev, nowayout);
>  	watchdog_stop_on_reboot(&softdog_dev);
>  
> @@ -134,8 +127,8 @@ static int __init watchdog_init(void)
>  	if (ret)
>  		return ret;
>  
> -	pr_info("Software Watchdog Timer: 0.08 initialized. soft_noboot=%d soft_margin=%d sec soft_panic=%d (nowayout=%d)\n",
> -		soft_noboot, soft_margin, soft_panic, nowayout);
> +	pr_info("initialized. soft_noboot=%d soft_margin=%d sec soft_panic=%d (nowayout=%d)\n",
> +		soft_noboot, softdog_dev.timeout, soft_panic, nowayout);
>  
>  	return 0;
>  }
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
