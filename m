Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:53438 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdJVRju (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 13:39:50 -0400
Received: by mail-pg0-f65.google.com with SMTP id s2so10066094pge.10
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Oct 2017 10:39:50 -0700 (PDT)
Date: Sun, 22 Oct 2017 10:39:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, lee.jones@linaro.org,
        support.opensource@diasemi.com, wim@iguana.be,
        kernel@pengutronix.de
Subject: Re: [5/6] watchdog: da9062: use protection delay mechanism from core
Message-ID: <20171022173948.GA20371@roeck-us.net>
References: <20171017153027.24665-6-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017153027.24665-6-m.grzeschik@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 17, 2017 at 05:30:26PM +0200, Michael Grzeschik wrote:
> This patch removes the windows protection routine that got
> now covered by the wdt core.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/da9062_wdt.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index d43e0c46e23fb..8297bcf0b9f75 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -46,22 +46,6 @@ static void da9062_set_window_start(struct da9062_watchdog *wdt)
>  	wdt->j_time_stamp = jiffies;
>  }
>  
> -static void da9062_apply_window_protection(struct da9062_watchdog *wdt)
> -{
> -	unsigned long delay = msecs_to_jiffies(DA9062_RESET_PROTECTION_MS);
> -	unsigned long timeout = wdt->j_time_stamp + delay;
> -	unsigned long now = jiffies;
> -	unsigned int diff_ms;
> -
> -	/* if time-limit has not elapsed then wait for remainder */
> -	if (time_before(now, timeout)) {
> -		diff_ms = jiffies_to_msecs(timeout-now);
> -		dev_dbg(wdt->hw->dev,
> -			"Kicked too quickly. Delaying %u msecs\n", diff_ms);
> -		msleep(diff_ms);
> -	}
> -}
> -
>  static unsigned int da9062_wdt_timeout_to_sel(unsigned int secs)
>  {
>  	unsigned int i;
> @@ -78,8 +62,6 @@ static int da9062_reset_watchdog_timer(struct da9062_watchdog *wdt)
>  {
>  	int ret;
>  
> -	da9062_apply_window_protection(wdt);
> -
>  	ret = regmap_update_bits(wdt->hw->regmap,
>  			   DA9062AA_CONTROL_F,
>  			   DA9062AA_WATCHDOG_MASK,
> @@ -256,6 +238,7 @@ static int da9062_wdt_probe(struct platform_device *pdev)
>  	wdt->wdtdev.ops = &da9062_watchdog_ops;
>  	wdt->wdtdev.min_timeout = DA9062_WDT_MIN_TIMEOUT;
>  	wdt->wdtdev.max_timeout = DA9062_WDT_MAX_TIMEOUT;
> +	wdt->wdtdev.min_hw_heartbeat_ms = DA9062_RESET_PROTECTION_MS;
>  	wdt->wdtdev.timeout = DA9062_WDG_DEFAULT_TIMEOUT;
>  	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
>  	wdt->wdtdev.parent = &pdev->dev;
