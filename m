Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57148 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526AbcEYRbF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 13:31:05 -0400
Date: Wed, 25 May 2016 10:31:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 4/7] watchdog: softdog: remove forward declaration
Message-ID: <20160525173110.GF19545@roeck-us.net>
References: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
 <1464158269-2447-5-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464158269-2447-5-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 25, 2016 at 08:37:46AM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/softdog.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
> index 0a29f5a0833787..42faa3d424d5ca 100644
> --- a/drivers/watchdog/softdog.c
> +++ b/drivers/watchdog/softdog.c
> @@ -54,11 +54,6 @@ module_param(soft_panic, int, 0);
>  MODULE_PARM_DESC(soft_panic,
>  	"Softdog action, set to 1 to panic, 0 to reboot (default=0)");
>  
> -static void softdog_fire(unsigned long);
> -
> -static struct timer_list softdog_ticktock =
> -		TIMER_INITIALIZER(softdog_fire, 0, 0);
> -
>  static void softdog_fire(unsigned long data)
>  {
>  	module_put(THIS_MODULE);
> @@ -74,6 +69,9 @@ static void softdog_fire(unsigned long data)
>  	}
>  }
>  
> +static struct timer_list softdog_ticktock =
> +		TIMER_INITIALIZER(softdog_fire, 0, 0);
> +
>  static int softdog_ping(struct watchdog_device *w)
>  {
>  	if (!mod_timer(&softdog_ticktock, jiffies+(w->timeout*HZ)))
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
