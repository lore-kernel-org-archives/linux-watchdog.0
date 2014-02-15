Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:55971 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbaBORnM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Feb 2014 12:43:12 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so13590436pab.4
        for <linux-watchdog@vger.kernel.org>; Sat, 15 Feb 2014 09:43:12 -0800 (PST)
Date: Sat, 15 Feb 2014 09:43:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: bcm63xx_wdt: Remove unused field from
 bcm63xx_wdt_device
Message-ID: <20140215174309.GB19001@roeck-us.net>
References: <1392456063-29918-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392456063-29918-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Feb 15, 2014 at 01:21:03PM +0400, Alexander Shiyan wrote:
> Field "default_ticks" is not used anywhere in the driver code.
> This patch removes this field.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/bcm63xx_wdt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
> index 4eb188b..d055e3c 100644
> --- a/drivers/watchdog/bcm63xx_wdt.c
> +++ b/drivers/watchdog/bcm63xx_wdt.c
> @@ -45,7 +45,6 @@
>  static struct {
>  	void __iomem *regs;
>  	struct timer_list timer;
> -	int default_ticks;
>  	unsigned long inuse;
>  	atomic_t ticks;
>  } bcm63xx_wdt_device;
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
