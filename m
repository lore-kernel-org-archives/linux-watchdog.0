Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:55878 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab3EXO6e (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 May 2013 10:58:34 -0400
Date: Fri, 24 May 2013 07:58:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/5] watchdog: da9052: use platform_{get,set}_drvdata()
Message-ID: <20130524145850.GC6085@roeck-us.net>
References: <003501ce57a2$749344d0$5db9ce70$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003501ce57a2$749344d0$5db9ce70$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 23, 2013 at 07:44:09PM +0900, Jingoo Han wrote:
> Use the wrapper functions for getting and setting the driver data using
> platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
> so we can directly pass a struct platform_device.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/da9052_wdt.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
> index 3674450..f09c54e 100644
> --- a/drivers/watchdog/da9052_wdt.c
> +++ b/drivers/watchdog/da9052_wdt.c
> @@ -215,14 +215,14 @@ static int da9052_wdt_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	dev_set_drvdata(&pdev->dev, driver_data);
> +	platform_set_drvdata(pdev, driver_data);
>  err:
>  	return ret;
>  }
>  
>  static int da9052_wdt_remove(struct platform_device *pdev)
>  {
> -	struct da9052_wdt_data *driver_data = dev_get_drvdata(&pdev->dev);
> +	struct da9052_wdt_data *driver_data = platform_get_drvdata(pdev);
>  
>  	watchdog_unregister_device(&driver_data->wdt);
>  	kref_put(&driver_data->kref, da9052_wdt_release_resources);
> -- 
> 1.7.10.4
> 
> 
> 
