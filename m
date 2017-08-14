Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60027 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdHNOxH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 10:53:07 -0400
Date: Mon, 14 Aug 2017 07:53:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: wim@iguana.be, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: max77620_wdt: constify platform_device_id
Message-ID: <20170814145305.GE14491@roeck-us.net>
References: <af372e3b17be9892810e4fc5ed5b1381a4ad2b97.1502623612.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af372e3b17be9892810e4fc5ed5b1381a4ad2b97.1502623612.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Aug 13, 2017 at 04:58:28PM +0530, Arvind Yadav wrote:
> platform_device_id are not supposed to change at runtime. All functions
> working with platform_device_id provided by <linux/platform_device.h>
> work with const platform_device_id. So mark the non-const structs as
> const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/max77620_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
> index 68c41fa..2c9f53e 100644
> --- a/drivers/watchdog/max77620_wdt.c
> +++ b/drivers/watchdog/max77620_wdt.c
> @@ -201,7 +201,7 @@ static int max77620_wdt_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct platform_device_id max77620_wdt_devtype[] = {
> +static const struct platform_device_id max77620_wdt_devtype[] = {
>  	{ .name = "max77620-watchdog", },
>  	{ },
>  };
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
