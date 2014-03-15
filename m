Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:33995 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752769AbaCOTxG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Mar 2014 15:53:06 -0400
Date: Sat, 15 Mar 2014 20:53:04 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: advantechwdt: Use platform_driver_probe
Message-ID: <20140315195304.GC14681@spo001.leaseweb.com>
References: <20140314130740.15e2465d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140314130740.15e2465d@endymion.delvare>
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
>  drivers/watchdog/advantechwdt.c |   21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> --- linux-3.14-rc6.orig/drivers/watchdog/advantechwdt.c	2014-01-20 03:40:07.000000000 +0100
> +++ linux-3.14-rc6/drivers/watchdog/advantechwdt.c	2014-03-14 10:26:25.886315593 +0100
> @@ -238,7 +238,7 @@ static struct miscdevice advwdt_miscdev
>   *	Init & exit routines
>   */
>  
> -static int advwdt_probe(struct platform_device *dev)
> +static int __init advwdt_probe(struct platform_device *dev)
>  {
>  	int ret;
>  
> @@ -299,7 +299,6 @@ static void advwdt_shutdown(struct platf
>  }
>  
>  static struct platform_driver advwdt_driver = {
> -	.probe		= advwdt_probe,
>  	.remove		= advwdt_remove,
>  	.shutdown	= advwdt_shutdown,
>  	.driver		= {
> @@ -314,21 +313,19 @@ static int __init advwdt_init(void)
>  
>  	pr_info("WDT driver for Advantech single board computer initialising\n");
>  
> -	err = platform_driver_register(&advwdt_driver);
> -	if (err)
> -		return err;
> -
>  	advwdt_platform_device = platform_device_register_simple(DRV_NAME,
>  								-1, NULL, 0);
> -	if (IS_ERR(advwdt_platform_device)) {
> -		err = PTR_ERR(advwdt_platform_device);
> -		goto unreg_platform_driver;
> -	}
> +	if (IS_ERR(advwdt_platform_device))
> +		return PTR_ERR(advwdt_platform_device);
> +
> +	err = platform_driver_probe(&advwdt_driver, advwdt_probe);
> +	if (err)
> +		goto unreg_platform_device;
>  
>  	return 0;
>  
> -unreg_platform_driver:
> -	platform_driver_unregister(&advwdt_driver);
> +unreg_platform_device:
> +	platform_device_unregister(advwdt_platform_device);
>  	return err;
>  }
>  
> 
> 

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

