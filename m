Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:52984 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab3JaN3F (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 31 Oct 2013 09:29:05 -0400
Message-ID: <52725B1F.4040107@roeck-us.net>
Date: Thu, 31 Oct 2013 06:29:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Tomasz Figa <t.figa@samsung.com>,
	Leela Krishna Amudala <l.krishna@samsung.com>
CC: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be, devicetree@vger.kernel.org, dianders@chromium.org,
	linux-watchdog@vger.kernel.org, cpgs@samsung.com,
	sachin.kamat@linaro.org
Subject: Re: [PATCH V5 3/3] watchdog: s3c2410_wdt: use syscon regmap interface
 to configure pmu register
References: <1383199250-15405-1-git-send-email-l.krishna@samsung.com> <1383199250-15405-4-git-send-email-l.krishna@samsung.com> <2427917.T2x6X1TJ2k@amdc1227>
In-Reply-To: <2427917.T2x6X1TJ2k@amdc1227>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/31/2013 05:29 AM, Tomasz Figa wrote:
> Hi Leela,
>
> On Thursday 31 of October 2013 11:30:50 Leela Krishna Amudala wrote:
>> The syscon regmap interface is used to configure AUTOMATIC_WDT_RESET_DISABLE
>> and MASK_WDT_RESET_REQUEST registers of PMU to mask/unmask enable/disable of
>> watchdog in probe and s2r scenarios.
>>
>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> ---
>>   .../devicetree/bindings/watchdog/samsung-wdt.txt   |   22 ++-
>>   drivers/watchdog/s3c2410_wdt.c                     |  150 +++++++++++++++++---
>>   2 files changed, 154 insertions(+), 18 deletions(-)
>
> This patch looks better now, but there are still several issues remaining.
> Please see my comments inline.
>
>> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> index 2aa486c..0b8aa4b 100644
>> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> @@ -5,10 +5,30 @@ after a preset amount of time during which the WDT reset event has not
>>   occurred.
>>
>>   Required properties:
>> -- compatible : should be "samsung,s3c2410-wdt"
>> +- compatible : should be one among the following
>> +	(a) "samsung,s3c2410-wdt" for Exynos4 and previous SoCs
>> +	(b) "samsung,exynos5250-wdt" for Exynos5250
>> +	(c) "samsung,exynos5420-wdt" for Exynos5420
>> +
>>   - reg : base physical address of the controller and length of memory mapped
>>   	region.
>>   - interrupts : interrupt number to the cpu.
>> +- samsung,syscon-phandle : reference to syscon node (This property required only
>> +	in case of compatible being "samsung,exynos5250-wdt" or "samsung,exynos5420-wdt".
>> +	In case of Exynos5250 and 5420 this property points to syscon node holding the PMU
>> +	base address)
>>
>>   Optional properties:
>>   - timeout-sec : contains the watchdog timeout in seconds.
>> +
>> +Example:
>> +
>> +watchdog@101D0000 {
>> +	compatible = "samsung,exynos5250-wdt";
>> +	reg = <0x101D0000 0x100>;
>> +	interrupts = <0 42 0>;
>> +	clocks = <&clock 336>;
>> +	clock-names = "watchdog";
>> +	samsung,sysreg = <&pmu_sys_reg>;
>
> Shouldn't it be samsung,syscon-phandle?
>
>> +	status = "okay";
>
> The status property is not a part of this binding, so can be dropped
> from the example.
>
>> +};
>> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
>> index 23aad7c..235d160 100644
>> --- a/drivers/watchdog/s3c2410_wdt.c
>> +++ b/drivers/watchdog/s3c2410_wdt.c
>> @@ -41,6 +41,8 @@
>>   #include <linux/slab.h>
>>   #include <linux/err.h>
>>   #include <linux/of.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>>
>>   #define S3C2410_WTCON		0x00
>>   #define S3C2410_WTDAT		0x04
>> @@ -61,6 +63,10 @@
>>   #define CONFIG_S3C2410_WATCHDOG_ATBOOT		(0)
>>   #define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME	(15)
>>
>> +#define WDT_DISABLE_REG_OFFSET		0x0408
>> +#define WDT_MASK_RESET_REG_OFFSET	0x040c
>> +#define QUIRK_NEEDS_PMU_CONFIG		(1 << 0)
>> +
>>   static bool nowayout	= WATCHDOG_NOWAYOUT;
>>   static int tmr_margin;
>>   static int tmr_atboot	= CONFIG_S3C2410_WATCHDOG_ATBOOT;
>> @@ -84,18 +90,61 @@ MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, "
>>   			"0 to reboot (default 0)");
>>   MODULE_PARM_DESC(debug, "Watchdog debug, set to >1 for debug (default 0)");
>>
>> +struct s3c2410_wdt_variant {
>> +	int	disable_reg;
>> +	int	mask_reset_reg;
>> +	int	mask_bit;
>> +	u32	quirks;
>
> nit: To avoid the need of changing the indentation in future, if fields
> with longer types gets added, I would simply separate type name from field
> name using a single space.
>
>> +};
>> +
>>   struct s3c2410_wdt {
>> -	struct device		*dev;
>> -	struct clk		*clock;
>> -	void __iomem		*reg_base;
>> -	unsigned int		count;
>> -	spinlock_t		lock;
>> -	unsigned long		wtcon_save;
>> -	unsigned long		wtdat_save;
>> -	struct watchdog_device	wdt_device;
>> -	struct notifier_block	freq_transition;
>> +	struct device			*dev;
>> +	struct clk			*clock;
>> +	void __iomem			*reg_base;
>> +	unsigned int			count;
>> +	spinlock_t			lock;
>> +	unsigned long			wtcon_save;
>> +	unsigned long			wtdat_save;
>> +	struct watchdog_device		wdt_device;
>> +	struct notifier_block		freq_transition;
>> +	struct s3c2410_wdt_variant	*pmu_config;
>> +	struct regmap			*pmureg;
>
> And here's an example of such (unnecessary) change. I believe it would
> be better to keep indendation of other fields as is, use single space for
> the new field and then change remaining fields in a separate patch,
> outside of this series.
>
>> +};
>> +
>> +#ifdef CONFIG_OF
>> +static struct s3c2410_wdt_variant pmu_config_s3c2410 = {
>
> static const struct
>
>> +	.disable_reg = 0x0,
>> +	.mask_reset_reg = 0x0,
>> +	.mask_bit = 0,
>
> nit: I would simply omit the three fields above, since they are irrelevant
> when QUIRK_NEEDS_PMU_CONFIG flag is not set. Not even saying that when
> unspecified, they default to zero.
>
checkpatch used to complain about that ... in general, static variables
should not be initialized to 0. That is just unnecessary extra code.

Guenter

>> +	.quirks = 0
>>   };
>>
>> +static struct s3c2410_wdt_variant pmu_config_5250  = {
>
> static const struct
>
>> +	.disable_reg = WDT_DISABLE_REG_OFFSET,
>> +	.mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
>> +	.mask_bit = 20,
>> +	.quirks = QUIRK_NEEDS_PMU_CONFIG
>> +};
>> +
>> +static struct s3c2410_wdt_variant pmu_config_5420 = {
>
> static const struct
>
>> +	.disable_reg = WDT_DISABLE_REG_OFFSET,
>> +	.mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
>> +	.mask_bit = 0,
>> +	.quirks = QUIRK_NEEDS_PMU_CONFIG
>> +};
>> +
>> +static const struct of_device_id s3c2410_wdt_match[] = {
>> +	{ .compatible = "samsung,s3c2410-wdt",
>> +	  .data = (struct s3c2410_wdt_variant *) &pmu_config_s3c2410 },
>
> No need for the cast.
>
>> +	{ .compatible = "samsung,exynos5250-wdt",
>> +	  .data = (struct s3c2410_wdt_variant *) &pmu_config_5250 },
>
> Ditto.
>
>> +	{ .compatible = "samsung,exynos5420-wdt",
>> +	  .data = (struct s3c2410_wdt_variant *) &pmu_config_5420 },
>
> Ditto.
>
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
>> +#endif
>> +
>>   /* watchdog control routines */
>>
>>   #define DBG(fmt, ...)					\
>> @@ -111,6 +160,47 @@ static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
>>   	return container_of(nb, struct s3c2410_wdt, freq_transition);
>>   }
>>
>> +static void s3c2410wdt_mask_and_disable_reset(int mask, struct s3c2410_wdt *wdt)
>
> This function should return int and propagate possible errors to the caller.
>
> Also the order of arguments is rather strange. The main context structure
> is usually passed as first argument.
>
> In addition, bool probably would make more sense for mask argument than int.
>
>> +{
>> +	int ret;
>> +
>> +	if (mask) {
>> +		ret = regmap_update_bits(wdt->pmureg,
>> +					wdt->pmu_config->disable_reg,
>> +					(1 << wdt->pmu_config->mask_bit),
>> +					(1 << wdt->pmu_config->mask_bit));
>> +		if (ret < 0) {
>> +			dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
>> +			return;
>> +		}
>> +		ret = regmap_update_bits(wdt->pmureg,
>> +					wdt->pmu_config->mask_reset_reg,
>> +					(1 << wdt->pmu_config->mask_bit),
>> +					(1 << wdt->pmu_config->mask_bit));
>> +		if (ret < 0) {
>> +			dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
>> +			return;
>> +		}
>> +	} else {
>> +		ret = regmap_update_bits(wdt->pmureg,
>> +					wdt->pmu_config->disable_reg,
>> +					(1 << wdt->pmu_config->mask_bit),
>> +					(0 << wdt->pmu_config->mask_bit));
>> +		if (ret < 0) {
>> +			dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
>> +			return;
>> +		}
>> +		ret = regmap_update_bits(wdt->pmureg,
>> +					wdt->pmu_config->mask_reset_reg,
>> +					(1 << wdt->pmu_config->mask_bit),
>> +					(0 << wdt->pmu_config->mask_bit));
>> +		if (ret < 0) {
>> +			dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
>> +			return;
>> +		}
>> +	}
>
> This is not really what I imagined. You can greatly simplify this code
> by refactoring it as follows:
>
> static int s3c2410wdt_mask_and_disable_reset(struct s3c2410_wdt *wdt, bool mask)
> {
> 	int ret;
> 	u32 mask_val = 1 << wdt->pmu_config->mask_bit;
> 	u32 val = 0;
>
> 	if (mask)
> 		val = mask_val;
>
> 	ret = regmap_update_bits(wdt->pmureg,
> 				wdt->pmu_config->disable_reg,
> 				mask_val, val);
> 	if (ret < 0) {
> 		dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
> 		return ret;
> 	}
>
> 	ret = regmap_update_bits(wdt->pmureg,
> 				wdt->pmu_config->mask_reset_reg,
> 				mask_val, val);
> 	if (ret < 0) {
> 		dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
> 		return ret;
> 	}
>
> 	return 0;
> }
>
>> +}
>> +
>>   static int s3c2410wdt_keepalive(struct watchdog_device *wdd)
>>   {
>>   	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
>> @@ -332,6 +422,15 @@ static inline void s3c2410wdt_cpufreq_deregister(struct s3c2410_wdt *wdt)
>>   }
>>   #endif
>>
>> +/* s3c2410_get_wdt_driver_data */
>> +static inline struct s3c2410_wdt_variant *
>
> const struct
>
>> +get_wdt_drv_data(struct platform_device *pdev)
>> +{
>> +	const struct of_device_id *match;
>> +	match = of_match_node(s3c2410_wdt_match, pdev->dev.of_node);
>> +	return (struct s3c2410_wdt_variant *)match->data;
>
> This function does not handle non-DT cases, which will cause a NULL pointer
> dereference when the device is instantiated from a board file.
>
>> +}
>> +
>>   static int s3c2410wdt_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev;
>> @@ -354,6 +453,16 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>>   	spin_lock_init(&wdt->lock);
>>   	wdt->wdt_device = s3c2410_wdd;
>>
>> +	wdt->pmu_config = (struct s3c2410_wdt_variant *) get_wdt_drv_data(pdev);
>
> No need for type cast here.
>
>> +	if (wdt->pmu_config->quirks & QUIRK_NEEDS_PMU_CONFIG) {
>> +		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
>> +							"samsung,syscon-phandle");
>> +		if (IS_ERR(wdt->pmureg)) {
>> +			dev_err(dev, "syscon regmap lookup failed.\n");
>> +			return PTR_ERR(wdt->pmureg);
>> +		}
>> +	}
>> +
>>   	wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>   	if (wdt_irq == NULL) {
>>   		dev_err(dev, "no irq resource specified\n");
>> @@ -444,6 +553,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>>   		 (wtcon & S3C2410_WTCON_RSTEN) ? "en" : "dis",
>>   		 (wtcon & S3C2410_WTCON_INTEN) ? "en" : "dis");
>>
>> +	if (wdt->pmu_config->quirks & QUIRK_NEEDS_PMU_CONFIG)
>> +		s3c2410wdt_mask_and_disable_reset(0, wdt);
>
> Error should be handled here. Also false would be better than 0 here.
>
>> +
>>   	return 0;
>>
>>    err_cpufreq:
>> @@ -461,6 +573,9 @@ static int s3c2410wdt_remove(struct platform_device *dev)
>>   {
>>   	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
>>
>> +	if (wdt->pmu_config->quirks & QUIRK_NEEDS_PMU_CONFIG)
>> +		s3c2410wdt_mask_and_disable_reset(1, wdt);
>
> Error should be handled here. Also true would be better than 1 here.
>
>> +
>>   	watchdog_unregister_device(&wdt->wdt_device);
>>
>>   	s3c2410wdt_cpufreq_deregister(wdt);
>> @@ -475,6 +590,9 @@ static void s3c2410wdt_shutdown(struct platform_device *dev)
>>   {
>>   	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
>>
>> +	if (wdt->pmu_config->quirks & QUIRK_NEEDS_PMU_CONFIG)
>> +		s3c2410wdt_mask_and_disable_reset(1, wdt);
>
> Error should be handled here. Also true would be better than 1 here.
>
>> +
>>   	s3c2410wdt_stop(&wdt->wdt_device);
>>   }
>>
>> @@ -488,6 +606,9 @@ static int s3c2410wdt_suspend(struct device *dev)
>>   	wdt->wtcon_save = readl(wdt->reg_base + S3C2410_WTCON);
>>   	wdt->wtdat_save = readl(wdt->reg_base + S3C2410_WTDAT);
>>
>> +	if (wdt->pmu_config->quirks & QUIRK_NEEDS_PMU_CONFIG)
>> +		s3c2410wdt_mask_and_disable_reset(1, wdt);
>
> Error should be handled here. Also true would be better than 1 here.
>
>> +
>>   	/* Note that WTCNT doesn't need to be saved. */
>>   	s3c2410wdt_stop(&wdt->wdt_device);
>>
>> @@ -503,6 +624,9 @@ static int s3c2410wdt_resume(struct device *dev)
>>   	writel(wdt->wtdat_save, wdt->reg_base + S3C2410_WTCNT);/* Reset count */
>>   	writel(wdt->wtcon_save, wdt->reg_base + S3C2410_WTCON);
>>
>> +	if (wdt->pmu_config->quirks & QUIRK_NEEDS_PMU_CONFIG)
>> +		s3c2410wdt_mask_and_disable_reset(0, wdt);
>
> Error should be handled here. Also false would be better than 0 here.
>
> Best regards,
> Tomasz
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

