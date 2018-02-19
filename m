Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42641 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753130AbeBSQky (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Feb 2018 11:40:54 -0500
Received: by mail-pf0-f193.google.com with SMTP id t15so1541501pfh.9
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Feb 2018 08:40:54 -0800 (PST)
Subject: Re: [PATCH] watchdog: sp5100_tco.c: fix potential build failure
To: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org
References: <20180219160433.GA25309@www.linux-watchdog.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2457bca8-86ea-49ce-6259-cdfa3e6a396e@roeck-us.net>
Date: Mon, 19 Feb 2018 08:40:51 -0800
MIME-Version: 1.0
In-Reply-To: <20180219160433.GA25309@www.linux-watchdog.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/19/2018 08:04 AM, Wim Van Sebroeck wrote:
> isp5100_tco.c  uses watchdog core functions (from watchdog_core.c) and, when
> compiled without CONFIG_WATCHDOG_CORE being set, it produces the
> following build error:
> 
> ERROR: "devm_watchdog_register_device" [drivers/watchdog/sp5100_tco.ko] undefined!
> ERROR: "watchdog_init_timeout" [drivers/watchdog/sp5100_tco.ko] undefined!
> 
> Fix this by selecting CONFIG_WATCHDOG_CORE.
> 
> Fixes: 7cd9d5fff792 ("watchdog: sp5100_tco: Convert to use watchdog subsystem")
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

I really need to get better watching out for those dependencies :-(

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 3d984cd..37460cd 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -904,6 +904,7 @@ config F71808E_WDT
>   config SP5100_TCO
>          tristate "AMD/ATI SP5100 TCO Timer/Watchdog"
>          depends on X86 && PCI
> +       select WATCHDOG_CORE
>          ---help---
>            Hardware watchdog driver for the AMD/ATI SP5100 chipset. The TCO
>            (Total Cost of Ownership) timer is a watchdog timer that will reboot
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

