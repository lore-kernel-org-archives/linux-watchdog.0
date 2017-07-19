Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60107 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752811AbdGSNci (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Jul 2017 09:32:38 -0400
Subject: Re: [PATCH] watchdog: asm9260_wdt: don't round closest with
 get_timeleft
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>
References: <20170717171224.13444-1-wsa+renesas@sang-engineering.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <bfad12d7-6bf2-e30e-f415-dae9759e8d41@roeck-us.net>
Date: Wed, 19 Jul 2017 06:32:34 -0700
MIME-Version: 1.0
In-Reply-To: <20170717171224.13444-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/17/2017 10:12 AM, Wolfram Sang wrote:
> We should never return more time left than there actually is. So, switch
> to a plain divider instead of DIV_ROUND_CLOSEST.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> This is similar to a patch for the renesas-rwdt[1]. I think it makes sense to
> remove this pattern from the whole subsystem, if we can agree on the behaviour
> stated in the patch description. So, this is the other driver using
> DIV_ROUND_CLOSEST.
> 
> Note: This driver and the lpc18xx_wdt.c extremly likely drive the same IP core.
> They would ideally be merged.
> 
> [1] https://patchwork.kernel.org/patch/9845459/
> 
>   drivers/watchdog/asm9260_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
> index 53da001f0838ee..f40dd71c904bef 100644
> --- a/drivers/watchdog/asm9260_wdt.c
> +++ b/drivers/watchdog/asm9260_wdt.c
> @@ -82,7 +82,7 @@ static unsigned int asm9260_wdt_gettimeleft(struct watchdog_device *wdd)
>   
>   	counter = ioread32(priv->iobase + HW_WDTV);
>   
> -	return DIV_ROUND_CLOSEST(counter, priv->wdt_freq);
> +	return counter / priv->wdt_freq;
>   }
>   
>   static int asm9260_wdt_updatetimeout(struct watchdog_device *wdd)
> 

