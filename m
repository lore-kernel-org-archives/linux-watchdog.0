Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58940 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754794AbeEWS3U (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 23 May 2018 14:29:20 -0400
Date: Wed, 23 May 2018 11:29:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: wim@linux-watchdog.org, support.opensource@diasemi.com,
        linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v6 2/5] watchdog: da9063: Fix setting/changing timeout
Message-ID: <20180523182918.GA28791@roeck-us.net>
References: <20180523082755.8205-1-m.felsch@pengutronix.de>
 <20180523082755.8205-3-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523082755.8205-3-m.felsch@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 23, 2018 at 10:27:52AM +0200, Marco Felsch wrote:
> If the timeout value is set more than once the DA9063 watchdog triggers
> a reset signal which reset the system.
> 
> To update the timeout value we have to disable the watchdog, clear the
> watchdog counter value and write the new timeout value to the watchdog.
> Clearing the counter value is a feature to be on the safe side because the
> data sheet doesn't describe the behaviour of the watchdog counter value
> after a watchdog disabling-enable-sequence.
> 
> The patch is based on Philipp Zabel's previous patch.
> 
> Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")

This is where things fall apart: This patch won't apply to older kernels and
would require a backport because of patch 1, which isn't applicable for stable
releases. So your "improvement" makes life hard for everyone. If you want
to make an improvement for the sake of readability, please do it as last
step, after all the fixes have been applied.

Guenter

> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/watchdog/da9063_wdt.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> index 10bf325598d7..0669e5cfa835 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -45,8 +45,31 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
>  	return DA9063_TWDSCALE_MAX;
>  }
>  
> +static int da9063_wdt_disable_timer(struct da9063 *da9063)
> +{
> +	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> +				  DA9063_TWDSCALE_MASK,
> +				  DA9063_TWDSCALE_DISABLE);
> +}
> +
>  static int da9063_wdt_update_timeout(struct da9063 *da9063, unsigned int regval)
>  {
> +	int ret;
> +
> +	/*
> +	 * The watchdog triggers a reboot if a timeout value is already
> +	 * programmed because the timeout value combines two functions
> +	 * in one: indicating the counter limit and starting the watchdog.
> +	 * The watchdog must be disabled to be able to change the timeout
> +	 * value if the watchdog is already running. Then we can set the
> +	 * new timeout value which enables the watchdog again.
> +	 */
> +	ret = da9063_wdt_disable_timer(da9063);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(150, 300);
> +
>  	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
>  				  DA9063_TWDSCALE_MASK, regval);
>  }
> @@ -71,8 +94,7 @@ static int da9063_wdt_stop(struct watchdog_device *wdd)
>  	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
>  	int ret;
>  
> -	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> -				 DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
> +	ret = da9063_wdt_disable_timer(da9063);
>  	if (ret)
>  		dev_alert(da9063->dev, "Watchdog failed to stop (err = %d)\n",
>  			  ret);
> -- 
> 2.17.0
> 
