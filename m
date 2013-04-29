Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm15-vm0.access.bullet.mail.sp2.yahoo.com ([98.139.44.164]:37617
	"EHLO nm15-vm0.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758592Ab3D2RzH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 13:55:07 -0400
Date: Mon, 29 Apr 2013 10:55:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 3/7] watchdog: mv64x60_wdt: use devm_ioremap()
Message-ID: <20130429175507.GC5183@roeck-us.net>
References: <000d01ce44bc$da891380$8f9b3a80$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000d01ce44bc$da891380$8f9b3a80$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 29, 2013 at 06:35:15PM +0900, Jingoo Han wrote:
> Use devm_ioremap() to make cleanup paths simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

This patch also addresses the missing call to iounmap() if the call
to misc_register fails.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mv64x60_wdt.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/mv64x60_wdt.c b/drivers/watchdog/mv64x60_wdt.c
> index c7fb878..e4cf980 100644
> --- a/drivers/watchdog/mv64x60_wdt.c
> +++ b/drivers/watchdog/mv64x60_wdt.c
> @@ -276,7 +276,7 @@ static int mv64x60_wdt_probe(struct platform_device *dev)
>  	if (!r)
>  		return -ENODEV;
>  
> -	mv64x60_wdt_regs = ioremap(r->start, resource_size(r));
> +	mv64x60_wdt_regs = devm_ioremap(&dev->dev, r->start, resource_size(r));
>  	if (mv64x60_wdt_regs == NULL)
>  		return -ENOMEM;
>  
> @@ -293,8 +293,6 @@ static int mv64x60_wdt_remove(struct platform_device *dev)
>  
>  	mv64x60_wdt_handler_disable();
>  
> -	iounmap(mv64x60_wdt_regs);
> -
>  	return 0;
>  }
>  
> -- 
> 1.7.2.5
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
