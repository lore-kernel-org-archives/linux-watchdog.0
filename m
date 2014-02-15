Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60735 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbaBORwH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Feb 2014 12:52:07 -0500
Received: by mail-pa0-f46.google.com with SMTP id rd3so13679769pab.33
        for <linux-watchdog@vger.kernel.org>; Sat, 15 Feb 2014 09:52:07 -0800 (PST)
Date: Sat, 15 Feb 2014 09:52:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: shwdt: Remove unused variable
Message-ID: <20140215175204.GF19001@roeck-us.net>
References: <1392456187-30082-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392456187-30082-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Feb 15, 2014 at 01:23:07PM +0400, Alexander Shiyan wrote:
> Variable "wdt" is not used anywhere in the function sh_wdt_remove().
> This patch removes this variable.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Though you might as well remove the matching platform_set_drvdata()
which is also unnecessary.

> ---
>  drivers/watchdog/shwdt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
> index af3528f..d04d02b 100644
> --- a/drivers/watchdog/shwdt.c
> +++ b/drivers/watchdog/shwdt.c
> @@ -293,8 +293,6 @@ static int sh_wdt_probe(struct platform_device *pdev)
>  
>  static int sh_wdt_remove(struct platform_device *pdev)
>  {
> -	struct sh_wdt *wdt = platform_get_drvdata(pdev);
> -
>  	watchdog_unregister_device(&sh_wdt_dev);
>  
>  	pm_runtime_disable(&pdev->dev);
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
