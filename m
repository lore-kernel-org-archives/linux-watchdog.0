Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43798 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751181AbcGQUS7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:18:59 -0400
Date: Sun, 17 Jul 2016 22:18:54 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Stefan Christ <s.christ@phytec.de>
Cc: linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: da9063_wdt: don't trigger watchdog too fast
Message-ID: <20160717201854.GA900@spo001.leaseweb.nl>
References: <1467794411-11155-1-git-send-email-s.christ@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467794411-11155-1-git-send-email-s.christ@phytec.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Stefan,

> Triggering the watchdog faster than T_WDMIN=256ms leads to resets of the
> DA9063 chip. The datasheet says that the watchdog must only be triggered
> in the timeframe T_WDMIN to T_WDMAX. The T_WDMAX is configured in the
> driver.
> 
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> ---
> v2: use internal kernel API 'min_hw_heartbeat_ms' instead of driver specific
>     implementation.
> 
> Hi,
> 
> this is a follow up patch to the patch
> 
>     [RFC 1/6] watchdog: da9063_wdt: don't trigger watchdog too fast
> 
> in my RFC patch series. Using the internal kernel watchdog API also makes my
> second patch
> 
>     [RFC 2/6] watchdog: da9063_wdt: use delayed work to trigger
> 
> obsolete, because the kernel API uses a delayed worker already.
> 
> Kind regards,
>     Stefan Christ
> ---
>  drivers/watchdog/da9063_wdt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> index a100f64..5d6b4e5 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -34,6 +34,7 @@ static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
>  #define DA9063_WDT_MIN_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MIN]
>  #define DA9063_WDT_MAX_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MAX]
>  #define DA9063_WDG_TIMEOUT		wdt_timeout[3]
> +#define DA9063_RESET_PROTECTION_MS	256
>  
>  struct da9063_watchdog {
>  	struct da9063 *da9063;
> @@ -171,6 +172,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
>  	wdt->wdtdev.ops = &da9063_watchdog_ops;
>  	wdt->wdtdev.min_timeout = DA9063_WDT_MIN_TIMEOUT;
>  	wdt->wdtdev.max_timeout = DA9063_WDT_MAX_TIMEOUT;
> +	wdt->wdtdev.min_hw_heartbeat_ms = DA9063_RESET_PROTECTION_MS;
>  	wdt->wdtdev.timeout = DA9063_WDG_TIMEOUT;
>  	wdt->wdtdev.parent = &pdev->dev;
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

