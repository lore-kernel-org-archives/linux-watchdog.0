Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42307 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbbLOQUm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 15 Dec 2015 11:20:42 -0500
Subject: Re: [PATCH 2/2] watchdog: omap: don't disable the timer when it
 should be enabled early
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1450175861-16801-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1450175861-16801-2-git-send-email-u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-watchdog@vger.kernel.org,
	Lars Poeschel <poeschel@lemonage.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56703DD8.1090103@roeck-us.net>
Date: Tue, 15 Dec 2015 08:20:40 -0800
MIME-Version: 1.0
In-Reply-To: <1450175861-16801-2-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/15/2015 02:37 AM, Uwe Kleine-König wrote:
> With the early_enable module parameter the watchdog can be started
> during driver probe time. If this is requested the bets are good that
> the timer is already running, so to narrow the gap where the timer is
> disabled only call the disable function when the timer shouldn't be
> started.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/omap_wdt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index af8947429c91..ae673cd06aa1 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -270,7 +270,8 @@ static int omap_wdt_probe(struct platform_device *pdev)
>   			wdev->wdog.bootstatus = WDIOF_CARDRESET;
>   	}
>
> -	omap_wdt_disable(wdev);
> +	if (!early_enable)
> +		omap_wdt_disable(wdev);
>
>   	ret = watchdog_register_device(&wdev->wdog);
>   	if (ret) {
>

