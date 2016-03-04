Return-path: <wimvs@spo001.leaseweb.nl>
Date: Fri, 4 Mar 2016 20:37:44 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Justin Chen <justinpopo6@gmail.com>
Subject: Re: [PATCH v2] watchdog: Add hardware dependency to BCM7038 driver
Message-ID: <20160304193744.GD6900@spo001.leaseweb.nl>
References: <20160224161726.4888edd4@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160224161726.4888edd4@endymion>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Jean,

> The BCM7038 watchdog driver is specific to Broadcom ARM and MIPS
> SoCs so do not present it on other architectures, unless
> build-testing.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Justin Chen <justinpopo6@gmail.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
> Changes since v1:
>  * Better dependencies, suggested by Justin, and updated the
>    description accordingly.
>  * Better option description, provided by Justin.
> 
>  drivers/watchdog/Kconfig |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> --- linux-4.5-rc5.orig/drivers/watchdog/Kconfig	2016-02-24 14:43:18.943460233 +0100
> +++ linux-4.5-rc5/drivers/watchdog/Kconfig	2016-02-24 15:42:49.756057691 +0100
> @@ -1377,10 +1377,12 @@ config BCM7038_WDT
>  	tristate "BCM7038 Watchdog"
>  	select WATCHDOG_CORE
>  	depends on HAS_IOMEM
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
>  	help
> -	 Watchdog driver for the built-in hardware in Broadcom 7038 SoCs.
> -
> -	 Say 'Y or 'M' here to enable the driver.
> +	 Watchdog driver for the built-in hardware in Broadcom 7038 and
> +	 later SoCs used in set-top boxes.  BCM7038 was made public
> +	 during the 2004 CES, and since then, many Broadcom chips use this
> +	 watchdog block, including some cable modem chips.
>  
>  config IMGPDC_WDT
>  	tristate "Imagination Technologies PDC Watchdog Timer"
> 
> -- 
> Jean Delvare
> SUSE L3 Support

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.
