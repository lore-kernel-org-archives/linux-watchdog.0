Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54963 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbcGONqk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Jul 2016 09:46:40 -0400
Subject: Re: [PATCH 3/3] watchdog: bcm2835_wdt: set WDOG_HW_RUNNING bit when
 appropriate
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
References: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1468570524-18222-3-git-send-email-rasmus.villemoes@prevas.dk>
Cc: linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5788E935.6080608@roeck-us.net>
Date: Fri, 15 Jul 2016 06:46:29 -0700
MIME-Version: 1.0
In-Reply-To: <1468570524-18222-3-git-send-email-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/15/2016 01:15 AM, Rasmus Villemoes wrote:
> A bootloader may start the watchdog device before handing control to
> the kernel - in that case, we should tell the kernel about it so the
> watchdog framework can keep it alive until userspace opens
> /dev/watchdog0.
>

Separate note: The maximum timeout for this watchdog is 15 seconds.
Given that, it might be useful to set max_hw_heartbeat_ms instead of
max_timeout. Separate patch, though.

> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>   drivers/watchdog/bcm2835_wdt.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
> index 4dddd82..9a08334 100644
> --- a/drivers/watchdog/bcm2835_wdt.c
> +++ b/drivers/watchdog/bcm2835_wdt.c
> @@ -55,6 +55,15 @@ struct bcm2835_wdt {
>   static unsigned int heartbeat;
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>
> +static bool bcm2835_wdt_is_running(struct bcm2835_wdt *wdt)
> +{
> +	uint32_t cur;
> +
> +	cur = readl(wdt->base + PM_RSTC);
> +
> +	return !!(cur & PM_RSTC_WRCFG_FULL_RESET);
> +}
> +
>   static int bcm2835_wdt_start(struct watchdog_device *wdog)
>   {
>   	struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
> @@ -70,6 +79,7 @@ static int bcm2835_wdt_start(struct watchdog_device *wdog)
>   		  PM_RSTC_WRCFG_FULL_RESET, wdt->base + PM_RSTC);
>
>   	spin_unlock_irqrestore(&wdt->lock, flags);
> +	set_bit(WDOG_HW_RUNNING, &wdog->status);
>
You don't need to set this bit here unless the watchdog can not be stopped.

>   	return 0;
>   }
> @@ -79,6 +89,7 @@ static int bcm2835_wdt_stop(struct watchdog_device *wdog)
>   	struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
>
>   	writel_relaxed(PM_PASSWORD | PM_RSTC_RESET, wdt->base + PM_RSTC);
> +	clear_bit(WDOG_HW_RUNNING, &wdog->status);

... and since you clear the bit, it can be stopped. Both setting and resetting the bit
is therefore not necessary.

>   	return 0;
>   }
>
> @@ -181,6 +192,17 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
>   	watchdog_init_timeout(&bcm2835_wdt_wdd, heartbeat, dev);
>   	watchdog_set_nowayout(&bcm2835_wdt_wdd, nowayout);
>   	bcm2835_wdt_wdd.parent = &pdev->dev;
> +	if (bcm2835_wdt_is_running(wdt)) {
> +		/*
> +		 * The currently active timeout value (set by the
> +		 * bootloader) may be different from the module
> +		 * heartbeat parameter or the value in device
> +		 * tree. But we just need to set WDOG_HW_RUNNING,
> +		 * because then the framework will "immediately" ping
> +		 * the device, updating the timeout.
> +		 */
> +		set_bit(WDOG_HW_RUNNING, &bcm2835_wdt_wdd.status);
> +	}
>   	err = watchdog_register_device(&bcm2835_wdt_wdd);
>   	if (err) {
>   		dev_err(dev, "Failed to register watchdog device");
>

