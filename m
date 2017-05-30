Return-path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Murilo Opsfelder Araujo <mopsfelder@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>, linuxppc-dev@lists.ozlabs.org, Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Subject: Re: [PATCH v2] drivers/watchdog/Kconfig: Update CONFIG_WATCHDOG_RTAS dependencies
In-Reply-To: <20170529132628.10803-1-mopsfelder@gmail.com>
References: <20170529132628.10803-1-mopsfelder@gmail.com>
Date: Tue, 30 May 2017 20:55:35 +1000
Message-ID: <8737bm62c8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Murilo Opsfelder Araujo <mopsfelder@gmail.com> writes:

> drivers/watchdog/wdrtas.c uses symbols defined in arch/powerpc/kernel/rtas.c,
> which are exported iff CONFIG_PPC_RTAS is selected. Building wdrtas.c without
> setting CONFIG_PPC_RTAS throws the following errors:
>
>     ERROR: ".rtas_token" [drivers/watchdog/wdrtas.ko] undefined!
>     ERROR: "rtas_data_buf" [drivers/watchdog/wdrtas.ko] undefined!
>     ERROR: "rtas_data_buf_lock" [drivers/watchdog/wdrtas.ko] undefined!
>     ERROR: ".rtas_get_sensor" [drivers/watchdog/wdrtas.ko] undefined!
>     ERROR: ".rtas_call" [drivers/watchdog/wdrtas.ko] undefined!
>
> This was identified during a randconfig build where CONFIG_WATCHDOG_RTAS=m and
> CONFIG_PPC_RTAS was not set. Logs are here:
>
>     http://kisskb.ellerman.id.au/kisskb/buildresult/12982152/
>
> This patch fixes the issue by updating CONFIG_WATCHDOG_RTAS to depend on just
> CONFIG_PPC_RTAS, removing COMPILE_TEST entirely.
>
> Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
