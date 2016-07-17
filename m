Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43839 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751181AbcGQU0d (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:26:33 -0400
Date: Sun, 17 Jul 2016 22:26:10 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
	linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: bcm2835_wdt: constify _ops and _info structures
Message-ID: <20160717202610.GE916@spo001.leaseweb.nl>
References: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Rasmus,

> These are never modified, so might as well be const.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  drivers/watchdog/bcm2835_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
> index 2e6164c..733e402 100644
> --- a/drivers/watchdog/bcm2835_wdt.c
> +++ b/drivers/watchdog/bcm2835_wdt.c
> @@ -96,7 +96,7 @@ static unsigned int bcm2835_wdt_get_timeleft(struct watchdog_device *wdog)
>  	return WDOG_TICKS_TO_SECS(ret & PM_WDOG_TIME_SET);
>  }
>  
> -static struct watchdog_ops bcm2835_wdt_ops = {
> +static const struct watchdog_ops bcm2835_wdt_ops = {
>  	.owner =	THIS_MODULE,
>  	.start =	bcm2835_wdt_start,
>  	.stop =		bcm2835_wdt_stop,
> @@ -104,7 +104,7 @@ static struct watchdog_ops bcm2835_wdt_ops = {
>  	.get_timeleft =	bcm2835_wdt_get_timeleft,
>  };
>  
> -static struct watchdog_info bcm2835_wdt_info = {
> +static const struct watchdog_info bcm2835_wdt_info = {
>  	.options =	WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE |
>  			WDIOF_KEEPALIVEPING,
>  	.identity =	"Broadcom BCM2835 Watchdog timer",
> -- 
> 2.5.0
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

