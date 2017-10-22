Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:54105 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdJVReS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 13:34:18 -0400
Received: by mail-pg0-f68.google.com with SMTP id s2so10061532pge.10
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Oct 2017 10:34:18 -0700 (PDT)
Date: Sun, 22 Oct 2017 10:34:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, lee.jones@linaro.org,
        support.opensource@diasemi.com, wim@iguana.be,
        kernel@pengutronix.de, Michael Grzeschik <mgr@pengutronix.de>
Subject: Re: [1/6] watchdog: da9062: Add restart handler support
Message-ID: <20171022173416.GA19789@roeck-us.net>
References: <20171017153027.24665-2-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017153027.24665-2-m.grzeschik@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 17, 2017 at 05:30:22PM +0200, Michael Grzeschik wrote:
> From: Michael Grzeschik <mgr@pengutronix.de>
> 
> Register a restart handler for the da9062 watchdog.  System restart is
> triggered by sending the shutdown command to the PMIC.
> As more-suitable restart handlers may exist, the priority of the
> watchdog restart handler is set to 128.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/da9062_wdt.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index 9083d3d922b0b..4349a02215489 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -175,6 +175,25 @@ static int da9062_wdt_set_timeout(struct watchdog_device *wdd,
>  	return ret;
>  }
>  
> +static int da9062_wdt_restart(struct watchdog_device *wdd, unsigned long action,
> +			      void *data)
> +{
> +	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	ret = regmap_write(wdt->hw->regmap,
> +			   DA9062AA_CONTROL_F,
> +			   DA9062AA_SHUTDOWN_MASK);
> +	if (ret)
> +		dev_alert(wdt->hw->dev, "Failed to shutdown (err = %d)\n",
> +			  ret);
> +
> +	/* wait for reset to assert... */
> +	mdelay(500);
> +
> +	return ret;
> +}
> +
>  static const struct watchdog_info da9062_watchdog_info = {
>  	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>  	.identity = "DA9062 WDT",
> @@ -186,6 +205,7 @@ static const struct watchdog_ops da9062_watchdog_ops = {
>  	.stop = da9062_wdt_stop,
>  	.ping = da9062_wdt_ping,
>  	.set_timeout = da9062_wdt_set_timeout,
> +	.restart = da9062_wdt_restart,
>  };
>  
>  static const struct of_device_id da9062_compatible_id_table[] = {
> @@ -219,6 +239,8 @@ static int da9062_wdt_probe(struct platform_device *pdev)
>  	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
>  	wdt->wdtdev.parent = &pdev->dev;
>  
> +	watchdog_set_restart_priority(&wdt->wdtdev, 128);
> +
>  	watchdog_set_drvdata(&wdt->wdtdev, wdt);
>  
>  	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdtdev);
