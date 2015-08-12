Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41692 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbbHLKVq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Aug 2015 06:21:46 -0400
Message-ID: <55CB1E34.8050203@roeck-us.net>
Date: Wed, 12 Aug 2015 03:21:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@iguana.be>
CC: kernel@pengutronix.de, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 6/7] watchdog: mpc8xxx: use better error code when
 watchdog cannot be enabled
References: <1439367358-5338-1-git-send-email-u.kleine-koenig@pengutronix.de> <1439367358-5338-7-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1439367358-5338-7-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/12/2015 01:15 AM, Uwe Kleine-König wrote:
> checkpatch warns about ENOSYS, telling "ENOSYS means 'invalid syscall
> nr' and nothing else". So use ENODEV instead.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/mpc8xxx_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index 0b69797d3417..5f2273aac37d 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -170,7 +170,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>   	enabled = in_be32(&ddata->base->swcrr) & SWCRR_SWEN;
>   	if (!enabled && wdt_type->hw_enabled) {
>   		pr_info("could not be enabled in software\n");
> -		return -ENOSYS;
> +		return -ENODEV;
>   	}
>
>   	spin_lock_init(&ddata->lock);
>

