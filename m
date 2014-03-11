Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:46054 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbaCKAFA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Mar 2014 20:05:00 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so7749566pdj.4
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Mar 2014 17:05:00 -0700 (PDT)
Date: Mon, 10 Mar 2014 17:04:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: iTCO_wdt: Fix the parent device
Message-ID: <20140311000457.GB31942@roeck-us.net>
References: <20140310212817.08adda85@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140310212817.08adda85@endymion.delvare>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 10, 2014 at 09:28:17PM +0100, Jean Delvare wrote:
> The watchdog's parent is iTCO_wdt (the platform device) not lpc_ich
> (the PCI device.) Setting the parent right makes it much easier for
> the user to figure out which driver/module is handling the watchdog
> device node.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Makes sense to me.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/iTCO_wdt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-3.14-rc5.orig/drivers/watchdog/iTCO_wdt.c	2014-01-20 03:40:07.000000000 +0100
> +++ linux-3.14-rc5/drivers/watchdog/iTCO_wdt.c	2014-03-08 13:56:01.905564783 +0100
> @@ -485,7 +485,7 @@ static int iTCO_wdt_probe(struct platfor
>  	iTCO_wdt_watchdog_dev.bootstatus = 0;
>  	iTCO_wdt_watchdog_dev.timeout = WATCHDOG_TIMEOUT;
>  	watchdog_set_nowayout(&iTCO_wdt_watchdog_dev, nowayout);
> -	iTCO_wdt_watchdog_dev.parent = dev->dev.parent;
> +	iTCO_wdt_watchdog_dev.parent = &dev->dev;
>  
>  	/* Make sure the watchdog is not running */
>  	iTCO_wdt_stop(&iTCO_wdt_watchdog_dev);
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
