Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57554 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932385AbcEYRba (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 13:31:30 -0400
Date: Wed, 25 May 2016 10:31:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 7/7] watchdog: softdog: improve coding style
Message-ID: <20160525173135.GI19545@roeck-us.net>
References: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
 <1464158269-2447-8-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464158269-2447-8-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 25, 2016 at 08:37:49AM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/softdog.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
> index 5e3a30b99d4415..b067edf246dff2 100644
> --- a/drivers/watchdog/softdog.c
> +++ b/drivers/watchdog/softdog.c
> @@ -57,9 +57,9 @@ MODULE_PARM_DESC(soft_panic,
>  static void softdog_fire(unsigned long data)
>  {
>  	module_put(THIS_MODULE);
> -	if (soft_noboot)
> +	if (soft_noboot) {
>  		pr_crit("Triggered - Reboot ignored\n");
> -	else if (soft_panic) {
> +	} else if (soft_panic) {
>  		pr_crit("Initiating panic\n");
>  		panic("Software Watchdog Timer expired");
>  	} else {
> @@ -74,7 +74,7 @@ static struct timer_list softdog_ticktock =
>  
>  static int softdog_ping(struct watchdog_device *w)
>  {
> -	if (!mod_timer(&softdog_ticktock, jiffies+(w->timeout*HZ)))
> +	if (!mod_timer(&softdog_ticktock, jiffies + (w->timeout * HZ)))
>  		__module_get(THIS_MODULE);
>  	return 0;
>  }
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
