Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48743 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbdHNOr3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 10:47:29 -0400
Date: Mon, 14 Aug 2017 07:47:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 1/2] watchdog: cadence_wdt: Enable access to module
 parameters
Message-ID: <20170814144727.GB14491@roeck-us.net>
References: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Aug 04, 2017 at 09:39:16AM +0200, Michal Simek wrote:
> Give read access to module parameters to all and write access to root.
> This change also improves driver error path testing.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Please let me know what you think - I can use macros from stat.h if
> required
> 
You mean instead of 0644 ? That is discouraged nowadays.

Guenter

> ---
>  drivers/watchdog/cadence_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
> index 05c000081e9d..dadd3b0c2d49 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -52,12 +52,12 @@
>  static int wdt_timeout;
>  static int nowayout = WATCHDOG_NOWAYOUT;
>  
> -module_param(wdt_timeout, int, 0);
> +module_param(wdt_timeout, int, 0644);
>  MODULE_PARM_DESC(wdt_timeout,
>  		 "Watchdog time in seconds. (default="
>  		 __MODULE_STRING(CDNS_WDT_DEFAULT_TIMEOUT) ")");
>  
> -module_param(nowayout, int, 0);
> +module_param(nowayout, int, 0644);
>  MODULE_PARM_DESC(nowayout,
>  		 "Watchdog cannot be stopped once started (default="
>  		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> -- 
> 1.9.1
> 
