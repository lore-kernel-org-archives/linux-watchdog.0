Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56062 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbcGONrl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Jul 2016 09:47:41 -0400
Subject: Re: [PATCH 2/3] watchdog: bcm2835_wdt: remove redundant ->set_timeout
 callback
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
References: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1468570524-18222-2-git-send-email-rasmus.villemoes@prevas.dk>
Cc: linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5788E971.2020005@roeck-us.net>
Date: Fri, 15 Jul 2016 06:47:29 -0700
MIME-Version: 1.0
In-Reply-To: <1468570524-18222-2-git-send-email-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/15/2016 01:15 AM, Rasmus Villemoes wrote:
> bcm2835_wdt_set_timeout does exactly what the watchdog framework does
> in the absence of a ->set_timeout callback (see watchdog_set_timeout
> in watchdog_dev.c), so remove it.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/bcm2835_wdt.c | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
> index 733e402..4dddd82 100644
> --- a/drivers/watchdog/bcm2835_wdt.c
> +++ b/drivers/watchdog/bcm2835_wdt.c
> @@ -82,12 +82,6 @@ static int bcm2835_wdt_stop(struct watchdog_device *wdog)
>   	return 0;
>   }
>
> -static int bcm2835_wdt_set_timeout(struct watchdog_device *wdog, unsigned int t)
> -{
> -	wdog->timeout = t;
> -	return 0;
> -}
> -
>   static unsigned int bcm2835_wdt_get_timeleft(struct watchdog_device *wdog)
>   {
>   	struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
> @@ -100,7 +94,6 @@ static const struct watchdog_ops bcm2835_wdt_ops = {
>   	.owner =	THIS_MODULE,
>   	.start =	bcm2835_wdt_start,
>   	.stop =		bcm2835_wdt_stop,
> -	.set_timeout =	bcm2835_wdt_set_timeout,
>   	.get_timeleft =	bcm2835_wdt_get_timeleft,
>   };
>
>

