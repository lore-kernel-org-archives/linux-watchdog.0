Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35170 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbdLZR2d (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 26 Dec 2017 12:28:33 -0500
Date: Tue, 26 Dec 2017 09:28:31 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        ysxie@foxmail.com, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: Re: [v3,21/27] watchdog: replace devm_ioremap_nocache with
 devm_ioremap
Message-ID: <20171226172831.GA23118@roeck-us.net>
References: <1514026897-33581-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514026897-33581-1-git-send-email-xieyisheng1@huawei.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Dec 23, 2017 at 07:01:37PM +0800, Yisheng Xie wrote:
> Default ioremap is ioremap_nocache, so devm_ioremap has the same
> function with devm_ioremap_nocache, which can just be killed to
> save the size of devres.o
> 
> This patch is to use use devm_ioremap instead of devm_ioremap_nocache,
> which should not have any function change but prepare for killing
> devm_ioremap_nocache.
> 
I don't have issues with the patch itself - on mips, the definitions
_are_ the same - but with the description. It is not universally correct
that the definitions are the same. Please update and resubmit.

Guenter

> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/watchdog/bcm63xx_wdt.c | 4 ++--
>  drivers/watchdog/rc32434_wdt.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
> index 8555afc..697a7e7 100644
> --- a/drivers/watchdog/bcm63xx_wdt.c
> +++ b/drivers/watchdog/bcm63xx_wdt.c
> @@ -248,8 +248,8 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	bcm63xx_wdt_device.regs = devm_ioremap_nocache(&pdev->dev, r->start,
> -							resource_size(r));
> +	bcm63xx_wdt_device.regs = devm_ioremap(&pdev->dev, r->start,
> +						resource_size(r));
>  	if (!bcm63xx_wdt_device.regs) {
>  		dev_err(&pdev->dev, "failed to remap I/O resources\n");
>  		return -ENXIO;
> diff --git a/drivers/watchdog/rc32434_wdt.c b/drivers/watchdog/rc32434_wdt.c
> index 3a75f3b..7d519c5 100644
> --- a/drivers/watchdog/rc32434_wdt.c
> +++ b/drivers/watchdog/rc32434_wdt.c
> @@ -31,7 +31,7 @@
>  #include <linux/platform_device.h>	/* For platform_driver framework */
>  #include <linux/spinlock.h>		/* For spin_lock/spin_unlock/... */
>  #include <linux/uaccess.h>		/* For copy_to_user/put_user/... */
> -#include <linux/io.h>			/* For devm_ioremap_nocache */
> +#include <linux/io.h>			/* For devm_ioremap */
>  
>  #include <asm/mach-rc32434/integ.h>	/* For the Watchdog registers */
>  
> @@ -271,7 +271,7 @@ static int rc32434_wdt_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	wdt_reg = devm_ioremap_nocache(&pdev->dev, r->start, resource_size(r));
> +	wdt_reg = devm_ioremap(&pdev->dev, r->start, resource_size(r));
>  	if (!wdt_reg) {
>  		pr_err("failed to remap I/O resources\n");
>  		return -ENXIO;
