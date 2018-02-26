Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40311 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeBZWiz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Feb 2018 17:38:55 -0500
Date: Mon, 26 Feb 2018 14:38:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: Re: [PATCH] watchdog: renesas_wdt: adapt timer setup to recommended
 procedure
Message-ID: <20180226223853.GC5924@roeck-us.net>
References: <20180226214905.24516-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226214905.24516-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 26, 2018 at 10:49:05PM +0100, Wolfram Sang wrote:
> The datasheet says we should stop the timer before changing the clock
> divider. So, let's meet that recommendation.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/watchdog/renesas_wdt.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index 831ef83f6de15b..c4a17d72d02506 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -74,12 +74,17 @@ static int rwdt_init_timeout(struct watchdog_device *wdev)
>  static int rwdt_start(struct watchdog_device *wdev)
>  {
>  	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u8 val;
>  
>  	pm_runtime_get_sync(wdev->parent);
>  
> -	rwdt_write(priv, 0, RWTCSRB);
> -	rwdt_write(priv, priv->cks, RWTCSRA);

Isn't this done implicitly with the above already ?
After all, priv->cks won't have RWTCSRA_TME set.

The only exception I can think of is if the watchdog is 
already running during boot, but that situation isn't handled
anyway.

Thanks,
Guenter

> +	/* Stop the timer before we modify any register */
> +	val = readb_relaxed(priv->base + RWTCSRA) & ~RWTCSRA_TME;
> +	rwdt_write(priv, val, RWTCSRA);
> +
>  	rwdt_init_timeout(wdev);
> +	rwdt_write(priv, priv->cks, RWTCSRA);
> +	rwdt_write(priv, 0, RWTCSRB);
>  
>  	while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
>  		cpu_relax();
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
