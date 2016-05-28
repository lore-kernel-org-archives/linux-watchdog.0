Return-path: <jic23@kernel.org>
Subject: Re: [PATCH v5 3/4] iio: stx104: Allow build for X86_64
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org
References: <cover.1464380034.git.vilhelm.gray@gmail.com>
 <26bbe8f7c46b2504068f11c1f6219e1df6879822.1464380034.git.vilhelm.gray@gmail.com>
Cc: x86@kernel.org, linux-next@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org, sfr@canb.auug.org.au, linux@roeck-us.net,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1d62168c-ab95-ff67-fd04-f8c3ba4f81a2@kernel.org>
Date: Sat, 28 May 2016 18:15:47 +0100
MIME-Version: 1.0
In-Reply-To: <26bbe8f7c46b2504068f11c1f6219e1df6879822.1464380034.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 27/05/16 23:09, William Breathitt Gray wrote:
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
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
I've only been following this discussion very vaguely, but the consensus seems
to be good, so feel free to apply this one with my Ack for IIO.
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/dac/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index e63b957..f7c71da 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -247,7 +247,7 @@ config MCP4922
>  
>  config STX104
>  	tristate "Apex Embedded Systems STX104 DAC driver"
> -	depends on X86 && ISA
> +	depends on X86 && ISA_BUS_API
>  	help
>  	  Say yes here to build support for the 2-channel DAC on the Apex
>  	  Embedded Systems STX104 integrated analog PC/104 card. The base port
> 
