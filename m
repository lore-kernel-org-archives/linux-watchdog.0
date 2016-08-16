Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49776 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbcHPQeU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Aug 2016 12:34:20 -0400
Date: Tue, 16 Aug 2016 09:34:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-watchdog@vger.kernel.org, shubhrajyoti.datta@gmail.com
Subject: Re: [PATCH] watchdog: cadence_wdt: Fix the suspend resume
Message-ID: <20160816163403.GB28201@roeck-us.net>
References: <1471342652-40005-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471342652-40005-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Aug 16, 2016 at 03:47:32PM +0530, Shubhrajyoti Datta wrote:
> Currently even if no users are there the suspend tries to
> stop the watchdog and resume starts the watchdog.
> 
> So after resume the watchdog starts and resets the board.
> Fix the same by adding a check for users.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/watchdog/cadence_wdt.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
> index 4dda902..b58343c 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -77,6 +77,7 @@ MODULE_PARM_DESC(nowayout,
>  struct cdns_wdt {
>  	void __iomem		*regs;
>  	bool			rst;
> +	bool			cdns_wdt_users;
>  	struct clk		*clk;
>  	u32			prescaler;
>  	u32			ctrl_clksel;
> @@ -129,6 +130,7 @@ static int cdns_wdt_stop(struct watchdog_device *wdd)
>  	struct cdns_wdt *wdt = watchdog_get_drvdata(wdd);
>  
>  	spin_lock(&wdt->io_lock);
> +	wdt->cdns_wdt_users = false;

Why not use watchdog_active() ?

Guenter

>  	cdns_wdt_writereg(wdt, CDNS_WDT_ZMR_OFFSET,
>  			  CDNS_WDT_ZMR_ZKEY_VAL & (~CDNS_WDT_ZMR_WDEN_MASK));
>  	spin_unlock(&wdt->io_lock);
> @@ -182,6 +184,7 @@ static int cdns_wdt_start(struct watchdog_device *wdd)
>  	unsigned short count;
>  	unsigned long clock_f = clk_get_rate(wdt->clk);
>  
> +	wdt->cdns_wdt_users = true;
>  	/*
>  	 * Counter value divisor to obtain the value of
>  	 * counter reset to be written to control register.
> @@ -298,6 +301,7 @@ static int cdns_wdt_probe(struct platform_device *pdev)
>  	if (!wdt)
>  		return -ENOMEM;
>  
> +	wdt->cdns_wdt_users = false;
>  	cdns_wdt_device = &wdt->cdns_wdt_device;
>  	cdns_wdt_device->info = &cdns_wdt_info;
>  	cdns_wdt_device->ops = &cdns_wdt_ops;
> @@ -424,8 +428,10 @@ static int __maybe_unused cdns_wdt_suspend(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
>  
> -	cdns_wdt_stop(&wdt->cdns_wdt_device);
> -	clk_disable_unprepare(wdt->clk);
> +	if (wdt->cdns_wdt_users) {
> +		cdns_wdt_stop(&wdt->cdns_wdt_device);
> +		clk_disable_unprepare(wdt->clk);
> +	}
>  
>  	return 0;
>  }
> @@ -442,12 +448,14 @@ static int __maybe_unused cdns_wdt_resume(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
>  
> -	ret = clk_prepare_enable(wdt->clk);
> -	if (ret) {
> -		dev_err(dev, "unable to enable clock\n");
> -		return ret;
> +	if (wdt->cdns_wdt_users) {
> +		ret = clk_prepare_enable(wdt->clk);
> +		if (ret) {
> +			dev_err(dev, "unable to enable clock\n");
> +			return ret;
> +		}
> +		cdns_wdt_start(&wdt->cdns_wdt_device);
>  	}
> -	cdns_wdt_start(&wdt->cdns_wdt_device);
>  
>  	return 0;
>  }
> -- 
> 2.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
