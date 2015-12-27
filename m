Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43673 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751914AbbL0UQ4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 27 Dec 2015 15:16:56 -0500
Date: Sun, 27 Dec 2015 21:16:55 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-watchdog@vger.kernel.org,
	Lars Poeschel <poeschel@lemonage.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] watchdog: omap: don't disable the timer when it should be enabled early
Message-ID: <20151227201655.GB25197@spo001.leaseweb.nl>
References: <1450175861-16801-1-git-send-email-u.kleine-koenig@pengutronix.de> <1450175861-16801-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1450175861-16801-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

> With the early_enable module parameter the watchdog can be started
> during driver probe time. If this is requested the bets are good that
> the timer is already running, so to narrow the gap where the timer is
> disabled only call the disable function when the timer shouldn't be
> started.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/watchdog/omap_wdt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.=
c
> index af8947429c91..ae673cd06aa1 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -270,7 +270,8 @@ static int omap_wdt_probe(struct platform_device =
*pdev)
>  			wdev->wdog.bootstatus =3D WDIOF_CARDRESET;
>  	}
> =20
> -	omap_wdt_disable(wdev);
> +	if (!early_enable)
> +		omap_wdt_disable(wdev);
> =20
>  	ret =3D watchdog_register_device(&wdev->wdog);
>  	if (ret) {
> --=20
> 2.6.2
>=20

Patch added to linux-watchdog-next.

Kind regards,
Wim.

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
