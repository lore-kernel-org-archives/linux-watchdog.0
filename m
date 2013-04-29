Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm15.access.bullet.mail.mud.yahoo.com ([66.94.237.216]:48861
	"EHLO nm15.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757865Ab3D2Qcm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 12:32:42 -0400
Date: Mon, 29 Apr 2013 09:32:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 1/5] watchdog: dw_wdt: use devm_clk_get()
Message-ID: <20130429163242.GC23799@roeck-us.net>
References: <000201ce44ba$160fc0a0$422f41e0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201ce44ba$160fc0a0$422f41e0$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 29, 2013 at 06:15:26PM +0900, Jingoo Han wrote:
> Use devm_clk_get() to make cleanup paths more simple.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/dw_wdt.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 2037669..2e70fd0 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -305,13 +305,13 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  	if (IS_ERR(dw_wdt.regs))
>  		return PTR_ERR(dw_wdt.regs);
>  
> -	dw_wdt.clk = clk_get(&pdev->dev, NULL);
> +	dw_wdt.clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(dw_wdt.clk))
>  		return PTR_ERR(dw_wdt.clk);
>  
>  	ret = clk_enable(dw_wdt.clk);
>  	if (ret)
> -		goto out_put_clk;
> +		return ret;
>  
>  	spin_lock_init(&dw_wdt.lock);
>  
> @@ -327,8 +327,6 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  
>  out_disable_clk:
>  	clk_disable(dw_wdt.clk);
> -out_put_clk:
> -	clk_put(dw_wdt.clk);
>  
>  	return ret;
>  }
> @@ -338,7 +336,6 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
>  	misc_deregister(&dw_wdt_miscdev);
>  
>  	clk_disable(dw_wdt.clk);
> -	clk_put(dw_wdt.clk);
>  
>  	return 0;
>  }
> -- 
> 1.7.2.5
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
