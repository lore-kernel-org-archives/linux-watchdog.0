Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37749 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeH1X02 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 19:26:28 -0400
Date: Tue, 28 Aug 2018 12:33:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH v2 1/4] watchdog: core: add mechanism to prevent
 removing if NOWAYOUT
Message-ID: <20180828193320.GA22656@roeck-us.net>
References: <20180828191416.7781-1-wsa+renesas@sang-engineering.com>
 <20180828191416.7781-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828191416.7781-2-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Aug 28, 2018 at 09:14:13PM +0200, Wolfram Sang wrote:
> To prevent removing if NOWAYOUT, we invalidate the .remove function and
> suppress the bind/unbind attributes in sysfs. These are driver
> capabilities, so we need to set it up at runtime during init. To avoid
> boilerplate, introduce module_watchdog_driver() similar to
> module_driver(). On top of that, we then build
> module_watchdog_platform_driver(). Others may follow, if needed.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  include/linux/watchdog.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 44985c4a1e86..5768fb6b5cde 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -216,4 +216,24 @@ extern void watchdog_unregister_device(struct watchdog_device *);
>  /* devres register variant */
>  int devm_watchdog_register_device(struct device *dev, struct watchdog_device *);
>  
> +#define module_watchdog_driver(__driver, __register, __unregister, __nowayout, ...) \
> +static int __init __driver##_init(void) \
> +{ \
> +	if (__nowayout) { \
> +		__driver.driver.suppress_bind_attrs = true; \
> +		__driver.remove = NULL; \

Does that really do any good ? If I understand correctly, the only
impact is that the platform driver remove function will believe that
nothing needs to be done on removal. See platform_drv_remove().

> +	} \
> +	return __register(&(__driver)  ##__VA_ARGS__); \
> +} \
> +module_init(__driver##_init); \
> +static void __exit __driver##_exit(void) \
> +{ \
> +	__unregister(&(__driver), ##__VA_ARGS__); \
> +} \
> +module_exit(__driver##_exit)
> +
> +#define module_watchdog_platform_driver(__platform_driver, __nowayout) \
> +	module_watchdog_driver(__platform_driver, platform_driver_register, \
> +				platform_driver_unregister, __nowayout)
> +
>  #endif  /* ifndef _LINUX_WATCHDOG_H */
> -- 
> 2.11.0
> 
