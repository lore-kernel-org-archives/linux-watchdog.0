Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60058 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbdFGUtJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 7 Jun 2017 16:49:09 -0400
Date: Wed, 7 Jun 2017 13:49:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: davinci: Handle return value of
 clk_prepare_enable
Message-ID: <20170607204906.GA29222@roeck-us.net>
References: <79da4d6a88384de0b9d8dcea9fc49ca696273576.1496744110.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79da4d6a88384de0b9d8dcea9fc49ca696273576.1496744110.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 06, 2017 at 03:47:53PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/davinci_wdt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> index 0e731d7..1ba9ead 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -173,7 +173,11 @@ static int davinci_wdt_probe(struct platform_device *pdev)
>  		return PTR_ERR(davinci_wdt->clk);
>  	}
>  
> -	clk_prepare_enable(davinci_wdt->clk);
> +	ret = clk_prepare_enable(davinci_wdt->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to prepare clock\n");
> +		return ret;
> +	}
>  
>  	platform_set_drvdata(pdev, davinci_wdt);
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
