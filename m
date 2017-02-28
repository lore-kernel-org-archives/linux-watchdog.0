Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59942 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbdB1Vmm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Feb 2017 16:42:42 -0500
Date: Tue, 28 Feb 2017 13:42:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] watchdog: geode: restore hard CS5535_MFGPT dependency
Message-ID: <20170228214229.GF6651@roeck-us.net>
References: <20170228210123.3404816-1-arnd@arndb.de>
 <20170228210123.3404816-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170228210123.3404816-5-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 28, 2017 at 10:01:19PM +0100, Arnd Bergmann wrote:
> Wtihout CONFIG_CS5535_MFGPT, the driver does not link right:
> 
> drivers/watchdog/built-in.o: In function `geodewdt_probe':
> geodewdt.c:(.init.text+0xca3): undefined reference to `cs5535_mfgpt_alloc_timer'
> geodewdt.c:(.init.text+0xcd4): undefined reference to `cs5535_mfgpt_write'
> geodewdt.c:(.init.text+0xcef): undefined reference to `cs5535_mfgpt_toggle_event'
> 
> This adds back the dependency on this base driver.
> 
> Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 34a927703d64..de52495ef150 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -851,7 +851,7 @@ config SP5100_TCO
>  
>  config GEODE_WDT
>  	tristate "AMD Geode CS5535/CS5536 Watchdog"
> -	depends on CS5535_MFGPT || (X86 && COMPILE_TEST)
> +	depends on CS5535_MFGPT
>  	help
>  	  This driver enables a watchdog capability built into the
>  	  CS5535/CS5536 companion chips for the AMD Geode GX and LX
> -- 
> 2.9.0
> 
