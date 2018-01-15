Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33715 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbeAOSAf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 15 Jan 2018 13:00:35 -0500
Subject: Re: [PATCH] watchdog: rave-sp: add NVMEM dependency
To: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180115161052.684821-1-arnd@arndb.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9fd661f1-6093-a6f3-6044-a32566abdbab@roeck-us.net>
Date: Mon, 15 Jan 2018 10:00:29 -0800
MIME-Version: 1.0
In-Reply-To: <20180115161052.684821-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/15/2018 08:10 AM, Arnd Bergmann wrote:
> We can build this driver with or without NVMEM, but not built-in
> when NVMEM is a loadable module:
> 
> drivers/watchdog/rave-sp-wdt.o: In function `rave_sp_wdt_probe':
> rave-sp-wdt.c:(.text+0x27c): undefined reference to `nvmem_cell_get'
> rave-sp-wdt.c:(.text+0x290): undefined reference to `nvmem_cell_read'
> rave-sp-wdt.c:(.text+0x2c4): undefined reference to `nvmem_cell_put'
> 
> This adds a Kconfig dependency to enforce that.
> 
> Fixes: c3bb33345721 ("watchdog: Add RAVE SP watchdog driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 34d1c6851fa7..c09369f80989 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -226,6 +226,7 @@ config ZIIRAVE_WATCHDOG
>   config RAVE_SP_WATCHDOG
>   	tristate "RAVE SP Watchdog timer"
>   	depends on RAVE_SP_CORE
> +	depends on NVMEM || !NVMEM
>   	select WATCHDOG_CORE
>   	help
>   	  Support for the watchdog on RAVE SP device.
> 

