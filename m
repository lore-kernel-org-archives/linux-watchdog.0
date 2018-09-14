Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40990 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeINWj7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Sep 2018 18:39:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id h79-v6so4604488pfk.8
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Sep 2018 10:24:32 -0700 (PDT)
Date: Fri, 14 Sep 2018 10:24:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        john@phrozen.org, dev@kresin.me
Subject: Re: [PATCH v3 3/3] wdt: lantiq: add get_timeleft callback
Message-ID: <20180914172431.GD26861@roeck-us.net>
References: <20180913213211.16781-1-hauke@hauke-m.de>
 <20180913213211.16781-4-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913213211.16781-4-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Sep 13, 2018 at 11:32:11PM +0200, Hauke Mehrtens wrote:
> This callback will provide the current time left.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/lantiq_wdt.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> index c2f14d2bd695..83da84d6074b 100644
> --- a/drivers/watchdog/lantiq_wdt.c
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -50,6 +50,7 @@
>  #define  LTQ_WDT_CR_MAX_TIMEOUT	((1 << 16) - 1)	/* The reload field is 16 bit */
>  #define LTQ_WDT_SR		0x8		/* watchdog status register */
>  #define  LTQ_WDT_SR_EN		BIT(31)		/* Enable */
> +#define  LTQ_WDT_SR_VALUE_MASK	GENMASK(15, 0)	/* Timer value */
>  
>  #define LTQ_WDT_DIVIDER		0x40000
>  
> @@ -139,11 +140,21 @@ static int ltq_wdt_ping(struct watchdog_device *wdt)
>  	return 0;
>  }
>  
> +static unsigned int ltq_wdt_get_timeleft(struct watchdog_device *wdt)
> +{
> +	struct ltq_wdt_priv *priv = ltq_wdt_get_priv(wdt);
> +	u64 timeout;
> +
> +	timeout = ltq_wdt_r32(priv, LTQ_WDT_SR) & LTQ_WDT_SR_VALUE_MASK;
> +	return do_div(timeout, priv->clk_rate);
> +}
> +
>  static const struct watchdog_ops ltq_wdt_ops = {
>  	.owner		= THIS_MODULE,
>  	.start		= ltq_wdt_start,
>  	.stop		= ltq_wdt_stop,
>  	.ping		= ltq_wdt_ping,
> +	.get_timeleft	= ltq_wdt_get_timeleft,
>  };
>  
>  static int ltq_wdt_xrx_bootstatus_get(struct device *dev)
> -- 
> 2.11.0
> 
