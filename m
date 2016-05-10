Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54708 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbcEJVwb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 10 May 2016 17:52:31 -0400
Date: Tue, 10 May 2016 14:52:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: shwdt: Use setup_timer()
Message-ID: <20160510215227.GB19128@roeck-us.net>
References: <1462539581-26207-1-git-send-email-falakreyaz@gmail.com>
 <1462539581-26207-2-git-send-email-falakreyaz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462539581-26207-2-git-send-email-falakreyaz@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 06, 2016 at 06:29:41PM +0530, Muhammad Falak R Wani wrote:
> The function setup_timer combines the initialization of a timer with
> the initialization of the timer's function and data fields.
> The multiline code for timer initialization is now replaced
> with function setup_timer.
> 
> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
