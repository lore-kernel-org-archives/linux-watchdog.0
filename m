Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42501 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbcE0SVA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 May 2016 14:21:00 -0400
Date: Fri, 27 May 2016 11:20:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	sfr@canb.auug.org.au, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 3/4] iio: stx104: Allow build for X86_64
Message-ID: <20160527182057.GC19472@roeck-us.net>
References: <cover.1464049539.git.vilhelm.gray@gmail.com>
 <e2165535dff3cfc30e82b5e3b4b4ccf9860ebf9f.1464049539.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2165535dff3cfc30e82b5e3b4b4ccf9860ebf9f.1464049539.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, May 23, 2016 at 08:31:07PM -0400, William Breathitt Gray wrote:
> With the introduction of the ISA_BUS_API Kconfig option, ISA-style
> drivers may be built for X86_64 architectures. This patch changes the
> ISA Kconfig option dependency of the Apex Embedded Systems STX104 DAC
> driver to ISA_BUS_API, thus allowing it to build for X86_64 as it is
> expected to.
> 
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/iio/dac/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index e63b957..315442f 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -247,7 +247,7 @@ config MCP4922
>  
>  config STX104
>  	tristate "Apex Embedded Systems STX104 DAC driver"
> -	depends on X86 && ISA
> +	depends on ISA_BUS_API

Assuming the dropped dependency on X86 is intentional:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>  	help
>  	  Say yes here to build support for the 2-channel DAC on the Apex
>  	  Embedded Systems STX104 integrated analog PC/104 card. The base port
> -- 
> 2.7.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
