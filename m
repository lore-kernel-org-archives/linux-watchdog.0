Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43618 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdJVRhR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 13:37:17 -0400
Received: by mail-pf0-f196.google.com with SMTP id a8so15456342pfc.0
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Oct 2017 10:37:17 -0700 (PDT)
Date: Sun, 22 Oct 2017 10:37:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, lee.jones@linaro.org,
        support.opensource@diasemi.com, wim@iguana.be,
        kernel@pengutronix.de, Stefan Christ <s.christ@phytec.de>
Subject: Re: [3/6] watchdog: da9062: reset board on watchdog timeout
Message-ID: <20171022173715.GA20012@roeck-us.net>
References: <20171017153027.24665-4-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017153027.24665-4-m.grzeschik@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 17, 2017 at 05:30:24PM +0200, Michael Grzeschik wrote:
> From: Stefan Christ <s.christ@phytec.de>
> 
> In the default fuse configuration the watchdog poweroffs the system
> instead of resetting it on a watchdog timeout. This patch changes the
> behavior. Now the board is reseted and reboots.

s/reseted/reset/

"reseted" is not a word.

> 
> Note: This patch requires that the config register CONFIG_I is
> configured as writable in the da9062 multi function device.
> 
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> Signed-off-by: Christian Hemp <c.hemp@phytec.de>

Not really worth a resend, though.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/da9062_wdt.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index 4349a02215489..b95719b349e5c 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -112,6 +112,20 @@ static int da9062_wdt_start(struct watchdog_device *wdd)
>  	unsigned int selector;
>  	int ret;
>  
> +	/*
> +	 * Use da9062's SHUTDOWN mode instead of POWERDOWN for watchdog reset.
> +	 * On timeout the PMIC should reset the system, not powering it
> +	 * off.
> +	 */
> +	ret = regmap_update_bits(wdt->hw->regmap,
> +				 DA9062AA_CONFIG_I,
> +				 DA9062AA_WATCHDOG_SD_MASK,
> +				 DA9062AA_WATCHDOG_SD_MASK);
> +	if (ret)
> +		dev_err(wdt->hw->dev,
> +			"failed to set wdt reset mode. Expect poweroff on watchdog reset: %d\n",
> +			ret);
> +
>  	selector = da9062_wdt_timeout_to_sel(wdt->wdtdev.timeout);
>  	ret = da9062_wdt_update_timeout_register(wdt, selector);
>  	if (ret)
