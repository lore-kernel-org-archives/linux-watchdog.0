Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54795 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdE0BxO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 26 May 2017 21:53:14 -0400
Subject: Re: [PATCH] drivers/watchdog/Kconfig: Update CONFIG_WATCHDOG_RTAS
 dependencies
To: Murilo Opsfelder Araujo <mopsfelder@gmail.com>,
        linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20170527012256.6005-1-mopsfelder@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2c95ae14-06a7-d3c2-aabb-1e164eb6b6e9@roeck-us.net>
Date: Fri, 26 May 2017 18:53:10 -0700
MIME-Version: 1.0
In-Reply-To: <20170527012256.6005-1-mopsfelder@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/26/2017 06:22 PM, Murilo Opsfelder Araujo wrote:
> drivers/watchdog/wdrtas.c uses symbols defined in arch/powerpc/kernel/rtas.c,
> which are exported iff CONFIG_PPC_RTAS is selected. Building wdrtas.c without
> setting CONFIG_PPC_RTAS throws the following errors:
> 
>      ERROR: ".rtas_token" [drivers/watchdog/wdrtas.ko] undefined!
>      ERROR: "rtas_data_buf" [drivers/watchdog/wdrtas.ko] undefined!
>      ERROR: "rtas_data_buf_lock" [drivers/watchdog/wdrtas.ko] undefined!
>      ERROR: ".rtas_get_sensor" [drivers/watchdog/wdrtas.ko] undefined!
>      ERROR: ".rtas_call" [drivers/watchdog/wdrtas.ko] undefined!
> 
> This was identified during a randconfig build where CONFIG_WATCHDOG_RTAS=m and
> CONFIG_PPC_RTAS was not set. Logs are here:
> 
>      http://kisskb.ellerman.id.au/kisskb/buildresult/12982152/
> 
> This patch fixes the issue by selecting CONFIG_PPC_RTAS when
> CONFIG_WATCHDOG_RTAS is set.
> 
> Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
> ---
>   drivers/watchdog/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 8b9049d..5d872145 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1689,6 +1689,7 @@ config MEN_A21_WDT
>   config WATCHDOG_RTAS
>   	tristate "RTAS watchdog"
>   	depends on PPC_RTAS || (PPC64 && COMPILE_TEST)
> +	select PPC_RTAS

This can not at the same time depend on PPC_RTAS and select it.
Guess we'll have to drop COMPILE_TEST entirely.

Guenter
