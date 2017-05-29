Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41830 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdE2THQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 29 May 2017 15:07:16 -0400
Subject: Re: [PATCH v2] drivers/watchdog/Kconfig: Update CONFIG_WATCHDOG_RTAS
 dependencies
To: Murilo Opsfelder Araujo <mopsfelder@gmail.com>,
        linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20170529132628.10803-1-mopsfelder@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ea2c9fc6-068e-f9f6-f8eb-1399c9a6cf7a@roeck-us.net>
Date: Mon, 29 May 2017 12:07:12 -0700
MIME-Version: 1.0
In-Reply-To: <20170529132628.10803-1-mopsfelder@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/29/2017 06:26 AM, Murilo Opsfelder Araujo wrote:
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
> This patch fixes the issue by updating CONFIG_WATCHDOG_RTAS to depend on just
> CONFIG_PPC_RTAS, removing COMPILE_TEST entirely.
> 
> Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 8b9049d..e6e31a1 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1688,7 +1688,7 @@ config MEN_A21_WDT
>   
>   config WATCHDOG_RTAS
>   	tristate "RTAS watchdog"
> -	depends on PPC_RTAS || (PPC64 && COMPILE_TEST)
> +	depends on PPC_RTAS
>   	help
>   	  This driver adds watchdog support for the RTAS watchdog.
>   
> 

