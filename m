Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41709 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165AbbHGOxD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Aug 2015 10:53:03 -0400
Message-ID: <55C4C648.4060509@roeck-us.net>
Date: Fri, 07 Aug 2015 07:52:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@iguana.be>
CC: kernel@pengutronix.de, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1 1/5] watchdog: mpc8xxx: remove dead code
References: <1438942067-1654-1-git-send-email-u.kleine-koenig@pengutronix.de> <1438942067-1654-2-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1438942067-1654-2-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/07/2015 03:07 AM, Uwe Kleine-König wrote:
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/mpc8xxx_wdt.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index 689381a24887..8ad42b83f995 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -68,12 +68,6 @@ module_param(nowayout, bool, 0);
>   MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
>   		 "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>
> -/*
> - * We always prescale, but if someone really doesn't want to they can set this
> - * to 0
> - */
> -static int prescale = 1;
> -
>   static DEFINE_SPINLOCK(wdt_spinlock);
>
>   static void mpc8xxx_wdt_keepalive(void)
> @@ -101,11 +95,9 @@ static void mpc8xxx_wdt_timer_ping(unsigned long arg)
>
>   static int mpc8xxx_wdt_start(struct watchdog_device *w)
>   {
> -	u32 tmp = SWCRR_SWEN;
> +	u32 tmp = SWCRR_SWEN | SWCRR_SWPR;
>
>   	/* Good, fire up the show */
> -	if (prescale)
> -		tmp |= SWCRR_SWPR;
>   	if (reset)
>   		tmp |= SWCRR_SWRI;
>
> @@ -179,10 +171,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>   	}
>
>   	/* Calculate the timeout in seconds */
> -	if (prescale)
> -		timeout_sec = (timeout * wdt_type->prescaler) / freq;
> -	else
> -		timeout_sec = timeout / freq;
> +	timeout_sec = (timeout * wdt_type->prescaler) / freq;
>
>   	mpc8xxx_wdt_dev.timeout = timeout_sec;
>   #ifdef MODULE
>

