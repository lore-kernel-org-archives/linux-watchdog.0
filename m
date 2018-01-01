Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbeAAJza (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 1 Jan 2018 04:55:30 -0500
Date: Mon, 1 Jan 2018 09:55:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, mail@maciej.szmigiero.name,
        linux@roeck-us.net, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/5] iio: Change ISA_BUS_API dependency to selection
Message-ID: <20180101095525.0de5021a@archlinux>
In-Reply-To: <84517171cdb142f3f04b45de6ef8daf13442a866.1514578085.git.vilhelm.gray@gmail.com>
References: <cover.1514578085.git.vilhelm.gray@gmail.com>
        <84517171cdb142f3f04b45de6ef8daf13442a866.1514578085.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 29 Dec 2017 15:13:19 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The ISA_BUS_API Kconfig option enables the compilation of the ISA bus
> driver. The ISA bus driver does not perform any hardware interaction,
> and is instead just a thin layer of software abstraction to eliminate
> boilerplate code common to ISA-style device drivers. Since ISA_BUS_API
> has no dependencies and does not jeopardize the integrity of the system
> when enabled, drivers should select it when the ISA bus driver
> functionality is needed.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/Kconfig     | 3 ++-
>  drivers/iio/counter/Kconfig | 3 ++-
>  drivers/iio/dac/Kconfig     | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index ef86296b8b0d..7c00e5858693 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -658,7 +658,8 @@ config STM32_ADC
>  
>  config STX104
>  	tristate "Apex Embedded Systems STX104 driver"
> -	depends on PC104 && X86 && ISA_BUS_API
> +	depends on PC104 && X86
> +	select ISA_BUS_API
>  	select GPIOLIB
>  	help
>  	  Say yes here to build support for the Apex Embedded Systems STX104
> diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
> index 474e1ac4e7c0..bf1e559ad7cd 100644
> --- a/drivers/iio/counter/Kconfig
> +++ b/drivers/iio/counter/Kconfig
> @@ -7,7 +7,8 @@ menu "Counters"
>  
>  config 104_QUAD_8
>  	tristate "ACCES 104-QUAD-8 driver"
> -	depends on PC104 && X86 && ISA_BUS_API
> +	depends on PC104 && X86
> +	select ISA_BUS_API
>  	help
>  	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
>  	  encoder counter/interface device family (104-QUAD-8, 104-QUAD-4).
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 965d5c0d2468..76db0768e454 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -195,7 +195,8 @@ config AD7303
>  
>  config CIO_DAC
>  	tristate "Measurement Computing CIO-DAC IIO driver"
> -	depends on X86 && ISA_BUS_API
> +	depends on X86 && (ISA_BUS || PC104)
> +	select ISA_BUS_API
>  	help
>  	  Say yes here to build support for the Measurement Computing CIO-DAC
>  	  analog output device family (CIO-DAC16, CIO-DAC08, PC104-DAC06). The

