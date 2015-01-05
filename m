Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54083 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753348AbbAETCy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 5 Jan 2015 14:02:54 -0500
Date: Mon, 5 Jan 2015 10:59:02 -0800
From: Tony Lindgren <tony@atomide.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org,
	Thomas Dziedzic <gostrc@gmail.com>
Subject: Re: [PATCH] watchdog: Fix omap watchdogs to enable the magic close
 bit
Message-ID: <20150105185902.GH4081@atomide.com>
References: <20141014192518.GH4972@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141014192518.GH4972@atomide.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [141014 12:27]:
> This allows testing the watchdog easily with distros just by
> doing pkill -9 watchdog.
> 
> Reported-by: Thomas Dziedzic <gostrc@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Wim, still not seeing this applied, did you forget about this one?

Regards,

Tony
 
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -189,7 +189,7 @@ static int omap_wdt_set_timeout(struct watchdog_device *wdog,
>  }
>  
>  static const struct watchdog_info omap_wdt_info = {
> -	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
>  	.identity = "OMAP Watchdog",
>  };
>  
> --- a/drivers/watchdog/retu_wdt.c
> +++ b/drivers/watchdog/retu_wdt.c
> @@ -94,7 +94,7 @@ static int retu_wdt_set_timeout(struct watchdog_device *wdog,
>  }
>  
>  static const struct watchdog_info retu_wdt_info = {
> -	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
>  	.identity = "Retu watchdog",
>  };
>  
> --- a/drivers/watchdog/twl4030_wdt.c
> +++ b/drivers/watchdog/twl4030_wdt.c
> @@ -57,7 +57,7 @@ static int twl4030_wdt_set_timeout(struct watchdog_device *wdt,
>  }
>  
>  static const struct watchdog_info twl4030_wdt_info = {
> -	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
>  	.identity = "TWL4030 Watchdog",
>  };
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
