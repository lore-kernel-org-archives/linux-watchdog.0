Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49444 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbdHNPJW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 11:09:22 -0400
Date: Mon, 14 Aug 2017 08:09:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 03/11] watchdog: ftwdt010: Make interrupt optional
Message-ID: <20170814150920.GI14491@roeck-us.net>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-4-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170812184318.10144-4-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Aug 12, 2017 at 08:43:10PM +0200, Linus Walleij wrote:
> The Moxart does not appear to be using the interrupt from the
> watchdog timer, maybe it's not even routed, so as to support
> more architectures with this driver, make the interrupt
> optional.
> 
> While we are at it: actually enable the use of the interrupt
> if present by setting the right bit in the control register
> and define the missing control register bits.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/watchdog/ftwdt010_wdt.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
> index 637ffd812f0b..ab38a3a89300 100644
> --- a/drivers/watchdog/ftwdt010_wdt.c
> +++ b/drivers/watchdog/ftwdt010_wdt.c
> @@ -30,6 +30,8 @@
>  #define WDRESTART_MAGIC		0x5AB9
>  
>  #define WDCR_CLOCK_5MHZ		BIT(4)
> +#define WDCR_WDEXT		BIT(3)
> +#define WDCR_WDINTR		BIT(2)
>  #define WDCR_SYS_RST		BIT(1)
>  #define WDCR_ENABLE		BIT(0)
>  
> @@ -39,6 +41,7 @@ struct ftwdt010_wdt {
>  	struct watchdog_device	wdd;
>  	struct device		*dev;
>  	void __iomem		*base;
> +	bool			has_irq;
>  };
>  
>  static inline
> @@ -50,14 +53,18 @@ struct ftwdt010_wdt *to_ftwdt010_wdt(struct watchdog_device *wdd)
>  static int ftwdt010_wdt_start(struct watchdog_device *wdd)
>  {
>  	struct ftwdt010_wdt *gwdt = to_ftwdt010_wdt(wdd);
> +	u32 enable;
>  
>  	writel(wdd->timeout * WDT_CLOCK, gwdt->base + FTWDT010_WDLOAD);
>  	writel(WDRESTART_MAGIC, gwdt->base + FTWDT010_WDRESTART);
>  	/* set clock before enabling */
> -	writel(WDCR_CLOCK_5MHZ | WDCR_SYS_RST,
> -			gwdt->base + FTWDT010_WDCR);
> -	writel(WDCR_CLOCK_5MHZ | WDCR_SYS_RST | WDCR_ENABLE,
> -			gwdt->base + FTWDT010_WDCR);
> +	enable = WDCR_CLOCK_5MHZ | WDCR_SYS_RST;
> +	writel(enable, gwdt->base + FTWDT010_WDCR);
> +	enable |= WDCR_CLOCK_5MHZ;

This seems wrong/unnecessary. This bit is already set.

> +	if (gwdt->has_irq)
> +		enable |= WDCR_WDINTR;
> +	enable |= WDCR_ENABLE;
> +	writel(enable, gwdt->base + FTWDT010_WDCR);
>  
>  	return 0;
>  }
> @@ -133,10 +140,6 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(gwdt->base))
>  		return PTR_ERR(gwdt->base);
>  
> -	irq = platform_get_irq(pdev, 0);
> -	if (!irq)
> -		return -EINVAL;
> -
>  	gwdt->dev = dev;
>  	gwdt->wdd.info = &ftwdt010_wdt_info;
>  	gwdt->wdd.ops = &ftwdt010_wdt_ops;
> @@ -158,10 +161,14 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
>  		writel(reg, gwdt->base + FTWDT010_WDCR);
>  	}
>  
> -	ret = devm_request_irq(dev, irq, ftwdt010_wdt_interrupt, 0,
> -			       "watchdog bark", gwdt);
> -	if (ret)
> -		return ret;
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq) {
> +		ret = devm_request_irq(dev, irq, ftwdt010_wdt_interrupt, 0,
> +				       "watchdog bark", gwdt);
> +		if (ret)
> +			return ret;
> +		gwdt->has_irq = true;
> +	}
>  
>  	ret = devm_watchdog_register_device(dev, &gwdt->wdd);
>  	if (ret) {
> -- 
> 2.13.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
