Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45777 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdAXWTd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 24 Jan 2017 17:19:33 -0500
Date: Tue, 24 Jan 2017 14:19:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: ebc-c384_wdt: Utilize devm_ functions in
 driver probe callback
Message-ID: <20170124221929.GA11399@roeck-us.net>
References: <20170124220233.3389-1-vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170124220233.3389-1-vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 24, 2017 at 05:02:33PM -0500, William Breathitt Gray wrote:
> The devm_ resource manager functions allow memory to be automatically
> released when a device is unbound. This patch takes advantage of the
> resource manager functions and replaces the watchdog_register_device
> call with the devm_watchdog_register_device call. In addition, the
> ebc_c384_wdt_remove function has been removed as no longer necessary due
> to the use of the relevant devm_ resource manager functions.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
>   - Removed dev_set_drvdata call in ebc_c384_wdt_probe; now that
>     ebc_c384_wdt_remove is gone, the driver_data doesn't need to be set
> 
>  drivers/watchdog/ebc-c384_wdt.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
> index 4b849b8e..2170b275 100644
> --- a/drivers/watchdog/ebc-c384_wdt.c
> +++ b/drivers/watchdog/ebc-c384_wdt.c
> @@ -121,18 +121,7 @@ static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
>  		dev_warn(dev, "Invalid timeout (%u seconds), using default (%u seconds)\n",
>  			timeout, WATCHDOG_TIMEOUT);
>  
> -	dev_set_drvdata(dev, wdd);
> -
> -	return watchdog_register_device(wdd);
> -}
> -
> -static int ebc_c384_wdt_remove(struct device *dev, unsigned int id)
> -{
> -	struct watchdog_device *wdd = dev_get_drvdata(dev);
> -
> -	watchdog_unregister_device(wdd);
> -
> -	return 0;
> +	return devm_watchdog_register_device(dev, wdd);
>  }
>  
>  static struct isa_driver ebc_c384_wdt_driver = {
> @@ -140,7 +129,6 @@ static struct isa_driver ebc_c384_wdt_driver = {
>  	.driver = {
>  		.name = MODULE_NAME
>  	},
> -	.remove = ebc_c384_wdt_remove
>  };
>  
>  static int __init ebc_c384_wdt_init(void)
> -- 
> 2.11.0
> 
