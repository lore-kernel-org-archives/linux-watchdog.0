Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:60218 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754879Ab2BBULm (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 Feb 2012 15:11:42 -0500
Message-ID: <4F2AEC3A.7000304@antcom.de>
Date: Thu, 02 Feb 2012 21:04:10 +0100
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 1/4] watchdog: pnx4008: cleanup resource handling using
 managed devices
References: <1328204891-32551-1-git-send-email-w.sang@pengutronix.de> <1328204891-32551-2-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1328204891-32551-2-git-send-email-w.sang@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/02/2012 06:48 PM, Wolfram Sang wrote:
> The resource handling in this driver was flaky: IO_ADDRESS instead of
> ioremap (and no unmapping), an unneeded static resource, no central exit
> path for error cases. Fix this by converting the driver to use managed
> resources. Also use dev_*-messages instead of printk while we are here.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/watchdog/pnx4008_wdt.c |   74 ++++++++++++++-------------------------
>  1 files changed, 27 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> index 8e210aa..322a392 100644
> --- a/drivers/watchdog/pnx4008_wdt.c
> +++ b/drivers/watchdog/pnx4008_wdt.c
> @@ -89,7 +89,6 @@ static unsigned long wdt_status;
>  
>  static unsigned long boot_status;
>  
> -static struct resource	*wdt_mem;
>  static void __iomem	*wdt_base;
>  struct clk		*wdt_clk;
>  
> @@ -253,61 +252,46 @@ static struct miscdevice pnx4008_wdt_miscdev = {
>  
>  static int __devinit pnx4008_wdt_probe(struct platform_device *pdev)
>  {
> -	int ret = 0, size;
> +	struct resource *r;
> +	int ret = 0;
>  
>  	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
>  		heartbeat = DEFAULT_HEARTBEAT;
>  
> -	printk(KERN_INFO MODULE_NAME
> -		"PNX4008 Watchdog Timer: heartbeat %d sec\n", heartbeat);
> -
> -	wdt_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (wdt_mem == NULL) {
> -		printk(KERN_INFO MODULE_NAME
> -			"failed to get memory region resouce\n");
> -		return -ENOENT;
> -	}
> -
> -	size = resource_size(wdt_mem);
> -
> -	if (!request_mem_region(wdt_mem->start, size, pdev->name)) {
> -		printk(KERN_INFO MODULE_NAME "failed to get memory region\n");
> -		return -ENOENT;
> -	}
> -	wdt_base = (void __iomem *)IO_ADDRESS(wdt_mem->start);
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	wdt_base = devm_request_and_ioremap(&pdev->dev, r);
> +	if (!wdt_base)
> +		return -EADDRINUSE;
>  
>  	wdt_clk = clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(wdt_clk)) {
> -		ret = PTR_ERR(wdt_clk);
> -		release_mem_region(wdt_mem->start, size);
> -		wdt_mem = NULL;
> -		goto out;
> -	}
> +	if (IS_ERR(wdt_clk))
> +		return PTR_ERR(wdt_clk);
>  
>  	ret = clk_enable(wdt_clk);
> -	if (ret) {
> -		release_mem_region(wdt_mem->start, size);
> -		wdt_mem = NULL;
> -		clk_put(wdt_clk);
> -		goto out;
> -	}
> +	if (ret)
> +		goto put_clk;
>  
>  	ret = misc_register(&pnx4008_wdt_miscdev);
>  	if (ret < 0) {
> -		printk(KERN_ERR MODULE_NAME "cannot register misc device\n");
> -		release_mem_region(wdt_mem->start, size);
> -		wdt_mem = NULL;
> -		clk_disable(wdt_clk);
> -		clk_put(wdt_clk);
> -	} else {
> -		boot_status = (__raw_readl(WDTIM_RES(wdt_base)) & WDOG_RESET) ?
> -		    WDIOF_CARDRESET : 0;
> -		wdt_disable();		/*disable for now */
> -		clk_disable(wdt_clk);
> -		set_bit(WDT_DEVICE_INITED, &wdt_status);
> +		dev_err(&pdev->dev, "cannot register misc device\n");
> +		goto disable_clk;
>  	}
>  
> -out:
> +	boot_status = (__raw_readl(WDTIM_RES(wdt_base)) &
> +		WDOG_RESET) ? WDIOF_CARDRESET : 0;
> +	wdt_disable();		/*disable for now */
> +	clk_disable(wdt_clk);
> +	set_bit(WDT_DEVICE_INITED, &wdt_status);
> +
> +	dev_info(&pdev->dev, "PNX4008 Watchdog Timer: heartbeat %d sec\n",
> +			heartbeat);
> +
> +	return 0;
> +
> + disable_clk:
> +	clk_disable(wdt_clk);
> + put_clk:
> +	clk_put(wdt_clk);
>  	return ret;
>  }
>  
> @@ -318,10 +302,6 @@ static int __devexit pnx4008_wdt_remove(struct platform_device *pdev)
>  	clk_disable(wdt_clk);
>  	clk_put(wdt_clk);
>  
> -	if (wdt_mem) {
> -		release_mem_region(wdt_mem->start, resource_size(wdt_mem));
> -		wdt_mem = NULL;
> -	}
>  	return 0;
>  }
>  

Tested-by: Roland Stigge <stigge@antcom.de>
