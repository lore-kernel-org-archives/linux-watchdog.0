Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48189 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbcGZP6a (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jul 2016 11:58:30 -0400
Date: Tue, 26 Jul 2016 08:58:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: gpio_wdt: Fix missing platform_set_drvdata()
 in gpio_wdt_probe()
Message-ID: <20160726155822.GD30628@roeck-us.net>
References: <1469544614-31842-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1469544614-31842-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jul 26, 2016 at 02:50:14PM +0000, Wei Yongjun wrote:
> Add missing platform_set_drvdata() in gpio_wdt_probe(), otherwise
> calling platform_get_drvdata() in remove returns NULL.
> 
> This is detected by Coccinelle semantic patch.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/gpio_wdt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index ba066e4..93457ca 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -151,6 +151,8 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	platform_set_drvdata(pdev, priv);
> +
>  	priv->gpio = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
>  	if (!gpio_is_valid(priv->gpio))
>  		return priv->gpio;
> 
