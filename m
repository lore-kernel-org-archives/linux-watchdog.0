Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:57902 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbaBORrn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Feb 2014 12:47:43 -0500
Received: by mail-pb0-f48.google.com with SMTP id rr13so13576444pbb.21
        for <linux-watchdog@vger.kernel.org>; Sat, 15 Feb 2014 09:47:43 -0800 (PST)
Date: Sat, 15 Feb 2014 09:47:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: sc520_wdt: Remove unused variable
Message-ID: <20140215174740.GE19001@roeck-us.net>
References: <1392456169-30042-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392456169-30042-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Feb 15, 2014 at 01:22:49PM +0400, Alexander Shiyan wrote:
> Variable "dummy" is not used anywhere in the function wdt_config().
> This patch removes this variable.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sc520_wdt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/sc520_wdt.c b/drivers/watchdog/sc520_wdt.c
> index f353e18..1cfd3f6 100644
> --- a/drivers/watchdog/sc520_wdt.c
> +++ b/drivers/watchdog/sc520_wdt.c
> @@ -158,12 +158,11 @@ static void wdt_timer_ping(unsigned long data)
>  
>  static void wdt_config(int writeval)
>  {
> -	__u16 dummy;
>  	unsigned long flags;
>  
>  	/* buy some time (ping) */
>  	spin_lock_irqsave(&wdt_spinlock, flags);
> -	dummy = readw(wdtmrctl);	/* ensure write synchronization */
> +	readw(wdtmrctl);	/* ensure write synchronization */
>  	writew(0xAAAA, wdtmrctl);
>  	writew(0x5555, wdtmrctl);
>  	/* unlock WDT = make WDT configuration register writable one time */
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
