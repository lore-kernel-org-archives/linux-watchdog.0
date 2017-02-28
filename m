Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58033 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbdCAA34 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Feb 2017 19:29:56 -0500
Date: Tue, 28 Feb 2017 13:43:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] watchdog: bcm2835: add CONFIG_OF dependency
Message-ID: <20170228214349.GI6651@roeck-us.net>
References: <20170228210123.3404816-1-arnd@arndb.de>
 <20170228210123.3404816-8-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170228210123.3404816-8-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 28, 2017 at 10:01:22PM +0100, Arnd Bergmann wrote:
> Without CONFIG_OF, the driver fails to link:
> 
> drivers/watchdog/built-in.o: In function `bcm2835_power_off':
> bcm2835_wdt.c:(.text+0x1946): undefined reference to `of_find_device_by_node'
> 
> This adds a new dependency, to allow the COMPILE_TEST check to succeed.
> 
> Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 3216012170fa..8cb9b986ee2d 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1496,7 +1496,7 @@ config BCM63XX_WDT
>  
>  config BCM2835_WDT
>  	tristate "Broadcom BCM2835 hardware watchdog"
> -	depends on ARCH_BCM2835 || COMPILE_TEST
> +	depends on ARCH_BCM2835 || (OF && COMPILE_TEST)
>  	select WATCHDOG_CORE
>  	help
>  	  Watchdog driver for the built in watchdog hardware in Broadcom
> -- 
> 2.9.0
> 
