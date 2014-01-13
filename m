Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:33917
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751357AbaAMMWd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 13 Jan 2014 07:22:33 -0500
Date: Mon, 13 Jan 2014 20:23:52 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Anson Huang <b20788@freescale.com>
CC: <wim@iguana.be>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH] watchdog: imx2_wdt: disable watchdog timer during low
 power mode
Message-ID: <20140113122350.GS23525@S2101-09.ap.freescale.net>
References: <1389614314-8987-1-git-send-email-b20788@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1389614314-8987-1-git-send-email-b20788@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 13, 2014 at 07:58:34PM +0800, Anson Huang wrote:
> We should set watchdog timer to be disabled in low power mode,
> as there is no service running in background, otherwise, system
> will reset unexpected.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/watchdog/imx2_wdt.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index b4786bc..dd51d95 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -2,6 +2,7 @@
>   * Watchdog driver for IMX2 and later processors
>   *
>   *  Copyright (C) 2010 Wolfram Sang, Pengutronix e.K. <w.sang@pengutronix.de>
> + *  Copyright (C) 2014 Freescale Semiconductor, Inc.
>   *
>   * some parts adapted by similar drivers from Darius Augulis and Vladimir
>   * Zapolskiy, additional improvements by Wim Van Sebroeck.
> @@ -40,6 +41,7 @@
>  #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
>  #define IMX2_WDT_WCR_WRE	(1 << 3)	/* -> WDOG Reset Enable */
>  #define IMX2_WDT_WCR_WDE	(1 << 2)	/* -> Watchdog Enable */
> +#define IMX2_WDT_WCR_WDZST	(1 << 0)	/* -> Watchdog timer Suspend */
>  
>  #define IMX2_WDT_WSR		0x02		/* Service Register */
>  #define IMX2_WDT_SEQ1		0x5555		/* -> service sequence 1 */
> @@ -87,6 +89,8 @@ static inline void imx2_wdt_setup(void)
>  {
>  	u16 val = __raw_readw(imx2_wdt.base + IMX2_WDT_WCR);
>  
> +	/* Suspend timer in low power mode, write once-only */
> +	val |= IMX2_WDT_WCR_WDZST;
>  	/* Strip the old watchdog Time-Out value */
>  	val &= ~IMX2_WDT_WCR_WT;
>  	/* Generate reset if WDOG times out */
> -- 
> 1.7.9.5
> 
> 

