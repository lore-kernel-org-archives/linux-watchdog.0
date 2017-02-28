Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44534 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdCABMh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Feb 2017 20:12:37 -0500
Date: Tue, 28 Feb 2017 13:39:01 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] watchdog: kempld: revert to full dependency
Message-ID: <20170228213901.GC6651@roeck-us.net>
References: <20170228210123.3404816-1-arnd@arndb.de>
 <20170228210123.3404816-9-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170228210123.3404816-9-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 28, 2017 at 10:01:23PM +0100, Arnd Bergmann wrote:
> The kempld watchdog driver requires the respective MFD driver:
> 
> drivers/watchdog/built-in.o: In function `kempld_wdt_probe':
> kempld_wdt.c:(.text+0x5c78): undefined reference to `kempld_get_mutex'
> kempld_wdt.c:(.text+0x5c84): undefined reference to `kempld_read8'
> kempld_wdt.c:(.text+0x5c8e): undefined reference to `kempld_release_mutex'
> kempld_wdt.c:(.text+0x5d1c): undefined reference to `kempld_read8'
> kempld_wdt.c:(.text+0x5d2c): undefined reference to `kempld_write8'
> 
> This adds the Kconfig dependency back.
> 
> Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 8cb9b986ee2d..fcaab3139a5c 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1064,7 +1064,7 @@ config HP_WATCHDOG
>  
>  config KEMPLD_WDT
>  	tristate "Kontron COM Watchdog Timer"
> -	depends on MFD_KEMPLD || COMPILE_TEST
> +	depends on MFD_KEMPLD

Randy suggested:

-       depends on MFD_KEMPLD || COMPILE_TEST
+       depends on MFD_KEMPLD || (MFD_KEMPLD=y && COMPILE_TEST)

... though I guess that boils down to the same.

Guenter

>  	select WATCHDOG_CORE
>  	help
>  	  Support for the PLD watchdog on some Kontron ETX and COMexpress
> -- 
> 2.9.0
> 
