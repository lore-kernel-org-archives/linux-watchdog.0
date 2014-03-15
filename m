Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:33993 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752769AbaCOTw2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Mar 2014 15:52:28 -0400
Date: Sat, 15 Mar 2014 20:52:26 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: acquirewdt: Use platform_driver_probe
Message-ID: <20140315195226.GB14681@spo001.leaseweb.com>
References: <20140314130437.0774fb75@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140314130437.0774fb75@endymion.delvare>
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
>  drivers/watchdog/acquirewdt.c |   21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> --- linux-3.14-rc6.orig/drivers/watchdog/acquirewdt.c	2014-01-20 03:40:07.000000000 +0100
> +++ linux-3.14-rc6/drivers/watchdog/acquirewdt.c	2014-03-14 10:32:39.208535731 +0100
> @@ -239,7 +239,7 @@ static struct miscdevice acq_miscdev = {
>   *	Init & exit routines
>   */
>  
> -static int acq_probe(struct platform_device *dev)
> +static int __init acq_probe(struct platform_device *dev)
>  {
>  	int ret;
>  
> @@ -291,7 +291,6 @@ static void acq_shutdown(struct platform
>  }
>  
>  static struct platform_driver acquirewdt_driver = {
> -	.probe		= acq_probe,
>  	.remove		= acq_remove,
>  	.shutdown	= acq_shutdown,
>  	.driver		= {
> @@ -306,20 +305,18 @@ static int __init acq_init(void)
>  
>  	pr_info("WDT driver for Acquire single board computer initialising\n");
>  
> -	err = platform_driver_register(&acquirewdt_driver);
> -	if (err)
> -		return err;
> -
>  	acq_platform_device = platform_device_register_simple(DRV_NAME,
>  								-1, NULL, 0);
> -	if (IS_ERR(acq_platform_device)) {
> -		err = PTR_ERR(acq_platform_device);
> -		goto unreg_platform_driver;
> -	}
> +	if (IS_ERR(acq_platform_device))
> +		return PTR_ERR(acq_platform_device);
> +
> +	err = platform_driver_probe(&acquirewdt_driver, acq_probe);
> +	if (err)
> +		goto unreg_platform_device;
>  	return 0;
>  
> -unreg_platform_driver:
> -	platform_driver_unregister(&acquirewdt_driver);
> +unreg_platform_device:
> +	platform_device_unregister(acq_platform_device);
>  	return err;
>  }
>  
> 
> 

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

