Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:61057 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab3K0Q6P (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 27 Nov 2013 11:58:15 -0500
Message-ID: <529624A3.2030802@roeck-us.net>
Date: Wed, 27 Nov 2013 08:58:11 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc@vger.kernel.org, wim@iguana.be
CC: dianders@chromium.org, kgene.kim@samsung.com, t.figa@samsung.com,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com
Subject: Re: [PATCH V10 2/3] watchdog: s3c2410_wdt: use syscon regmap interface
 to configure pmu register
References: <1385553010-30183-1-git-send-email-l.krishna@samsung.com> <1385553010-30183-3-git-send-email-l.krishna@samsung.com>
In-Reply-To: <1385553010-30183-3-git-send-email-l.krishna@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/27/2013 03:50 AM, Leela Krishna Amudala wrote:
> Add device tree support for exynos5250 and 5420 SoCs and use syscon regmap interface
> to configure AUTOMATIC_WDT_RESET_DISABLE and MASK_WDT_RESET_REQUEST registers of PMU
> to mask/unmask enable/disable of watchdog in probe and s2r scenarios.
>
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>   .../devicetree/bindings/watchdog/samsung-wdt.txt   |   21 ++-
>   drivers/watchdog/Kconfig                           |    1 +
>   drivers/watchdog/s3c2410_wdt.c                     |  164 ++++++++++++++++++--
>   3 files changed, 176 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> index 2aa486c..cfff375 100644
> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> @@ -5,10 +5,29 @@ after a preset amount of time during which the WDT reset event has not
>   occurred.
>
>   Required properties:
> -- compatible : should be "samsung,s3c2410-wdt"
> +- compatible : should be one among the following
> +	(a) "samsung,s3c2410-wdt" for Exynos4 and previous SoCs
> +	(b) "samsung,exynos5250-wdt" for Exynos5250
> +	(c) "samsung,exynos5420-wdt" for Exynos5420
> +
>   - reg : base physical address of the controller and length of memory mapped
>   	region.
>   - interrupts : interrupt number to the cpu.
> +- samsung,syscon-phandle : reference to syscon node (This property required only
> +	in case of compatible being "samsung,exynos5250-wdt" or "samsung,exynos5420-wdt".
> +	In case of Exynos5250 and 5420 this property points to syscon node holding the PMU
> +	base address)
>
>   Optional properties:
>   - timeout-sec : contains the watchdog timeout in seconds.
> +
> +Example:
> +
> +watchdog@101D0000 {
> +	compatible = "samsung,exynos5250-wdt";
> +	reg = <0x101D0000 0x100>;
> +	interrupts = <0 42 0>;
> +	clocks = <&clock 336>;
> +	clock-names = "watchdog";
> +	samsung,syscon-phandle = <&pmu_syscon>;
> +};
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 5be6e91..24738c0 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -188,6 +188,7 @@ config S3C2410_WATCHDOG
>   	tristate "S3C2410 Watchdog"
>   	depends on HAVE_S3C2410_WATCHDOG
>   	select WATCHDOG_CORE
> +	select MFD_SYSCON if ARCH_EXYNOS5
>   	help
>   	  Watchdog timer block in the Samsung SoCs. This will reboot
>   	  the system when the timer expires with the watchdog enabled.
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 7d8fd04..b00b535 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -40,6 +40,8 @@
>   #include <linux/slab.h>
>   #include <linux/err.h>
>   #include <linux/of.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
>
>   #define S3C2410_WTCON		0x00
>   #define S3C2410_WTDAT		0x04
> @@ -60,6 +62,10 @@
>   #define CONFIG_S3C2410_WATCHDOG_ATBOOT		(0)
>   #define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME	(15)
>
> +#define WDT_DISABLE_REG_OFFSET		0x0408
> +#define WDT_MASK_RESET_REG_OFFSET	0x040c
> +#define QUIRK_NEEDS_PMU_CONFIG		(1 << 0)
> +
>   static bool nowayout	= WATCHDOG_NOWAYOUT;
>   static int tmr_margin;
>   static int tmr_atboot	= CONFIG_S3C2410_WATCHDOG_ATBOOT;
> @@ -83,6 +89,25 @@ MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, "
>   			"0 to reboot (default 0)");
>   MODULE_PARM_DESC(debug, "Watchdog debug, set to >1 for debug (default 0)");
>
> +/**
> + * struct s3c2410_wdt_variant - Per-variant config data
> + *
> + * @disable_reg: Offset in pmureg for the register that disables the watchdog
> + * timer reset functionality.
> + * @mask_reset_reg: Offset in pmureg for the register that masks the watchdog
> + * timer reset functionality.
> + * @mask_bit: Bit number for the watchdog timer in the disable register and the
> + * mask reset register.
> + * @quirks: A bitfield of quirks.
> + */
> +
> +struct s3c2410_wdt_variant {
> +	int disable_reg;
> +	int mask_reset_reg;
> +	int mask_bit;
> +	u32 quirks;
> +};
> +
>   struct s3c2410_wdt {
>   	struct device		*dev;
>   	struct clk		*clock;
> @@ -93,8 +118,50 @@ struct s3c2410_wdt {
>   	unsigned long		wtdat_save;
>   	struct watchdog_device	wdt_device;
>   	struct notifier_block	freq_transition;
> +	struct s3c2410_wdt_variant *drv_data;
> +	struct regmap *pmureg;
> +};
> +
> +static const struct s3c2410_wdt_variant drv_data_s3c2410 = {
> +	.quirks = 0
> +};
> +
> +#ifdef CONFIG_OF
> +static const struct s3c2410_wdt_variant drv_data_exynos5250  = {
> +	.disable_reg = WDT_DISABLE_REG_OFFSET,
> +	.mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
> +	.mask_bit = 20,
> +	.quirks = QUIRK_NEEDS_PMU_CONFIG
> +};
> +
> +static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
> +	.disable_reg = WDT_DISABLE_REG_OFFSET,
> +	.mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
> +	.mask_bit = 0,
> +	.quirks = QUIRK_NEEDS_PMU_CONFIG
>   };
>
> +static const struct of_device_id s3c2410_wdt_match[] = {
> +	{ .compatible = "samsung,s3c2410-wdt",
> +	  .data = &drv_data_s3c2410 },
> +	{ .compatible = "samsung,exynos5250-wdt",
> +	  .data = &drv_data_exynos5250 },
> +	{ .compatible = "samsung,exynos5420-wdt",
> +	  .data = &drv_data_exynos5420 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
> +#endif
> +
> +static const struct platform_device_id s3c2410_wdt_ids[] = {
> +	{
> +		.name = "s3c2410-wdt",
> +		.driver_data = (unsigned long)&drv_data_s3c2410,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, s3c2410_wdt_ids);
> +
>   /* watchdog control routines */
>
>   #define DBG(fmt, ...)					\
> @@ -110,6 +177,32 @@ static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
>   	return container_of(nb, struct s3c2410_wdt, freq_transition);
>   }
>
> +static int s3c2410wdt_mask_and_disable_reset(struct s3c2410_wdt *wdt, bool mask)
> +{
> +	int ret;
> +	u32 mask_val = 1 << wdt->drv_data->mask_bit;
> +	u32 val = 0;
> +
> +	if (mask)
> +		val = mask_val;
> +
> +	ret = regmap_update_bits(wdt->pmureg,
> +			wdt->drv_data->disable_reg,
> +			mask_val, val);
> +	if (ret < 0) {
> +		dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
> +		return ret;
> +	}
> +
Since you are now doing something in the error handler,
you might want to follow coding style rules:

	if (ret < 0)
		goto error;

> +	ret = regmap_update_bits(wdt->pmureg,
> +			wdt->drv_data->mask_reset_reg,
> +			mask_val, val);

error:
> +	if (ret < 0)
> +		dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
> +
> +	return ret;
> +}
> +
>   static int s3c2410wdt_keepalive(struct watchdog_device *wdd)
>   {
>   	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
> @@ -331,6 +424,20 @@ static inline void s3c2410wdt_cpufreq_deregister(struct s3c2410_wdt *wdt)
>   }
>   #endif
>
> +/* s3c2410_get_wdt_driver_data */
> +static inline struct s3c2410_wdt_variant *
> +get_wdt_drv_data(struct platform_device *pdev)
> +{
> +	if (pdev->dev.of_node) {
> +		const struct of_device_id *match;
> +		match = of_match_node(s3c2410_wdt_match, pdev->dev.of_node);
> +		return (struct s3c2410_wdt_variant *)match->data;
> +	} else {
> +		return (struct s3c2410_wdt_variant *)
> +			platform_get_device_id(pdev)->driver_data;
> +	}
> +}
> +
>   static int s3c2410wdt_probe(struct platform_device *pdev)
>   {
>   	struct device *dev;
> @@ -353,6 +460,16 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>   	spin_lock_init(&wdt->lock);
>   	wdt->wdt_device = s3c2410_wdd;
>
> +	wdt->drv_data = get_wdt_drv_data(pdev);
> +	if (wdt->drv_data->quirks & QUIRK_NEEDS_PMU_CONFIG) {
> +		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
> +							"samsung,syscon-phandle");
> +		if (IS_ERR(wdt->pmureg)) {
> +			dev_err(dev, "syscon regmap lookup failed.\n");
> +			return PTR_ERR(wdt->pmureg);
> +		}
> +	}
> +
>   	wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>   	if (wdt_irq == NULL) {
>   		dev_err(dev, "no irq resource specified\n");
> @@ -421,6 +538,12 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>   		goto err_cpufreq;
>   	}
>
> +	if (wdt->drv_data->quirks & QUIRK_NEEDS_PMU_CONFIG) {
> +		ret = s3c2410wdt_mask_and_disable_reset(wdt, false);
> +		if (ret < 0)
> +			goto err_unregister;
> +	}
> +
>   	if (tmr_atboot && started == 0) {
>   		dev_info(dev, "starting watchdog timer\n");
>   		s3c2410wdt_start(&wdt->wdt_device);
> @@ -445,6 +568,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>
>   	return 0;
>
> + err_unregister:
> +	watchdog_unregister_device(&wdt->wdt_device);
> +
>    err_cpufreq:
>   	s3c2410wdt_cpufreq_deregister(wdt);
>
> @@ -458,8 +584,15 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>
>   static int s3c2410wdt_remove(struct platform_device *dev)
>   {
> +	int ret;
>   	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
>
> +	if (wdt->drv_data->quirks & QUIRK_NEEDS_PMU_CONFIG) {
> +		ret = s3c2410wdt_mask_and_disable_reset(wdt, true);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>   	watchdog_unregister_device(&wdt->wdt_device);
>
>   	s3c2410wdt_cpufreq_deregister(wdt);
> @@ -472,8 +605,15 @@ static int s3c2410wdt_remove(struct platform_device *dev)
>
>   static void s3c2410wdt_shutdown(struct platform_device *dev)
>   {
> +	int ret;
>   	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
>
> +	if (wdt->drv_data->quirks & QUIRK_NEEDS_PMU_CONFIG) {
> +		ret = s3c2410wdt_mask_and_disable_reset(wdt, true);
> +		if (ret < 0)
> +			dev_warn(wdt->dev, "failed to update pmu register");

Duplicate error message.

> +	}
> +
>   	s3c2410wdt_stop(&wdt->wdt_device);
>   }
>
> @@ -481,12 +621,19 @@ static void s3c2410wdt_shutdown(struct platform_device *dev)
>
>   static int s3c2410wdt_suspend(struct device *dev)
>   {
> +	int ret;
>   	struct s3c2410_wdt *wdt = dev_get_drvdata(dev);
>
>   	/* Save watchdog state, and turn it off. */
>   	wdt->wtcon_save = readl(wdt->reg_base + S3C2410_WTCON);
>   	wdt->wtdat_save = readl(wdt->reg_base + S3C2410_WTDAT);
>
> +	if (wdt->drv_data->quirks & QUIRK_NEEDS_PMU_CONFIG) {
> +		ret = s3c2410wdt_mask_and_disable_reset(wdt, true);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>   	/* Note that WTCNT doesn't need to be saved. */
>   	s3c2410wdt_stop(&wdt->wdt_device);
>
> @@ -495,6 +642,7 @@ static int s3c2410wdt_suspend(struct device *dev)
>
>   static int s3c2410wdt_resume(struct device *dev)
>   {
> +	int ret;
>   	struct s3c2410_wdt *wdt = dev_get_drvdata(dev);
>
>   	/* Restore watchdog state. */
> @@ -502,6 +650,12 @@ static int s3c2410wdt_resume(struct device *dev)
>   	writel(wdt->wtdat_save, wdt->reg_base + S3C2410_WTCNT);/* Reset count */
>   	writel(wdt->wtcon_save, wdt->reg_base + S3C2410_WTCON);
>
> +	if (wdt->drv_data->quirks & QUIRK_NEEDS_PMU_CONFIG) {
> +		ret = s3c2410wdt_mask_and_disable_reset(wdt, false);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>   	dev_info(dev, "watchdog %sabled\n",
>   		(wdt->wtcon_save & S3C2410_WTCON_ENABLE) ? "en" : "dis");
>
> @@ -512,18 +666,11 @@ static int s3c2410wdt_resume(struct device *dev)
>   static SIMPLE_DEV_PM_OPS(s3c2410wdt_pm_ops, s3c2410wdt_suspend,
>   			s3c2410wdt_resume);
>
> -#ifdef CONFIG_OF
> -static const struct of_device_id s3c2410_wdt_match[] = {
> -	{ .compatible = "samsung,s3c2410-wdt" },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
> -#endif
> -
>   static struct platform_driver s3c2410wdt_driver = {
>   	.probe		= s3c2410wdt_probe,
>   	.remove		= s3c2410wdt_remove,
>   	.shutdown	= s3c2410wdt_shutdown,
> +	.id_table	= s3c2410_wdt_ids,
>   	.driver		= {
>   		.owner	= THIS_MODULE,
>   		.name	= "s3c2410-wdt",
> @@ -538,4 +685,3 @@ MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>, "
>   	      "Dimitry Andric <dimitry.andric@tomtom.com>");
>   MODULE_DESCRIPTION("S3C2410 Watchdog Device Driver");
>   MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:s3c2410-wdt");
>

