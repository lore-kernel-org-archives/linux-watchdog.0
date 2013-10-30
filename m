Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:61780 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab3J3IJs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 04:09:48 -0400
MIME-Version: 1.0
In-Reply-To: <CAK9yfHyRVsRXo2K6YHeOXCtOiCXrojiqz1AJ5hOotEZ-Yk+xXw@mail.gmail.com>
References: <1383116025-5638-1-git-send-email-l.krishna@samsung.com>
 <1383116025-5638-3-git-send-email-l.krishna@samsung.com> <CAK9yfHyRVsRXo2K6YHeOXCtOiCXrojiqz1AJ5hOotEZ-Yk+xXw@mail.gmail.com>
From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Wed, 30 Oct 2013 13:39:25 +0530
Message-ID: <CAL1wa8dZdCgNJ-5X0kZ1GdQawdHE2hC94zo__pGS2hyGORDxHw@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: s3c2410_wdt: use syscon regmap interface to
 configure pmu register
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Tomasz Figa <t.figa@samsung.com>, devicetree@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org, cpgs@samsung.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sachin,

Thanks for reviewing the patch

On Wed, Oct 30, 2013 at 12:33 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> On 30 October 2013 12:23, Leela Krishna Amudala <l.krishna@samsung.com> wrote:
>> The syscon regmap interface is used to configure AUTOMATIC_WDT_RESET_DISABLE
>> and MASK_WDT_RESET_REQUEST registers of PMU to mask/unmask enable/disable of
>> watchdog in probe and s2r scenarios.
>>
>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> ---
>>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |   13 ++-
>>  drivers/watchdog/s3c2410_wdt.c                     |  114 ++++++++++++++++++--
>>  2 files changed, 118 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> index 2aa486c..c46c7ce 100644
>> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> @@ -5,10 +5,21 @@ after a preset amount of time during which the WDT reset event has not
>>  occurred.
>>
>>  Required properties:
>> -- compatible : should be "samsung,s3c2410-wdt"
>> +- compatible : should be "samsung,s3c2410-wdt" or "samsung,s3c5250-wdt" or "samsung,s3c5420-wdt"
>
> This should be written as "should be one among the following:
>                 (a) "samsung,s3c2410-wdt" for xyz SoC
>                 (b) ....
>                 (c) ...
>

Okay, will change it.

>>  - reg : base physical address of the controller and length of memory mapped
>>         region.
>>  - interrupts : interrupt number to the cpu.
>> +- samsung,pmusysreg : reference node to pmu sysreg (required only in case of Exynos5250 and 5420)
>
> This property is samsung,sysreg.
>

Okay, will keep this as it is and take care in driver

>>
>>  Optional properties:
>>  - timeout-sec : contains the watchdog timeout in seconds.
>> +
>> +watchdog@101D0000 {
>> +       compatible = "samsung,s3c5250-wdt";
>> +       reg = <0x101D0000 0x100>;
>> +       interrupts = <0 42 0>;
>> +       clocks = <&clock 336>;
>> +       clock-names = "watchdog";
>> +       samsung,sysreg = <&pmu_sys_reg>;
>> +       status = "okay";
>> +};
>> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
>> index 23aad7c..2a3429c 100644
>> --- a/drivers/watchdog/s3c2410_wdt.c
>> +++ b/drivers/watchdog/s3c2410_wdt.c
>> @@ -41,6 +41,8 @@
>>  #include <linux/slab.h>
>>  #include <linux/err.h>
>>  #include <linux/of.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>>
>>  #define S3C2410_WTCON          0x00
>>  #define S3C2410_WTDAT          0x04
>> @@ -61,6 +63,10 @@
>>  #define CONFIG_S3C2410_WATCHDOG_ATBOOT         (0)
>>  #define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME   (15)
>>
>> +#define WDT_DISABLE_REG_OFFSET         0x0408
>> +#define WDT_MASK_RESET_REG_OFFSET      0x040c
>> +#define QUIRK_NEEDS_PMU_CONFIG         (1 << 0)
>> +
>>  static bool nowayout   = WATCHDOG_NOWAYOUT;
>>  static int tmr_margin;
>>  static int tmr_atboot  = CONFIG_S3C2410_WATCHDOG_ATBOOT;
>> @@ -84,6 +90,12 @@ MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, "
>>                         "0 to reboot (default 0)");
>>  MODULE_PARM_DESC(debug, "Watchdog debug, set to >1 for debug (default 0)");
>>
>> +struct pmu_config {
>> +       int     disable_reg;
>> +       int     mask_reset_reg;
>> +       int     mask_bit;
>> +};
>> +
>>  struct s3c2410_wdt {
>>         struct device           *dev;
>>         struct clk              *clock;
>> @@ -94,7 +106,34 @@ struct s3c2410_wdt {
>>         unsigned long           wtdat_save;
>>         struct watchdog_device  wdt_device;
>>         struct notifier_block   freq_transition;
>> +       struct pmu_config       *wdt_pmu_config;
>> +       struct regmap           *pmureg;
>> +       unsigned int            quirks;
>> +};
>> +
>> +static struct pmu_config pmu_config_5250  = {
>> +       .disable_reg = WDT_DISABLE_REG_OFFSET,
>> +       .mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
>> +       .mask_bit = 20
>> +};
>> +
>> +static struct pmu_config pmu_config_5420 = {
>> +       .disable_reg = WDT_DISABLE_REG_OFFSET,
>> +       .mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
>> +       .mask_bit = 0
>> +};
>> +
>
> The above 2 structures could also be under ifdef CONFIG_OF
>

Okay, will move it

>> +#ifdef CONFIG_OF
>> +static const struct of_device_id s3c2410_wdt_match[] = {
>> +       { .compatible = "samsung,s3c2410-wdt" },
>> +       { .compatible = "samsung,s3c5250-wdt",
>> +         .data = (struct pmu_config *) &pmu_config_5250 },
>> +       { .compatible = "samsung,s3c5420-wdt",
>> +         .data = (struct pmu_config *) &pmu_config_5420 },
>> +       {},
>>  };
>> +MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
>> +#endif
>>
>>  /* watchdog control routines */
>>
>> @@ -111,6 +150,40 @@ static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
>>         return container_of(nb, struct s3c2410_wdt, freq_transition);
>>  }
>>
>> +static void s3c2410wdt_mask_and_disable_reset(int mask, struct s3c2410_wdt *wdt)
>> +{
>> +       unsigned int disable, mask_reset;
>> +       int ret;
>> +
>> +       ret = regmap_read(wdt->pmureg, wdt->wdt_pmu_config->disable_reg,
>> +                                                               &disable);
>> +       if (ret < 0) {
>> +               dev_err(wdt->dev, "%s:%d fail to read disable reg(%d)\n",
>> +                               __func__, __LINE__, ret);
>
> func and LINE does not add much value. Could be dropped.
>

Okay, will drop it

Best Wishes,
Leela Krishna

>> +               return;
>> +       }
>> +
>> +       ret = regmap_read(wdt->pmureg, wdt->wdt_pmu_config->mask_reset_reg,
>> +                                                               &mask_reset);
>> +       if (ret < 0) {
>> +               dev_err(wdt->dev, "%s:%d fail to read mask reset reg(%d)\n",
>> +                               __func__, __LINE__, ret);
>
> ditto
>
> --
> With warm regards,
> Sachin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
