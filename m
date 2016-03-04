Return-path: <wimvs@spo001.leaseweb.nl>
Date: Fri, 4 Mar 2016 20:37:07 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: orion: Depend on 32-bit ARM
Message-ID: <20160304193707.GC6900@spo001.leaseweb.nl>
References: <1456323726-20234-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456323726-20234-1-git-send-email-thierry.reding@gmail.com>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Thierry,

> From: Thierry Reding <treding@nvidia.com>
> 
> The driver uses the atomic_io_modify() function to update registers, but
> that function is only available on 32-bit ARM. Recent changes have added
> ARCH_MVEBU support to 64-bit ARM and hence allowed this driver to build
> on 64-bit ARM where this function isn't available and thereby causing
> allmodconfig builds to break.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/watchdog/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9289da313d98..cfec157488b1 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -399,6 +399,7 @@ config DAVINCI_WATCHDOG
>  config ORION_WATCHDOG
>  	tristate "Orion watchdog"
>  	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU
> +	depends on ARM
>  	select WATCHDOG_CORE
>  	help
>  	  Say Y here if to include support for the watchdog timer
> -- 
> 2.7.1
> 

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.
