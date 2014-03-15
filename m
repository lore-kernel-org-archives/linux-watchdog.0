Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:33998 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755030AbaCOTx5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Mar 2014 15:53:57 -0400
Date: Sat, 15 Mar 2014 20:53:56 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: geodewdt: Use platform_driver_probe
Message-ID: <20140315195356.GD14681@spo001.leaseweb.com>
References: <20140314131647.60c51274@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140314131647.60c51274@endymion.delvare>
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
>  drivers/watchdog/geodewdt.c |   17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> --- linux-3.14-rc6.orig/drivers/watchdog/geodewdt.c	2014-01-20 03:40:07.000000000 +0100
> +++ linux-3.14-rc6/drivers/watchdog/geodewdt.c	2014-03-14 10:41:42.415355724 +0100
> @@ -215,7 +215,7 @@ static struct miscdevice geodewdt_miscde
>  	.fops = &geodewdt_fops,
>  };
>  
> -static int geodewdt_probe(struct platform_device *dev)
> +static int __init geodewdt_probe(struct platform_device *dev)
>  {
>  	int ret;
>  
> @@ -255,7 +255,6 @@ static void geodewdt_shutdown(struct pla
>  }
>  
>  static struct platform_driver geodewdt_driver = {
> -	.probe		= geodewdt_probe,
>  	.remove		= geodewdt_remove,
>  	.shutdown	= geodewdt_shutdown,
>  	.driver		= {
> @@ -268,20 +267,18 @@ static int __init geodewdt_init(void)
>  {
>  	int ret;
>  
> -	ret = platform_driver_register(&geodewdt_driver);
> -	if (ret)
> -		return ret;
> -
>  	geodewdt_platform_device = platform_device_register_simple(DRV_NAME,
>  								-1, NULL, 0);
> -	if (IS_ERR(geodewdt_platform_device)) {
> -		ret = PTR_ERR(geodewdt_platform_device);
> +	if (IS_ERR(geodewdt_platform_device))
> +		return PTR_ERR(geodewdt_platform_device);
> +
> +	ret = platform_driver_probe(&geodewdt_driver, geodewdt_probe);
> +	if (ret)
>  		goto err;
> -	}
>  
>  	return 0;
>  err:
> -	platform_driver_unregister(&geodewdt_driver);
> +	platform_device_unregister(geodewdt_platform_device);
>  	return ret;
>  }
>  
> 
> 

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

