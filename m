Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:58055 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494AbaBORo6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Feb 2014 12:44:58 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so13130697pde.6
        for <linux-watchdog@vger.kernel.org>; Sat, 15 Feb 2014 09:44:57 -0800 (PST)
Date: Sat, 15 Feb 2014 09:44:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: indydog: Simplify indydog_{start,stop}
Message-ID: <20140215174455.GC19001@roeck-us.net>
References: <1392456111-29962-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392456111-29962-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Feb 15, 2014 at 01:21:51PM +0400, Alexander Shiyan wrote:
> This patch simplify functions indydog_start() and indydog_stop()
> a bit and removes excess intermediate variable.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/indydog.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/watchdog/indydog.c b/drivers/watchdog/indydog.c
> index 1b5c25a..5d20cdd 100644
> --- a/drivers/watchdog/indydog.c
> +++ b/drivers/watchdog/indydog.c
> @@ -41,24 +41,15 @@ MODULE_PARM_DESC(nowayout,
>  
>  static void indydog_start(void)
>  {
> -	u32 mc_ctrl0;
> -
>  	spin_lock(&indydog_lock);
> -	mc_ctrl0 = sgimc->cpuctrl0;
> -	mc_ctrl0 = sgimc->cpuctrl0 | SGIMC_CCTRL0_WDOG;
> -	sgimc->cpuctrl0 = mc_ctrl0;
> +	sgimc->cpuctrl0 |= SGIMC_CCTRL0_WDOG;
>  	spin_unlock(&indydog_lock);
>  }
>  
>  static void indydog_stop(void)
>  {
> -	u32 mc_ctrl0;
> -
>  	spin_lock(&indydog_lock);
> -
> -	mc_ctrl0 = sgimc->cpuctrl0;
> -	mc_ctrl0 &= ~SGIMC_CCTRL0_WDOG;
> -	sgimc->cpuctrl0 = mc_ctrl0;
> +	sgimc->cpuctrl0 &= ~SGIMC_CCTRL0_WDOG;
>  	spin_unlock(&indydog_lock);
>  
>  	pr_info("Stopped watchdog timer\n");
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
