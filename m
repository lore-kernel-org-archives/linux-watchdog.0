Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35496 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933141AbeAKSZ4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 11 Jan 2018 13:25:56 -0500
Date: Thu, 11 Jan 2018 10:25:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
Cc: linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: Re: [PATCH 2/2] watchdog: mt7621: switch to using managed
 devm_watchdog_register_device()
Message-ID: <20180111182554.GB10058@roeck-us.net>
References: <20180110121323.17657-1-git@andred.net>
 <20180110121323.17657-2-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180110121323.17657-2-git@andred.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 10, 2018 at 12:13:23PM +0000, André Draszik wrote:
> This does the necessary cleanup on driver unload automatically.
> 
> Signed-off-by: André Draszik <git@andred.net>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> Cc: John Crispin <john@phrozen.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mt7621_wdt.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> index 0eabea2d88a2..a04f49309188 100644
> --- a/drivers/watchdog/mt7621_wdt.c
> +++ b/drivers/watchdog/mt7621_wdt.c
> @@ -133,7 +133,6 @@ static struct watchdog_device mt7621_wdt_dev = {
>  static int mt7621_wdt_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> -	int ret;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	mt7621_wdt_base = devm_ioremap_resource(&pdev->dev, res);
> @@ -161,16 +160,7 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
>  		set_bit(WDOG_HW_RUNNING, &mt7621_wdt_dev.status);
>  	}
>  
> -	ret = watchdog_register_device(&mt7621_wdt_dev);
> -
> -	return 0;
> -}
> -
> -static int mt7621_wdt_remove(struct platform_device *pdev)
> -{
> -	watchdog_unregister_device(&mt7621_wdt_dev);
> -
> -	return 0;
> +	return devm_watchdog_register_device(&pdev->dev, &mt7621_wdt_dev);
>  }
>  
>  static void mt7621_wdt_shutdown(struct platform_device *pdev)
> @@ -186,7 +176,6 @@ MODULE_DEVICE_TABLE(of, mt7621_wdt_match);
>  
>  static struct platform_driver mt7621_wdt_driver = {
>  	.probe		= mt7621_wdt_probe,
> -	.remove		= mt7621_wdt_remove,
>  	.shutdown	= mt7621_wdt_shutdown,
>  	.driver		= {
>  		.name		= KBUILD_MODNAME,
> -- 
> 2.15.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
