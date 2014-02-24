Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:59340 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752768AbaBXTzx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Feb 2014 14:55:53 -0500
Date: Mon, 24 Feb 2014 20:55:52 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Michal Simek' <michal.simek@xilinx.com>,
	'Viresh Kumar' <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] watchdog: sp805_wdt: Use devm_ioremap_resource()
Message-ID: <20140224195552.GG20712@spo001.leaseweb.com>
References: <000e01cf2726$a511a030$ef34e090$%han@samsung.com> <001001cf2727$355d2ba0$a01782e0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001001cf2727$355d2ba0$a01782e0$%han@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jingoo,

> Use devm_ioremap_resource() in order to make the code simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/watchdog/sp805_wdt.c |   17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 3f786ce..cf35036 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -209,13 +209,6 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct sp805_wdt *wdt;
>  	int ret = 0;
>  
> -	if (!devm_request_mem_region(&adev->dev, adev->res.start,
> -				resource_size(&adev->res), "sp805_wdt")) {
> -		dev_warn(&adev->dev, "Failed to get memory region resource\n");
> -		ret = -ENOENT;
> -		goto err;
> -	}
> -
>  	wdt = devm_kzalloc(&adev->dev, sizeof(*wdt), GFP_KERNEL);
>  	if (!wdt) {
>  		dev_warn(&adev->dev, "Kzalloc failed\n");
> @@ -223,13 +216,9 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>  		goto err;
>  	}
>  
> -	wdt->base = devm_ioremap(&adev->dev, adev->res.start,
> -			resource_size(&adev->res));
> -	if (!wdt->base) {
> -		ret = -ENOMEM;
> -		dev_warn(&adev->dev, "ioremap fail\n");
> -		goto err;
> -	}
> +	wdt->base = devm_ioremap_resource(&adev->dev, &adev->res);
> +	if (IS_ERR(wdt->base))
> +		return PTR_ERR(wdt->base);
>  
>  	wdt->clk = devm_clk_get(&adev->dev, NULL);
>  	if (IS_ERR(wdt->clk)) {
> -- 
> 1.7.10.4
> 
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

