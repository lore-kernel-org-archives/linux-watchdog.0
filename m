Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm30-vm0.access.bullet.mail.sp2.yahoo.com ([98.139.44.194]:31942
	"EHLO nm30-vm0.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757328Ab3D2QoZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 12:44:25 -0400
Date: Mon, 29 Apr 2013 09:44:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] watchdog: mtx1-wdt: use
 devm_gpio_request_one()
Message-ID: <20130429164425.GJ23799@roeck-us.net>
References: <000901ce44bc$38dcfbf0$aa96f3d0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901ce44bc$38dcfbf0$aa96f3d0$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 29, 2013 at 06:30:43PM +0900, Jingoo Han wrote:
> Use devm_gpio_request_one() to make cleanup paths simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

This patch also addresses the missing gpio_free in the probe error path
(if the call to misc_register() fails).

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mtx-1_wdt.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> index 14dab6f..b434111 100644
> --- a/drivers/watchdog/mtx-1_wdt.c
> +++ b/drivers/watchdog/mtx-1_wdt.c
> @@ -209,7 +209,7 @@ static int mtx1_wdt_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	mtx1_wdt_device.gpio = pdev->resource[0].start;
> -	ret = gpio_request_one(mtx1_wdt_device.gpio,
> +	ret = devm_gpio_request_one(&pdev->dev, mtx1_wdt_device.gpio,
>  				GPIOF_OUT_INIT_HIGH, "mtx1-wdt");
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to request gpio");
> @@ -241,7 +241,6 @@ static int mtx1_wdt_remove(struct platform_device *pdev)
>  		wait_for_completion(&mtx1_wdt_device.stop);
>  	}
>  
> -	gpio_free(mtx1_wdt_device.gpio);
>  	misc_deregister(&mtx1_wdt_misc);
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
