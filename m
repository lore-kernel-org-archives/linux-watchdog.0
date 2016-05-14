Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:34821 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753579AbcENSdc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 14 May 2016 14:33:32 -0400
Date: Sat, 14 May 2016 20:33:29 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Colin King <colin.king@canonical.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: remove error message when unable to allocate watchdog device
Message-ID: <20160514183329.GE21026@spo001.leaseweb.nl>
References: <1461691129-4764-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461691129-4764-1-git-send-email-colin.king@canonical.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Colin,

> From: Colin Ian King <colin.king@canonical.com>
> 
> The dev_err message is superfluous because the failure is already
> printed by dev_kzalloc, so remove it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/watchdog/jz4740_wdt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 6a7d5c3..c8d51dd 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -160,10 +160,8 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>  
>  	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata),
>  			       GFP_KERNEL);
> -	if (!drvdata) {
> -		dev_err(&pdev->dev, "Unable to alloacate watchdog device\n");
> +	if (!drvdata)
>  		return -ENOMEM;
> -	}
>  
>  	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
>  		heartbeat = DEFAULT_HEARTBEAT;
> -- 
> 2.7.4
> 

This patch was added to linux-watchdog-next.

Kind Regards,
Wim.

