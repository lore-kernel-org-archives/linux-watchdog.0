Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41873 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab1FGJ7h (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Jun 2011 05:59:37 -0400
Received: by wwa36 with SMTP id 36so4739894wwa.1
        for <linux-watchdog@vger.kernel.org>; Tue, 07 Jun 2011 02:59:36 -0700 (PDT)
Date: Tue, 7 Jun 2011 10:59:32 +0100
From: Jamie Iles <jamie@jamieiles.com>
To: Florian Fainelli <florian@openwrt.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>, stable@kernel.org
Subject: Re: [PATCH 3/3] WATCHDOG: mtx1-wdt: fix GPIO toggling
Message-ID: <20110607095932.GC21174@pulham.picochip.com>
References: <201106021454.21827.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106021454.21827.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jun 02, 2011 at 02:54:21PM +0200, Florian Fainelli wrote:
> Commit e391be76 (MIPS: Alchemy: Clean up GPIO registers and accessors)
> changed the way the GPIO was toggled. Prior to this patch, we would
> always actively drive the GPIO output to either 0 or 1, this patch
> drove the GPIO active to 0, and put the GPIO in tristate to drive it
> to 1, unfortunately this does not work, revert back to active driving.
> 
> Using a signed variable (gstate) to hold the gpio state and using a bit-
> wise operation on it also resulted in toggling value from 1 to -2 since
> the variable is signed. This value was then passed on to gpio_direction_
> output, which always perform a if (value) ... to set the value to the
> gpio, so we were always writing a 1 to this GPIO instead of 1 -> 0 -> 1 ...
> 
> CC: stable@kernel.org
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> index 16086f8..9756da9 100644
> --- a/drivers/watchdog/mtx-1_wdt.c
> +++ b/drivers/watchdog/mtx-1_wdt.c
> @@ -66,7 +66,7 @@ static struct {
>  	int default_ticks;
>  	unsigned long inuse;
>  	unsigned gpio;
> -	int gstate;
> +	unsigned int gstate;
>  } mtx1_wdt_device;
>  
>  static void mtx1_wdt_trigger(unsigned long unused)
> @@ -78,11 +78,8 @@ static void mtx1_wdt_trigger(unsigned long unused)
>  		ticks--;
>  
>  	/* toggle wdt gpio */
> -	mtx1_wdt_device.gstate = ~mtx1_wdt_device.gstate;
> -	if (mtx1_wdt_device.gstate)
> -		gpio_direction_output(mtx1_wdt_device.gpio, 1);
> -	else
> -		gpio_direction_input(mtx1_wdt_device.gpio);
> +	mtx1_wdt_device.gstate = !mtx1_wdt_device.gstate;
> +	gpio_direction_output(mtx1_wdt_device.gpio, mtx1_wdt_device.gstate);

Would gpio_set_value() be more appropriate here?  Isn't the gpio always 
an output after the first call?

Jamie
