Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43540 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753841AbdL1SkN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 28 Dec 2017 13:40:13 -0500
Subject: Re: [PATCH 2/7] watchdog: jz4740: Use devm_* functions
To: Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20171228162939.3928-1-paul@crapouillou.net>
 <20171228162939.3928-3-paul@crapouillou.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9b5a2b88-995b-0540-6cf5-aba8b1ba6508@roeck-us.net>
Date: Thu, 28 Dec 2017 10:40:11 -0800
MIME-Version: 1.0
In-Reply-To: <20171228162939.3928-3-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/28/2017 08:29 AM, Paul Cercueil wrote:
> - Use devm_clk_get instead of clk_get
> - Use devm_watchdog_register_device instead of watchdog_register_device
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

[ the change I suggested earlier should be made in a separate patch ]

> ---
>   drivers/watchdog/jz4740_wdt.c | 27 ++++++++-------------------
>   1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 6955deb100ef..92d6ca8ceb49 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -178,40 +178,29 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(drvdata->base)) {
> -		ret = PTR_ERR(drvdata->base);
> -		goto err_out;
> -	}
> +	if (IS_ERR(drvdata->base))
> +		return PTR_ERR(drvdata->base);
>   
> -	drvdata->rtc_clk = clk_get(&pdev->dev, "rtc");
> +	drvdata->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
>   	if (IS_ERR(drvdata->rtc_clk)) {
>   		dev_err(&pdev->dev, "cannot find RTC clock\n");
> -		ret = PTR_ERR(drvdata->rtc_clk);
> -		goto err_out;
> +		return PTR_ERR(drvdata->rtc_clk);
>   	}
>   
> -	ret = watchdog_register_device(&drvdata->wdt);
> +	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
>   	if (ret < 0)
> -		goto err_disable_clk;
> +		return ret;
>   
>   	platform_set_drvdata(pdev, drvdata);
> -	return 0;
>   
> -err_disable_clk:
> -	clk_put(drvdata->rtc_clk);
> -err_out:
> -	return ret;
> +	return 0;
>   }
>   
>   static int jz4740_wdt_remove(struct platform_device *pdev)
>   {
>   	struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
>   
> -	jz4740_wdt_stop(&drvdata->wdt);
> -	watchdog_unregister_device(&drvdata->wdt);
> -	clk_put(drvdata->rtc_clk);
> -
> -	return 0;
> +	return jz4740_wdt_stop(&drvdata->wdt);
>   }
>   
>   static struct platform_driver jz4740_wdt_driver = {
> 

