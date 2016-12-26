Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49302 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753368AbcLZKji (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Dec 2016 05:39:38 -0500
Subject: Re: [PATCH] drivers: watchdog: pika_wdt: add __ro_after_init to ident
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr,
        wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1482652824-8648-1-git-send-email-bhumirks@gmail.com>
Cc: keescook@chromium.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <182d4c22-53d1-5b93-5eb5-2763005a94be@roeck-us.net>
Date: Mon, 26 Dec 2016 02:39:35 -0800
MIME-Version: 1.0
In-Reply-To: <1482652824-8648-1-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/25/2016 12:00 AM, Bhumika Goyal wrote:
> The object ident of type watchdog_info structure is not
> modified after getting initialized by pikawdt_init. Apart from getting
> referenced in init it is also passed as an argument to the function
> copy_to_user but this argument is of type const void *. Therefore add
> __ro_after_init to its declaration.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/pika_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
> index 0cdfee2..e35cf5e 100644
> --- a/drivers/watchdog/pika_wdt.c
> +++ b/drivers/watchdog/pika_wdt.c
> @@ -54,7 +54,7 @@
>  	struct timer_list timer;	/* The timer that pings the watchdog */
>  } pikawdt_private;
>
> -static struct watchdog_info ident = {
> +static struct watchdog_info ident __ro_after_init = {
>  	.identity	= DRV_NAME,
>  	.options	= WDIOF_CARDRESET |
>  			  WDIOF_SETTIMEOUT |
>

