Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43412 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616AbcE0SWG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 May 2016 14:22:06 -0400
Date: Fri, 27 May 2016 11:21:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	sfr@canb.auug.org.au, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH v4 4/4] watchdog: ebc-c384_wdt: Allow build for X86_64
Message-ID: <20160527182151.GA24035@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, May 23, 2016 at 08:31:19PM -0400, William Breathitt Gray wrote:
> With the introduction of the ISA_BUS_API Kconfig option, ISA-style
> drivers may be built for X86_64 architectures. This patch changes the
> ISA Kconfig option dependency of the WinSystems EBC-C384 watchdog timer
> driver to ISA_BUS_API, thus allowing it to build for X86_64 as it is
> expected to.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index b54f26c..3938e2d 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -746,7 +746,7 @@ config ALIM7101_WDT
>  
>  config EBC_C384_WDT
>  	tristate "WinSystems EBC-C384 Watchdog Timer"
> -	depends on X86 && ISA
> +	depends on ISA_BUS_API

Assuming the dropped dependency on X86 is intentional:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>  	select WATCHDOG_CORE
>  	help
>  	  Enables watchdog timer support for the watchdog timer on the
> -- 
> 2.7.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
