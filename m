Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43891 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbcLDR0Y (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 4 Dec 2016 12:26:24 -0500
Subject: Re: [PATCH v2.3 2/3] watchdog: loongson1: Add Loongson1 SoC watchdog
 driver
To: Yang Ling <gnaygnil@gmail.com>, wim@iguana.be,
        keguang.zhang@gmail.com
References: <20161204150250.GA29772@ubuntu>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8b12c705-27d3-f9a9-2a99-6be190f19ae9@roeck-us.net>
Date: Sun, 4 Dec 2016 09:26:19 -0800
MIME-Version: 1.0
In-Reply-To: <20161204150250.GA29772@ubuntu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/04/2016 07:02 AM, Yang Ling wrote:
> Add watchdog timer specific driver for Loongson1 SoC.
>
> Signed-off-by: Yang Ling <gnaygnil@gmail.com>
>
> ---
> V2.3:
>   Set DEFAULT_HEARTBEAT value to ls1x_wdt->timeout.
> V2.2:
>   Remove the wide character.
>   Check the return value for clk_get_rate().
> V2.1 from Kelvin Cheung:
>   Use max_hw_heartbeat_ms instead of max_timeout.
> V2.0:
>   Increase the value of the default heartbeat.
>   Modify the setup process for register.
>   Order include files and Makefile alphabetically.
> V1.1:
>   Add a little debugging information.
> ---
>  drivers/watchdog/Kconfig         |   7 ++
>  drivers/watchdog/Makefile        |   1 +
>  drivers/watchdog/loongson1_wdt.c | 170 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 178 insertions(+)
>  create mode 100644 drivers/watchdog/loongson1_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index fdd3228..c5b9c6e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1513,6 +1513,13 @@ config LANTIQ_WDT
>  	help
>  	  Hardware driver for the Lantiq SoC Watchdog Timer.
>
> +config LOONGSON1_WDT
> +	tristate "Loongson1 SoC hardware watchdog"
> +	depends on MACH_LOONGSON32
> +	select WATCHDOG_CORE
> +	help
> +	  Hardware driver for the Loongson1 SoC Watchdog Timer.
> +
>  config RALINK_WDT
>  	tristate "Ralink SoC watchdog"
>  	select WATCHDOG_CORE
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index caa9f4a..0c3d35e 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -163,6 +163,7 @@ obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
>  obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
>  octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
>  obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
> +obj-$(CONFIG_LOONGSON1_WDT) += loongson1_wdt.o
>  obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
>  obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
>  obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
> diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
> new file mode 100644
> index 0000000..c43ad38
> --- /dev/null
> +++ b/drivers/watchdog/loongson1_wdt.c
> @@ -0,0 +1,170 @@
> +/*
> + * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <loongson1.h>
> +
> +#define DEFAULT_HEARTBEAT	30
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0444);
> +
> +static unsigned int heartbeat = DEFAULT_HEARTBEAT;

heartbeat should be 0.

Guenter

