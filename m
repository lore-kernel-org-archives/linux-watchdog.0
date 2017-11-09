Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45574 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbdKIQJL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 9 Nov 2017 11:09:11 -0500
Date: Thu, 9 Nov 2017 08:09:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: gpio_wdt: set WDOG_HW_RUNNING in gpio_wdt_stop
Message-ID: <20171109160909.GD19959@roeck-us.net>
References: <20171108181548.GA19661@roeck-us.net>
 <1510234795-25881-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510234795-25881-1-git-send-email-rasmus.villemoes@prevas.dk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Nov 09, 2017 at 02:39:55PM +0100, Rasmus Villemoes wrote:
> The first patch above (https://patchwork.kernel.org/patch/9970181/)
> makes the oops go away, but it just papers over the problem. The real
> problem is that the watchdog core clears WDOG_HW_RUNNING in
> watchdog_stop, and the gpio driver fails to set it in its stop
> function when it doesn't actually stop it. This means that the core
> doesn't know that it now has responsibility for petting the device, in
> turn causing the device to reset the system (I hadn't noticed this
> because the board I'm working on has that reset logic disabled).
> 
> How about this (other drivers may of course have the same problem, I
> haven't checked). One might say that ->stop should return an error
> when the device can't be stopped, but OTOH this brings parity between
> a device without a ->stop method and a GPIO wd that has always-running
> set. IOW, I think ->stop should only return an error when an actual
> attempt to stop the hardware failed.
> 
Agreed.

> From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> 
> The watchdog framework clears WDOG_HW_RUNNING before calling
> ->stop. If the driver is unable to stop the device, it is supposed to
> set that bit again so that the watchdog core takes care of sending
> heart-beats while the device is not open from user-space. Update the
> gpio_wdt driver to honour that contract (and get rid of the redundant
> clearing of WDOG_HW_RUNNING).
> 
> Fixes: 3c10bbde10 ("watchdog: core: Clear WDOG_HW_RUNNING before calling the stop function")
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  drivers/watchdog/gpio_wdt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index cb66c2f..7a6279d 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -80,7 +80,8 @@ static int gpio_wdt_stop(struct watchdog_device *wdd)
>  
>  	if (!priv->always_running) {
>  		gpio_wdt_disable(priv);
> -		clear_bit(WDOG_HW_RUNNING, &wdd->status);
> +	} else {
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
>  	}

{ } are now unnecessary. otherwise

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>  
>  	return 0;
> -- 
> 2.7.4
> 
