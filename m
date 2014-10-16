Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:52862 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbaJPR34 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 16 Oct 2014 13:29:56 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so3585719pde.22
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Oct 2014 10:29:56 -0700 (PDT)
Date: Thu, 16 Oct 2014 10:29:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: imx2_wdt: Add power management support.
Message-ID: <20141016172951.GA16399@roeck-us.net>
References: <1413431055-41805-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413431055-41805-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 16, 2014 at 11:44:15AM +0800, Xiubo Li wrote:
> Add power management operations(suspend and resume) as part of
> dev_pm_ops for IMX2 watchdog driver.
> 
> If PM will be supported, please make sure that the wdev->clk
> could disable the watchdog's counter input clock source or can
> mask watchdog's reset request to the core.
> 
> If watchdog is still used by consumers and resumes from deep
> sleep state, we need to restart the watchdog again without
> enabling the timer.
> 
> If watchdog been has started --> stopped by the consumers and
> resumes from non-deep sleep state, then start the timer again.
> 
> If watchdog has been started --> stopped by the consumers and
> resumes from deep sleep state, will do nothing. The watchdog
> will be restarted by consumers next time to be used.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>

Looks ok to me.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Change in V3:
> - Uses standard multi-line comments.
> 
> 
>  drivers/watchdog/imx2_wdt.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 7e12f88..22ab599 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -326,6 +326,65 @@ static void imx2_wdt_shutdown(struct platform_device *pdev)
>  	}
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +/* Disable watchdog if it is active or non-active but still running */
> +static int imx2_wdt_suspend(struct device *dev)
> +{
> +	struct watchdog_device *wdog = dev_get_drvdata(dev);
> +	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
> +
> +	/* The watchdog IP block is running */
> +	if (imx2_wdt_is_running(wdev)) {
> +		imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
> +		imx2_wdt_ping(wdog);
> +
> +		/* The watchdog is not active */
> +		if (!watchdog_active(wdog))
> +			del_timer_sync(&wdev->timer);
> +	}
> +
> +	clk_disable_unprepare(wdev->clk);
> +
> +	return 0;
> +}
> +
> +/* Enable watchdog and configure it if necessary */
> +static int imx2_wdt_resume(struct device *dev)
> +{
> +	struct watchdog_device *wdog = dev_get_drvdata(dev);
> +	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
> +
> +	clk_prepare_enable(wdev->clk);
> +
> +	if (watchdog_active(wdog) && !imx2_wdt_is_running(wdev)) {
> +		/*
> +		 * If the watchdog is still active and resumes
> +		 * from deep sleep state, need to restart the
> +		 * watchdog again.
> +		 */
> +		imx2_wdt_setup(wdog);
> +		imx2_wdt_set_timeout(wdog, wdog->timeout);
> +		imx2_wdt_ping(wdog);
> +	} else if (imx2_wdt_is_running(wdev)) {
> +		/* Resuming from non-deep sleep state. */
> +		imx2_wdt_set_timeout(wdog, wdog->timeout);
> +		imx2_wdt_ping(wdog);
> +		/*
> +		 * But the watchdog is not active, then start
> +		 * the timer again.
> +		 */
> +		if (!watchdog_active(wdog))
> +			mod_timer(&wdev->timer,
> +				  jiffies + wdog->timeout * HZ / 2);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
> +			 imx2_wdt_resume);
> +
>  static const struct of_device_id imx2_wdt_dt_ids[] = {
>  	{ .compatible = "fsl,imx21-wdt", },
>  	{ /* sentinel */ }
> @@ -338,6 +397,7 @@ static struct platform_driver imx2_wdt_driver = {
>  	.driver		= {
>  		.name	= DRIVER_NAME,
>  		.owner	= THIS_MODULE,
> +		.pm     = &imx2_wdt_pm_ops,
>  		.of_match_table = imx2_wdt_dt_ids,
>  	},
>  };
> -- 
> 2.1.0.27.g96db324
> 
