Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43018 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdFOR0B (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 15 Jun 2017 13:26:01 -0400
Date: Thu, 15 Jun 2017 10:25:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: bcm47xx_wdt: constify bcm47xx_wdt_hard_ops and
 bcm47xx_wdt_soft_ops
Message-ID: <20170615172559.GB7549@roeck-us.net>
References: <09f03198797fa7041adfab96811c059e50f44171.1497248301.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f03198797fa7041adfab96811c059e50f44171.1497248301.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jun 12, 2017 at 11:50:26AM +0530, Arvind Yadav wrote:
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    1282	    388	      1	   1671	    687	drivers/watchdog/bcm47xx_wdt.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    1474	    196	      1	   1671	    687	drivers/watchdog/bcm47xx_wdt.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/bcm47xx_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
> index 35725e2..2365828 100644
> --- a/drivers/watchdog/bcm47xx_wdt.c
> +++ b/drivers/watchdog/bcm47xx_wdt.c
> @@ -97,7 +97,7 @@ static int bcm47xx_wdt_restart(struct watchdog_device *wdd,
>  	return 0;
>  }
>  
> -static struct watchdog_ops bcm47xx_wdt_hard_ops = {
> +static const struct watchdog_ops bcm47xx_wdt_hard_ops = {
>  	.owner		= THIS_MODULE,
>  	.start		= bcm47xx_wdt_hard_start,
>  	.stop		= bcm47xx_wdt_hard_stop,
> @@ -168,7 +168,7 @@ static int bcm47xx_wdt_soft_set_timeout(struct watchdog_device *wdd,
>  				WDIOF_MAGICCLOSE,
>  };
>  
> -static struct watchdog_ops bcm47xx_wdt_soft_ops = {
> +static const struct watchdog_ops bcm47xx_wdt_soft_ops = {
>  	.owner		= THIS_MODULE,
>  	.start		= bcm47xx_wdt_soft_start,
>  	.stop		= bcm47xx_wdt_soft_stop,
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
