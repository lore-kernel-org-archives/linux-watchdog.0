Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:46393 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753699AbdFSMZh (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Jun 2017 08:25:37 -0400
In-Reply-To: <20170529132628.10803-1-mopsfelder@gmail.com>
To: Murilo Opsfelder Araujo <mopsfelder@gmail.com>,
        linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-watchdog@vger.kernel.org,
        Murilo Opsfelder Araujo <mopsfelder@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v2] drivers/watchdog/Kconfig: Update CONFIG_WATCHDOG_RTAS dependencies
Message-Id: <3wrqv32nQZz9s7v@ozlabs.org>
Date: Mon, 19 Jun 2017 22:25:35 +1000 (AEST)
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 2017-05-29 at 13:26:28 UTC, Murilo Opsfelder Araujo wrote:
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
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/42bed042556261b56aa92e05f4f388

cheers
