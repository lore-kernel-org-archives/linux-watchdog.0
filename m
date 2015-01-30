Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33671 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932705AbbA3OsM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Jan 2015 09:48:12 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YHCrk-002yJy-Nq
	for linux-watchdog@vger.kernel.org; Fri, 30 Jan 2015 14:48:13 +0000
Message-ID: <54CB9994.1020503@roeck-us.net>
Date: Fri, 30 Jan 2015 06:47:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH 2/4] watchdog: max63xx: cleanup
References: <1422551745-29101-1-git-send-email-vivien.didelot@savoirfairelinux.com> <1422551745-29101-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1422551745-29101-3-git-send-email-vivien.didelot@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/29/2015 09:15 AM, Vivien Didelot wrote:
> This patch cleans up the MAX63xx driver with the following:
>
>    * better device description;
>    * put module parameter just above their declaration for clarity;
>    * remove global variables in favor of a driver data structure;
>    * fix "quoted string split across lines" warning from checkpatch.pl;
>    * constify timeouts;
>    * factorize the SET write operations;
>    * few typos and comments...
>
> This will help introduce new features to the driver.
>
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> ---
>   drivers/watchdog/Kconfig       |   7 +-
>   drivers/watchdog/max63xx_wdt.c | 207 ++++++++++++++++++++---------------------
>   2 files changed, 108 insertions(+), 106 deletions(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 40ea835..fc10451 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -408,11 +408,14 @@ config TS72XX_WATCHDOG
>   	  module will be called ts72xx_wdt.
>
>   config MAX63XX_WATCHDOG
> -	tristate "Max63xx watchdog"
> +	tristate "Maxim MAX6369 Pin-Selectable Watchdog Timer and compatibles"
>   	depends on HAS_IOMEM
>   	select WATCHDOG_CORE
>   	help
> -	  Support for memory mapped max63{69,70,71,72,73,74} watchdog timer.
> +	  Support for MAX6369, MAX6370, MAX6371, MAX6372, MAX6373, and MAX6374.
> +
> +	  To compile this driver as a module, choose M here:
> +	  the module will be called max63xx_wdt.
>
>   config IMX2_WDT
>   	tristate "IMX2+ Watchdog"
> diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
> index 08da311..1d77669 100644
> --- a/drivers/watchdog/max63xx_wdt.c
> +++ b/drivers/watchdog/max63xx_wdt.c
> @@ -1,7 +1,5 @@
>   /*
> - * drivers/char/watchdog/max63xx_wdt.c
> - *
> - * Driver for max63{69,70,71,72,73,74} watchdog timers
> + * Maxim MAX6369 Pin-Selectable Watchdog Timer and compatibles
>    *
>    * Copyright (C) 2009 Marc Zyngier <maz@misterjones.org>
>    *
> @@ -26,23 +24,33 @@
>   #include <linux/io.h>
>   #include <linux/slab.h>
>
> -#define DEFAULT_HEARTBEAT 60
> -#define MAX_HEARTBEAT     60
> +#define DEFAULT_HEARTBEAT	60
> +#define MAX_HEARTBEAT		60
>
> -static unsigned int heartbeat = DEFAULT_HEARTBEAT;
> -static bool nowayout  = WATCHDOG_NOWAYOUT;
> +#define MAX63XX_DISABLED	3
>
> -/*
> - * Memory mapping: a single byte, 3 first lower bits to select bit 3
> - * to ping the watchdog.
> - */
> -#define MAX6369_WDSET	(7 << 0)
> -#define MAX6369_WDI	(1 << 3)

Not really sure I understand why you remove those constants.
that is personal preference, not cleanup. Someone else might
submit another cleanup later on and re-introduce them.

Guenter

