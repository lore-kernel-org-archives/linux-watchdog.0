Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59881 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755638AbdEOQRI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 15 May 2017 12:17:08 -0400
Date: Mon, 15 May 2017 09:17:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: orion: don't build for ARCH_EBSA110
Message-ID: <20170515161705.GA22188@roeck-us.net>
References: <20170515155040.1521131-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170515155040.1521131-1-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, May 15, 2017 at 05:50:19PM +0200, Arnd Bergmann wrote:
> The randconfig builder caught another corner case with this driver that
> fails to build for EBSA110 since that has its own MMIO handlers and
> lacks atomic_io_modify:
> 
> drivers/watchdog/orion_wdt.o: In function `orion_stop':
> orion_wdt.c:(.text.orion_stop+0x28): undefined reference to `atomic_io_modify'
> orion_wdt.c:(.text.orion_stop+0x3c): undefined reference to `atomic_io_modify'
> drivers/watchdog/orion_wdt.o: In function `armada370_wdt_clock_init':
> orion_wdt.c:(.text.armada370_wdt_clock_init+0x2c): undefined reference to `atomic_io_modify'
> drivers/watchdog/orion_wdt.o: In function `armada375_stop':
> orion_wdt.c:(.text.armada375_stop+0x28): undefined reference to `atomic_io_modify'
> orion_wdt.c:(.text.armada375_stop+0x58): undefined reference to `atomic_io_modify'
> 
> The best workaround I can think of is to add another Kconfig dependency.
> We could add atomic_io_modify() for ebsa110 in theory, but it seemed
> wrong because that platform would never actually use it.
> 
> Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 52a70ee6014f..feead0dbfc55 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -453,7 +453,7 @@ config DAVINCI_WATCHDOG
>  config ORION_WATCHDOG
>  	tristate "Orion watchdog"
>  	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU || COMPILE_TEST
> -	depends on ARM
> +	depends on ARM && !ARCH_EBSA110
>  	select WATCHDOG_CORE
>  	help
>  	  Say Y here if to include support for the watchdog timer
> -- 
> 2.9.0
> 
