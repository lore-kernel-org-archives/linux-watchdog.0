Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43224 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab1FMJYj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 13 Jun 2011 05:24:39 -0400
Received: by wwa36 with SMTP id 36so4631919wwa.1
        for <linux-watchdog@vger.kernel.org>; Mon, 13 Jun 2011 02:24:38 -0700 (PDT)
Date: Mon, 13 Jun 2011 10:24:35 +0100
From: Jamie Iles <jamie@jamieiles.com>
To: Florian Fainelli <florian@openwrt.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Jamie Iles <jamie@jamieiles.com>, stable@kernel.org
Subject: Re: [PATCH 2/5 v2] WATCHDOG: mtx1-wdt: request gpio before using it
Message-ID: <20110613092435.GC2472@pulham.picochip.com>
References: <201106121856.17176.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106121856.17176.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Jun 12, 2011 at 06:56:17PM +0200, Florian Fainelli wrote:
> Otherwise, the gpiolib autorequest feature will produce a WARN_ON():
> 
> WARNING: at drivers/gpio/gpiolib.c:101 0x8020ec6c()
> autorequest GPIO-215
> [...]
> 
> CC:stable@kernel.org
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---

One really minor nit inline but otherwise this series looks fine to me.

Jamie

> Changes since v1:
> - use gpio_request_one()
> - added missing gpio_free() in mtx1_wdt_remove
> 
> Stable: [2.6.39+]
> 
> diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> index 63df28c..9b63642 100644
> --- a/drivers/watchdog/mtx-1_wdt.c
> +++ b/drivers/watchdog/mtx-1_wdt.c
> @@ -214,6 +214,12 @@ static int __devinit mtx1_wdt_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	mtx1_wdt_device.gpio = pdev->resource[0].start;
> +	ret = gpio_request_one(mtx1_wdt_device.gpio,
> +				GPIOF_OUT_INIT_HIGH,"mtx1-wdt");

Missing an extra space after the comma.

> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to request gpio");
> +		return ret;
> +	}
>  
>  	spin_lock_init(&mtx1_wdt_device.lock);
>  	init_completion(&mtx1_wdt_device.stop);
> @@ -239,6 +245,8 @@ static int __devexit mtx1_wdt_remove(struct platform_device *pdev)
>  		mtx1_wdt_device.queue = 0;
>  		wait_for_completion(&mtx1_wdt_device.stop);
>  	}
> +
> +	gpio_free(mtx1_wdt_device.gpio);
>  	misc_deregister(&mtx1_wdt_misc);
>  	return 0;
>  }
> -- 
> 1.7.4.1
> 
