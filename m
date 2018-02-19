Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36877 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752734AbeBSPst (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Feb 2018 10:48:49 -0500
Received: by mail-pg0-f65.google.com with SMTP id o1so6003238pgn.4
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Feb 2018 07:48:49 -0800 (PST)
Subject: Re: [PATCH 1/1] watchdog: xen_wdt: fix potential build failure
To: Radu Rendec <radu.rendec@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
References: <20180219143851.13983-1-radu.rendec@gmail.com>
 <20180219143851.13983-2-radu.rendec@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8b93abdc-354f-2f1d-7201-8ca930fe8a8b@roeck-us.net>
Date: Mon, 19 Feb 2018 07:48:47 -0800
MIME-Version: 1.0
In-Reply-To: <20180219143851.13983-2-radu.rendec@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/19/2018 06:38 AM, Radu Rendec wrote:
> xen_wdt uses watchdog core functions (from watchdog_core.c) and, when
> compiled without CONFIG_WATCHDOG_CORE being set, it produces the
> following build error:
> 
> ERROR: "devm_watchdog_register_device" [drivers/watchdog/xen_wdt.ko] undefined!
> ERROR: "watchdog_init_timeout" [drivers/watchdog/xen_wdt.ko] undefined!
> 
> Fix this by selecting CONFIG_WATCHDOG_CORE when CONFIG_XEN_WDT is set.
> 
> Fixes: 18cffd68e0c4 ("watchdog: xen_wdt: use the watchdog subsystem")
> Signed-off-by: Radu Rendec <radu.rendec@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Sorry, should have caught that during the review.

Guenter

> ---
>   drivers/watchdog/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index a16bad78679b..2953e9fbb818 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1838,6 +1838,7 @@ config WATCHDOG_SUN4V
>   config XEN_WDT
>   	tristate "Xen Watchdog support"
>   	depends on XEN
> +	select WATCHDOG_CORE
>   	help
>   	  Say Y here to support the hypervisor watchdog capability provided
>   	  by Xen 4.0 and newer.  The watchdog timeout period is normally one
> 

