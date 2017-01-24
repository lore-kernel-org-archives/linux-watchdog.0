Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52981 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdAXVwj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 24 Jan 2017 16:52:39 -0500
Date: Tue, 24 Jan 2017 13:52:34 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: ebc-c384_wdt: Utilize devm_ functions in
 driver probe callback
Message-ID: <20170124215234.GB9359@roeck-us.net>
References: <20170124203619.21099-1-vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170124203619.21099-1-vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 24, 2017 at 03:36:19PM -0500, William Breathitt Gray wrote:
> The devm_ resource manager functions allow memory to be automatically
> released when a device is unbound. This patch takes advantage of the
> resource manager functions and replaces the watchdog_register_device
> call with the devm_watchdog_register_device call. In addition, the
> ebc_c384_wdt_remove function has been removed as no longer necessary due
> to the use of the relevant devm_ resource manager functions.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/watchdog/ebc-c384_wdt.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
> index 4b849b8e..de135dff 100644
> --- a/drivers/watchdog/ebc-c384_wdt.c
> +++ b/drivers/watchdog/ebc-c384_wdt.c
> @@ -123,16 +123,7 @@ static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
>  
>  	dev_set_drvdata(dev, wdd);

Unless I am missing something, this is no longer needed.

Thanks,
Guenter

>  
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
> @@ -140,7 +131,6 @@ static struct isa_driver ebc_c384_wdt_driver = {
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
