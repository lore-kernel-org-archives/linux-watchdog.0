Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33389 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeIMCYp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 12 Sep 2018 22:24:45 -0400
Date: Wed, 12 Sep 2018 14:18:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jagdish Tirumala <t.jag587@gmail.com>
Cc: wim@linux-watchdog.org, yamada.masahiro@socionext.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: diag288_wdt: pointer location foo * bar should
 be foo *bar
Message-ID: <20180912211822.GA12970@roeck-us.net>
References: <20180912172907.1802-1-t.jag587@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912172907.1802-1-t.jag587@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Sep 12, 2018 at 10:29:07AM -0700, Jagdish Tirumala wrote:
> Fix the following checkpatch error:
> 
> ERROR: pointer location foo * bar should be foo *bar
> FILE: drivers/watchdog/diag288_wdt.c:202
> 
> Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/diag288_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
> index 806a04a676b7..046333d1beb2 100644
> --- a/drivers/watchdog/diag288_wdt.c
> +++ b/drivers/watchdog/diag288_wdt.c
> @@ -199,7 +199,7 @@ static int wdt_ping(struct watchdog_device *dev)
>  	return ret;
>  }
>  
> -static int wdt_set_timeout(struct watchdog_device * dev, unsigned int new_to)
> +static int wdt_set_timeout(struct watchdog_device *dev, unsigned int new_to)
>  {
>  	dev->timeout = new_to;
>  	return wdt_ping(dev);
> -- 
> 2.17.1
> 
