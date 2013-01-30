Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 30 Jan 2013 20:23:30 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Dajun Chen <dchen@diasemi.com>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: da9055_wdt needs to select WATCHDOG_CORE
Message-ID: <20130130192330.GD20100@spo001.leaseweb.com>
References: <20130129000610.22f0ebd13431c59c5dc8cf3d@canb.auug.org.au> <5106A77C.2050400@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5106A77C.2050400@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Randy,

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> DA9055_WATCHDOG needs to select WATCHDOG_CORE so that it will
> build cleanly.  Fixes these build errors:
> 
> da9055_wdt.c:(.text+0xe9bc7): undefined reference to `watchdog_unregister_device'
> da9055_wdt.c:(.text+0xe9f4b): undefined reference to `watchdog_register_device'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Dajun Chen <dchen@diasemi.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-watchdog@vger.kernel.org
> ---
>  drivers/watchdog/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> Found in linux-next, but also applies to mainline.
> 
> --- linux-next-20130128.orig/drivers/watchdog/Kconfig
> +++ linux-next-20130128/drivers/watchdog/Kconfig
> @@ -79,6 +79,7 @@ config DA9052_WATCHDOG
>  config DA9055_WATCHDOG
>  	tristate "Dialog Semiconductor DA9055 Watchdog"
>  	depends on MFD_DA9055
> +	select WATCHDOG_CORE
>  	help
>  	  If you say yes here you get support for watchdog on the Dialog
>  	  Semiconductor DA9055 PMIC.

Added to linux-watchdog-next.

Kind regards,
Wim.
