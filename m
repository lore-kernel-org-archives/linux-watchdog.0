Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40672 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965664AbeEXJ0r (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 24 May 2018 05:26:47 -0400
Received: by mail-pg0-f67.google.com with SMTP id l2-v6so519573pgc.7
        for <linux-watchdog@vger.kernel.org>; Thu, 24 May 2018 02:26:47 -0700 (PDT)
Subject: Re: [PATCH v7 2/5] watchdog: da9063: Fix setting HW_RUNNING
 indication during wdt_start
To: Marco Felsch <m.felsch@pengutronix.de>, wim@linux-watchdog.org,
        support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
References: <20180524075609.19951-1-m.felsch@pengutronix.de>
 <20180524075609.19951-3-m.felsch@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4f49a01e-6b42-0b29-9cfa-0da6a48b9a2a@roeck-us.net>
Date: Thu, 24 May 2018 02:26:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180524075609.19951-3-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/24/2018 12:56 AM, Marco Felsch wrote:
> Inform the watchdog framework that the watchog is running. Each driver
> have to set this bit because the watchdog core framework only clears
> this bit.
> 

This should only be necessary if the stop function does not stop the watchdog.
Guess you need it because you call watchdog_hw_running() instead of
watchdog_active() in the next patch, but the context, description, and use
is not correct.

Guenter

> Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>   drivers/watchdog/da9063_wdt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> index c1216e61e64e..1b0ccadbc248 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -86,6 +86,8 @@ static int da9063_wdt_start(struct watchdog_device *wdd)
>   		dev_err(da9063->dev, "Watchdog failed to start (err = %d)\n",
>   			ret);
>   
> +	set_bit(WDOG_HW_RUNNING, &wdd->status);
> +
>   	return ret;
>   }
>   
> 

