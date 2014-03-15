Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:33979 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750900AbaCOTaD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Mar 2014 15:30:03 -0400
Date: Sat, 15 Mar 2014 20:30:00 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: s3c2410_wdt: Check return value of clk_prepare_enable
Message-ID: <20140315193000.GB13799@spo001.leaseweb.com>
References: <1393925675-21636-1-git-send-email-sachin.kamat@linaro.org> <1393925675-21636-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1393925675-21636-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sachin,

> clk_prepare_enable can fail. Check its return value.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/watchdog/s3c2410_wdt.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index a0f8f771adec..7c6ccd071baf 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -525,7 +525,11 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	clk_prepare_enable(wdt->clock);
> +	ret = clk_prepare_enable(wdt->clock);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable clock\n");
> +		return ret;
> +	}
>  
>  	ret = s3c2410wdt_cpufreq_register(wdt);
>  	if (ret < 0) {

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

