Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:47314 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753030Ab2CZIfw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 Mar 2012 04:35:52 -0400
Date: Mon, 26 Mar 2012 10:35:45 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org,
	Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH] watchdog: coh901327: fix build failure due to typo
Message-ID: <20120326083545.GY10698@spo001.leaseweb.com>
References: <1332743793-12822-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1332743793-12822-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Wolfram,

> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> 
> Linus: at least you could have build tested... ;)
> 
>  drivers/watchdog/coh901327_wdt.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
> index 3175767..6876430 100644
> --- a/drivers/watchdog/coh901327_wdt.c
> +++ b/drivers/watchdog/coh901327_wdt.c
> @@ -250,7 +250,7 @@ static struct watchdog_device coh901327_wdt = {
>  	.info = &coh901327_ident,
>  	.ops = &coh901327_ops,
>  	/*
> -	 * Max timout is 327 since the 10ms
> +	 * Max timeout is 327 since the 10ms
>  	 * timeout register is max
>  	 * 0x7FFF = 327670ms ~= 327s.
>  	 */
> @@ -355,7 +355,7 @@ static int __init coh901327_probe(struct platform_device *pdev)
>  
>  	if (margin < 1 || margin > 327)
>  		margin = 60;
> -	coh901327_wdt.timout = margin;
> +	coh901327_wdt.timeout = margin;
>  
>  	ret = watchdog_register_device(&coh901327_wdt);
>  	if (ret == 0)

I will fold this into the original patch and add an acked-by you if that is OK?

Thanks,
Wim.

