Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37353 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423127AbdKRQhg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 18 Nov 2017 11:37:36 -0500
Received: by mail-pg0-f66.google.com with SMTP id o7so4188255pgc.4
        for <linux-watchdog@vger.kernel.org>; Sat, 18 Nov 2017 08:37:36 -0800 (PST)
Date: Sat, 18 Nov 2017 08:37:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [v4,2/2] watchdog: xen_wdt: remove info message and version
 number
Message-ID: <20171118163735.GA13144@roeck-us.net>
References: <20171115193442.8511-2-rrendec@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171115193442.8511-2-rrendec@arista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 15, 2017 at 07:34:42PM +0000, Radu Rendec wrote:
> The initial info message (early in the xen_wdt_init_module() function)
> is not very useful and we already have a message on successful probe. If
> the probe fails, additional messages are printed anyway.
> 
> The version number serves no useful purpose and it ran out of favor
> upstream anyway.
> 
> Signed-off-by: Radu Rendec <rrendec@arista.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/xen_wdt.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
> index 51576e15a086..f1c016d015b3 100644
> --- a/drivers/watchdog/xen_wdt.c
> +++ b/drivers/watchdog/xen_wdt.c
> @@ -10,7 +10,6 @@
>   */
>  
>  #define DRV_NAME	"xen_wdt"
> -#define DRV_VERSION	"0.01"
>  
>  #include <linux/bug.h>
>  #include <linux/errno.h>
> @@ -189,8 +188,6 @@ static int __init xen_wdt_init_module(void)
>  	if (!xen_domain())
>  		return -ENODEV;
>  
> -	pr_info("Xen WatchDog Timer Driver v%s\n", DRV_VERSION);
> -
>  	err = platform_driver_register(&xen_wdt_driver);
>  	if (err)
>  		return err;
> @@ -216,5 +213,4 @@ module_exit(xen_wdt_cleanup_module);
>  
>  MODULE_AUTHOR("Jan Beulich <jbeulich@novell.com>");
>  MODULE_DESCRIPTION("Xen WatchDog Timer Driver");
> -MODULE_VERSION(DRV_VERSION);
>  MODULE_LICENSE("GPL");
