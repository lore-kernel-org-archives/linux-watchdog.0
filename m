Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:34000 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752769AbaCOTyh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Mar 2014 15:54:37 -0400
Date: Sat, 15 Mar 2014 20:54:36 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: ib700wdt: Use platform_driver_probe
Message-ID: <20140315195436.GE14681@spo001.leaseweb.com>
References: <20140314131847.5e27fe11@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140314131847.5e27fe11@endymion.delvare>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jean,

> Using platform_driver_probe instead of platform_driver_register has
> two benefits:
> * The driver will fail to load if device probing fails.
> * The probe function can be marked __init.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
>  drivers/watchdog/ib700wdt.c |   21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> --- linux-3.14-rc6.orig/drivers/watchdog/ib700wdt.c	2014-01-20 03:40:07.000000000 +0100
> +++ linux-3.14-rc6/drivers/watchdog/ib700wdt.c	2014-03-13 15:31:38.097211632 +0100
> @@ -277,7 +277,7 @@ static struct miscdevice ibwdt_miscdev =
>   *	Init & exit routines
>   */
>  
> -static int ibwdt_probe(struct platform_device *dev)
> +static int __init ibwdt_probe(struct platform_device *dev)
>  {
>  	int res;
>  
> @@ -336,7 +336,6 @@ static void ibwdt_shutdown(struct platfo
>  }
>  
>  static struct platform_driver ibwdt_driver = {
> -	.probe		= ibwdt_probe,
>  	.remove		= ibwdt_remove,
>  	.shutdown	= ibwdt_shutdown,
>  	.driver		= {
> @@ -351,21 +350,19 @@ static int __init ibwdt_init(void)
>  
>  	pr_info("WDT driver for IB700 single board computer initialising\n");
>  
> -	err = platform_driver_register(&ibwdt_driver);
> -	if (err)
> -		return err;
> -
>  	ibwdt_platform_device = platform_device_register_simple(DRV_NAME,
>  								-1, NULL, 0);
> -	if (IS_ERR(ibwdt_platform_device)) {
> -		err = PTR_ERR(ibwdt_platform_device);
> -		goto unreg_platform_driver;
> -	}
> +	if (IS_ERR(ibwdt_platform_device))
> +		return PTR_ERR(ibwdt_platform_device);
> +
> +	err = platform_driver_probe(&ibwdt_driver, ibwdt_probe);
> +	if (err)
> +		goto unreg_platform_device;
>  
>  	return 0;
>  
> -unreg_platform_driver:
> -	platform_driver_unregister(&ibwdt_driver);
> +unreg_platform_device:
> +	platform_device_unregister(ibwdt_platform_device);
>  	return err;
>  }
>  
> 
> 

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

