Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34812 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965783AbeEXJZK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 24 May 2018 05:25:10 -0400
Received: by mail-pl0-f65.google.com with SMTP id ay10-v6so712118plb.1
        for <linux-watchdog@vger.kernel.org>; Thu, 24 May 2018 02:25:09 -0700 (PDT)
Subject: Re: [PATCH v7 3/5] watchdog: da9063: Fix updating timeout value
To: Marco Felsch <m.felsch@pengutronix.de>, wim@linux-watchdog.org,
        support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
References: <20180524075609.19951-1-m.felsch@pengutronix.de>
 <20180524075609.19951-4-m.felsch@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f58dd3e8-2d51-4017-0579-5fa4e447b115@roeck-us.net>
Date: Thu, 24 May 2018 02:25:07 -0700
MIME-Version: 1.0
In-Reply-To: <20180524075609.19951-4-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/24/2018 12:56 AM, Marco Felsch wrote:
> The DA9063 watchdog has only one register field to store the timeout value
> and to enable the watchdog. The watchdog gets enabled if the value is
> not zero. There is no issue if the watchdog is already running but it
> leads into problems if the watchdog is disabled.
> 
> If the watchdog is diabled and only the timeout value should be prepared

disabled

> the watchdog gets enabled too. Add a check to get the current watchdog
> state and update the watchdog timeout value on hw-side only if the
> watchdog is already running.
> 
> Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>   drivers/watchdog/da9063_wdt.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> index 1b0ccadbc248..54c526436304 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -123,10 +123,23 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
>   {
>   	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
>   	unsigned int selector;
> -	int ret;
> +	int ret = 0;
>   
>   	selector = da9063_wdt_timeout_to_sel(timeout);
> -	ret = _da9063_wdt_set_timeout(da9063, selector);
> +
> +	/*
> +	 * There are two cases when a set_timeout() will be called:
> +	 * 1. The watchdog is off and someone wants to set the timeout for the
> +	 *    further use.
> +	 * 2. The watchdog is already running and a new timeout value should be
> +	 *    set.
> +	 *
> +	 * The watchdog can't store a timeout value not equal zero without
> +	 * enabling the watchdog, so the timeout must be buffered by the driver.
> +	 */
> +	if (watchdog_hw_running(wdd))

Normally one would call watchdog_active() here.

Guenter

> +		ret = _da9063_wdt_set_timeout(da9063, selector);
> +
>   	if (ret)
>   		dev_err(da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
>   			ret);
> 

