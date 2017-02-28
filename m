Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52678 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdB1VlO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Feb 2017 16:41:14 -0500
Date: Tue, 28 Feb 2017 13:40:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mfd: retu: add inline alternatives for CONFIG_RETU=n
Message-ID: <20170228214036.GD6651@roeck-us.net>
References: <20170228210123.3404816-1-arnd@arndb.de>
 <20170228210123.3404816-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170228210123.3404816-2-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 28, 2017 at 10:01:16PM +0100, Arnd Bergmann wrote:
> The retu watchdog calls into the respective mfd driver, but fails to
> link if that is diabled:
> 
> drivers/watchdog/built-in.o: In function `retu_wdt_set_timeout':
> ziirave_wdt.c:(.text+0x8c88): undefined reference to `retu_write'
> ziirave_wdt.c:(.text+0x8c88): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `retu_write'
> drivers/watchdog/built-in.o: In function `retu_wdt_start':
> ziirave_wdt.c:(.text+0x8cc8): undefined reference to `retu_write'
> ziirave_wdt.c:(.text+0x8cc8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `retu_write'
> 
> This adds inline stub helpers that let us build the driver anyway.
> 
> Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  include/linux/mfd/retu.h | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c831b7967bf9..6ca2f3ae7f1e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -585,7 +585,7 @@ config UX500_WATCHDOG
>  
>  config RETU_WATCHDOG
>  	tristate "Retu watchdog"
> -	depends on MFD_RETU || COMPILE_TEST
> +	depends on MFD_RETU || (COMPILE_TEST && MFD_RETU=n)

Let's just disable COMPILE_TEST for RETU_WATCHDOG instead.

>  	select WATCHDOG_CORE
>  	help
>  	  Retu watchdog driver for Nokia Internet Tablets (770, N800,
> diff --git a/include/linux/mfd/retu.h b/include/linux/mfd/retu.h
> index 65471c4a3926..a6828e899775 100644
> --- a/include/linux/mfd/retu.h
> +++ b/include/linux/mfd/retu.h
> @@ -11,8 +11,13 @@
>  
>  struct retu_dev;
>  
> +#if IS_ENABLED(CONFIG_MFD_RETU)
>  int retu_read(struct retu_dev *, u8);
>  int retu_write(struct retu_dev *, u8, u16);
> +#else
> +static inline int retu_read(struct retu_dev *dev, u8 r)		{ return -EINVAL; }
> +static inline int retu_write(struct retu_dev *dev, u8 r, u16 v)	{ return -EINVAL; }
> +#endif
>  
>  /* Registers */
>  #define RETU_REG_WATCHDOG	0x17		/* Watchdog */
> -- 
> 2.9.0
> 
