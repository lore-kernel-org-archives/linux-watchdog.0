Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from shell.v3.sk ([195.168.3.45]:34699 "EHLO shell.v3.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbaBKLLJ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 06:11:09 -0500
Message-ID: <1392116453.22948.0.camel@hobbes>
Subject: Re: [PATCH 2/8] watchdog: bcm2835: Remove unnecessary OOM messages
From: Lubomir Rintel <lkundrak@v3.sk>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wim Van Sebroeck' <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Stephen Warren' <swarren@wwwdotorg.org>
Date: Tue, 11 Feb 2014 12:00:53 +0100
In-Reply-To: <000301cf26f5$808d4a60$81a7df20$%han@samsung.com>
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
	 <000301cf26f5$808d4a60$81a7df20$%han@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 2014-02-11 at 15:50 +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Lubomir Rintel <lkundrak@v3.sk>

> ---
>  drivers/watchdog/bcm2835_wdt.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
> index cafa973..8df450c 100644
> --- a/drivers/watchdog/bcm2835_wdt.c
> +++ b/drivers/watchdog/bcm2835_wdt.c
> @@ -114,10 +114,8 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
>  	int err;
>  
>  	wdt = devm_kzalloc(dev, sizeof(struct bcm2835_wdt), GFP_KERNEL);
> -	if (!wdt) {
> -		dev_err(dev, "Failed to allocate memory for watchdog device");
> +	if (!wdt)
>  		return -ENOMEM;
> -	}
>  	platform_set_drvdata(pdev, wdt);
>  
>  	spin_lock_init(&wdt->lock);


