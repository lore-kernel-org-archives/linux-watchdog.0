Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45985 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753598AbcJNQz7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Oct 2016 12:55:59 -0400
Date: Fri, 14 Oct 2016 09:55:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 1/2] watchdog: bcm7038_wdt: fix module autoload
Message-ID: <20161014165548.GA21425@roeck-us.net>
References: <1476458631-29685-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1476458631-29685-1-git-send-email-javier@osg.samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 14, 2016 at 12:23:50PM -0300, Javier Martinez Canillas wrote:
> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
> 
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> 
> Before this patch:
> 
> $ modinfo drivers/watchdog/bcm7038_wdt.ko | grep alias
> $
> 
> After this patch:
> 
> $ modinfo drivers/watchdog/bcm7038_wdt.ko | grep alias
> alias:          of:N*T*Cbrcm,bcm7038-wdtC*
> alias:          of:N*T*Cbrcm,bcm7038-wdt
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  drivers/watchdog/bcm7038_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
> index e238df4d75a2..4814c00b32f6 100644
> --- a/drivers/watchdog/bcm7038_wdt.c
> +++ b/drivers/watchdog/bcm7038_wdt.c
> @@ -216,6 +216,7 @@ static const struct of_device_id bcm7038_wdt_match[] = {
>  	{ .compatible = "brcm,bcm7038-wdt" },
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, bcm7038_wdt_match);
>  
>  static struct platform_driver bcm7038_wdt_driver = {
>  	.probe		= bcm7038_wdt_probe,
> -- 
> 2.7.4
> 
