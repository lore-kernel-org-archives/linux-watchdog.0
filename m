Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37696 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696AbcAOSs7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Jan 2016 13:48:59 -0500
Date: Fri, 15 Jan 2016 10:48:56 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] watchdog: max63xx: make module's license marker match
 the header
Message-ID: <20160115184856.GA4413@roeck-us.net>
References: <1452879334-2499-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1452879334-2499-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jan 15, 2016 at 06:35:34PM +0100, Uwe Kleine-König wrote:
> The header specifies GPL version 2 only, so make the MODULE_LICENSE
> string use the respective string for that.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/max63xx_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
> index f36ca4be0720..ac5840d9689a 100644
> --- a/drivers/watchdog/max63xx_wdt.c
> +++ b/drivers/watchdog/max63xx_wdt.c
> @@ -292,4 +292,4 @@ MODULE_PARM_DESC(nodelay,
>  		 "Force selection of a timeout setting without initial delay "
>  		 "(max6373/74 only, default=0)");
>  
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
