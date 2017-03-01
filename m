Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40856 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbdCAONh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 1 Mar 2017 09:13:37 -0500
Subject: Re: [PATCH 2/3] watchdog: db8500: add back prmcu dependency
To: Arnd Bergmann <arnd@arndb.de>
References: <20170301091531.522161-1-arnd@arndb.de>
 <20170301091531.522161-3-arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <307cb5ad-61d1-a72f-223c-11a7918c039a@roeck-us.net>
Date: Wed, 1 Mar 2017 06:13:29 -0800
MIME-Version: 1.0
In-Reply-To: <20170301091531.522161-3-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/01/2017 01:15 AM, Arnd Bergmann wrote:
> When the db8500 watchdog is enabled without the PRCMU, we get a lot of
> warnings about duplicate or missing helper functions:
>
> In file included from drivers/watchdog/ux500_wdt.c:21:0:
> include/linux/mfd/dbx500-prcmu.h:422:19: error: redefinition of 'prcmu_abb_read'
>  static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)
>
> This restores the dependency as it was.
>
> Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 47dbacf3bfb4..a199e8536ce4 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -574,7 +574,7 @@ config IMX2_WDT
>
>  config UX500_WATCHDOG
>  	tristate "ST-Ericsson Ux500 watchdog"
> -	depends on MFD_DB8500_PRCMU || (ARM && COMPILE_TEST)
> +	depends on MFD_DB8500_PRCMU
>  	select WATCHDOG_CORE
>  	default y
>  	help
>

