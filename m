Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43789 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932290AbbIBUTX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Sep 2015 16:19:23 -0400
Date: Wed, 2 Sep 2015 13:19:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Justin Chen <justinpopo6@gmail.com>
Cc: linux-kernel@vger.kernel.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] watchdog_dev: Use device tree alias for naming watchdogs
Message-ID: <20150902201918.GA19158@roeck-us.net>
References: <1441216817-25095-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1441216817-25095-1-git-send-email-justinpopo6@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Justin,

On Wed, Sep 02, 2015 at 11:00:17AM -0700, Justin Chen wrote:
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

Minor nitpick: the changelog should be after the '---'.

Other than that, I really like it. Well done.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

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
