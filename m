Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36037 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbdHDNpN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 4 Aug 2017 09:45:13 -0400
Subject: Re: [PATCH 1/2] watchdog: cadence_wdt: Enable access to module
 parameters
To: Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
References: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c25ea869-55fe-dde9-4004-cb49bb5553c2@roeck-us.net>
Date: Fri, 4 Aug 2017 06:45:10 -0700
MIME-Version: 1.0
In-Reply-To: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/04/2017 12:39 AM, Michal Simek wrote:
> Give read access to module parameters to all and write access to root.
> This change also improves driver error path testing.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Please let me know what you think - I can use macros from stat.h if
> required
> 

Seems to be quite pointless and misleading, since the values are only read
at probe time. Am I missing something ?

Guenter

> ---
>   drivers/watchdog/cadence_wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
> index 05c000081e9d..dadd3b0c2d49 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -52,12 +52,12 @@
>   static int wdt_timeout;
>   static int nowayout = WATCHDOG_NOWAYOUT;
>   
> -module_param(wdt_timeout, int, 0);
> +module_param(wdt_timeout, int, 0644);
>   MODULE_PARM_DESC(wdt_timeout,
>   		 "Watchdog time in seconds. (default="
>   		 __MODULE_STRING(CDNS_WDT_DEFAULT_TIMEOUT) ")");
>   
> -module_param(nowayout, int, 0);
> +module_param(nowayout, int, 0644);
>   MODULE_PARM_DESC(nowayout,
>   		 "Watchdog cannot be stopped once started (default="
>   		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> 

