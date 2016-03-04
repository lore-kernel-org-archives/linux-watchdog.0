Return-path: <wimvs@spo001.leaseweb.nl>
Date: Fri, 4 Mar 2016 20:36:04 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: ts4800: add hardware dependency
Message-ID: <20160304193604.GB6900@spo001.leaseweb.nl>
References: <20160209111549.7e9b4fbb@endymion> <20160209111748.4973e203@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160209111748.4973e203@endymion>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Jean,

> The Technologic Systems TS-4800 is an i.MX515 board, so its drivers
> are useless unless building a SOC_IMX51 kernel, except for build
> testing purposes.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
>  drivers/watchdog/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-4.5-rc3.orig/drivers/watchdog/Kconfig	2016-02-09 08:53:37.465170476 +0100
> +++ linux-4.5-rc3/drivers/watchdog/Kconfig	2016-02-09 08:53:45.001221261 +0100
> @@ -468,6 +468,7 @@ config NUC900_WATCHDOG
>  config TS4800_WATCHDOG
>  	tristate "TS-4800 Watchdog"
>  	depends on HAS_IOMEM && OF
> +	depends on SOC_IMX51 || COMPILE_TEST
>  	select WATCHDOG_CORE
>  	select MFD_SYSCON
>  	help
> 
> -- 
> Jean Delvare
> SUSE L3 Support

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.
