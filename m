Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm30.access.bullet.mail.sp2.yahoo.com ([98.139.44.157]:21932
	"EHLO nm30.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758098Ab3D2QeH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 12:34:07 -0400
Date: Mon, 29 Apr 2013 09:34:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 4/5] watchdog: shwdt: use devm_clk_get()
Message-ID: <20130429163407.GF23799@roeck-us.net>
References: <000501ce44ba$3df0f350$b9d2d9f0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000501ce44ba$3df0f350$b9d2d9f0$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 29, 2013 at 06:16:33PM +0900, Jingoo Han wrote:
> Use devm_clk_get() to make cleanup paths more simple.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/shwdt.c |   16 ++++------------
>  1 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
> index 6185af2..ea2154b 100644
> --- a/drivers/watchdog/shwdt.c
> +++ b/drivers/watchdog/shwdt.c
> @@ -241,7 +241,7 @@ static int sh_wdt_probe(struct platform_device *pdev)
>  
>  	wdt->dev = &pdev->dev;
>  
> -	wdt->clk = clk_get(&pdev->dev, NULL);
> +	wdt->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(wdt->clk)) {
>  		/*
>  		 * Clock framework support is optional, continue on
> @@ -251,10 +251,8 @@ static int sh_wdt_probe(struct platform_device *pdev)
>  	}
>  
>  	wdt->base = devm_ioremap_resource(wdt->dev, res);
> -	if (IS_ERR(wdt->base)) {
> -		rc = PTR_ERR(wdt->base);
> -		goto err;
> -	}
> +	if (IS_ERR(wdt->base))
> +		return PTR_ERR(wdt->base);
>  
>  	watchdog_set_nowayout(&sh_wdt_dev, nowayout);
>  	watchdog_set_drvdata(&sh_wdt_dev, wdt);
> @@ -277,7 +275,7 @@ static int sh_wdt_probe(struct platform_device *pdev)
>  	rc = watchdog_register_device(&sh_wdt_dev);
>  	if (unlikely(rc)) {
>  		dev_err(&pdev->dev, "Can't register watchdog (err=%d)\n", rc);
> -		goto err;
> +		return rc;
>  	}
>  
>  	init_timer(&wdt->timer);
> @@ -292,11 +290,6 @@ static int sh_wdt_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>  
>  	return 0;
> -
> -err:
> -	clk_put(wdt->clk);
> -
> -	return rc;
>  }
>  
>  static int sh_wdt_remove(struct platform_device *pdev)
> @@ -308,7 +301,6 @@ static int sh_wdt_remove(struct platform_device *pdev)
>  	watchdog_unregister_device(&sh_wdt_dev);
>  
>  	pm_runtime_disable(&pdev->dev);
> -	clk_put(wdt->clk);
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
