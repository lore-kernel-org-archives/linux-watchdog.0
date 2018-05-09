Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41824 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934272AbeEIMGl (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 9 May 2018 08:06:41 -0400
Received: by mail-pl0-f66.google.com with SMTP id az12-v6so4178366plb.8
        for <linux-watchdog@vger.kernel.org>; Wed, 09 May 2018 05:06:41 -0700 (PDT)
Subject: Re: [PATCH 1/1] watchdog: da9063: Fix setting/changing timeout
To: Marco Felsch <m.felsch@pengutronix.de>, wim@linux-watchdog.org
Cc: krystian.garbaciak@diasemi.com, support.opensource@diasemi.com,
        linux-watchdog@vger.kernel.org, fzuuzf@googlemail.com,
        kernel@pengutronix.de
References: <20180509103126.15285-1-m.felsch@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <468514ce-0cee-4e63-e04f-39b02c6cf91d@roeck-us.net>
Date: Wed, 9 May 2018 05:06:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180509103126.15285-1-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/09/2018 03:31 AM, Marco Felsch wrote:
> The DA9063 watchdog always resets the system when it changes the timeout
> value after the bootloader (e.g. Barebox) has it already set.
> 
> To update the timeout value we have to disable the watchdog, clear the
> watchdog counter value and write the new timeout value to the watchdog.
> Clearing the counter value is a feature to be on the safe side, because the
> data sheet doesn't describe the behaviour of the watchdog counter value
> after a watchdog disabling-enable-sequence.
> 
> The patch is based on Philipp Zabel's <p.zabel@pengutronix.de> previous
> patch but doesn't wait 150us because the DA9063 doesn't need this delay.
> 
> Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>   drivers/watchdog/da9063_wdt.c | 42 +++++++++++++++++++++++++++++++----
>   1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> index b17ac1bb1f28..c82541c39d35 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -45,10 +45,45 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
>   	return DA9063_TWDSCALE_MAX;
>   }
>   
> +/*
> + * Writing a '1' to the self-clearing WATCHDOG bit resets the watchdog counter
> + * value.
> + */
> +static int _da9063_wdt_reset_timer(struct da9063 *da9063)
> +{
> +	return regmap_write(da9063->regmap,
> +			    DA9063_REG_CONTROL_F,
> +			    DA9063_WATCHDOG);
> +}
> +
>   static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int regval)
>   {
> -	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> -				  DA9063_TWDSCALE_MASK, regval);
> +	int ret;
> +
> +	/*
> +	 * The watchdog trigger a reboot if a timeout value is already
> +	 * programmed. Because the timeout value combines two functions in
> +	 * one: indicating the counter limit and starting the watchdog. To be
> +	 * able to set the watchdog a second time (first time was done by the
> +	 * bootloader) disable the watchdog clear the counter value manually and
> +	 * set the new timeout value.
> +	 */
> +	ret = regmap_update_bits(da9063->regmap,
> +				 DA9063_REG_CONTROL_D,
> +				 DA9063_TWDSCALE_MASK,
> +				 DA9063_TWDSCALE_DISABLE);
> +	if (ret)
> +		dev_warn(da9063->dev,
> +			 "Failed to disable watchdog before setting new timeout\n");
> +
> +	ret = _da9063_wdt_reset_timer(da9063);
> +	if (ret)
> +		dev_warn(da9063->dev, "Failed to reset watchdog counter\n");
> +
> +	return regmap_update_bits(da9063->regmap,
> +				  DA9063_REG_CONTROL_D,
> +				  DA9063_TWDSCALE_MASK,
> +				  regval);

I am not a friend of unnecessary line breaks.

Guenter

>   }
>   
>   static int da9063_wdt_start(struct watchdog_device *wdd)
> @@ -85,8 +120,7 @@ static int da9063_wdt_ping(struct watchdog_device *wdd)
>   	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
>   	int ret;
>   
> -	ret = regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
> -			   DA9063_WATCHDOG);
> +	ret = _da9063_wdt_reset_timer(da9063);
>   	if (ret)
>   		dev_alert(da9063->dev, "Failed to ping the watchdog (err = %d)\n",
>   			  ret);
> 

