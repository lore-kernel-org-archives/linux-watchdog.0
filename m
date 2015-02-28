Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:55862 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751464AbbB1Pgc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 28 Feb 2015 10:36:32 -0500
Message-ID: <1425137789.24292.44.camel@x220>
Subject: Re: [PATCH v4 6/9] watchdog: st_wdt: Add new driver for ST's LPC
 Watchdog
From: Paul Bolle <pebolle@tiscali.nl>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com, a.zummo@towertech.it,
	kernel@stlinux.com
Date: Sat, 28 Feb 2015 16:36:29 +0100
In-Reply-To: <1424872349-4155-7-git-send-email-lee.jones@linaro.org>
References: <1424872349-4155-1-git-send-email-lee.jones@linaro.org>
	 <1424872349-4155-7-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 2015-02-25 at 13:52 +0000, Lee Jones wrote:
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: David Paris <david.paris@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/watchdog/Kconfig      |  13 ++
>  drivers/watchdog/Makefile     |   1 +
>  drivers/watchdog/st_lpc_wdt.c | 333 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 347 insertions(+)
>  create mode 100644 drivers/watchdog/st_lpc_wdt.c

A few nits follow.

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 16f2023..023df6d 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -471,6 +471,19 @@ config SIRFSOC_WATCHDOG
>  	  Support for CSR SiRFprimaII and SiRFatlasVI watchdog. When
>  	  the watchdog triggers the system will be reset.
>  
> +config ST_LPC_WATCHDOG
> +	tristate "STMicroelectronics LPC Watchdog"
> +	depends on ARCH_STI
> +	depends on OF
> +	select WATCHDOG_CORE
> +	select MFD_ST_LPC
> +	help
> +	  Say Y here to include STMicroelectronics Low Power Controller
> +	  (LPC) based Watchdog timer support.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called st_wdt.
> +

This calls the module st_wdt. So does the title.

>  config TEGRA_WATCHDOG
>  	tristate "Tegra watchdog"
>  	depends on (ARCH_TEGRA || COMPILE_TEST) && HAS_IOMEM
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 5c19294..d98768c 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
>  obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o
>  obj-$(CONFIG_MOXART_WDT) += moxart_wdt.o
>  obj-$(CONFIG_SIRFSOC_WATCHDOG) += sirfsoc_wdt.o
> +obj-$(CONFIG_ST_LPC_WATCHDOG) += st_lpc_wdt.o

But this makes it st_lpc_wdt, doesn't it?

>  obj-$(CONFIG_QCOM_WDT) += qcom-wdt.o
>  obj-$(CONFIG_BCM_KONA_WDT) += bcm_kona_wdt.o
>  obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
> diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
> new file mode 100644
> index 0000000..91bb631
> --- /dev/null
> +++ b/drivers/watchdog/st_lpc_wdt.c
> @@ -0,0 +1,333 @@
> +/*
> + * st-wdt.c - ST's LPC Watchdog

Mismatch between "st-wdt.c" and the actual filename. Perhaps just remove
"st-wdt.c - "?

> + *
> + * Copyright (C) 2014 STMicroelectronics -- All Rights Reserved
> + *
> + * Author: David Paris <david.paris@st.com> for STMicroelectronics
> + *         Lee Jones <lee.jones@linaro.org> for STMicroelectronics
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public Licence
> + * as published by the Free Software Foundation; either version
> + * 2 of the Licence, or (at your option) any later version.
> + */

This states the license is "GPL v2 or later"

[...]

> +MODULE_LICENSE("GPL v2");

So this should probably be
    MODULE_LICENSE("GPL");


Paul Bolle

