Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38156 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250Ab0LNI5Q (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 14 Dec 2010 03:57:16 -0500
Date: Tue, 14 Dec 2010 09:57:11 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	u.kleine-koenig@pengutronix.de, wim@iguana.be,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: imx: use clk_get to acquire the watchdog
	clock
Message-ID: <20101214085711.GV6017@pengutronix.de>
References: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fabio,

On Tue, Dec 07, 2010 at 02:16:04PM -0200, Fabio Estevam wrote:
> Use clk_get to acquire the watchdog clock and also avoid hardcoding the clock name.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - adapted the watchdog name in arch/arm/plat-mxc/system.c
> 
>  arch/arm/mach-imx/clock-imx21.c |    2 +-
>  arch/arm/mach-imx/clock-imx25.c |    2 +-
>  arch/arm/mach-imx/clock-imx27.c |    2 +-
>  arch/arm/mach-mx3/clock-imx31.c |    2 +-
>  arch/arm/mach-mx3/clock-imx35.c |    2 +-
>  arch/arm/plat-mxc/system.c      |    2 +-
>  drivers/watchdog/imx2_wdt.c     |    2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clock-imx21.c b/arch/arm/mach-imx/clock-imx21.c
> index cf15ea5..c63a4f5 100644
> --- a/arch/arm/mach-imx/clock-imx21.c
> +++ b/arch/arm/mach-imx/clock-imx21.c
> @@ -1185,7 +1185,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK(NULL, "brom", brom_clk)
>  	_REGISTER_CLOCK(NULL, "emma", emma_clk[0])
>  	_REGISTER_CLOCK(NULL, "slcdc", slcdc_clk[0])
> -	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
> +	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
>  	_REGISTER_CLOCK(NULL, "gpio", gpio_clk)
>  	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
>  	_REGISTER_CLOCK("mxc-keypad", NULL, kpp_clk)
> diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
> index 9e4a557..2c98be8 100644
> --- a/arch/arm/mach-imx/clock-imx25.c
> +++ b/arch/arm/mach-imx/clock-imx25.c
> @@ -296,7 +296,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
>  	_REGISTER_CLOCK("imxdi_rtc.0", NULL, dryice_clk)
>  	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
> -	_REGISTER_CLOCK("imx-wdt.0", NULL, wdt_clk)
> +	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)

This breaks compilation on i.MX25. I updated the patch to fix this.

Sascha

>  	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
>  	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
>  	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
> diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
> index 2202b88..f32f3b8 100644
> --- a/arch/arm/mach-imx/clock-imx27.c
> +++ b/arch/arm/mach-imx/clock-imx27.c
> @@ -667,7 +667,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK(NULL, "sahara2", sahara2_clk)
>  	_REGISTER_CLOCK(NULL, "ata", ata_clk)
>  	_REGISTER_CLOCK(NULL, "mstick", mstick_clk)
> -	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
> +	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
>  	_REGISTER_CLOCK(NULL, "gpio", gpio_clk)
>  	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
>  	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
> diff --git a/arch/arm/mach-mx3/clock-imx31.c b/arch/arm/mach-mx3/clock-imx31.c
> index 7cf6d29..4193cf5 100644
> --- a/arch/arm/mach-mx3/clock-imx31.c
> +++ b/arch/arm/mach-mx3/clock-imx31.c
> @@ -530,7 +530,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("imx31-cspi.2", NULL, cspi3_clk)
>  	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
>  	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
> -	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
> +	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
>  	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
>  	_REGISTER_CLOCK(NULL, "epit", epit1_clk)
>  	_REGISTER_CLOCK(NULL, "epit", epit2_clk)
> diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
> index 61e4a31..22259d9 100644
> --- a/arch/arm/mach-mx3/clock-imx35.c
> +++ b/arch/arm/mach-mx3/clock-imx35.c
> @@ -495,7 +495,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usbahb_clk)
> -	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
> +	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
>  	_REGISTER_CLOCK(NULL, "max", max_clk)
>  	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
>  	_REGISTER_CLOCK(NULL, "csi", csi_clk)
> diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
> index c3972c5..3455fc0 100644
> --- a/arch/arm/plat-mxc/system.c
> +++ b/arch/arm/plat-mxc/system.c
> @@ -55,7 +55,7 @@ void arch_reset(char mode, const char *cmd)
>  	} else {
>  		struct clk *clk;
>  
> -		clk = clk_get_sys("imx-wdt.0", NULL);
> +		clk = clk_get_sys("imx2-wdt.0", NULL);
>  		if (!IS_ERR(clk))
>  			clk_enable(clk);
>  		wcr_enable = (1 << 2);
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 2ee7dac..86f7cac 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -270,7 +270,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	imx2_wdt.clk = clk_get_sys("imx-wdt.0", NULL);
> +	imx2_wdt.clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(imx2_wdt.clk)) {
>  		dev_err(&pdev->dev, "can't get Watchdog clock\n");
>  		return PTR_ERR(imx2_wdt.clk);
> -- 
> 1.6.0.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
