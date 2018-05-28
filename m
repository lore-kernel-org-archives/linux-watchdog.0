Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37286 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163440AbeE1NVk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 28 May 2018 09:21:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id w19-v6so7218322plq.4
        for <linux-watchdog@vger.kernel.org>; Mon, 28 May 2018 06:21:40 -0700 (PDT)
Subject: Re: [PATCH v9 3/3] watchdog: da9063: Fix timeout handling during
 probe
To: Marco Felsch <m.felsch@pengutronix.de>, wim@linux-watchdog.org,
        support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
References: <20180528064546.11244-1-m.felsch@pengutronix.de>
 <20180528064546.11244-4-m.felsch@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <96fd756f-b414-dd83-9207-d0c48c4f5c1b@roeck-us.net>
Date: Mon, 28 May 2018 06:21:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180528064546.11244-4-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/27/2018 11:45 PM, Marco Felsch wrote:
> The watchdog can be enabled in previous steps (e.g. the bootloader). Set
> the driver default timeout value (8s) if the watchdog is already running
> and the HW_RUNNING flag. So the watchdog core framework will ping the
> watchdog till the user space activates the watchdog explicit with the
> desired timeout value.
> 
> Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/da9063_wdt.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> index 6b0092b7d5a6..a4380a887e85 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -45,6 +45,18 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
>   	return DA9063_TWDSCALE_MAX;
>   }
>   
> +/*
> + * Return 0 if watchdog is disabled, else non zero.
> + */
> +static unsigned int da9063_wdt_is_running(struct da9063 *da9063)
> +{
> +	unsigned int val;
> +
> +	regmap_read(da9063->regmap, DA9063_REG_CONTROL_D, &val);
> +
> +	return val & DA9063_TWDSCALE_MASK;
> +}
> +
>   static int da9063_wdt_disable_timer(struct da9063 *da9063)
>   {
>   	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> @@ -206,6 +218,15 @@ static int da9063_wdt_probe(struct platform_device *pdev)
>   
>   	watchdog_set_drvdata(wdd, da9063);
>   
> +	/* Change the timeout to the default value if the watchdog is running */
> +	if (da9063_wdt_is_running(da9063)) {
> +		unsigned int timeout;
> +
> +		timeout = da9063_wdt_timeout_to_sel(DA9063_WDG_TIMEOUT);
> +		_da9063_wdt_set_timeout(da9063, timeout);
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> +	}
> +
>   	return devm_watchdog_register_device(&pdev->dev, wdd);
>   }
>   
> 

