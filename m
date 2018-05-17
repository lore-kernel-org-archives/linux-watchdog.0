Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:5411 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751680AbeEQHwj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 17 May 2018 03:52:39 -0400
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Marco Felsch <m.felsch@pengutronix.de>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>
CC: Support Opensource <Support.Opensource@diasemi.com>,
        "fzuuzf@googlemail.com" <fzuuzf@googlemail.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Guenter Roeck <groeck7@gmail.com>
Subject: RE: [PATCH v3] watchdog: da9063: Fix setting/changing timeout
Date: Thu, 17 May 2018 07:52:33 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7019418166B@SW-EX-MBX02.diasemi.com>
References: <20180517070354.5318-1-m.felsch@pengutronix.de>
In-Reply-To: <20180517070354.5318-1-m.felsch@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Marco,
Thanks.

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Stephen

On 17 May 2018 08:04, Marco Felsch wrote:

> Subject: [PATCH v3] watchdog: da9063: Fix setting/changing timeout
> 
> If the timeout value is set more than once the DA9063 watchdog triggers
> a reset signal which reset the system.
> 
> To update the timeout value we have to disable the watchdog, clear the
> watchdog counter value and write the new timeout value to the watchdog.
> Clearing the counter value is a feature to be on the safe side because the
> data sheet doesn't describe the behaviour of the watchdog counter value
> after a watchdog disabling-enable-sequence.
> 
> The patch is based on Philipp Zabel's previous patch but doesn't wait
> 150us because the DA9063 doesn't need this delay.
> 
> Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/watchdog/da9063_wdt.c | 35
> +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/da9063_wdt.c
> b/drivers/watchdog/da9063_wdt.c
> index b17ac1bb1f28..06fcc662673e 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -45,8 +45,40 @@ static unsigned int
> da9063_wdt_timeout_to_sel(unsigned int secs)
>  	return DA9063_TWDSCALE_MAX;
>  }
> 
> +/*
> + * Writing a '1' to the self-clearing WATCHDOG bit resets the watchdog counter
> + * value.
> + */
> +static int _da9063_wdt_reset_timer(struct da9063 *da9063)
> +{
> +	return regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
> +			    DA9063_WATCHDOG);
> +}
> +
>  static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int regval)
>  {
> +	int ret;
> +
> +	/*
> +	 * The watchdog triggers a reboot if a timeout value is already
> +	 * programmed. The reason for this is that the timeout value
> +	 * combines two functions in one: indicating the counter limit and
> +	 * starting the watchdog. The watchdog must be disabled to be able to
> +	 * change the timeout value if the watchdog is already running. Then
> +	 * we can set the new timeout value which enables the watchdog again.
> +	 */
> +	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> +				 DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
> +	if (ret)
> +		dev_warn(da9063->dev,
> +			 "Failed to disable watchdog before setting new timeout\n");
> +
> +	usleep_range(150, 300);
> +
> +	ret = _da9063_wdt_reset_timer(da9063);
> +	if (ret)
> +		dev_warn(da9063->dev, "Failed to reset watchdog counter\n");
> +
>  	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
>  				  DA9063_TWDSCALE_MASK, regval);
>  }
> @@ -85,8 +117,7 @@ static int da9063_wdt_ping(struct watchdog_device
> *wdd)
>  	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
>  	int ret;
> 
> -	ret = regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
> -			   DA9063_WATCHDOG);
> +	ret = _da9063_wdt_reset_timer(da9063);
>  	if (ret)
>  		dev_alert(da9063->dev, "Failed to ping the watchdog (err =
> %d)\n",
>  			  ret);
> --
> 2.17.0

