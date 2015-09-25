Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37275 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756574AbbIYN3X (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 25 Sep 2015 09:29:23 -0400
Subject: Re: [PATCH] watchdog: iTCO_wdt: Fix unmet dependency in select
To: Jean Delvare <jdelvare@suse.de>, linux-watchdog@vger.kernel.org
References: <20150925101045.06062b59@endymion.delvare>
Cc: Linux I2C <linux-i2c@vger.kernel.org>,
	Jim Davis <jim.epost@gmail.com>,
	Matt Fleming <matt.fleming@intel.com>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56054C2E.9010703@roeck-us.net>
Date: Fri, 25 Sep 2015 06:29:18 -0700
MIME-Version: 1.0
In-Reply-To: <20150925101045.06062b59@endymion.delvare>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/25/2015 01:10 AM, Jean Delvare wrote:
> ITCO_WDT selects I2C_I801 but does not select its dependencies (I2C.)
> This can result in link-time failures:
>
> drivers/built-in.o: In function `i801_remove':
> i2c-i801.c:(.text+0x1a6126): undefined reference to `i2c_del_adapter'
> drivers/built-in.o: In function `dmi_check_onboard_devices':
> i2c-i801.c:(.text+0x1a7531): undefined reference to `i2c_new_device'
> drivers/built-in.o: In function `i801_probe':
> i2c-i801.c:(.text+0x1a7aa8): undefined reference to `i2c_add_adapter'
> i2c-i801.c:(.text+0x1a7e14): undefined reference to `i2c_new_device'
>
> So we must select I2C as well.
>
> Reported-by: Jim Davis <jim.epost@gmail.com>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: 2a7a0e9bf7 ("watchdog: iTCO_wdt: Add support for TCO on Intel Sunrisepoint")
> Cc: Matt Fleming <matt.fleming@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
>   drivers/watchdog/Kconfig |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-4.3-rc2.orig/drivers/watchdog/Kconfig	2015-09-24 11:43:29.959432358 +0200
> +++ linux-4.3-rc2/drivers/watchdog/Kconfig	2015-09-25 09:56:20.518840112 +0200
> @@ -818,6 +818,7 @@ config ITCO_WDT
>   	depends on (X86 || IA64) && PCI
>   	select WATCHDOG_CORE
>   	select LPC_ICH if !EXPERT
> +	select I2C if !EXPERT
>   	select I2C_I801 if !EXPERT
>   	---help---
>   	  Hardware driver for the intel TCO timer based watchdog devices.
>
>

I had fixed the problem differently, similar to other drivers.

http://patchwork.roeck-us.net/patch/239/

Waiting for Wim to apply it.

Guenter

