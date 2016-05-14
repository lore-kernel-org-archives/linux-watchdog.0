Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:34827 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932385AbcENSe7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 14 May 2016 14:34:59 -0400
Date: Sat, 14 May 2016 20:34:56 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: shwdt: Use setup_timer()
Message-ID: <20160514183456.GG21026@spo001.leaseweb.nl>
References: <1462539581-26207-1-git-send-email-falakreyaz@gmail.com> <1462539581-26207-2-git-send-email-falakreyaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462539581-26207-2-git-send-email-falakreyaz@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Muhammed,

> The function setup_timer combines the initialization of a timer with
> the initialization of the timer's function and data fields.
> The multiline code for timer initialization is now replaced
> with function setup_timer.
> 
> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
> ---
>  drivers/watchdog/shwdt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
> index f908121..517a733 100644
> --- a/drivers/watchdog/shwdt.c
> +++ b/drivers/watchdog/shwdt.c
> @@ -275,9 +275,7 @@ static int sh_wdt_probe(struct platform_device *pdev)
>  		return rc;
>  	}
>  
> -	init_timer(&wdt->timer);
> -	wdt->timer.function	= sh_wdt_ping;
> -	wdt->timer.data		= (unsigned long)wdt;
> +	setup_timer(&wdt->timer, sh_wdt_ping, (unsigned long)wdt);
>  	wdt->timer.expires	= next_ping_period(clock_division_ratio);
>  
>  	dev_info(&pdev->dev, "initialized.\n");
> -- 
> 1.9.1
> 

This patch was added to linux-watchdog-next.

Kind Regards,
Wim.

