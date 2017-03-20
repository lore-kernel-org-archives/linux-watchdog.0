Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45887 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbdCTRHA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Mar 2017 13:07:00 -0400
Date: Mon, 20 Mar 2017 09:30:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: cadence_wdt: fix timeout setting
Message-ID: <20170320163028.GA7908@roeck-us.net>
References: <1489994971-56027-1-git-send-email-tomas.melin@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489994971-56027-1-git-send-email-tomas.melin@vaisala.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 20, 2017 at 09:29:31AM +0200, Tomas Melin wrote:
> wdt_timeout must not be initialized to CDNS_WDT_DEFAULT_TIMEOUT in
> order to allow the value to be overriddden by a device tree setting.
> 
> This way, the default timeout value will be used only in case module_param
> has not been set, or device tree timeout-sec has not been defined.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/cadence_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
> index f0d199a..85960c0 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -50,7 +50,7 @@
>  /* Counter maximum value */
>  #define CDNS_WDT_COUNTER_MAX 0xFFF
>  
> -static int wdt_timeout = CDNS_WDT_DEFAULT_TIMEOUT;
> +static int wdt_timeout;
>  static int nowayout = WATCHDOG_NOWAYOUT;
>  
>  module_param(wdt_timeout, int, 0);
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
