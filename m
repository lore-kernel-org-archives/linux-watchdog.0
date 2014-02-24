Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:59348 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753080AbaBXT6G (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Feb 2014 14:58:06 -0500
Date: Mon, 24 Feb 2014 20:58:06 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: indydog: Simplify indydog_{start,stop}
Message-ID: <20140224195806.GI20712@spo001.leaseweb.com>
References: <1392456111-29962-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392456111-29962-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alexander,

> This patch simplify functions indydog_start() and indydog_stop()
> a bit and removes excess intermediate variable.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
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

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

