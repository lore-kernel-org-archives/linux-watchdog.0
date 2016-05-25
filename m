Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56763 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbcEYRam (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 13:30:42 -0400
Date: Wed, 25 May 2016 10:30:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 1/7] watchdog: softdog: remove obsolete comments
Message-ID: <20160525173036.GC19545@roeck-us.net>
References: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
 <1464158269-2447-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464158269-2447-2-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 25, 2016 at 08:37:43AM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> The history is obsolete, especially since we switched to watchdog
> framework. The section markers also don't make sense anymore given
> the small size of the driver.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/softdog.c | 33 ---------------------------------
>  1 file changed, 33 deletions(-)
> 
> diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
> index 99a06f9e393064..8bc0b164afc94b 100644
> --- a/drivers/watchdog/softdog.c
> +++ b/drivers/watchdog/softdog.c
> @@ -17,23 +17,6 @@
>   *
>   *	Software only watchdog driver. Unlike its big brother the WDT501P
>   *	driver this won't always recover a failed machine.
> - *
> - *  03/96: Angelo Haritsis <ah@doc.ic.ac.uk> :
> - *	Modularised.
> - *	Added soft_margin; use upon insmod to change the timer delay.
> - *	NB: uses same minor as wdt (WATCHDOG_MINOR); we could use separate
> - *	    minors.
> - *
> - *  19980911 Alan Cox
> - *	Made SMP safe for 2.3.x
> - *
> - *  20011127 Joel Becker (jlbec@evilplan.org>
> - *	Added soft_noboot; Allows testing the softdog trigger without
> - *	requiring a recompile.
> - *	Added WDIOC_GETTIMEOUT and WDIOC_SETTIMOUT.
> - *
> - *  20020530 Joel Becker <joel.becker@oracle.com>
> - *	Added Matt Domsch's nowayout module option.
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -71,19 +54,11 @@ module_param(soft_panic, int, 0);
>  MODULE_PARM_DESC(soft_panic,
>  	"Softdog action, set to 1 to panic, 0 to reboot (default=0)");
>  
> -/*
> - *	Our timer
> - */
> -
>  static void watchdog_fire(unsigned long);
>  
>  static struct timer_list watchdog_ticktock =
>  		TIMER_INITIALIZER(watchdog_fire, 0, 0);
>  
> -/*
> - *	If the timer expires..
> - */
> -
>  static void watchdog_fire(unsigned long data)
>  {
>  	module_put(THIS_MODULE);
> @@ -99,10 +74,6 @@ static void watchdog_fire(unsigned long data)
>  	}
>  }
>  
> -/*
> - *	Softdog operations
> - */
> -
>  static int softdog_ping(struct watchdog_device *w)
>  {
>  	if (!mod_timer(&watchdog_ticktock, jiffies+(w->timeout*HZ)))
> @@ -124,10 +95,6 @@ static int softdog_set_timeout(struct watchdog_device *w, unsigned int t)
>  	return 0;
>  }
>  
> -/*
> - *	Kernel Interfaces
> - */
> -
>  static struct watchdog_info softdog_info = {
>  	.identity = "Software Watchdog",
>  	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
