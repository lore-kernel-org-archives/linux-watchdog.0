Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39483 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbcE0SRo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 May 2016 14:17:44 -0400
Date: Fri, 27 May 2016 11:17:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	sfr@canb.auug.org.au, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 2/4] gpio: Allow PC/104 devices on X86_64
Message-ID: <20160527181724.GB19472@roeck-us.net>
References: <cover.1464049539.git.vilhelm.gray@gmail.com>
 <3cafd2a47f785ea9d0c96365b64366289a1b0807.1464049539.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cafd2a47f785ea9d0c96365b64366289a1b0807.1464049539.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, May 23, 2016 at 08:30:55PM -0400, William Breathitt Gray wrote:
> With the introduction of the ISA_BUS_API Kconfig option, ISA-style
> drivers may be built for X86_64 architectures. This patch changes the
> ISA Kconfig option dependency of the PC/104 drivers to ISA_BUS_API, thus
> allowing them to build for X86_64 as they are expected to.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/gpio/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 48da857..dc6da77 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -530,7 +530,7 @@ menu "Port-mapped I/O GPIO drivers"
>  
>  config GPIO_104_DIO_48E
>  	tristate "ACCES 104-DIO-48E GPIO support"
> -	depends on ISA
> +	depends on ISA_BUS_API
>  	select GPIOLIB_IRQCHIP
>  	help
>  	  Enables GPIO support for the ACCES 104-DIO-48E series (104-DIO-48E,
> @@ -540,7 +540,7 @@ config GPIO_104_DIO_48E
>  
>  config GPIO_104_IDIO_16
>  	tristate "ACCES 104-IDIO-16 GPIO support"
> -	depends on ISA
> +	depends on ISA_BUS_API
>  	select GPIOLIB_IRQCHIP
>  	help
>  	  Enables GPIO support for the ACCES 104-IDIO-16 family (104-IDIO-16,
> @@ -551,7 +551,7 @@ config GPIO_104_IDIO_16
>  
>  config GPIO_104_IDI_48
>  	tristate "ACCES 104-IDI-48 GPIO support"
> -	depends on ISA
> +	depends on ISA_BUS_API
>  	select GPIOLIB_IRQCHIP
>  	help
>  	  Enables GPIO support for the ACCES 104-IDI-48 family (104-IDI-48A,
> @@ -627,7 +627,7 @@ config GPIO_TS5500
>  
>  config GPIO_WS16C48
>  	tristate "WinSystems WS16C48 GPIO support"
> -	depends on ISA
> +	depends on ISA_BUS_API
>  	select GPIOLIB_IRQCHIP
>  	help
>  	  Enables GPIO support for the WinSystems WS16C48. The base port
> -- 
> 2.7.3
> 
