Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34504 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdB1Sni (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Feb 2017 13:43:38 -0500
Date: Tue, 28 Feb 2017 10:43:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-watchdog@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Mark Brown <broonie@kernel.org>,
        patches@opensource.wolfsonmicro.com
Subject: Re: [PATCH -next] watchdog/wm831x: fix build when COMPILE_TEST is
 enabled
Message-ID: <20170228184335.GB5589@roeck-us.net>
References: <8bb4874f-7d0e-225f-3a97-842c2d171c78@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bb4874f-7d0e-225f-3a97-842c2d171c78@infradead.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 28, 2017 at 10:31:15AM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kconfig dependencies when COMPILE_TEST is enabled so that
> interdependent module dependencies are configured as needed.
> 
> Fixes build when WM831X_WATCHDOG=m and COMPILE_TEST=y.
> No other WM831X drivers are enabled.
> The problem is in mixing tristate and boolean dependencies.
> 
> ERROR: "wm831x_reg_write" [drivers/watchdog/wm831x_wdt.ko] undefined!
> ERROR: "wm831x_reg_read" [drivers/watchdog/wm831x_wdt.ko] undefined!
> ERROR: "wm831x_reg_unlock" [drivers/watchdog/wm831x_wdt.ko] undefined!
> ERROR: "wm831x_reg_lock" [drivers/watchdog/wm831x_wdt.ko] undefined!
> ERROR: "wm831x_set_bits" [drivers/watchdog/wm831x_wdt.ko] undefined!
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc:	patches@opensource.wolfsonmicro.com
> Cc:	Mark Brown <broonie@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20170228.orig/drivers/watchdog/Kconfig
> +++ linux-next-20170228/drivers/watchdog/Kconfig
> @@ -176,7 +176,7 @@ config WDAT_WDT
>  
>  config WM831X_WATCHDOG
>  	tristate "WM831x watchdog"
> -	depends on MFD_WM831X || COMPILE_TEST
> +	depends on MFD_WM831X || (MFD_WM831X=y && COMPILE_TEST)
>  	select WATCHDOG_CORE
>  	help
>  	  Support for the watchdog in the WM831x AudioPlus PMICs.  When
