Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45203 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJKAhV (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 10 Oct 2018 20:37:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id t70-v6so2806770pgd.12
        for <linux-watchdog@vger.kernel.org>; Wed, 10 Oct 2018 10:14:16 -0700 (PDT)
Date: Wed, 10 Oct 2018 10:14:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH watchdog-next] watchdog: armada_37xx_wdt: use do_div for
 u64 division
Message-ID: <20181010171413.GA10400@roeck-us.net>
References: <20181010151727.21644-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181010151727.21644-1-marek.behun@nic.cz>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 10, 2018 at 05:17:27PM +0200, Marek Behún wrote:
> When the driver is built on 32 bit architectures during compile test,
> the linker complains about "__udivdi3" being undefined. We have to use
> do_div macro instead of the division operator when dividing u64 value.
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/armada_37xx_wdt.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
> index c43c313ba63d..4b4054f54df9 100644
> --- a/drivers/watchdog/armada_37xx_wdt.c
> +++ b/drivers/watchdog/armada_37xx_wdt.c
> @@ -156,10 +156,10 @@ static int armada_37xx_wdt_ping(struct watchdog_device *wdt)
>  static unsigned int armada_37xx_wdt_get_timeleft(struct watchdog_device *wdt)
>  {
>  	struct armada_37xx_watchdog *dev = watchdog_get_drvdata(wdt);
> -	unsigned int res;
> +	u64 res;
>  
> -	res = get_counter_value(dev, CNTR_ID_WDOG) *
> -	      CNTR_CTRL_PRESCALE_MIN / dev->clk_rate;
> +	res = get_counter_value(dev, CNTR_ID_WDOG) * CNTR_CTRL_PRESCALE_MIN;
> +	do_div(res, dev->clk_rate);
>  
>  	return res;
>  }
> @@ -176,7 +176,8 @@ static int armada_37xx_wdt_set_timeout(struct watchdog_device *wdt,
>  	 * prescaler, which divides the clock rate by 2
>  	 * (CNTR_CTRL_PRESCALE_MIN).
>  	 */
> -	dev->timeout = (u64)dev->clk_rate * timeout / CNTR_CTRL_PRESCALE_MIN;
> +	dev->timeout = (u64)dev->clk_rate * timeout;
> +	do_div(dev->timeout, CNTR_CTRL_PRESCALE_MIN);
>  
>  	return 0;
>  }
> -- 
> 2.16.4
> 
