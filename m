Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34265 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934296AbeAKSYz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 11 Jan 2018 13:24:55 -0500
Date: Thu, 11 Jan 2018 10:24:52 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
Cc: linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: Re: [PATCH 1/2] watchdog: mt7621: Set WDOG_HW_RUNNING, when watchdog
 is already running.
Message-ID: <20180111182452.GA10058@roeck-us.net>
References: <20180110121323.17657-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180110121323.17657-1-git@andred.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 10, 2018 at 12:13:22PM +0000, André Draszik wrote:
> This patch uses the new flag WDOG_HW_RUNNING in driver.
> According to the definition of this flag, it should be set
> if the watchdog hardware is enabled/running during boot
> before being opened here, e.g. due to a boot loader
> configuring the watchdog.
> 
> Given the watchdog driver core doesn't know what timeout was
> originally set by whoever started the watchdog (boot loader),
> we make sure to update the timeout in the hardware according
> to what the watchdog core thinks it is.
> 
> Signed-off-by: André Draszik <git@andred.net>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> Cc: John Crispin <john@phrozen.org>
> ---
>  drivers/watchdog/mt7621_wdt.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> index db38f8017218..0eabea2d88a2 100644
> --- a/drivers/watchdog/mt7621_wdt.c
> +++ b/drivers/watchdog/mt7621_wdt.c
> @@ -105,6 +105,11 @@ static int mt7621_wdt_bootcause(void)
>  	return 0;
>  }
>  
> +static int mt7621_wdt_is_running(struct watchdog_device *w)
> +{
> +	return !!(rt_wdt_r32(TIMER_REG_TMR1CTL) & TMR1CTL_ENABLE);
> +}
> +
>  static const struct watchdog_info mt7621_wdt_info = {
>  	.identity = "Mediatek Watchdog",
>  	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> @@ -144,6 +149,17 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
>  	watchdog_init_timeout(&mt7621_wdt_dev, mt7621_wdt_dev.max_timeout,
>  			      &pdev->dev);
>  	watchdog_set_nowayout(&mt7621_wdt_dev, nowayout);
> +	if (mt7621_wdt_is_running(&mt7621_wdt_dev)) {
> +		/* Make sure to apply timeout from wathdog_core, taking

watchdog core

> +		   the prescaler of this driver here into account (the
> +		   boot loader might be using a different prescaler).
> +		   To avoid spurious resets because of different scaling,
> +		   we first disable the watchdog, set the new prescaler
> +		   and timeout, and then re-enable the watchdog. */

Please use proper multi-line comments.

> +		mt7621_wdt_stop(&mt7621_wdt_dev);
> +		mt7621_wdt_start(&mt7621_wdt_dev);
> +		set_bit(WDOG_HW_RUNNING, &mt7621_wdt_dev.status);
> +	}
>  
>  	ret = watchdog_register_device(&mt7621_wdt_dev);
>  
> -- 
> 2.15.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
