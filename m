Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:36377 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3HCXLq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 3 Aug 2013 19:11:46 -0400
Received: by mail-we0-f170.google.com with SMTP id w60so1514307wes.29
        for <linux-watchdog@vger.kernel.org>; Sat, 03 Aug 2013 16:11:45 -0700 (PDT)
Date: Sun, 4 Aug 2013 00:11:42 +0100
From: Jamie Iles <jamie@jamieiles.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wim Van Sebroeck' <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH] watchdog: dw_wdt: Add __user annotation
Message-ID: <20130803231142.GA3515@maple>
References: <003101ce8e79$5e7a6670$1b6f3350$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003101ce8e79$5e7a6670$1b6f3350$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jingoo,

On Thu, Aug 01, 2013 at 02:38:36PM +0900, Jingoo Han wrote:
> Added __user annotation to fix the following sparse warnings.
> 
> drivers/watchdog/dw_wdt.c:206:38: warning: incorrect type in argument 1 (different address spaces)
> drivers/watchdog/dw_wdt.c:206:38:    expected void [noderef] <asn:1>*to
> drivers/watchdog/dw_wdt.c:206:38:    got struct watchdog_info *<noident>
> drivers/watchdog/dw_wdt.c:211:24: warning: incorrect type in initializer (different address spaces)
> drivers/watchdog/dw_wdt.c:211:24:    expected int const [noderef] <asn:1>*register __p
> drivers/watchdog/dw_wdt.c:211:24:    got int *<noident>
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

This looks good to me, thanks.

Acked-by: Jamie Iles <jamie@jamieiles.com>

> ---
>  drivers/watchdog/dw_wdt.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index e621098..cd5befb 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -203,12 +203,12 @@ static long dw_wdt_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  
>  	switch (cmd) {
>  	case WDIOC_GETSUPPORT:
> -		return copy_to_user((struct watchdog_info *)arg, &dw_wdt_ident,
> +		return copy_to_user((void __user *)arg, &dw_wdt_ident,
>  				    sizeof(dw_wdt_ident)) ? -EFAULT : 0;
>  
>  	case WDIOC_GETSTATUS:
>  	case WDIOC_GETBOOTSTATUS:
> -		return put_user(0, (int *)arg);
> +		return put_user(0, (int __user *)arg);
>  
>  	case WDIOC_KEEPALIVE:
>  		dw_wdt_set_next_heartbeat();
> -- 
> 1.7.10.4
> 
> 
