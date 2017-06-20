Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34090 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbdFTUxx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Jun 2017 16:53:53 -0400
Date: Tue, 20 Jun 2017 13:53:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: cadence_wdt: make of_device_ids const.
Message-ID: <20170620205351.GB28761@roeck-us.net>
References: <368e831c5ca264a6314361ca5b8a31cac00ea8ea.1497935866.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <368e831c5ca264a6314361ca5b8a31cac00ea8ea.1497935866.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 20, 2017 at 11:04:26AM +0530, Arvind Yadav wrote:
> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    1962	    612	      4	   2578	    a12	drivers/watchdog/cadence_wdt.o
> 
> File size after constify cdns_wdt_of_match:
>    text	   data	    bss	    dec	    hex	filename
>    2378	    196	      4	   2578	    a12	drivers/watchdog/cadence_wdt.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/cadence_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
> index 8d61e8b..4824b0a 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -458,7 +458,7 @@ static int __maybe_unused cdns_wdt_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(cdns_wdt_pm_ops, cdns_wdt_suspend, cdns_wdt_resume);
>  
> -static struct of_device_id cdns_wdt_of_match[] = {
> +static const struct of_device_id cdns_wdt_of_match[] = {
>  	{ .compatible = "cdns,wdt-r1p2", },
>  	{ /* end of table */ }
>  };
> -- 
> 1.9.1
> 
