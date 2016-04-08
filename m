Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35110 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818AbcDHAfl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Apr 2016 20:35:41 -0400
Date: Thu, 7 Apr 2016 17:35:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, tglx@linutronix.de, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wim@iguana.be,
	linus.walleij@linaro.org, gnurou@gmail.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 06/10] watchdog: ebc-c384_wdt: Utilize the ISA bus driver
Message-ID: <20160408003535.GA10211@roeck-us.net>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
 <1f5bf2e21006f0fd4f10ab3948cf69a737c0b039.1460040201.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f5bf2e21006f0fd4f10ab3948cf69a737c0b039.1460040201.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Apr 07, 2016 at 10:47:27AM -0400, William Breathitt Gray wrote:
> The WinSystems EBC-C384 watchdog timer is controlled via ISA bus
> communication. As such, the ISA bus driver is more appropriate than the
> platform driver for the WinSystems EBC-C384 watchdog timer driver.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/watchdog/Kconfig        |  2 +-
>  drivers/watchdog/ebc-c384_wdt.c | 43 ++++++++++-------------------------------
>  2 files changed, 11 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index fb94765..b10761d 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -738,7 +738,7 @@ config ALIM7101_WDT
>  
>  config EBC_C384_WDT
>  	tristate "WinSystems EBC-C384 Watchdog Timer"
> -	depends on X86
> +	depends on X86 && ISA_BUS

I am a bit concerend that the newly introduced ISA_BUS is not automatically
enabled. Effectively this means that all drivers depending on it will
be disabled until someone enables ISA_BUS in the distribution.

Is this a concern for anyone but me ?

Anyway, since you are the driver maintainer, I assume that you are ok
with it, so

Acked-by: Guenter Roeck <linux@roeck-us.net>

Side note for Wim: ISA_BUS was introduced with commit b3c1be1b789c
("base: isa: Remove X86_32 dependency") in -next.

Guenter

>  	select WATCHDOG_CORE
>  	help
>  	  Enables watchdog timer support for the watchdog timer on the
> diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
> index 77fda0b..4b849b8 100644
> --- a/drivers/watchdog/ebc-c384_wdt.c
> +++ b/drivers/watchdog/ebc-c384_wdt.c
> @@ -16,10 +16,10 @@
>  #include <linux/errno.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/isa.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> -#include <linux/platform_device.h>
>  #include <linux/types.h>
>  #include <linux/watchdog.h>
>  
> @@ -95,9 +95,8 @@ static const struct watchdog_info ebc_c384_wdt_info = {
>  	.identity = MODULE_NAME
>  };
>  
> -static int __init ebc_c384_wdt_probe(struct platform_device *pdev)
> +static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
>  {
> -	struct device *dev = &pdev->dev;
>  	struct watchdog_device *wdd;
>  
>  	if (!devm_request_region(dev, BASE_ADDR, ADDR_EXTENT, dev_name(dev))) {
> @@ -122,61 +121,39 @@ static int __init ebc_c384_wdt_probe(struct platform_device *pdev)
>  		dev_warn(dev, "Invalid timeout (%u seconds), using default (%u seconds)\n",
>  			timeout, WATCHDOG_TIMEOUT);
>  
> -	platform_set_drvdata(pdev, wdd);
> +	dev_set_drvdata(dev, wdd);
>  
>  	return watchdog_register_device(wdd);
>  }
>  
> -static int ebc_c384_wdt_remove(struct platform_device *pdev)
> +static int ebc_c384_wdt_remove(struct device *dev, unsigned int id)
>  {
> -	struct watchdog_device *wdd = platform_get_drvdata(pdev);
> +	struct watchdog_device *wdd = dev_get_drvdata(dev);
>  
>  	watchdog_unregister_device(wdd);
>  
>  	return 0;
>  }
>  
> -static struct platform_driver ebc_c384_wdt_driver = {
> +static struct isa_driver ebc_c384_wdt_driver = {
> +	.probe = ebc_c384_wdt_probe,
>  	.driver = {
>  		.name = MODULE_NAME
>  	},
>  	.remove = ebc_c384_wdt_remove
>  };
>  
> -static struct platform_device *ebc_c384_wdt_device;
> -
>  static int __init ebc_c384_wdt_init(void)
>  {
> -	int err;
> -
>  	if (!dmi_match(DMI_BOARD_NAME, "EBC-C384 SBC"))
>  		return -ENODEV;
>  
> -	ebc_c384_wdt_device = platform_device_alloc(MODULE_NAME, -1);
> -	if (!ebc_c384_wdt_device)
> -		return -ENOMEM;
> -
> -	err = platform_device_add(ebc_c384_wdt_device);
> -	if (err)
> -		goto err_platform_device;
> -
> -	err = platform_driver_probe(&ebc_c384_wdt_driver, ebc_c384_wdt_probe);
> -	if (err)
> -		goto err_platform_driver;
> -
> -	return 0;
> -
> -err_platform_driver:
> -	platform_device_del(ebc_c384_wdt_device);
> -err_platform_device:
> -	platform_device_put(ebc_c384_wdt_device);
> -	return err;
> +	return isa_register_driver(&ebc_c384_wdt_driver, 1);
>  }
>  
>  static void __exit ebc_c384_wdt_exit(void)
>  {
> -	platform_device_unregister(ebc_c384_wdt_device);
> -	platform_driver_unregister(&ebc_c384_wdt_driver);
> +	isa_unregister_driver(&ebc_c384_wdt_driver);
>  }
>  
>  module_init(ebc_c384_wdt_init);
> @@ -185,4 +162,4 @@ module_exit(ebc_c384_wdt_exit);
>  MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
>  MODULE_DESCRIPTION("WinSystems EBC-C384 watchdog timer driver");
>  MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("platform:" MODULE_NAME);
> +MODULE_ALIAS("isa:" MODULE_NAME);
> -- 
> 2.7.3
> 
