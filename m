Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41402 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbbJBPBT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 Oct 2015 11:01:19 -0400
Subject: Re: [PATCH] watchdog: imx2_wdt: Use register definition in
 regmap_write()
To: Fabio Estevam <festevam@gmail.com>, wim@iguana.be
References: <1443756328-11680-1-git-send-email-festevam@gmail.com>
Cc: linux-watchdog@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <560E9C3B.2090409@roeck-us.net>
Date: Fri, 2 Oct 2015 08:01:15 -0700
MIME-Version: 1.0
In-Reply-To: <1443756328-11680-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/01/2015 08:25 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> In order to improve readability it is better to pass the register name
> definition rather than to pass its hardcoded offset.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/imx2_wdt.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 0bb1a1d..29ef719 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -91,7 +91,7 @@ static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
>   						    struct imx2_wdt_device,
>   						    restart_handler);
>   	/* Assert SRS signal */
> -	regmap_write(wdev->regmap, 0, wcr_enable);
> +	regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
>   	/*
>   	 * Due to imx6q errata ERR004346 (WDOG: WDOG SRS bit requires to be
>   	 * written twice), we add another two writes to ensure there must be at
> @@ -99,8 +99,8 @@ static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
>   	 * the target check here, since the writes shouldn't be a huge burden
>   	 * for other platforms.
>   	 */
> -	regmap_write(wdev->regmap, 0, wcr_enable);
> -	regmap_write(wdev->regmap, 0, wcr_enable);
> +	regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
> +	regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
>
>   	/* wait for reset to assert... */
>   	mdelay(500);
>

