Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48706 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbdCBUD7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Mar 2017 15:03:59 -0500
Subject: Re: [PATCH] watchdog: orion: fix compile-test dependencies
To: Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>
References: <20170302121009.2348055-1-arnd@arndb.de>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <484651b0-32b3-f961-5302-85d295da3ec9@roeck-us.net>
Date: Thu, 2 Mar 2017 06:25:50 -0800
MIME-Version: 1.0
In-Reply-To: <20170302121009.2348055-1-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/02/2017 04:09 AM, Arnd Bergmann wrote:
> I ran into one corner case with the orion watchdog using the
> atomic_io_modify interface:
>
> drivers/watchdog/orion_wdt.o: In function `orion_stop':
> orion_wdt.c:(.text.orion_stop+0x28): undefined reference to `atomic_io_modify'
> drivers/watchdog/orion_wdt.o: In function `armada375_stop':
> orion_wdt.c:(.text.armada375_stop+0x28): undefined reference to `atomic_io_modify'
>
> This function is available on all 32-bit ARM builds except for ebsa110, so
> we have to specifically exclude that from compile-testing.
>
> Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 657529fc1453..5c3deeed646a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -452,7 +452,7 @@ config DAVINCI_WATCHDOG
>
>  config ORION_WATCHDOG
>  	tristate "Orion watchdog"
> -	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU || COMPILE_TEST
> +	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU || (COMPILE_TEST && !ARCH_EBSA110)
>  	depends on ARM
>  	select WATCHDOG_CORE
>  	help
>

