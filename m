Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35521 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163362AbeE1NUy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 28 May 2018 09:20:54 -0400
Received: by mail-pf0-f195.google.com with SMTP id x9-v6so5861477pfm.2
        for <linux-watchdog@vger.kernel.org>; Mon, 28 May 2018 06:20:54 -0700 (PDT)
Subject: Re: [PATCH v9 1/3] watchdog: da9063: Fix setting/changing timeout
To: Marco Felsch <m.felsch@pengutronix.de>, wim@linux-watchdog.org,
        support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
References: <20180528064546.11244-1-m.felsch@pengutronix.de>
 <20180528064546.11244-2-m.felsch@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b4b9bb42-ec5a-1f76-18cd-2af91fbf2a68@roeck-us.net>
Date: Mon, 28 May 2018 06:20:51 -0700
MIME-Version: 1.0
In-Reply-To: <20180528064546.11244-2-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/27/2018 11:45 PM, Marco Felsch wrote:
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
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/da9063_wdt.c | 26 ++++++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> index b17ac1bb1f28..c1216e61e64e 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -45,8 +45,31 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
>   	return DA9063_TWDSCALE_MAX;
>   }
>   
> +static int da9063_wdt_disable_timer(struct da9063 *da9063)
> +{
> +	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> +				  DA9063_TWDSCALE_MASK,
> +				  DA9063_TWDSCALE_DISABLE);
> +}
> +
>   static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int regval)
>   {
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
>   	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
>   				  DA9063_TWDSCALE_MASK, regval);
>   }
> @@ -71,8 +94,7 @@ static int da9063_wdt_stop(struct watchdog_device *wdd)
>   	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
>   	int ret;
>   
> -	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> -				 DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
> +	ret = da9063_wdt_disable_timer(da9063);
>   	if (ret)
>   		dev_alert(da9063->dev, "Watchdog failed to stop (err = %d)\n",
>   			  ret);
> 

