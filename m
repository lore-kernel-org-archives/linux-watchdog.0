Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:33974 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750900AbaCOT30 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Mar 2014 15:29:26 -0400
Date: Sat, 15 Mar 2014 20:29:24 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: s3c2410_wdt: Remove unneeded initialization
Message-ID: <20140315192923.GA13799@spo001.leaseweb.com>
References: <1393925675-21636-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1393925675-21636-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sachin,

> Initializing clk to NULL as a reset/error condition does not
> help as NULL is not an invalid condition w.r.t clk. Remove this
> initialization altogether as there is no state retention.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/watchdog/s3c2410_wdt.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index aba6cd46b45b..a0f8f771adec 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -607,7 +607,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>  
>   err_clk:
>  	clk_disable_unprepare(wdt->clock);
> -	wdt->clock = NULL;
>  
>   err:
>  	return ret;
> @@ -627,7 +626,6 @@ static int s3c2410wdt_remove(struct platform_device *dev)
>  	s3c2410wdt_cpufreq_deregister(wdt);
>  
>  	clk_disable_unprepare(wdt->clock);
> -	wdt->clock = NULL;
>  
>  	return 0;
>  }

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

