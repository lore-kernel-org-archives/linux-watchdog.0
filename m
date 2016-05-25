Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57559 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932808AbcEYRbb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 13:31:31 -0400
Date: Wed, 25 May 2016 10:31:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 6/7] watchdog: softdog: drop superfluous set_timeout
 callback
Message-ID: <20160525173126.GH19545@roeck-us.net>
References: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
 <1464158269-2447-7-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464158269-2447-7-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 25, 2016 at 08:37:48AM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> If we leave set_timeout empty, the core will do exactly what is
> implemented here anyway.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/softdog.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
> index ab0e02fc81a276..5e3a30b99d4415 100644
> --- a/drivers/watchdog/softdog.c
> +++ b/drivers/watchdog/softdog.c
> @@ -87,12 +87,6 @@ static int softdog_stop(struct watchdog_device *w)
>  	return 0;
>  }
>  
> -static int softdog_set_timeout(struct watchdog_device *w, unsigned int t)
> -{
> -	w->timeout = t;
> -	return 0;
> -}
> -
>  static struct watchdog_info softdog_info = {
>  	.identity = "Software Watchdog",
>  	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> @@ -102,7 +96,6 @@ static struct watchdog_ops softdog_ops = {
>  	.owner = THIS_MODULE,
>  	.start = softdog_ping,
>  	.stop = softdog_stop,
> -	.set_timeout = softdog_set_timeout,
>  };
>  
>  static struct watchdog_device softdog_dev = {
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
