Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46364 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753598AbcJNQ4M (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Oct 2016 12:56:12 -0400
Date: Fri, 14 Oct 2016 09:56:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 2/2] watchdog: max77620_wdt: fix module autoload
Message-ID: <20161014165610.GB21425@roeck-us.net>
References: <1476458631-29685-1-git-send-email-javier@osg.samsung.com>
 <1476458631-29685-2-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1476458631-29685-2-git-send-email-javier@osg.samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 14, 2016 at 12:23:51PM -0300, Javier Martinez Canillas wrote:
> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
> 
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> 
> Before this patch:
> 
> $ $ modinfo drivers/watchdog/max77620_wdt.ko | grep alias
> $
> 
> After this patch:
> 
> modinfo drivers/watchdog/max77620_wdt.ko | grep alias
> alias:          platform:max77620-watchdog
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  drivers/watchdog/max77620_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
> index 48b84df2afda..68c41fa2be27 100644
> --- a/drivers/watchdog/max77620_wdt.c
> +++ b/drivers/watchdog/max77620_wdt.c
> @@ -205,6 +205,7 @@ static struct platform_device_id max77620_wdt_devtype[] = {
>  	{ .name = "max77620-watchdog", },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(platform, max77620_wdt_devtype);
>  
>  static struct platform_driver max77620_wdt_driver = {
>  	.driver	= {
> -- 
> 2.7.4
> 
