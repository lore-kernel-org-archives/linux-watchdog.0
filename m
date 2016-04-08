Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36348 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbcDHApB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Apr 2016 20:45:01 -0400
Date: Thu, 7 Apr 2016 17:45:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, tglx@linutronix.de, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wim@iguana.be,
	linus.walleij@linaro.org, gnurou@gmail.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 04/10] iio: stx104: Change STX104 dependency to ISA_BUS
Message-ID: <20160408004503.GB10211@roeck-us.net>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
 <783be62acf68b35f3fe4785a2cedfe017624688b.1460040201.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <783be62acf68b35f3fe4785a2cedfe017624688b.1460040201.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Apr 07, 2016 at 10:47:25AM -0400, William Breathitt Gray wrote:
> The Apex Embedded Systems STX104 may be used on 64-bit X86 systems. This
> patch allows the Apex Embedded Systems STX104 DAC driver to be compiled
> for both 32-bit and 64-bit X86 systems.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/iio/dac/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index a995139..df4b55d 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -210,7 +210,7 @@ config MCP4922
>  
>  config STX104
>  	tristate "Apex Embedded Systems STX104 DAC driver"
> -	depends on ISA
> +	depends on X86 && ISA_BUS

This means for this and other similar drivers that the driver is no longer
supported on architectures which support ISA but not the newly introduced
ISA_BUS. Affected architectures are alpha, arm, m32r, m68k, mips, powerpc,
and parisc.

A typical example is SCSI_AHA1542, which is no longer supported on those
architectures. It builds, but isa_register_driver() will be a dummy and fail.
Actually, this is true for _all_ drivers calling isa_register_driver().

I hope this is understood and doesn't cause any problems.

Thanks,
Guenter

>  	help
>  	  Say yes here to build support for the 2-channel DAC on the Apex
>  	  Embedded Systems STX104 integrated analog PC/104 card. The base port
> -- 
> 2.7.3
> 
