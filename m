Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44405 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeLDPUj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Dec 2018 10:20:39 -0500
Subject: Re: [RFC] watchdog: renesas_wdt: don't keep timer value during
 suspend/resume
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
References: <20181204120146.1923-1-wsa+renesas@sang-engineering.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <476b6d6c-657d-7e10-d0a8-a7aafe61eae9@roeck-us.net>
Date: Tue, 4 Dec 2018 07:20:34 -0800
MIME-Version: 1.0
In-Reply-To: <20181204120146.1923-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/4/18 4:01 AM, Wolfram Sang wrote:
> After discussing this mail thread [1] again, we concluded that giving
> userspace enough time to prepare is our favourite option. So, do not
> keep the time value when suspended but reset it when resuming.
> 
> [1] https://patchwork.kernel.org/patch/10252209/
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Above exchange says it all, no need to repeat.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Fabrizio: can you agree to that? The R-Car BSP team and we (the R-Car upstream
> team) would prefer it this way (knowing it is also not perfect).
> 
>   drivers/watchdog/renesas_wdt.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index b570962e84f3..9f2307bf727b 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -48,7 +48,6 @@ struct rwdt_priv {
>   	void __iomem *base;
>   	struct watchdog_device wdev;
>   	unsigned long clk_rate;
> -	u16 time_left;
>   	u8 cks;
>   };
>   
> @@ -263,10 +262,9 @@ static int __maybe_unused rwdt_suspend(struct device *dev)
>   {
>   	struct rwdt_priv *priv = dev_get_drvdata(dev);
>   
> -	if (watchdog_active(&priv->wdev)) {
> -		priv->time_left = readw(priv->base + RWTCNT);
> +	if (watchdog_active(&priv->wdev))
>   		rwdt_stop(&priv->wdev);
> -	}
> +
>   	return 0;
>   }
>   
> @@ -274,10 +272,9 @@ static int __maybe_unused rwdt_resume(struct device *dev)
>   {
>   	struct rwdt_priv *priv = dev_get_drvdata(dev);
>   
> -	if (watchdog_active(&priv->wdev)) {
> +	if (watchdog_active(&priv->wdev))
>   		rwdt_start(&priv->wdev);
> -		rwdt_write(priv, priv->time_left, RWTCNT);
> -	}
> +
>   	return 0;
>   }
>   
> 
