Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:52267 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdJVQJX (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 12:09:23 -0400
Date: Sun, 22 Oct 2017 09:09:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Jeffery <andrew@aj.id.au>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be, joel@jms.id.au,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: Re: [v2,1/4] watchdog: aspeed: Retain watchdog enabled state
Message-ID: <20171022160921.GA12755@roeck-us.net>
References: <20170920053020.6860-2-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920053020.6860-2-andrew@aj.id.au>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Sep 20, 2017 at 03:00:17PM +0930, Andrew Jeffery wrote:
> An unintended post-condition of probe() is that the watchdog is
> disabled. This behaviour was introduced by an unnecessary write to the
> control register to configure the hardware based on the devicetree. The
> write is unnecessary because the cached control value that is
> manipulated by the code parsing the devicetree is eventually written by
> aspeed_wdt_enable(), which is when we care how the control register
> should be configured.
> 
> Remove the write to restore expected behaviour.
> 
> Fixes: b7f0b8ad25f3 ("drivers/watchdog: ASPEED reference dev tree properties for config")
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/aspeed_wdt.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 79cc766cd30f..6c6dd3f4c48d 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -243,9 +243,13 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	if (of_property_read_bool(np, "aspeed,external-signal"))
>  		wdt->ctrl |= WDT_CTRL_WDT_EXT;
>  
> -	writel(wdt->ctrl, wdt->base + WDT_CTRL);
> -
>  	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
> +		/*
> +		 * The watchdog is running, but invoke aspeed_wdt_start() to
> +		 * write wdt->ctrl to WDT_CTRL to ensure the watchdog's
> +		 * configuration conforms to the driver's expectations.
> +		 * Primarily, ensure we're using the 1MHz clock source.
> +		 */
>  		aspeed_wdt_start(&wdt->wdd);
>  		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
>  	}
