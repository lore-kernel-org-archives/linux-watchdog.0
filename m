Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33835 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbdFGUvk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 7 Jun 2017 16:51:40 -0400
Date: Wed, 7 Jun 2017 13:51:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: davinci: Add missing clk_disable_unprepare().
Message-ID: <20170607205125.GB29222@roeck-us.net>
References: <616d54e4ee92f443b52efcd50606baa06e41760e.1496745446.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <616d54e4ee92f443b52efcd50606baa06e41760e.1496745446.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 06, 2017 at 04:08:31PM +0530, Arvind Yadav wrote:
> davinci_wdt_probe() can fail here and we must disable clock.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

... though I would really prefer to have devm_clk_prepare_enable()
instead :-(.

> ---
>  drivers/watchdog/davinci_wdt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> index 1ba9ead..2f46487 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -202,8 +202,10 @@ static int davinci_wdt_probe(struct platform_device *pdev)
>  		return PTR_ERR(davinci_wdt->base);
>  
>  	ret = watchdog_register_device(wdd);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		clk_disable_unprepare(davinci_wdt->clk);
>  		dev_err(dev, "cannot register watchdog device\n");
> +	}
>  
>  	return ret;
>  }
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
