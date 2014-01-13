Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:55986 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbaAMOtQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 13 Jan 2014 09:49:16 -0500
Message-ID: <52D3FCE9.2060108@roeck-us.net>
Date: Mon, 13 Jan 2014 06:49:13 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Anson Huang <b20788@freescale.com>, wim@iguana.be,
	shawn.guo@linaro.org
CC: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: imx2_wdt: disable watchdog timer during low
 power mode
References: <1389614314-8987-1-git-send-email-b20788@freescale.com>
In-Reply-To: <1389614314-8987-1-git-send-email-b20788@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/13/2014 03:58 AM, Anson Huang wrote:
> We should set watchdog timer to be disabled in low power mode,
> as there is no service running in background, otherwise, system
> will reset unexpected.
>
> Signed-off-by: Anson Huang <b20788@freescale.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/imx2_wdt.c |    4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index b4786bc..dd51d95 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -2,6 +2,7 @@
>    * Watchdog driver for IMX2 and later processors
>    *
>    *  Copyright (C) 2010 Wolfram Sang, Pengutronix e.K. <w.sang@pengutronix.de>
> + *  Copyright (C) 2014 Freescale Semiconductor, Inc.
>    *
>    * some parts adapted by similar drivers from Darius Augulis and Vladimir
>    * Zapolskiy, additional improvements by Wim Van Sebroeck.
> @@ -40,6 +41,7 @@
>   #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
>   #define IMX2_WDT_WCR_WRE	(1 << 3)	/* -> WDOG Reset Enable */
>   #define IMX2_WDT_WCR_WDE	(1 << 2)	/* -> Watchdog Enable */
> +#define IMX2_WDT_WCR_WDZST	(1 << 0)	/* -> Watchdog timer Suspend */
>
>   #define IMX2_WDT_WSR		0x02		/* Service Register */
>   #define IMX2_WDT_SEQ1		0x5555		/* -> service sequence 1 */
> @@ -87,6 +89,8 @@ static inline void imx2_wdt_setup(void)
>   {
>   	u16 val = __raw_readw(imx2_wdt.base + IMX2_WDT_WCR);
>
> +	/* Suspend timer in low power mode, write once-only */
> +	val |= IMX2_WDT_WCR_WDZST;
>   	/* Strip the old watchdog Time-Out value */
>   	val &= ~IMX2_WDT_WCR_WT;
>   	/* Generate reset if WDOG times out */
>

