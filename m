Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:33984 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756293AbaCOTol (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Mar 2014 15:44:41 -0400
Date: Sat, 15 Mar 2014 20:44:38 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: iTCO_wdt: Fix the parent device
Message-ID: <20140315194438.GA14401@spo001.leaseweb.com>
References: <20140310212817.08adda85@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140310212817.08adda85@endymion.delvare>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jean,

> The watchdog's parent is iTCO_wdt (the platform device) not lpc_ich
> (the PCI device.) Setting the parent right makes it much easier for
> the user to figure out which driver/module is handling the watchdog
> device node.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
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

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

