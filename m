Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34005 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdGVV3H (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 22 Jul 2017 17:29:07 -0400
Date: Sat, 22 Jul 2017 14:29:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Fabio Estevam <festevam@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        wsa+renesas@sang-engineering.com, justinpopo6@gmail.com,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH 2/2] watchdog: bcm7038: Check the return value from
 clk_prepare_enable()
Message-ID: <20170722212906.GC2969@roeck-us.net>
References: <1500754979-19836-1-git-send-email-festevam@gmail.com>
 <1500754979-19836-2-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500754979-19836-2-git-send-email-festevam@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Jul 22, 2017 at 05:22:59PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> clk_prepare_enable() may fail, so we should better check its return value
> and propagate it in the case of error.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/bcm7038_wdt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
> index c1b8e534..f88f546 100644
> --- a/drivers/watchdog/bcm7038_wdt.c
> +++ b/drivers/watchdog/bcm7038_wdt.c
> @@ -136,7 +136,9 @@ static int bcm7038_wdt_probe(struct platform_device *pdev)
>  	wdt->clk = devm_clk_get(dev, NULL);
>  	/* If unable to get clock, use default frequency */
>  	if (!IS_ERR(wdt->clk)) {
> -		clk_prepare_enable(wdt->clk);
> +		err = clk_prepare_enable(wdt->clk);

One of those situations where devm_clk_prepare_enable() would be really
useful.

Wonder if it would make sense introduce subsystem specific functions, such
as devm_watchdog_clk_prepare_enable(). That would at least be better than
devm_add_action() in each driver.

Guenter

> +		if (err)
> +			return err;
>  		wdt->rate = clk_get_rate(wdt->clk);
>  		/* Prevent divide-by-zero exception */
>  		if (!wdt->rate)
> -- 
> 2.7.4
> 
