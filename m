Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:59352 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753055AbaBXT7b (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Feb 2014 14:59:31 -0500
Date: Mon, 24 Feb 2014 20:59:30 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: sc520_wdt: Remove unused variable
Message-ID: <20140224195930.GK20712@spo001.leaseweb.com>
References: <1392456169-30042-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392456169-30042-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alexander,

> Variable "dummy" is not used anywhere in the function wdt_config().
> This patch removes this variable.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
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

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

