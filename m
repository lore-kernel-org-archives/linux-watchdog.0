Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35229 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbdB1SnS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Feb 2017 13:43:18 -0500
Date: Tue, 28 Feb 2017 10:43:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-watchdog@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Michael Brunner <michael.brunner@kontron.com>
Subject: Re: [PATCH -next] watchdog/kempld_wdt: fix build for COMPILE_TEST
Message-ID: <20170228184314.GA5589@roeck-us.net>
References: <00718dc0-2a7c-391d-a091-c79e192dbeb2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00718dc0-2a7c-391d-a091-c79e192dbeb2@infradead.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 28, 2017 at 10:31:07AM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kconfig dependencies when COMPILE_TEST is enabled so that
> interdependent module dependencies are configured as needed.
> 
> Fixes build when MFD_KEMPLD=m and KEMPLD_WDT=y and COMPILE_TEST=y.
> The problem is in mixing tristate and boolean dependencies.
> 
> This fixes 32 build errors like these (most are omitted here):
> drivers/built-in.o: In function `kempld_wdt_stop':
> kempld_wdt.c:(.text+0x19ab8d): undefined reference to `kempld_get_mutex'
> kempld_wdt.c:(.text+0x19ab99): undefined reference to `kempld_read8'
> kempld_wdt.c:(.text+0x19abaa): undefined reference to `kempld_write8'
> kempld_wdt.c:(.text+0x19abbf): undefined reference to `kempld_release_mutex'
> drivers/built-in.o: In function `kempld_wdt_keepalive':
> kempld_wdt.c:(.text+0x19ac24): undefined reference to `kempld_release_mutex'
> drivers/built-in.o: In function `kempld_wdt_set_stage_action.isra.4':
> kempld_wdt.c:(.text+0x19aca1): undefined reference to `kempld_get_mutex'
> drivers/built-in.o: In function `kempld_wdt_set_stage_timeout.isra.5':
> kempld_wdt.c:(.text+0x19adde): undefined reference to `kempld_release_mutex'
> drivers/built-in.o: In function `kempld_wdt_start':
> kempld_wdt.c:(.text+0x19ae89): undefined reference to `kempld_get_mutex'
> drivers/built-in.o: In function `kempld_wdt_get_timeout.isra.6':
> kempld_wdt.c:(.text+0x19b01a): undefined reference to `kempld_read8'
> drivers/built-in.o: In function `kempld_wdt_update_timeouts':
> kempld_wdt.c:(.text+0x19b0c6): undefined reference to `kempld_get_mutex'
> drivers/built-in.o: In function `kempld_wdt_suspend':
> kempld_wdt.c:(.text+0x19b136): undefined reference to `kempld_release_mutex'
> drivers/built-in.o: In function `kempld_wdt_probe':
> kempld_wdt.c:(.text+0x19b1a4): undefined reference to `kempld_get_mutex'
> kempld_wdt.c:(.text+0x19b1bd): undefined reference to `kempld_release_mutex'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michael Brunner <michael.brunner@kontron.com>

And I thought I had that all sorted out :-(

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20170228.orig/drivers/watchdog/Kconfig
> +++ linux-next-20170228/drivers/watchdog/Kconfig
> @@ -1063,7 +1063,7 @@ config HP_WATCHDOG
>  
>  config KEMPLD_WDT
>  	tristate "Kontron COM Watchdog Timer"
> -	depends on MFD_KEMPLD || COMPILE_TEST
> +	depends on MFD_KEMPLD || (MFD_KEMPLD=y && COMPILE_TEST)
>  	select WATCHDOG_CORE
>  	help
>  	  Support for the PLD watchdog on some Kontron ETX and COMexpress
