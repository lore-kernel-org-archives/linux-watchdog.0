Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:52728 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab3KJTNo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 10 Nov 2013 14:13:44 -0500
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be, t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org
Subject: Re: [PATCH V6 3/3] watchdog: s3c2410_wdt: use syscon regmap interface to configure pmu register
Date: Sun, 10 Nov 2013 20:13:43 +0100
Message-ID: <3426745.Yob7zMjee0@flatron>
In-Reply-To: <1383825078-24515-4-git-send-email-l.krishna@samsung.com>
References: <1383825078-24515-1-git-send-email-l.krishna@samsung.com> <1383825078-24515-4-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Leela,

On Thursday 07 of November 2013 17:21:18 Leela Krishna Amudala wrote:
> The syscon regmap interface is used to configure AUTOMATIC_WDT_RESET_DISABLE
> and MASK_WDT_RESET_REQUEST registers of PMU to mask/unmask enable/disable of
> watchdog in probe and s2r scenarios.
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |   21 ++-
>  drivers/watchdog/s3c2410_wdt.c                     |  139 ++++++++++++++++++--
>  2 files changed, 151 insertions(+), 9 deletions(-)
[snip]
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 23aad7c..a151c20 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
[snip]
> +/* s3c2410_get_wdt_driver_data */
> +static inline struct s3c2410_wdt_variant *
> +get_wdt_drv_data(struct platform_device *pdev)
> +{
> +#ifdef CONFIG_OF
> +	if (pdev->dev.of_node) {
> +		const struct of_device_id *match;
> +		match = of_match_node(s3c2410_wdt_match, pdev->dev.of_node);
> +		return (struct s3c2410_wdt_variant *)match->data;
> +	}
> +#endif
> +	return (struct s3c2410_wdt_variant *)
> +		platform_get_device_id(pdev)->driver_data;

This code calls platform_get_device_id(), but I don't see any array of
platform_device_id in this driver. This will always crash on a NULL
pointer dereference whenever booted on a platform using board files.

Also, as this driver is now using syscon API, its Kconfig entry should
select MFD_SYSCON.

Other than that, the patch looks fine.

Best regards,
Tomasz

