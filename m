Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40589 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbbEAExW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 May 2015 00:53:22 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1Yo2wz-000Spq-6B
	for linux-watchdog@vger.kernel.org; Fri, 01 May 2015 04:53:21 +0000
Message-ID: <554306B3.7060104@roeck-us.net>
Date: Thu, 30 Apr 2015 21:53:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <balbi@ti.com>
CC: Lokesh Vutla <lokeshvutla@ti.com>, kernel@pengutronix.de
Subject: Re: [PATCH v2 5/4] watchdog: omap: assert the counter being stopped
 before reprogramming
References: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de> <1430332727-27491-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1430332727-27491-1-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/29/2015 11:38 AM, Uwe Kleine-König wrote:
> The omap watchdog has the annoying behaviour that writes to most
> registers don't have any effect when the watchdog is already running.
> Quoting the AM335x reference manual:
>
> 	To modify the timer counter value (the WDT_WCRR register),
> 	prescaler ratio (the WDT_WCLR[4:2] PTV bit field), delay
> 	configuration value (the WDT_WDLY[31:0] DLY_VALUE bit field), or
> 	the load value (the WDT_WLDR[31:0] TIMER_LOAD bit field), the
> 	watchdog timer must be disabled by using the start/stop sequence
> 	(the WDT_WSPR register).
>
> Currently the timer is stopped in the .probe callback but still there
> are possibilities that yield to a situation where omap_wdt_start is
> entered with the timer running (e.g. when /dev/watchdog is closed
> without stopping and then reopened). In such a case programming the
> timeout silently fails!
>
> To circumvent this stop the timer before reprogramming.
>
> Assuming one of the first things the watchdog user does is setting the
> timeout explicitly nothing too bad should happen because this explicit
> setting works fine.
>
> Fixes: 7768a13c252a ("[PATCH] OMAP: Add Watchdog driver support")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Annoying, but it looks like it is necessary.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/omap_wdt.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 0421c06a6cf0..d7619dd7c1ca 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -135,6 +135,13 @@ static int omap_wdt_start(struct watchdog_device *wdog)
>
>   	pm_runtime_get_sync(wdev->dev);
>
> +	/*
> +	 * Make sure the watchdog is disabled. This is unfortunately required
> +	 * because writing to various registers with the watchdog running has no
> +	 * effect.
> +	 */
> +	omap_wdt_disable(wdev);
> +
>   	/* initialize prescaler */
>   	while (readl_relaxed(base + OMAP_WATCHDOG_WPS) & 0x01)
>   		cpu_relax();
>

