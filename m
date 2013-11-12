Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37988 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab3KLGBU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Nov 2013 01:01:20 -0500
MIME-Version: 1.0
In-Reply-To: <1730902.jenppXSjOg@flatron>
References: <1384173897-16106-1-git-send-email-l.krishna@samsung.com>
 <1384173897-16106-4-git-send-email-l.krishna@samsung.com> <1730902.jenppXSjOg@flatron>
From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Tue, 12 Nov 2013 11:30:58 +0530
Message-ID: <CAL1wa8dM0aPVyAwkhQAnLpY6DM5Akv=8JxhvZE=b7sLxjQ-7Og@mail.gmail.com>
Subject: Re: [PATCH V7 3/3] watchdog: s3c2410_wdt: add device tree support and
 use syscon regmap interface to configure pmu register
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Tomasz Figa <t.figa@samsung.com>, devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org, cpgs@samsung.com,
	Sachin Kamat <sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tomasz,

Thanks for reviewing the patch

On Mon, Nov 11, 2013 at 6:53 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Leela,
>
> Thanks for addressing my comments for previous version. However now this
> won't even build when CONFIG_OF is disabled. See my comments inline.
>

Yes, you are right, I didn't compile it disabling CONFIG_OF

> On Monday 11 of November 2013 18:14:57 Leela Krishna Amudala wrote:
>> Add device tree support and use syscon regmap interface to configure
>> AUTOMATIC_WDT_RESET_DISABLE and MASK_WDT_RESET_REQUEST registers of PMU
>> to mask/unmask enable/disable of watchdog in probe and s2r scenarios.
>>
>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> ---
>>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |   21 ++-
>>  drivers/watchdog/Kconfig                           |    1 +
>>  drivers/watchdog/s3c2410_wdt.c                     |  154 +++++++++++++++++++-
>>  3 files changed, 167 insertions(+), 9 deletions(-)
> [snip]
>> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
>> index 23aad7c..b57ccae 100644
>> --- a/drivers/watchdog/s3c2410_wdt.c
>> +++ b/drivers/watchdog/s3c2410_wdt.c
> [snip]
>> @@ -94,8 +107,56 @@ struct s3c2410_wdt {
>>       unsigned long           wtdat_save;
>>       struct watchdog_device  wdt_device;
>>       struct notifier_block   freq_transition;
>> +     struct s3c2410_wdt_variant *pmu_config;
>> +     struct regmap *pmureg;
>> +};
>> +
>> +#ifdef CONFIG_OF
>> +static const struct s3c2410_wdt_variant pmu_config_s3c2410 = {
>> +     .quirks = 0
>> +};
>> +
>> +static const struct s3c2410_wdt_variant pmu_config_5250  = {
>> +     .disable_reg = WDT_DISABLE_REG_OFFSET,
>> +     .mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
>> +     .mask_bit = 20,
>> +     .quirks = QUIRK_NEEDS_PMU_CONFIG
>>  };
>>
>> +static const struct s3c2410_wdt_variant pmu_config_5420 = {
>> +     .disable_reg = WDT_DISABLE_REG_OFFSET,
>> +     .mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
>> +     .mask_bit = 0,
>> +     .quirks = QUIRK_NEEDS_PMU_CONFIG
>> +};
>
> The three variant data structs above are under #ifdef CONFIG_OF, while
> they are always needed for the platform match table.
>
> However, since Exynos supports only DT-based device instantation,
> I would move only the basic pmu_config_s3c2410 out of the ifdef and
> limit the platform match table only to this single variant.
>

Okay, Taken care

>> +
>> +static const struct of_device_id s3c2410_wdt_match[] = {
>> +     { .compatible = "samsung,s3c2410-wdt",
>> +       .data = &pmu_config_s3c2410 },
>> +     { .compatible = "samsung,exynos5250-wdt",
>> +       .data = &pmu_config_5250 },
>> +     { .compatible = "samsung,exynos5420-wdt",
>> +       .data = &pmu_config_5420 },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
>> +#endif
>> +
>> +static const struct platform_device_id s3c_wdt_driver_ids[] = {
>
> nit: For consistency with other names in this file, what about
> calling this s3c2410_wdt_ids[] instead?
>

Okay, modified

>> +     {
>> +             .name = "s3c2410-wdt",
>> +             .driver_data = (unsigned long)&pmu_config_s3c2410,
>> +     }, {
>> +             .name = "exynos5250-wdt",
>> +             .driver_data = (unsigned long)&pmu_config_5250,
>> +     }, {
>> +             .name = "exynos5420-wdt",
>> +             .driver_data = (unsigned long)&pmu_config_5420,
>> +     },
>
> So, generally, you don't need the two Exynos variants above in this array.
>

Yes, removed from the array

Best Wishes,
Leela Krishna

> Otherwise, the patch is fine.
>
> Best regards,
> Tomasz
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
