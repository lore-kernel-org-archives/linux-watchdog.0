Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:56275 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab3KSHCc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Nov 2013 02:02:32 -0500
Message-ID: <528B0D06.9080903@roeck-us.net>
Date: Mon, 18 Nov 2013 23:02:30 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Leela Krishna Amudala <l.krishna@samsung.com>
CC: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Tomasz Figa <t.figa@samsung.com>, devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org, cpgs@samsung.com,
	Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH V9 2/3] watchdog: s3c2410_wdt: use syscon regmap interface
 to configure pmu register
References: <1384768189-2839-1-git-send-email-l.krishna@samsung.com> <1384768189-2839-3-git-send-email-l.krishna@samsung.com> <20131118164203.GA15902@roeck-us.net> <CAL1wa8d7=60KB_Km0dkjDZeLP2Get7h-8EKE_T9qQ2JGG_js8g@mail.gmail.com> <528AF077.8000307@roeck-us.net> <CAL1wa8eXDfP3Swfx-LmNxt7MJBAjFYKHuQmiioX+Vs9aJW8giA@mail.gmail.com>
In-Reply-To: <CAL1wa8eXDfP3Swfx-LmNxt7MJBAjFYKHuQmiioX+Vs9aJW8giA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/18/2013 09:26 PM, Leela Krishna Amudala wrote:
> Hi Guenter Roeck,
>
> On Tue, Nov 19, 2013 at 10:30 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 11/18/2013 08:36 PM, Leela Krishna Amudala wrote:
>>>
>>> Hi Guenter Roeck,
>>>
>>> Thanks for reviewing the patch.
>>>
>>>
>>> On Mon, Nov 18, 2013 at 10:12 PM, Guenter Roeck <linux@roeck-us.net>
>>> wrote:
>>>>
>>>> On Mon, Nov 18, 2013 at 03:19:48PM +0530, Leela Krishna Amudala wrote:
>>>>>
>>>>> Add device tree support for exynos5250 and 5420 SoCs and use syscon
>>>>> regmap interface
>>>>> to configure AUTOMATIC_WDT_RESET_DISABLE and MASK_WDT_RESET_REQUEST
>>>>> registers of PMU
>>>>> to mask/unmask enable/disable of watchdog in probe and s2r scenarios.
>>>>>
>>>>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>>>>> ---
>>>>>    .../devicetree/bindings/watchdog/samsung-wdt.txt   |   21 ++-
>>>>>    drivers/watchdog/Kconfig                           |    1 +
>>>>>    drivers/watchdog/s3c2410_wdt.c                     |  145
>>>>> ++++++++++++++++++--
>>>>>    3 files changed, 157 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>>>>> b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>>>>> index 2aa486c..5dea363 100644
>>>>> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>>>>> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>>>>> @@ -5,10 +5,29 @@ after a preset amount of time during which the WDT
>>>>> reset event has not
>>>>>    occurred.
>>>>>
>>>>>    Required properties:
>>>>> -- compatible : should be "samsung,s3c2410-wdt"
>>>>> +- compatible : should be one among the following
>>>>> +     (a) "samsung,s3c2410-wdt" for Exynos4 and previous SoCs
>>>>> +     (b) "samsung,exynos5250-wdt" for Exynos5250
>>>>> +     (c) "samsung,exynos5420-wdt" for Exynos5420
>>>>> +
>>>>>    - reg : base physical address of the controller and length of memory
>>>>> mapped
>>>>>         region.
>>>>>    - interrupts : interrupt number to the cpu.
>>>>> +- samsung,syscon-phandle : reference to syscon node (This property
>>>>> required only
>>>>> +     in case of compatible being "samsung,exynos5250-wdt" or
>>>>> "samsung,exynos5420-wdt".
>>>>> +     In case of Exynos5250 and 5420 this property points to syscon node
>>>>> holding the PMU
>>>>> +     base address)
>>>>>
>>>>>    Optional properties:
>>>>>    - timeout-sec : contains the watchdog timeout in seconds.
>>>>> +
>>>>> +Example:
>>>>> +
>>>>> +watchdog@101D0000 {
>>>>> +     compatible = "samsung,exynos5250-wdt";
>>>>> +     reg = <0x101D0000 0x100>;
>>>>> +     interrupts = <0 42 0>;
>>>>> +     clocks = <&clock 336>;
>>>>> +     clock-names = "watchdog";
>>>>> +     samsung,syscon-phandle = <&pmu_sys_reg>;
>>>>> +};
>>>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>>>> index d1d53f3..0d272ae 100644
>>>>> --- a/drivers/watchdog/Kconfig
>>>>> +++ b/drivers/watchdog/Kconfig
>>>>> @@ -188,6 +188,7 @@ config S3C2410_WATCHDOG
>>>>>         tristate "S3C2410 Watchdog"
>>>>>         depends on HAVE_S3C2410_WATCHDOG
>>>>>         select WATCHDOG_CORE
>>>>> +     select MFD_SYSCON if ARCH_EXYNOS5
>>>>>         help
>>>>>           Watchdog timer block in the Samsung SoCs. This will reboot
>>>>>           the system when the timer expires with the watchdog enabled.
>>>>> diff --git a/drivers/watchdog/s3c2410_wdt.c
>>>>> b/drivers/watchdog/s3c2410_wdt.c
>>>>> index 23aad7c..42e0fd3 100644
>>>>> --- a/drivers/watchdog/s3c2410_wdt.c
>>>>> +++ b/drivers/watchdog/s3c2410_wdt.c
>>>>> @@ -41,6 +41,8 @@
>>>>>    #include <linux/slab.h>
>>>>>    #include <linux/err.h>
>>>>>    #include <linux/of.h>
>>>>> +#include <linux/mfd/syscon.h>
>>>>> +#include <linux/regmap.h>
>>>>>
>>>>>    #define S3C2410_WTCON                0x00
>>>>>    #define S3C2410_WTDAT                0x04
>>>>> @@ -61,6 +63,10 @@
>>>>>    #define CONFIG_S3C2410_WATCHDOG_ATBOOT               (0)
>>>>>    #define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME (15)
>>>>>
>>>>> +#define WDT_DISABLE_REG_OFFSET               0x0408
>>>>> +#define WDT_MASK_RESET_REG_OFFSET    0x040c
>>>>> +#define QUIRK_NEEDS_PMU_CONFIG               (1 << 0)
>>>>> +
>>>>>    static bool nowayout = WATCHDOG_NOWAYOUT;
>>>>>    static int tmr_margin;
>>>>>    static int tmr_atboot        = CONFIG_S3C2410_WATCHDOG_ATBOOT;
>>>>> @@ -84,6 +90,13 @@ MODULE_PARM_DESC(soft_noboot, "Watchdog action, set
>>>>> to 1 to ignore reboots, "
>>>>>                         "0 to reboot (default 0)");
>>>>>    MODULE_PARM_DESC(debug, "Watchdog debug, set to >1 for debug (default
>>>>> 0)");
>>>>>
>>>>> +struct s3c2410_wdt_variant {
>>>>> +     int disable_reg;
>>>>> +     int mask_reset_reg;
>>>>> +     int mask_bit;
>>>>> +     u32 quirks;
>>>>> +};
>>>>> +
>>>>>    struct s3c2410_wdt {
>>>>>         struct device           *dev;
>>>>>         struct clk              *clock;
>>>>> @@ -94,7 +107,49 @@ struct s3c2410_wdt {
>>>>>         unsigned long           wtdat_save;
>>>>>         struct watchdog_device  wdt_device;
>>>>>         struct notifier_block   freq_transition;
>>>>> +     struct s3c2410_wdt_variant *drv_data;
>>>>> +     struct regmap *pmureg;
>>>>> +};
>>>>> +
>>>>> +static const struct s3c2410_wdt_variant drv_data_s3c2410 = {
>>>>> +     .quirks = 0
>>>>> +};
>>>>> +
>>>>> +#ifdef CONFIG_OF
>>>>> +static const struct s3c2410_wdt_variant drv_data_exynos5250  = {
>>>>> +     .disable_reg = WDT_DISABLE_REG_OFFSET,
>>>>> +     .mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
>>>>> +     .mask_bit = 20,
>>>>> +     .quirks = QUIRK_NEEDS_PMU_CONFIG
>>>>> +};
>>>>> +
>>>>> +static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
>>>>> +     .disable_reg = WDT_DISABLE_REG_OFFSET,
>>>>> +     .mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
>>>>> +     .mask_bit = 0,
>>>>> +     .quirks = QUIRK_NEEDS_PMU_CONFIG
>>>>> +};
>>>>> +
>>>>> +static const struct of_device_id s3c2410_wdt_match[] = {
>>>>> +     { .compatible = "samsung,s3c2410-wdt",
>>>>> +       .data = &drv_data_s3c2410 },
>>>>> +     { .compatible = "samsung,exynos5250-wdt",
>>>>> +       .data = &drv_data_exynos5250 },
>>>>> +     { .compatible = "samsung,exynos5420-wdt",
>>>>> +       .data = &drv_data_exynos5420 },
>>>>> +     {},
>>>>>    };
>>>>> +MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
>>>>> +#endif
>>>>> +
>>>>> +static const struct platform_device_id s3c2410_wdt_ids[] = {
>>>>> +     {
>>>>> +             .name = "s3c2410-wdt",
>>>>> +             .driver_data = (unsigned long)&drv_data_s3c2410,
>>>>> +     },
>>>>> +     {}
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(platform, s3c2410_wdt_ids);
>>>>>
>>>>>    /* watchdog control routines */
>>>>>
>>>>> @@ -111,6 +166,26 @@ static inline struct s3c2410_wdt
>>>>> *freq_to_wdt(struct notifier_block *nb)
>>>>>         return container_of(nb, struct s3c2410_wdt, freq_transition);
>>>>>    }
>>>>>
>>>>> +static int s3c2410wdt_mask_and_disable_reset(struct s3c2410_wdt *wdt,
>>>>> bool mask)
>>>>> +{
>>>>> +     int ret;
>>>>> +     u32 mask_val = 1 << wdt->drv_data->mask_bit;
>>>>> +     u32 val = 0;
>>>>> +
>>>>> +     if (mask)
>>>>> +             val = mask_val;
>>>>> +
>>>>> +     ret = regmap_update_bits(wdt->pmureg,
>>>>> +                     wdt->drv_data->disable_reg,
>>>>> +                     mask_val, val);
>>>>> +     if (ret < 0)
>>>>> +             return ret;
>>>>> +
>>>>> +     return regmap_update_bits(wdt->pmureg,
>>>>> +                     wdt->drv_data->mask_reset_reg,
>>>>> +                     mask_val, val);
>>>>> +}
>>>>> +
>>>>>    static int s3c2410wdt_keepalive(struct watchdog_device *wdd)
>>>>>    {
>>>>>         struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
>>>>> @@ -332,6 +407,20 @@ static inline void
>>>>> s3c2410wdt_cpufreq_deregister(struct s3c2410_wdt *wdt)
>>>>>    }
>>>>>    #endif
>>>>>
>>>>> +/* s3c2410_get_wdt_driver_data */
>>>>> +static inline struct s3c2410_wdt_variant *
>>>>> +get_wdt_drv_data(struct platform_device *pdev)
>>>>> +{
>>>>> +     if (pdev->dev.of_node) {
>>>>> +             const struct of_device_id *match;
>>>>> +             match = of_match_node(s3c2410_wdt_match,
>>>>> pdev->dev.of_node);
>>>>> +             return (struct s3c2410_wdt_variant *)match->data;
>>>>> +     } else {
>>>>> +             return (struct s3c2410_wdt_variant *)
>>>>> +                     platform_get_device_id(pdev)->driver_data;
>>>>> +     }
>>>>> +}
>>>>> +
>>>>>    static int s3c2410wdt_probe(struct platform_device *pdev)
>>>>>    {
>>>>>         struct device *dev;
>>>>> @@ -354,6 +443,16 @@ static int s3c2410wdt_probe(struct platform_device
>>>>> *pdev)
>>>>>         spin_lock_init(&wdt->lock);
>>>>>         wdt->wdt_device = s3c2410_wdd;
>>>>>
>>>>> +     wdt->drv_data = get_wdt_drv_data(pdev);
>>>>> +     if (wdt->drv_data->quirks & QUIRK_NEEDS_PMU_CONFIG) {
>>>>> +             wdt->pmureg =
>>>>> syscon_regmap_lookup_by_phandle(dev->of_node,
>>>>> +
>>>>> "samsung,syscon-phandle");
>>>>> +             if (IS_ERR(wdt->pmureg)) {
>>>>> +                     dev_err(dev, "syscon regmap lookup failed.\n");
>>>>> +                     return PTR_ERR(wdt->pmureg);
>>>>> +             }
>>>>> +     }
>>>>> +
>>>>>         wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>>>>         if (wdt_irq == NULL) {
>>>>>                 dev_err(dev, "no irq resource specified\n");
>>>>> @@ -444,6 +543,14 @@ static int s3c2410wdt_probe(struct platform_device
>>>>> *pdev)
>>>>>                  (wtcon & S3C2410_WTCON_RSTEN) ? "en" : "dis",
>>>>>                  (wtcon & S3C2410_WTCON_INTEN) ? "en" : "dis");
>>>>>
>>>>> +     if (wdt->drv_data->quirks & QUIRK_NEEDS_PMU_CONFIG) {
>>>>> +             ret = s3c2410wdt_mask_and_disable_reset(wdt, false);
>>>>> +             if (ret < 0) {
>>>>> +                     dev_err(wdt->dev, "failed to update pmu
>>>>> register");
>>>>
>>>>
>>>> Hmm ... still not happy ;-). This message is the same for each call
>>>> to s3c2410wdt_mask_and_disable_reset(). Why not create it there ?
>>>> Sure, you'd have to decide if you want to use dev_warn() or dev_err(),
>>>> but that would still be better than repeating the same message (and code)
>>>> five times.
>>>>
>>>> The same is true for the if() statement. It might be worthwhile calling
>>>> s3c2410wdt_mask_and_disable_reset() unconditionally and adding something
>>>> like
>>>>
>>>>           if (!(wdt->drv_data->quirks & QUIRK_NEEDS_PMU_CONFIG))
>>>>                   return 0;
>>>>
>>>> to it.
>>>>
>>>
>>> As Tomasz Figa suggested I handled the error conditions here
>>> Please go through this link for your reference
>>> https://patchwork.kernel.org/patch/3118771/
>>>
>>
>> His proposed function had the error message in the function,
>> so I am not entirely following your logic.
>>
>> He said you should _handle_ the error condition in the calling code.
>> Dumping an error message and doing nothing isn't really "handling"
>> the error condition.
>>
>
> I know printing an error message is not really "handling" the error condition.
> But apart from probe function I don't have anything to handle in remove,
> shutdown, suspend and resume functions.
> In remove, shutdown, suspend funtions I must do stop/deregister
> the device even if regmap_update_bits fails so I simply do dev_warn
> and continuing
>
> So I removed the error message prints in the s3c2410wdt_mask_and_disable_reset
> function and added it in the above mentioned functions as part of
> error handling.
>

That doesn't make sense to me. I'll leave it up to Wim to decide how to handle this patch.

Guenter

