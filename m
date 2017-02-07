Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45896 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754323AbdBGTNt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 7 Feb 2017 14:13:49 -0500
Date: Tue, 7 Feb 2017 10:55:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH v2] watchdog: softdog: make pretimeout support a compile
 option
Message-ID: <20170207185509.GA5539@roeck-us.net>
References: <20170207140329.31459-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170207140329.31459-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 07, 2017 at 03:03:29PM +0100, Wolfram Sang wrote:
> It occurred to me that the panic pretimeout governor will stall the
> softdog, because it is purely software which simply breaks when the
> kernel panics. Testing governors with the softdog on the other hand is
> really useful, so make this feature a compile time option which nees to
> be enabled explicitly. This also removes the overhead if pretimeout
> support is not used because it will now be compiled away (saving ~10% on
> ARM32).
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Change since V1:
> 
> * use IS_DEFINED as if-conditions, removing the need for #ifdef
> 
> I have to admit that this result is better readable and what the compiler
> compiles away is sufficient.
> 
>  drivers/watchdog/Kconfig   |  8 ++++++++
>  drivers/watchdog/softdog.c | 21 +++++++++++++--------
>  2 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index acb00b53a5207b..70726ce3d166e8 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -71,6 +71,14 @@ config SOFT_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called softdog.
>  
> +config SOFT_WATCHDOG_PRETIMEOUT
> +	bool "Software watchdog pretimeout governor support"
> +	depends on SOFT_WATCHDOG && WATCHDOG_PRETIMEOUT_GOV
> +	help
> +	  Enable this if you want to use pretimeout governors with the software
> +	  watchdog. Be aware that governors might affect the watchdog because it
> +	  is purely software, e.g. the panic governor will stall it!
> +
>  config DA9052_WATCHDOG
>  	tristate "Dialog DA9052 Watchdog"
>  	depends on PMIC_DA9052
> diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
> index c7bdc986dca1c2..7983029852ab0d 100644
> --- a/drivers/watchdog/softdog.c
> +++ b/drivers/watchdog/softdog.c
> @@ -87,11 +87,13 @@ static int softdog_ping(struct watchdog_device *w)
>  	if (!mod_timer(&softdog_ticktock, jiffies + (w->timeout * HZ)))
>  		__module_get(THIS_MODULE);
>  
> -	if (w->pretimeout)
> -		mod_timer(&softdog_preticktock, jiffies +
> -			  (w->timeout - w->pretimeout) * HZ);
> -	else
> -		del_timer(&softdog_preticktock);
> +	if (IS_ENABLED(CONFIG_SOFT_WATCHDOG_PRETIMEOUT)) {
> +		if (w->pretimeout)
> +			mod_timer(&softdog_preticktock, jiffies +
> +				  (w->timeout - w->pretimeout) * HZ);
> +		else
> +			del_timer(&softdog_preticktock);
> +	}
>  
>  	return 0;
>  }
> @@ -101,15 +103,15 @@ static int softdog_stop(struct watchdog_device *w)
>  	if (del_timer(&softdog_ticktock))
>  		module_put(THIS_MODULE);
>  
> -	del_timer(&softdog_preticktock);
> +	if (IS_ENABLED(CONFIG_SOFT_WATCHDOG_PRETIMEOUT))
> +		del_timer(&softdog_preticktock);
>  
>  	return 0;
>  }
>  
>  static struct watchdog_info softdog_info = {
>  	.identity = "Software Watchdog",
> -	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE |
> -		   WDIOF_PRETIMEOUT,
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>  };
>  
>  static const struct watchdog_ops softdog_ops = {
> @@ -134,6 +136,9 @@ static int __init softdog_init(void)
>  	watchdog_set_nowayout(&softdog_dev, nowayout);
>  	watchdog_stop_on_reboot(&softdog_dev);
>  
> +	if (IS_ENABLED(CONFIG_SOFT_WATCHDOG_PRETIMEOUT))
> +		softdog_info.options |= WDIOF_PRETIMEOUT;
> +
>  	ret = watchdog_register_device(&softdog_dev);
>  	if (ret)
>  		return ret;
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
