Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44767 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965816AbeEXJ2u (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 24 May 2018 05:28:50 -0400
Received: by mail-pl0-f66.google.com with SMTP id m24-v6so700924pls.11
        for <linux-watchdog@vger.kernel.org>; Thu, 24 May 2018 02:28:50 -0700 (PDT)
Subject: Re: [PATCH v7 4/5] watchdog: da9063: Fix timeout handling during
 probe
To: Marco Felsch <m.felsch@pengutronix.de>, wim@linux-watchdog.org,
        support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
References: <20180524075609.19951-1-m.felsch@pengutronix.de>
 <20180524075609.19951-5-m.felsch@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <171f3363-86dc-8fa7-d20d-538130ca7258@roeck-us.net>
Date: Thu, 24 May 2018 02:28:48 -0700
MIME-Version: 1.0
In-Reply-To: <20180524075609.19951-5-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/24/2018 12:56 AM, Marco Felsch wrote:
> The watchdog can be enabled in previous steps (e.g. the bootloader). Check
> if the watchdog is already running, retrieve the set timeout value and
> set it again to set the new timeout reference mark.
> 
> Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>   drivers/watchdog/da9063_wdt.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> index 54c526436304..9056fa945c01 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -45,6 +45,19 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
>   	return DA9063_TWDSCALE_MAX;
>   }
>   
> +/*
> + * Return 0 if watchdog is disabled, else non zero.
> + */
> +static int da9063_wdt_is_running(struct da9063 *da9063)
> +{
> +	unsigned int val;
> +
> +	regmap_read(da9063->regmap, DA9063_REG_CONTROL_D, &val);
> +	val &= DA9063_TWDSCALE_MASK;
> +
> +	return wdt_timeout[val];
> +}
> +
>   static int da9063_wdt_disable_timer(struct da9063 *da9063)
>   {
>   	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> @@ -182,6 +195,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
>   {
>   	struct da9063 *da9063;
>   	struct watchdog_device *wdd;
> +	unsigned int cur_timeout;
>   
>   	if (!pdev->dev.parent)
>   		return -EINVAL;
> @@ -208,6 +222,12 @@ static int da9063_wdt_probe(struct platform_device *pdev)
>   
>   	watchdog_set_drvdata(wdd, da9063);
>   
> +	cur_timeout = da9063_wdt_is_running(da9063);
> +	if (cur_timeout) {
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> +		da9063_wdt_set_timeout(wdd, cur_timeout);

You could call _da9063_wdt_set_timeout() here.

Guenter

> +	}
> +
>   	return devm_watchdog_register_device(&pdev->dev, wdd);
>   }
>   
> 

