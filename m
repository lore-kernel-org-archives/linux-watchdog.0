Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36838 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCTV7p (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Mar 2018 17:59:45 -0400
Date: Tue, 20 Mar 2018 14:59:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>
Subject: Re: [PATCH] watchdog: renesas-wdt: Add support for WDIOF_CARDRESET
Message-ID: <20180320215943.GB29962@roeck-us.net>
References: <20180320213626.14208-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320213626.14208-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Mar 20, 2018 at 10:36:26PM +0100, Wolfram Sang wrote:
> From: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>
> 
> This patch adds the WDIOF_CARDRESET support for the Renessas platform
> watchdog, to know if the board reboot is due to a watchdog reset.
> 
> This is done via the WOVF bit (bit 4) of the RWTCSRA register, which
> indicates if RWTCNT overflowed, triggering the reset in last boot.
> 
> Signed-off-by: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>
> [takeshi.kihara.df: changed to read the RWTCSRA register while clock is
>  enabled]
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenetr Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/renesas_wdt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index 6b8c6ddfe30b31..514db5cc159511 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -121,7 +121,8 @@ static int rwdt_restart(struct watchdog_device *wdev, unsigned long action,
>  }
>  
>  static const struct watchdog_info rwdt_ident = {
> -	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
> +	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
> +		WDIOF_CARDRESET,
>  	.identity = "Renesas WDT Watchdog",
>  };
>  
> @@ -197,9 +198,10 @@ static int rwdt_probe(struct platform_device *pdev)
>  		return PTR_ERR(clk);
>  
>  	pm_runtime_enable(&pdev->dev);
> -
>  	pm_runtime_get_sync(&pdev->dev);
>  	priv->clk_rate = clk_get_rate(clk);
> +	priv->wdev.bootstatus = (readb_relaxed(priv->base + RWTCSRA) &
> +				RWTCSRA_WOVF) ? WDIOF_CARDRESET : 0;
>  	pm_runtime_put(&pdev->dev);
>  
>  	if (!priv->clk_rate) {
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
