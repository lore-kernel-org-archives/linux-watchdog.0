Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35233 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbdIRNZE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 18 Sep 2017 09:25:04 -0400
Subject: Re: [PATCH 1/4] watchdog: aspeed: Retain watchdog enabled state
To: Andrew Jeffery <andrew@aj.id.au>, linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, joel@jms.id.au, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
        ryan_chen@aspeedtech.com
References: <20170918054905.16470-1-andrew@aj.id.au>
 <20170918054905.16470-2-andrew@aj.id.au>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <bef08c5f-b0ae-a2e4-34a1-c9e1500b4234@roeck-us.net>
Date: Mon, 18 Sep 2017 06:25:02 -0700
MIME-Version: 1.0
In-Reply-To: <20170918054905.16470-2-andrew@aj.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/17/2017 10:49 PM, Andrew Jeffery wrote:
> An unintended post-condition of probe() is that the watchdog is
> disabled. Rework probe() such that we retain the value of the "enabled"
> bit from the control register, and take the appropriate actions with
> respect to the watchdog core if so. Otherwise, just configure the
> watchdog as directed.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>   drivers/watchdog/aspeed_wdt.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 79cc766cd30f..99bc6fbd8852 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -221,7 +221,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	config = ofdid->data;
>   
> -	wdt->ctrl = WDT_CTRL_1MHZ_CLK;
> +	wdt->ctrl |= readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE;
> +	wdt->ctrl |= WDT_CTRL_1MHZ_CLK;
>   
>   	/*
>   	 * Control reset on a per-device basis to ensure the
> @@ -243,11 +244,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	if (of_property_read_bool(np, "aspeed,external-signal"))
>   		wdt->ctrl |= WDT_CTRL_WDT_EXT;
>   
> -	writel(wdt->ctrl, wdt->base + WDT_CTRL);
> -
> -	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
> +	if (wdt->ctrl & WDT_CTRL_ENABLE) {
>   		aspeed_wdt_start(&wdt->wdd);

Why call the start function in this case ?

>   		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status); > +	} else {
> +		writel(wdt->ctrl, wdt->base + WDT_CTRL);
>   	}
>   
>   	if (of_device_is_compatible(np, "aspeed,ast2500-wdt")) {
> 

