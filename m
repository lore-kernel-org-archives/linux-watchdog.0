Return-Path: <wimvs@spo001.leaseweb.com>
Date: Mon, 24 Feb 2014 20:55:15 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-watchdog@vger.kernel.org, 'Guenter Roeck' <linux@roeck-us.net>,
	'H Hartley Sweeten' <hsweeten@visionengravers.com>
Subject: Re: [PATCH 1/3] watchdog: ep93xx_wdt: Use devm_ioremap_resource()
Message-ID: <20140224195515.GE20712@spo001.leaseweb.com>
References: <000e01cf2726$a511a030$ef34e090$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000e01cf2726$a511a030$ef34e090$%han@samsung.com>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Jingoo,

> Use devm_ioremap_resource() in order to make the code simpler,
> and remove redundant return value check of platform_get_resource()
> because the value is checked by devm_ioremap_resource().
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/watchdog/ep93xx_wdt.c |   13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
> index d1d07f2..5e4f3de 100644
> --- a/drivers/watchdog/ep93xx_wdt.c
> +++ b/drivers/watchdog/ep93xx_wdt.c
> @@ -118,16 +118,9 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
>  	int err;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENXIO;
> -
> -	if (!devm_request_mem_region(&pdev->dev, res->start,
> -				     resource_size(res), pdev->name))
> -		return -EBUSY;
> -
> -	mmio_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> -	if (!mmio_base)
> -		return -ENXIO;
> +	mmio_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(mmio_base))
> +		return PTR_ERR(mmio_base);
>  
>  	if (timeout < 1 || timeout > 3600) {
>  		timeout = WDT_TIMEOUT;
> -- 
> 1.7.10.4
> 
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.
