Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39979 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754395AbeGIIax (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 9 Jul 2018 04:30:53 -0400
Date: Mon, 9 Jul 2018 10:30:41 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] rtc: stmp3xxx: Don't reset the rtc in .probe() when
 watchdog is running
Message-ID: <20180709083041.m3h3smfaahl4awq4@pengutronix.de>
References: <20180609064313.18763-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180609064313.18763-1-u.kleine-koenig@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

On Sat, Jun 09, 2018 at 08:43:13AM +0200, Uwe Kleine-König wrote:
> As pointed out in the added comment resetting the rtc also stops the
> included watchdog. This is bad if the bootloader started the watchdog to
> secure the boot process. So don't reset if the watchdog is running.

I didn't get any feedback for this patch yet. Assuming my patch is
considered ok, my expectation would be that the watchdog people ack it
and that then it goes in via the rtc tree.

Best regards
Uwe

> diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
> index d578e40d5a50..b76318fd5bb0 100644
> --- a/drivers/rtc/rtc-stmp3xxx.c
> +++ b/drivers/rtc/rtc-stmp3xxx.c
> @@ -288,10 +288,22 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, rtc_data);
>  
> -	err = stmp_reset_block(rtc_data->io);
> -	if (err) {
> -		dev_err(&pdev->dev, "stmp_reset_block failed: %d\n", err);
> -		return err;
> +	/*
> +	 * Resetting the rtc stops the watchdog timer that is potentially
> +	 * running. So (assuming it is running on purpose) don't reset if the
> +	 * watchdog is enabled.
> +	 */
> +	if (readl(rtc_data->io + STMP3XXX_RTC_CTRL) &
> +	    STMP3XXX_RTC_CTRL_WATCHDOGEN) {
> +		dev_info(&pdev->dev,
> +			 "Watchdog is running, skip resetting rtc\n");
> +	} else {
> +		err = stmp_reset_block(rtc_data->io);
> +		if (err) {
> +			dev_err(&pdev->dev, "stmp_reset_block failed: %d\n",
> +				err);
> +			return err;
> +		}
>  	}
>  
>  	/*

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
