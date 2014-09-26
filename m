Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35985 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268AbaIZRjV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Sep 2014 13:39:21 -0400
Date: Fri, 26 Sep 2014 10:39:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-watchdog@vger.kernel.org, naveenkrishna.ch@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [09/14] watchdog: s3c2410_wdt: Add support for Watchdog device
 on Exynos7
Message-ID: <20140926173915.GA834@roeck-us.net>
References: <1409132831-2032-1-git-send-email-ch.naveen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1409132831-2032-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Aug 27, 2014 at 03:17:11PM +0530, Naveen Krishna Chatradhi wrote:
> Exynos7 SoC has a Watchdog for Atlas (A57) cores
> This patch adds support for the Atlas watchdog.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |    1 +
>  drivers/watchdog/s3c2410_wdt.c                     |   11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> index cfff375..8f3d96a 100644
> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> @@ -9,6 +9,7 @@ Required properties:
>  	(a) "samsung,s3c2410-wdt" for Exynos4 and previous SoCs
>  	(b) "samsung,exynos5250-wdt" for Exynos5250
>  	(c) "samsung,exynos5420-wdt" for Exynos5420
> +	(c) "samsung,exynos7-wdt" for Exynos7
>  
>  - reg : base physical address of the controller and length of memory mapped
>  	region.
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 7c6ccd0..015256e 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -155,6 +155,15 @@ static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
>  	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT,
>  };
>  
> +static const struct s3c2410_wdt_variant drv_data_exynos7 = {
> +	.disable_reg = EXYNOS5_WDT_DISABLE_REG_OFFSET,
> +	.mask_reset_reg = EXYNOS5_WDT_MASK_RESET_REG_OFFSET,
> +	.mask_bit = 0,
> +	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
> +	.rst_stat_bit = 23,	/* A57 WDTRESET */
> +	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT,
> +};
> +
>  static const struct of_device_id s3c2410_wdt_match[] = {
>  	{ .compatible = "samsung,s3c2410-wdt",
>  	  .data = &drv_data_s3c2410 },
> @@ -162,6 +171,8 @@ static const struct of_device_id s3c2410_wdt_match[] = {
>  	  .data = &drv_data_exynos5250 },
>  	{ .compatible = "samsung,exynos5420-wdt",
>  	  .data = &drv_data_exynos5420 },
> +	{ .compatible = "samsung,exynos7-wdt",
> +	  .data = &drv_data_exynos7 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
