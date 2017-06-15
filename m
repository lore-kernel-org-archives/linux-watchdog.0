Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40580 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdFOR0b (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 15 Jun 2017 13:26:31 -0400
Date: Thu, 15 Jun 2017 10:26:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: wim@iguana.be, baoyou.xie@linaro.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: zx2967: constify zx2967_wdt_ops.
Message-ID: <20170615172630.GC7549@roeck-us.net>
References: <42bf28fa31b27477cc97cfca4b0a8bcdc83309f4.1497249031.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42bf28fa31b27477cc97cfca4b0a8bcdc83309f4.1497249031.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jun 12, 2017 at 12:02:39PM +0530, Arvind Yadav wrote:
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>     988	    288	      0	   1276	    4fc	drivers/watchdog/zx2967_wdt.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    1084	    192	      0	   1276	    4fc	drivers/watchdog/zx2967_wdt.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/zx2967_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/zx2967_wdt.c b/drivers/watchdog/zx2967_wdt.c
> index e290d5a..17774de 100644
> --- a/drivers/watchdog/zx2967_wdt.c
> +++ b/drivers/watchdog/zx2967_wdt.c
> @@ -154,7 +154,7 @@ static int zx2967_wdt_keepalive(struct watchdog_device *wdd)
>  	.identity         =	"zx2967 watchdog",
>  };
>  
> -static struct watchdog_ops zx2967_wdt_ops = {
> +static const struct watchdog_ops zx2967_wdt_ops = {
>  	.owner = THIS_MODULE,
>  	.start = zx2967_wdt_start,
>  	.stop = zx2967_wdt_stop,
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
