Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55554 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbcGONrN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Jul 2016 09:47:13 -0400
Subject: Re: [PATCH 1/3] watchdog: bcm2835_wdt: constify _ops and _info
 structures
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
References: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk>
Cc: linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5788E956.8000905@roeck-us.net>
Date: Fri, 15 Jul 2016 06:47:02 -0700
MIME-Version: 1.0
In-Reply-To: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/15/2016 01:15 AM, Rasmus Villemoes wrote:
> These are never modified, so might as well be const.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/bcm2835_wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
> index 2e6164c..733e402 100644
> --- a/drivers/watchdog/bcm2835_wdt.c
> +++ b/drivers/watchdog/bcm2835_wdt.c
> @@ -96,7 +96,7 @@ static unsigned int bcm2835_wdt_get_timeleft(struct watchdog_device *wdog)
>   	return WDOG_TICKS_TO_SECS(ret & PM_WDOG_TIME_SET);
>   }
>
> -static struct watchdog_ops bcm2835_wdt_ops = {
> +static const struct watchdog_ops bcm2835_wdt_ops = {
>   	.owner =	THIS_MODULE,
>   	.start =	bcm2835_wdt_start,
>   	.stop =		bcm2835_wdt_stop,
> @@ -104,7 +104,7 @@ static struct watchdog_ops bcm2835_wdt_ops = {
>   	.get_timeleft =	bcm2835_wdt_get_timeleft,
>   };
>
> -static struct watchdog_info bcm2835_wdt_info = {
> +static const struct watchdog_info bcm2835_wdt_info = {
>   	.options =	WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE |
>   			WDIOF_KEEPALIVEPING,
>   	.identity =	"Broadcom BCM2835 Watchdog timer",
>

