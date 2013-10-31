Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:39797 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752424Ab3JaQaw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 31 Oct 2013 12:30:52 -0400
Date: Thu, 31 Oct 2013 17:30:47 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: grant.likely@linaro.org, rob.herring@calxeda.com,
	yongjun_wei@trendmicro.com.cn, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH -next] watchdog: rt2880_wdt: fix return value check in rt288x_wdt_probe()
Message-ID: <20131031163047.GF5261@spo001.leaseweb.com>
References: <CAPgLHd9HvoJKtv4x=WyQfRauH43vnYtr0vXDugbJWwUGL_0U2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPgLHd9HvoJKtv4x=WyQfRauH43vnYtr0vXDugbJWwUGL_0U2A@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wei,

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_request_and_ioremap() returns NULL
> pointer not ERR_PTR(). Fix it by using devm_ioremap_resource() instead
> of devm_request_and_ioremap().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/watchdog/rt2880_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
> index a9f8491..53d37fe 100644
> --- a/drivers/watchdog/rt2880_wdt.c
> +++ b/drivers/watchdog/rt2880_wdt.c
> @@ -144,7 +144,7 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	rt288x_wdt_base = devm_request_and_ioremap(&pdev->dev, res);
> +	rt288x_wdt_base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(rt288x_wdt_base))
>  		return PTR_ERR(rt288x_wdt_base);
>  

Patch added to linux-watchdog-next.

Kind regards,
Wim.

