Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42347 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbbHGO44 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Aug 2015 10:56:56 -0400
Message-ID: <55C4C733.7000802@roeck-us.net>
Date: Fri, 07 Aug 2015 07:56:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@iguana.be>
CC: kernel@pengutronix.de, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1 3/5] watchdog: mpc8xxx: make use of of_device_get_match_data
References: <1438942067-1654-1-git-send-email-u.kleine-koenig@pengutronix.de> <1438942067-1654-4-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1438942067-1654-4-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 08/07/2015 03:07 AM, Uwe Kleine-König wrote:
> This function is new in v4.2-rc1 and makes a forward declaration of the
> match table superfluous which can so be removed.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/watchdog/mpc8xxx_wdt.c | 25 +++++++++----------------
>   1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index e0acda3282d9..a6790fcfa69b 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -139,34 +139,31 @@ static struct watchdog_device mpc8xxx_wdt_dev = {
>   	.ops = &mpc8xxx_wdt_ops,
>   };
>
> -static const struct of_device_id mpc8xxx_wdt_match[];
>   static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>   {
>   	int ret;
> -	const struct of_device_id *match;
> -	struct device_node *np = ofdev->dev.of_node;
> +	struct resource *res;
>   	const struct mpc8xxx_wdt_type *wdt_type;
>   	u32 freq = fsl_get_sys_freq();
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
> -	wd_base = of_iomap(np, 0);
> -	if (!wd_base)
> -		return -ENOMEM;
> +	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
> +	wd_base = devm_ioremap_resource(&ofdev->dev, res);
> +	if (IS_ERR(wd_base))
> +		return PTR_ERR(wd_base);
>
>   	enabled = in_be32(&wd_base->swcrr) & SWCRR_SWEN;
>   	if (!enabled && wdt_type->hw_enabled) {
>   		pr_info("could not be enabled in software\n");
> -		ret = -ENOSYS;
> -		goto err_unmap;
> +		return -ENOSYS;
>   	}

checkpatch says:

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#65: FILE: drivers/watchdog/mpc8xxx_wdt.c:166:
+		return -ENOSYS;

Maybe just use -ENODEV.

Thanks,
Guenter

