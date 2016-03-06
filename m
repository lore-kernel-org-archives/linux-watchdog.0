Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:48795 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751154AbcCFJJy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 6 Mar 2016 04:09:54 -0500
Date: Sun, 6 Mar 2016 10:09:52 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: tangox_wdt: test clock rate to avoid division by 0
Message-ID: <20160306090952.GB1333@spo001.leaseweb.nl>
References: <1456993453-7958-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456993453-7958-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> The clk API may return 0 on clk_get_rate, so we should check the result before
> using it as a divisor. For this, refactor the code to use a central
> error path.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/watchdog/tangox_wdt.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
> index 709c1ed6fd79b9..cfbed7e051b619 100644
> --- a/drivers/watchdog/tangox_wdt.c
> +++ b/drivers/watchdog/tangox_wdt.c
> @@ -139,6 +139,10 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>  		return err;
>  
>  	dev->clk_rate = clk_get_rate(dev->clk);
> +	if (!dev->clk_rate) {
> +		err = -EINVAL;
> +		goto err;
> +	}
>  
>  	dev->wdt.parent = &pdev->dev;
>  	dev->wdt.info = &tangox_wdt_info;
> @@ -171,10 +175,8 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>  	}
>  
>  	err = watchdog_register_device(&dev->wdt);
> -	if (err) {
> -		clk_disable_unprepare(dev->clk);
> -		return err;
> -	}
> +	if (err)
> +		goto err;
>  
>  	platform_set_drvdata(pdev, dev);
>  
> @@ -187,6 +189,10 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev, "SMP86xx/SMP87xx watchdog registered\n");
>  
>  	return 0;
> +
> + err:
> +	clk_disable_unprepare(dev->clk);
> +	return err;
>  }
>  
>  static int tangox_wdt_remove(struct platform_device *pdev)
> -- 
> 2.7.0
> 

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

