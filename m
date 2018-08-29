Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44976 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeH2UMT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Aug 2018 16:12:19 -0400
Date: Wed, 29 Aug 2018 09:14:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH v3 1/4] watchdog: core: add mechanism to prevent
 removing if NOWAYOUT
Message-ID: <20180829161438.GA6723@roeck-us.net>
References: <20180829074241.1943-1-wsa+renesas@sang-engineering.com>
 <20180829074241.1943-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829074241.1943-2-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Aug 29, 2018 at 09:42:38AM +0200, Wolfram Sang wrote:
> To prevent removing if NOWAYOUT, we invalidate the .remove function and
> suppress the bind/unbind attributes in sysfs. These are driver
> capabilities, so we need to set it up at runtime during init. To avoid
> boilerplate, introduce module_watchdog_driver() similar to
> module_driver(). On top of that, we then build
> module_watchdog_platform_driver(). Others may follow, if needed.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  include/linux/watchdog.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 44985c4a1e86..c8ecbc53c807 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -216,4 +216,21 @@ extern void watchdog_unregister_device(struct watchdog_device *);
>  /* devres register variant */
>  int devm_watchdog_register_device(struct device *dev, struct watchdog_device *);
>  
> +#define module_watchdog_driver(__driver, __register, __unregister, __nowayout, ...) \

Another option might be to add another argument to this macro. Something like:

#define module_watchdog_driver(__wdriver, __driver, __register, __unregister, __nowayout, ...) \
static int __init __wdriver##_init(void) \
{ \
	__driver->suppress_bind_attrs = !!(__nowayout); \
	return __register(&(__wdriver)  ##__VA_ARGS__); \
} \
module_init(__wdriver##_init); \
static void __exit __wdriver##_exit(void) \
{ \
	__unregister(&(__wdriver), ##__VA_ARGS__); \
} \
module_exit(__wdriver##_exit)

#define module_watchdog_platform_driver(__platform_driver, __nowayout) \
	module_watchdog_driver(__platform_driver, &__platform_driver->driver, \
				platform_driver_register, \
				platform_driver_unregister, __nowayout)

This would avoid the dependency of having a ".driver" structure in each
supported bus driver structure.

Would that make sense ?

Guenter
