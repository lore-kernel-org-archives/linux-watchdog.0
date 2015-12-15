Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42271 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbbLOQUS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 15 Dec 2015 11:20:18 -0500
Subject: Re: [PATCH 1/2] watchdog: omap: don't disable runtime pm before
 starting device
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1450175861-16801-1-git-send-email-u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-watchdog@vger.kernel.org,
	Lars Poeschel <poeschel@lemonage.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56703DBF.2010601@roeck-us.net>
Date: Tue, 15 Dec 2015 08:20:15 -0800
MIME-Version: 1.0
In-Reply-To: <1450175861-16801-1-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/15/2015 02:37 AM, Uwe Kleine-König wrote:
> omap_wdt_start calls pm_runtime_get_sync so dropping a reference just
> before calling omap_wdt_start doesn't make much sense. Moreover there is
> no point to use the synchronous variant of pm_runtime_put because the
> driver doesn't care if the clock is disabled before or after
> omap_wdt_probe returns.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/omap_wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 7abd6988d94a..af8947429c91 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -282,11 +282,11 @@ static int omap_wdt_probe(struct platform_device *pdev)
>   		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
>   		wdev->wdog.timeout);
>
> -	pm_runtime_put_sync(wdev->dev);
> -
>   	if (early_enable)
>   		omap_wdt_start(&wdev->wdog);
>
> +	pm_runtime_put(wdev->dev);
> +
>   	return 0;
>   }
>
>

