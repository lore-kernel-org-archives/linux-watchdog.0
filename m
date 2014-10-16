Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:51069 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbaJPU3L (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 16 Oct 2014 16:29:11 -0400
Received: by mail-pd0-f179.google.com with SMTP id r10so3881465pdi.38
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Oct 2014 13:29:10 -0700 (PDT)
Date: Thu, 16 Oct 2014 13:29:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: John Crispin <blogic@openwrt.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] watchdog: rt2880_wdt: minor clean up
Message-ID: <20141016202905.GB26177@roeck-us.net>
References: <1413489665-52342-1-git-send-email-blogic@openwrt.org>
 <1413489665-52342-2-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413489665-52342-2-git-send-email-blogic@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 16, 2014 at 10:01:05PM +0200, John Crispin wrote:
> Replace device_reset() with devm_reset_control_get() + reset_control_deassert().
> Make use of watchdog_init_timeout() instead of setting the timeout manually.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/rt2880_wdt.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
> index d92c2d5..d2cd2bd 100644
> --- a/drivers/watchdog/rt2880_wdt.c
> +++ b/drivers/watchdog/rt2880_wdt.c
> @@ -45,6 +45,7 @@
>  static struct clk *rt288x_wdt_clk;
>  static unsigned long rt288x_wdt_freq;
>  static void __iomem *rt288x_wdt_base;
> +static struct reset_control *rt288x_wdt_reset;
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  module_param(nowayout, bool, 0);
> @@ -151,16 +152,18 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(rt288x_wdt_clk))
>  		return PTR_ERR(rt288x_wdt_clk);
>  
> -	device_reset(&pdev->dev);
> +	rt288x_wdt_reset = devm_reset_control_get(&pdev->dev, NULL);
> +	if (!IS_ERR(rt288x_wdt_reset))
> +		reset_control_deassert(rt288x_wdt_reset);
>  
>  	rt288x_wdt_freq = clk_get_rate(rt288x_wdt_clk) / RALINK_WDT_PRESCALE;
>  
>  	rt288x_wdt_dev.dev = &pdev->dev;
>  	rt288x_wdt_dev.bootstatus = rt288x_wdt_bootcause();
> -
>  	rt288x_wdt_dev.max_timeout = (0xfffful / rt288x_wdt_freq);
> -	rt288x_wdt_dev.timeout = rt288x_wdt_dev.max_timeout;
>  
> +	watchdog_init_timeout(&rt288x_wdt_dev, rt288x_wdt_dev.max_timeout,
> +			      &pdev->dev);
>  	watchdog_set_nowayout(&rt288x_wdt_dev, nowayout);
>  
>  	ret = watchdog_register_device(&rt288x_wdt_dev);
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
