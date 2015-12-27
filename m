Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43669 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751914AbbL0UQj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 27 Dec 2015 15:16:39 -0500
Date: Sun, 27 Dec 2015 21:16:34 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-watchdog@vger.kernel.org,
	Lars Poeschel <poeschel@lemonage.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] watchdog: omap: don't disable runtime pm before starting device
Message-ID: <20151227201634.GA25197@spo001.leaseweb.nl>
References: <1450175861-16801-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1450175861-16801-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

> omap_wdt_start calls pm_runtime_get_sync so dropping a reference just
> before calling omap_wdt_start doesn't make much sense. Moreover there=
 is
> no point to use the synchronous variant of pm_runtime_put because the
> driver doesn't care if the clock is disabled before or after
> omap_wdt_probe returns.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/watchdog/omap_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.=
c
> index 7abd6988d94a..af8947429c91 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -282,11 +282,11 @@ static int omap_wdt_probe(struct platform_devic=
e *pdev)
>  		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
>  		wdev->wdog.timeout);
> =20
> -	pm_runtime_put_sync(wdev->dev);
> -
>  	if (early_enable)
>  		omap_wdt_start(&wdev->wdog);
> =20
> +	pm_runtime_put(wdev->dev);
> +
>  	return 0;
>  }
> =20

Patch added to linux-watchdog-next.

Kind regards,
Wim.

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
