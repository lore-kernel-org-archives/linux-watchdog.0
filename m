Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51926 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbdB1Vnb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Feb 2017 16:43:31 -0500
Date: Tue, 28 Feb 2017 13:43:24 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] watchdog: sp805: add back AMBA dependency
Message-ID: <20170228214324.GH6651@roeck-us.net>
References: <20170228210123.3404816-1-arnd@arndb.de>
 <20170228210123.3404816-7-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170228210123.3404816-7-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 28, 2017 at 10:01:21PM +0100, Arnd Bergmann wrote:
> The driver fails to link if ARM_AMBA is disabled:
> 
> drivers/watchdog/sp805_wdt.o: In function `sp805_wdt_driver_init':
> sp805_wdt.c:(.init.text+0x4): undefined reference to `amba_driver_register'
> 
> It seems that the COMPILE_TEST was added in the wrong place, as there
> is no architecture dependency, but a bus dependency. This moves
> the dependency accordingly.
> 
> Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index ab0ec389e436..3216012170fa 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -218,7 +218,7 @@ config ZIIRAVE_WATCHDOG
>  
>  config ARM_SP805_WATCHDOG
>  	tristate "ARM SP805 Watchdog"
> -	depends on (ARM || ARM64) && (ARM_AMBA || COMPILE_TEST)
> +	depends on (ARM || ARM64 || COMPILE_TEST) && ARM_AMBA
>  	select WATCHDOG_CORE
>  	help
>  	  ARM Primecell SP805 Watchdog timer. This will reboot your system when
> -- 
> 2.9.0
> 
