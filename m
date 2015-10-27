Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:55276 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932256AbbJ0Pr2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Oct 2015 11:47:28 -0400
Date: Tue, 27 Oct 2015 16:47:26 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Justin Chen <justinpopo6@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux@roeck-us.net, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] watchdog_dev: Use device tree alias for naming watchdogs
Message-ID: <20151027154726.GA27947@spo001.leaseweb.nl>
References: <1441216817-25095-1-git-send-email-justinpopo6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1441216817-25095-1-git-send-email-justinpopo6@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Justin,

> Currently there is no way to easily differentiate multiple
> watchdog devices. The watchdogs are named by the order they
> are probed.
> 1st probed watchdog: /dev/watchdog0
> 2nd probed watchdog: /dev/watchdog1
> ...
> 
> This change uses the alias of the watchdog device node for
> the name of the watchdog.
> aliases {
>     watchdog0 = "/...../...."
>     watchdog3 = "/..../....."
>     watchdog2 = "/..../....."
>     ...
> }
> 
> This will translate to...
> /dev/watchdog0
> /dev/watchdog3
> /dev/watchdog2
> 
> v2
> Assign alias number to id in watchdog_core instead of watchdog_dev.
> If failed to get id, fallback to original ida_simple_get call.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> ---
>  drivers/watchdog/watchdog_core.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 1a80594..873f139 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -139,7 +139,7 @@ EXPORT_SYMBOL_GPL(watchdog_init_timeout);
>  
>  static int __watchdog_register_device(struct watchdog_device *wdd)
>  {
> -	int ret, id, devno;
> +	int ret, id = -1, devno;
>  
>  	if (wdd == NULL || wdd->info == NULL || wdd->ops == NULL)
>  		return -EINVAL;
> @@ -157,7 +157,18 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>  	 */
>  
>  	mutex_init(&wdd->lock);
> -	id = ida_simple_get(&watchdog_ida, 0, MAX_DOGS, GFP_KERNEL);
> +
> +	/* Use alias for watchdog id if possible */
> +	if (wdd->parent) {
> +		ret = of_alias_get_id(wdd->parent->of_node, "watchdog");
> +		if (ret >= 0)
> +			id = ida_simple_get(&watchdog_ida, ret,
> +					    ret + 1, GFP_KERNEL);
> +	}
> +
> +	if (id < 0)
> +		id = ida_simple_get(&watchdog_ida, 0, MAX_DOGS, GFP_KERNEL);
> +
>  	if (id < 0)
>  		return id;
>  	wdd->id = id;
> -- 
> 2.1.0
> 

Added to linux-watchdog-next.

Kind regards,
Wim.

