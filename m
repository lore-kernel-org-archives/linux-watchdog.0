Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40614 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbbEAExl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 May 2015 00:53:41 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1Yo2xI-000Tjt-1J
	for linux-watchdog@vger.kernel.org; Fri, 01 May 2015 04:53:40 +0000
Message-ID: <55430683.2030102@roeck-us.net>
Date: Thu, 30 Apr 2015 21:52:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <balbi@ti.com>
CC: Lokesh Vutla <lokeshvutla@ti.com>, kernel@pengutronix.de,
	unknown author <unknown.author@example.com>
Subject: Re: [PATCH v2 6/4] watchdog: omap: allow to keep timer running at
 probe time
References: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de> <1430332727-27491-2-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1430332727-27491-2-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/29/2015 11:38 AM, Uwe Kleine-König wrote:
> From: unknown author <unknown.author@example.com>
>
> On some machines it might be desirable to keep the watchdog that is
> started in the boot ROM running until userspace starts stroking it to be
> able to handle boot failures.
>
> To not introduce regressions for users not caring about the watchdog
> keep the previous behaviour of disabling the watchdog in the probe
> function unless a module parameter stop_at_probe is set to false.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Uwe,

would this address the problem you are tryng to solve ?

http://www.spinics.net/lists/arm-kernel/msg413658.html

Guenter

> ---
>   drivers/watchdog/omap_wdt.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index d7619dd7c1ca..5525afadf0ec 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -53,6 +53,11 @@ static unsigned timer_margin;
>   module_param(timer_margin, uint, 0);
>   MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)");
>
> +static bool stop_at_probe = true;
> +module_param(stop_at_probe, bool, 0);
> +MODULE_PARM_DESC(stop_at_probe,
> +		 "Watchdog is stopped at probe time (default=true)");
> +
>   #define to_omap_wdt_dev(_wdog)	container_of(_wdog, struct omap_wdt_dev, wdog)
>
>   struct omap_wdt_dev {
> @@ -254,7 +259,8 @@ static int omap_wdt_probe(struct platform_device *pdev)
>   			wdev->wdog.bootstatus = WDIOF_CARDRESET;
>   	}
>
> -	omap_wdt_disable(wdev);
> +	if (stop_at_probe)
> +		omap_wdt_disable(wdev);
>
>   	ret = watchdog_register_device(&wdev->wdog);
>   	if (ret) {
> @@ -262,9 +268,9 @@ static int omap_wdt_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>
> -	pr_info("OMAP Watchdog Timer Rev 0x%02x: initial timeout %d sec\n",
> +	pr_info("OMAP Watchdog Timer Rev 0x%02x: initial timeout %d sec, %sstopped\n",
>   		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
> -		wdev->wdog.timeout);
> +		wdev->wdog.timeout, stop_at_probe ? "" : "not ");
>
>   	pm_runtime_put_sync(wdev->dev);
>
>

