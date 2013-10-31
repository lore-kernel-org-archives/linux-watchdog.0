Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:61255 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab3JaFcK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 31 Oct 2013 01:32:10 -0400
MIME-Version: 1.0
In-Reply-To: <3427382.I443SkGPfg@amdc1227>
References: <1383126673-29033-1-git-send-email-l.krishna@samsung.com>
 <1383126673-29033-4-git-send-email-l.krishna@samsung.com> <3427382.I443SkGPfg@amdc1227>
From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Thu, 31 Oct 2013 11:01:48 +0530
Message-ID: <CAL1wa8cT=DrTLGFcK=7BO7pGB=_rBQZz9OXYsozA8qs=vAHc+g@mail.gmail.com>
Subject: Re: [PATCH V4 3/3] watchdog: s3c2410_wdt: use syscon regmap interface
 to configure pmu register
To: Tomasz Figa <t.figa@samsung.com>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org, cpgs@samsung.com,
	Sachin Kamat <sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tomasz,

On Wed, Oct 30, 2013 at 8:09 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Leela,
>
> On Wednesday 30 of October 2013 15:21:13 Leela Krishna Amudala wrote:
>> The syscon regmap interface is used to configure AUTOMATIC_WDT_RESET_DISABLE
>> and MASK_WDT_RESET_REQUEST registers of PMU to mask/unmask enable/disable of
>> watchdog in probe and s2r scenarios.
>>
>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> ---
>>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |   19 +++-
>>  drivers/watchdog/s3c2410_wdt.c                     |  112 ++++++++++++++++++--
>>  2 files changed, 122 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> index 2aa486c..5a9889b 100644
>> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> @@ -5,10 +5,27 @@ after a preset amount of time during which the WDT reset event has not
>>  occurred.
>>
>>  Required properties:
>> -- compatible : should be "samsung,s3c2410-wdt"
>> +- compatible : should be one among the following
>> +     (a) "samsung,s3c2410-wdt" for Exynos4 and previous SoCs
>> +     (b) "samsung,exynos5250-wdt" for Exynos5250
>> +     (c) "samsung,exynos5420-wdt" for Exynos5420
>> +
>>  - reg : base physical address of the controller and length of memory mapped
>>       region.
>>  - interrupts : interrupt number to the cpu.
>> +- samsung,pmusysreg : reference node to pmu sysreg (required only in case of Exynos5250 and 5420)
>
> I don't really like the name of this property. Maybe
> samsung,syscon-phandle would be better?
>
Okay, changed.

> I'm not sure if this property should be tied to PMU, as on future SoCs
> those registers might be located in another syscon-style IP. The
> description should note that in case of Exynos 5250 and 5420 this should
> point to the PMU node, though.
>

Added

