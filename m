Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:39439 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbaBORxi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Feb 2014 12:53:38 -0500
Received: by mail-pd0-f180.google.com with SMTP id x10so13161821pdj.25
        for <linux-watchdog@vger.kernel.org>; Sat, 15 Feb 2014 09:53:38 -0800 (PST)
Date: Sat, 15 Feb 2014 09:53:34 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: wdt285: Fix variable type
Message-ID: <20140215175334.GG19001@roeck-us.net>
References: <1392456205-30121-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392456205-30121-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Feb 15, 2014 at 01:23:25PM +0400, Alexander Shiyan wrote:
> Variable "new_margin" is checked in the function watchdog_ioctl()
> to be positive, so change its type to "int".

non-negative, really.

Other than that,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/watchdog/wdt285.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/wdt285.c b/drivers/watchdog/wdt285.c
> index 7355ddd0..ebbb183 100644
> --- a/drivers/watchdog/wdt285.c
> +++ b/drivers/watchdog/wdt285.c
> @@ -139,9 +139,8 @@ static const struct watchdog_info ident = {
>  static long watchdog_ioctl(struct file *file, unsigned int cmd,
>  			   unsigned long arg)
>  {
> -	unsigned int new_margin;
>  	int __user *int_arg = (int __user *)arg;
> -	int ret = -ENOTTY;
> +	int new_margin, ret = -ENOTTY;
>  
>  	switch (cmd) {
>  	case WDIOC_GETSUPPORT:
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
