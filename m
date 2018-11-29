Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33045 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeK3KsE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 30 Nov 2018 05:48:04 -0500
Date: Thu, 29 Nov 2018 15:40:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Colin King <colin.king@canonical.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: asm9260_wdt: make array mode_name static,
 shrinks object size
Message-ID: <20181129234046.GA19718@roeck-us.net>
References: <20181129232500.5039-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129232500.5039-1-colin.king@canonical.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Nov 29, 2018 at 11:25:00PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the const array mode_name on the stack but instead
> make it static. Makes the object code smaller by 41 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    7699	   1872	      0	   9571	   2563	drivers/watchdog/asm9260_wdt.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>    7594	   1936	      0	   9530	   253a	drivers/watchdog/asm9260_wdt.o
> 
> (gcc version 8.2.0 x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/asm9260_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
> index 2cf56b459d84..9768e44ffeb8 100644
> --- a/drivers/watchdog/asm9260_wdt.c
> +++ b/drivers/watchdog/asm9260_wdt.c
> @@ -278,7 +278,7 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
>  	struct watchdog_device *wdd;
>  	struct resource *res;
>  	int ret;
> -	const char * const mode_name[] = { "hw", "sw", "debug", };
> +	static const char * const mode_name[] = { "hw", "sw", "debug", };
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(struct asm9260_wdt_priv),
>  			    GFP_KERNEL);
> -- 
> 2.19.1
> 
