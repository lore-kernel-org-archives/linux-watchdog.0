Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40578 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247AbbHLKRG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Aug 2015 06:17:06 -0400
Message-ID: <55CB1D1A.9060201@roeck-us.net>
Date: Wed, 12 Aug 2015 03:16:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@iguana.be>
CC: kernel@pengutronix.de, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 3/7] watchdog: mpc8xxx: make use of of_device_get_match_data
References: <1439367358-5338-1-git-send-email-u.kleine-koenig@pengutronix.de> <1439367358-5338-4-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1439367358-5338-4-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/12/2015 01:15 AM, Uwe Kleine-König wrote:
> This function is new in v4.2-rc1 and makes a forward declaration of the
> match table superfluous which can so be removed.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/mpc8xxx_wdt.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index e0acda3282d9..fb1fe967cf57 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -139,7 +139,6 @@ static struct watchdog_device mpc8xxx_wdt_dev = {
>   	.ops = &mpc8xxx_wdt_ops,
>   };
>
> -static const struct of_device_id mpc8xxx_wdt_match[];
>   static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>   {
>   	int ret;
> @@ -150,10 +149,9 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>   	bool enabled;
>   	unsigned int timeout_sec;
>
> -	match = of_match_device(mpc8xxx_wdt_match, &ofdev->dev);
> -	if (!match)
> +	wdt_type = of_device_get_match_data(&ofdev->dev);
> +	if (!wdt_type)
>   		return -EINVAL;
> -	wdt_type = match->data;
>
>   	if (!freq || freq == -1)
>   		return -EINVAL;
>

