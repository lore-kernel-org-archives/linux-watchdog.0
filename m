Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40747 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbcDHBJx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Apr 2016 21:09:53 -0400
Subject: Re: [PATCH v5 1/2] watchdog: imx2_wdt: add external reset support via
 dt prop
To: Tim Harvey <tharvey@gateworks.com>, linux-watchdog@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>
References: <1459523804-11390-1-git-send-email-tharvey@gateworks.com>
 <1459523804-11390-2-git-send-email-tharvey@gateworks.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Wim Van Sebroeck <wim@iguana.be>, Stefan Roese <sr@denx.de>,
	Iain Paton <ipaton0@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <570704E1.6010700@roeck-us.net>
Date: Thu, 7 Apr 2016 18:09:53 -0700
MIME-Version: 1.0
In-Reply-To: <1459523804-11390-2-git-send-email-tharvey@gateworks.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/01/2016 08:16 AM, Tim Harvey wrote:
> The IMX6 watchdog supports assertion of a signal (WDOG_B) which
> can be pinmux'd to an external pin. This is typically used for boards that
> have PMIC's in control of the IMX6 power rails. In fact, failure to use
> such an external reset on boards with external PMIC's can result in various
> hangs due to the IMX6 not being fully reset [1] as well as the board failing
> to reset because its PMIC has not been reset to provide adequate voltage for
> the CPU when coming out of reset at 800Mhz.
>
> This uses a new device-tree property 'fsl,ext-reset-output' to indicate the
> board has such a reset and to cause the watchdog to be configured to assert
> WDOG_B instead of an internal reset both on a watchdog timeout and in
> system_restart.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html
>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Iain Paton <ipaton0@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Akshay Bhat <akshay.bhat@timesys.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v5:
>   - rename property to 'fsl,ext-reset-output'
> v4:
>   - change Property to Properties in documentation
> v3:
>   - mandate use of 'either' internal or external reset but not both
>     simultaneously
> v2:
>   - rename property to 'ext-reset-output' based on ML feedback
>   - simplify setting SRS bit if external-reset
>   - update comments and commit msg
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>   .../devicetree/bindings/watchdog/fsl-imx-wdt.txt      |  4 +++-
>   drivers/watchdog/imx2_wdt.c                           | 19 +++++++++++++++++--
>   2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> index 8dab6fd..107280e 100644
> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> @@ -5,10 +5,12 @@ Required properties:
>   - reg : Should contain WDT registers location and length
>   - interrupts : Should contain WDT interrupt
>
> -Optional property:
> +Optional properties:
>   - big-endian: If present the watchdog device's registers are implemented
>     in big endian mode, otherwise in native mode(same with CPU), for more
>     detail please see: Documentation/devicetree/bindings/regmap/regmap.txt.
> +- fsl,ext-reset-output: If present the watchdog device is configured to
> +  assert its external reset (WDOG_B) instead of issuing a software reset.
>
>   Examples:
>
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index e47966a..cb838be 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -39,6 +39,8 @@
>
>   #define IMX2_WDT_WCR		0x00		/* Control Register */
>   #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
> +#define IMX2_WDT_WCR_WDA	(1 << 5)	/* -> External Reset WDOG_B */
> +#define IMX2_WDT_WCR_SRS	(1 << 4)	/* -> Software Reset Signal */
>   #define IMX2_WDT_WCR_WRE	(1 << 3)	/* -> WDOG Reset Enable */
>   #define IMX2_WDT_WCR_WDE	(1 << 2)	/* -> Watchdog Enable */
>   #define IMX2_WDT_WCR_WDZST	(1 << 0)	/* -> Watchdog timer Suspend */
> @@ -62,6 +64,7 @@ struct imx2_wdt_device {
>   	struct regmap *regmap;
>   	struct timer_list timer;	/* Pings the watchdog when closed */
>   	struct watchdog_device wdog;
> +	bool ext_reset;
>   };
>
>   static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -85,6 +88,12 @@ static int imx2_wdt_restart(struct watchdog_device *wdog)
>   	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
>   	unsigned int wcr_enable = IMX2_WDT_WCR_WDE;
>
> +	/* Use internal reset or external - not both */
> +	if (wdev->ext_reset)
> +		wcr_enable |= IMX2_WDT_WCR_SRS; /* do not assert int reset */
> +	else
> +		wcr_enable |= IMX2_WDT_WCR_WDA; /* do not assert ext-reset */
> +
>   	/* Assert SRS signal */
>   	regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
>   	/*
> @@ -114,8 +123,12 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
>   	val |= IMX2_WDT_WCR_WDZST;
>   	/* Strip the old watchdog Time-Out value */
>   	val &= ~IMX2_WDT_WCR_WT;
> -	/* Generate reset if WDOG times out */
> -	val &= ~IMX2_WDT_WCR_WRE;
> +	/* Generate internal chip-level reset if WDOG times out */
> +	if (!wdev->ext_reset)
> +		val &= ~IMX2_WDT_WCR_WRE;
> +	/* Or if external-reset assert WDOG_B reset only on time-out */
> +	else
> +		val |= IMX2_WDT_WCR_WRE;
>   	/* Keep Watchdog Disabled */
>   	val &= ~IMX2_WDT_WCR_WDE;
>   	/* Set the watchdog's Time-Out value */
> @@ -263,6 +276,8 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>   	regmap_read(wdev->regmap, IMX2_WDT_WRSR, &val);
>   	wdog->bootstatus = val & IMX2_WDT_WRSR_TOUT ? WDIOF_CARDRESET : 0;
>
> +	wdev->ext_reset = of_property_read_bool(pdev->dev.of_node,
> +						"fsl,ext-reset-output");
>   	wdog->timeout = clamp_t(unsigned, timeout, 1, IMX2_WDT_MAX_TIME);
>   	if (wdog->timeout != timeout)
>   		dev_warn(&pdev->dev, "Initial timeout out of range! Clamped from %u to %u\n",
>

