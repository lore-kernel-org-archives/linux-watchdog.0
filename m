Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:53382 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdJVRix (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 13:38:53 -0400
Received: by mail-pg0-f66.google.com with SMTP id s2so10065379pge.10
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Oct 2017 10:38:53 -0700 (PDT)
Date: Sun, 22 Oct 2017 10:38:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, lee.jones@linaro.org,
        support.opensource@diasemi.com, wim@iguana.be,
        kernel@pengutronix.de
Subject: Re: [4/6] watchdog: da9062: Disable and wait before changing timeout
Message-ID: <20171022173851.GA20226@roeck-us.net>
References: <20171017153027.24665-5-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171017153027.24665-5-m.grzeschik@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 17, 2017 at 05:30:25PM +0200, Michael Grzeschik wrote:
> The DA9062 watchdog occasionally enters error condition and resets the
> system if the timeout is changed quickly after the timer was enabled.
> 
> The method of disabling and waiting for > 150 µs before setting the
> new timeout is taken from the DA9052 driver.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/da9062_wdt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index b95719b349e5c..d43e0c46e23fb 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -100,6 +100,13 @@ static int da9062_wdt_update_timeout_register(struct da9062_watchdog *wdt,
>  	if (ret)
>  		return ret;
>  
> +	regmap_update_bits(chip->regmap,
> +				  DA9062AA_CONTROL_D,
> +				  DA9062AA_TWDSCALE_MASK,
> +				  DA9062_TWDSCALE_DISABLE);
> +
> +	usleep_range(150, 300);
> +
>  	return regmap_update_bits(chip->regmap,
>  				  DA9062AA_CONTROL_D,
>  				  DA9062AA_TWDSCALE_MASK,
