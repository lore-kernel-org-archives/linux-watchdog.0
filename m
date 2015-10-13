Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33382 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbbJMOL6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 13 Oct 2015 10:11:58 -0400
Received: by oiar126 with SMTP id r126so10111958oia.0
        for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2015 07:11:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1438097230-2653-2-git-send-email-tharvey@gateworks.com>
References: <1433448960-9257-2-git-send-email-tharvey@gateworks.com>
	<1438097230-2653-1-git-send-email-tharvey@gateworks.com>
	<1438097230-2653-2-git-send-email-tharvey@gateworks.com>
Date: Tue, 13 Oct 2015 07:11:58 -0700
Message-ID: <CAJ+vNU16Yf2P9Xvznou-fAbrFdO_6kvDOt7+-ej5c1BxEyumGQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] watchdog: imx2_wdt: add external reset support via
 'ext-reset-output' dt prop
From: Tim Harvey <tharvey@gateworks.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Stefan Roese <sr@denx.de>, Iain Paton <ipaton0@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jul 28, 2015 at 8:27 AM, Tim Harvey <tharvey@gateworks.com> wrote:
> The IMX6 watchdog supports assertion of a signal (WDOG_B) which
> can be pinmux'd to an external pin. This is typically used for boards that
> have PMIC's in control of the IMX6 power rails. In fact, failure to use
> such an external reset on boards with external PMIC's can result in various
> hangs due to the IMX6 not being fully reset [1] as well as the board failing
> to reset because its PMIC has not been reset to provide adequate voltage for
> the CPU when coming out of reset at 800Mhz.
>
> This uses a new device-tree property 'ext-reset-output' to indicate the
> board has such a reset and to cause the watchdog to be configured to assert
> WDOG_B instead of an internal reset both on a watchdog timeout and in
> system_restart.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html
>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v3:
>  - mandate use of 'either' internal or external reset but not both
>    simultaneously
> v2:
>  - rename property to 'ext-reset-output' based on ML feedback
>  - simplify setting SRS bit if external-reset
>  - update comments and commit msg
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  .../devicetree/bindings/watchdog/fsl-imx-wdt.txt     |  2 ++
>  drivers/watchdog/imx2_wdt.c                          | 20 ++++++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> index 8dab6fd..9b89b3a 100644
> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> @@ -9,6 +9,8 @@ Optional property:
>  - big-endian: If present the watchdog device's registers are implemented
>    in big endian mode, otherwise in native mode(same with CPU), for more
>    detail please see: Documentation/devicetree/bindings/regmap/regmap.txt.
> +- ext-reset-output: If present the watchdog device is configured to assert its
> +  external reset (WDOG_B) instead of issuing a software reset.
>
>  Examples:
>
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 0bb1a1d..5d9ccf6 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -41,6 +41,8 @@
>
>  #define IMX2_WDT_WCR           0x00            /* Control Register */
>  #define IMX2_WDT_WCR_WT                (0xFF << 8)     /* -> Watchdog Timeout Field */
> +#define IMX2_WDT_WCR_WDA       (1 << 5)        /* -> External Reset WDOG_B */
> +#define IMX2_WDT_WCR_SRS       (1 << 4)        /* -> Software Reset Signal */
>  #define IMX2_WDT_WCR_WRE       (1 << 3)        /* -> WDOG Reset Enable */
>  #define IMX2_WDT_WCR_WDE       (1 << 2)        /* -> Watchdog Enable */
>  #define IMX2_WDT_WCR_WDZST     (1 << 0)        /* -> Watchdog timer Suspend */
> @@ -65,6 +67,7 @@ struct imx2_wdt_device {
>         struct timer_list timer;        /* Pings the watchdog when closed */
>         struct watchdog_device wdog;
>         struct notifier_block restart_handler;
> +       bool ext_reset;
>  };
>
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -90,6 +93,13 @@ static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
>         struct imx2_wdt_device *wdev = container_of(this,
>                                                     struct imx2_wdt_device,
>                                                     restart_handler);
> +
> +       /* Use internal reset or external - not both */
> +       if (wdev->ext_reset)
> +               wcr_enable |= IMX2_WDT_WCR_SRS; /* do not assert int reset */
> +       else
> +               wcr_enable |= IMX2_WDT_WCR_WDA; /* do not assert ext-reset */
> +
>         /* Assert SRS signal */
>         regmap_write(wdev->regmap, 0, wcr_enable);
>         /*
> @@ -119,8 +129,12 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
>         val |= IMX2_WDT_WCR_WDZST;
>         /* Strip the old watchdog Time-Out value */
>         val &= ~IMX2_WDT_WCR_WT;
> -       /* Generate reset if WDOG times out */
> -       val &= ~IMX2_WDT_WCR_WRE;
> +       /* Generate internal chip-level reset if WDOG times out */
> +       if (!wdev->ext_reset)
> +               val &= ~IMX2_WDT_WCR_WRE;
> +       /* Or if external-reset assert WDOG_B reset only on time-out */
> +       else
> +               val |= IMX2_WDT_WCR_WRE;
>         /* Keep Watchdog Disabled */
>         val &= ~IMX2_WDT_WCR_WDE;
>         /* Set the watchdog's Time-Out value */
> @@ -267,6 +281,8 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>         regmap_read(wdev->regmap, IMX2_WDT_WRSR, &val);
>         wdog->bootstatus = val & IMX2_WDT_WRSR_TOUT ? WDIOF_CARDRESET : 0;
>
> +       wdev->ext_reset = of_property_read_bool(pdev->dev.of_node,
> +                                               "ext-reset-output");
>         wdog->timeout = clamp_t(unsigned, timeout, 1, IMX2_WDT_MAX_TIME);
>         if (wdog->timeout != timeout)
>                 dev_warn(&pdev->dev, "Initial timeout out of range! Clamped from %u to %u\n",
> --
> 1.9.1
>

Wim,

I believe I missed sending this to the proper watchdog maintainer
which appears to be you.

Regards,

Tim