>>
>>  Optional properties:
>>  - timeout-sec : contains the watchdog timeout in seconds.
>> +
>> +Example:
>> +
>> +watchdog@101D0000 {
>> +     compatible = "samsung,exynos5250-wdt";
>> +     reg = <0x101D0000 0x100>;
>> +     interrupts = <0 42 0>;
>> +     clocks = <&clock 336>;
>> +     clock-names = "watchdog";
>> +     samsung,sysreg = <&pmu_sys_reg>;
>> +     status = "okay";
>> +};
>> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
>> index 23aad7c..d8aefef 100644
>> --- a/drivers/watchdog/s3c2410_wdt.c
>> +++ b/drivers/watchdog/s3c2410_wdt.c
>> @@ -41,6 +41,8 @@
>>  #include <linux/slab.h>
>>  #include <linux/err.h>
>>  #include <linux/of.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>>
>>  #define S3C2410_WTCON                0x00
>>  #define S3C2410_WTDAT                0x04
>> @@ -61,6 +63,10 @@
>>  #define CONFIG_S3C2410_WATCHDOG_ATBOOT               (0)
>>  #define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME (15)
>>
>> +#define WDT_DISABLE_REG_OFFSET               0x0408
>> +#define WDT_MASK_RESET_REG_OFFSET    0x040c
>> +#define QUIRK_NEEDS_PMU_CONFIG               (1 << 0)
>> +
>>  static bool nowayout = WATCHDOG_NOWAYOUT;
>>  static int tmr_margin;
>>  static int tmr_atboot        = CONFIG_S3C2410_WATCHDOG_ATBOOT;
>> @@ -84,6 +90,12 @@ MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, "
>>                       "0 to reboot (default 0)");
>>  MODULE_PARM_DESC(debug, "Watchdog debug, set to >1 for debug (default 0)");
>>
>> +struct pmu_config {
>
> For the sake of future extensibility I'd rename this struct to
> s3c2410_wdt_variant and add an u32 quirks field, which would has
> the QUIRK_NEEDS_PMU_CONFIG set for 5250 and 5420 variants.
>

Modified

>> +     int     disable_reg;
>> +     int     mask_reset_reg;
>> +     int     mask_bit;
>> +};
>> +
>>  struct s3c2410_wdt {
>>       struct device           *dev;
>>       struct clk              *clock;
>> @@ -94,7 +106,34 @@ struct s3c2410_wdt {
>>       unsigned long           wtdat_save;
>>       struct watchdog_device  wdt_device;
>>       struct notifier_block   freq_transition;
>> +     struct pmu_config       *wdt_pmu_config;
>> +     struct regmap           *pmureg;
>> +     unsigned int            quirks;
>
> Quirks should be a static per-variant property.
>

Taken care

>> +};
>> +
>> +#ifdef CONFIG_OF
>> +static struct pmu_config pmu_config_5250  = {
>> +     .disable_reg = WDT_DISABLE_REG_OFFSET,
>> +     .mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
>> +     .mask_bit = 20
>> +};
>> +
>> +static struct pmu_config pmu_config_5420 = {
>> +     .disable_reg = WDT_DISABLE_REG_OFFSET,
>> +     .mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
>> +     .mask_bit = 0
>> +};
>> +
>> +static const struct of_device_id s3c2410_wdt_match[] = {
>> +     { .compatible = "samsung,s3c2410-wdt" },
>
> If you follow what I suggested above, the basic variant would also have
> a variant struct associated with it, which would be more consistent.
>
>> +     { .compatible = "samsung,exynos5250-wdt",
>> +       .data = (struct pmu_config *) &pmu_config_5250 },
>> +     { .compatible = "samsung,exynos5420-wdt",
>> +       .data = (struct pmu_config *) &pmu_config_5420 },
>> +     {},
>>  };
>> +MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
>> +#endif
>>
>>  /* watchdog control routines */
>>
>> @@ -111,6 +150,38 @@ static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
>>       return container_of(nb, struct s3c2410_wdt, freq_transition);
>>  }
>>
>> +static void s3c2410wdt_mask_and_disable_reset(int mask, struct s3c2410_wdt *wdt)
>> +{
>> +     unsigned int disable, mask_reset;
>> +     int ret;
>> +
>> +     ret = regmap_read(wdt->pmureg, wdt->wdt_pmu_config->disable_reg,
>> +                                                             &disable);
>> +     if (ret < 0) {
>> +             dev_err(wdt->dev, "failed to read disable reg(%d)\n", ret);
>> +             return;
>> +     }
>> +
>> +     ret = regmap_read(wdt->pmureg, wdt->wdt_pmu_config->mask_reset_reg,
>> +                                                             &mask_reset);
>> +     if (ret < 0) {
>> +             dev_err(wdt->dev, "failed to read mask reset reg(%d)\n", ret);
>> +             return;
>> +     }
>> +
>> +     if (mask) {
>> +             disable |= (1 << wdt->wdt_pmu_config->mask_bit);
>> +             mask_reset |= (1 << wdt->wdt_pmu_config->mask_bit);
>> +     } else {
>> +             disable &= ~(1 << wdt->wdt_pmu_config->mask_bit);
>> +             mask_reset &= ~(1 << wdt->wdt_pmu_config->mask_bit);
>> +     }
>> +
>> +     regmap_write(wdt->pmureg, wdt->wdt_pmu_config->disable_reg, disable);
>> +     regmap_write(wdt->pmureg, wdt->wdt_pmu_config->mask_reset_reg,
>> +                                                             mask_reset);
>
> I believe you can (and on some SoCs even have to, due to other bits in the
> registers being used for other purposes) use regmap_update_bits() for
> read-modify-write sequences above.
>

Okay, Modified

>> +}
>> +
>>  static int s3c2410wdt_keepalive(struct watchdog_device *wdd)
>>  {
>>       struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
>> @@ -332,6 +403,14 @@ static inline void s3c2410wdt_cpufreq_deregister(struct s3c2410_wdt *wdt)
>>  }
>>  #endif
>>
>> +/* s3c2410_get_wdt_driver_data */
>> +static inline unsigned int get_wdt_driver_data(struct platform_device *pdev)
>> +{
>> +     const struct of_device_id *match;
>> +     match = of_match_node(s3c2410_wdt_match, pdev->dev.of_node);
>> +     return (unsigned int)match->data;
>
> Why do you need this cast? I believe this function should simply return
> (const struct pmu_config *) or (const struct s3c2410_wdt_variant *) when
> my comments above get addressed.
>

My mistake, Changed

>> +}
>> +
>>  static int s3c2410wdt_probe(struct platform_device *pdev)
>>  {
>>       struct device *dev;
>> @@ -354,6 +433,17 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>>       spin_lock_init(&wdt->lock);
>>       wdt->wdt_device = s3c2410_wdd;
>>
>> +     wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
>> +                                             "samsung,pmusysreg");
>> +     if (IS_ERR(wdt->pmureg)) {
>> +             dev_err(dev, "syscon regmap lookup failed.\n");
>> +             return PTR_ERR(wdt->pmureg);
>> +     }
>
> This should be performed only if given variant has the
> QUIRK_NEEDS_PMU_CONFIG flag set in its variant data. Otherwise you don't
> have any distinction between cases when PMU is not needed (and so
> unspecified) and PMU is needed, but unspecified.
>

Okay, Taken care

>> +
>> +     wdt->wdt_pmu_config = (struct pmu_config *) get_wdt_driver_data(pdev);
>> +     if (wdt->wdt_pmu_config)
>> +             wdt->quirks = QUIRK_NEEDS_PMU_CONFIG;
>
> See my comment on quirks above.
>
>> +
>>       wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>       if (wdt_irq == NULL) {
>>               dev_err(dev, "no irq resource specified\n");
>> @@ -444,6 +534,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>>                (wtcon & S3C2410_WTCON_RSTEN) ? "en" : "dis",
>>                (wtcon & S3C2410_WTCON_INTEN) ? "en" : "dis");
>>
>> +     if (wdt->quirks & QUIRK_NEEDS_PMU_CONFIG)
>> +             s3c2410wdt_mask_and_disable_reset(0, wdt);
>
> nit: Blank line here would be nice.
>

Done.

Best Wishes,
Leela Krishna

> Best regards,
> Tomasz
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
