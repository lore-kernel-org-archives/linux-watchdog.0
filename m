Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:58127 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756605Ab3EXO73 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 May 2013 10:59:29 -0400
Date: Fri, 24 May 2013 07:59:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 5/5] watchdog: wm831x: use platform_{get,set}_drvdata()
Message-ID: <20130524145946.GF6085@roeck-us.net>
References: <003801ce57a2$8f0dae40$ad290ac0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003801ce57a2$8f0dae40$ad290ac0$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 23, 2013 at 07:44:53PM +0900, Jingoo Han wrote:
> Use the wrapper functions for getting and setting the driver data using
> platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
> so we can directly pass a struct platform_device.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/wm831x_wdt.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
> index 9dcb6d0..6c302fd 100644
> --- a/drivers/watchdog/wm831x_wdt.c
> +++ b/drivers/watchdog/wm831x_wdt.c
> @@ -281,7 +281,7 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
>  		goto err_gpio;
>  	}
>  
> -	dev_set_drvdata(&pdev->dev, driver_data);
> +	platform_set_drvdata(pdev, driver_data);
>  
>  	return 0;
>  
> @@ -294,7 +294,7 @@ err:
>  
>  static int wm831x_wdt_remove(struct platform_device *pdev)
>  {
> -	struct wm831x_wdt_drvdata *driver_data = dev_get_drvdata(&pdev->dev);
> +	struct wm831x_wdt_drvdata *driver_data = platform_get_drvdata(pdev);
>  
>  	watchdog_unregister_device(&driver_data->wdt);
>  
> -- 
> 1.7.10.4
> 
> 
> 
