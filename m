Return-path: <Joshua.Henderson@microchip.com>
Subject: Re: [PATCH v2 2/2] watchdog: pic32-wdt: Add PIC32 watchdog driver
To: Guenter Roeck <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>
References: <1456424846-24409-2-git-send-email-joshua.henderson@microchip.com>
 <56D05BE0.8020609@roeck-us.net>
CC: <linux-mips@linux-mips.org>, <ralf@linux-mips.org>, Purna Chandra Mandal
	<purna.mandal@microchip.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll
	<pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Wim Van
 Sebroeck <wim@iguana.be>, <devicetree@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>
From: Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <56D08823.2020709@microchip.com>
Date: Fri, 26 Feb 2016 10:15:15 -0700
MIME-Version: 1.0
In-Reply-To: <56D05BE0.8020609@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Guenter,

On 02/26/2016 07:06 AM, Guenter Roeck wrote:
> On 02/25/2016 10:27 AM, Joshua Henderson wrote:
>> Add support for the watchdog peripheral found on PIC32 class
>> devices.
>>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> ---
>> Note: Please merge this patch series through the MIPS tree.
>>
>> Changes since v1:
>>     - Shorten commit description
>>     - Don't default to y in Kconfig
>>     - Alphabetical ordering of includes
>>     - Use BIT() where applicable
>>     - Use consistent function name prefixes
>>     - Inline some single use functions
>>     - Use a return of bool when appropriate
>>     - Replace cpu_relax() with nop and explain why this is needed
>>     - Better error handling, especially to prevent divide by zero
>>     - Remove unecessary pr_info().
>>     - Remove redudant driver spinlock which is already covered by
>>       watchdog core
>>     - Drop .get_timeleft implementation
>>     - Fix typo in compatibility flag and driver name
>>     - Remove wdt->timeout variable and calculation
>>     - Fix race condition in watchdog driver registration
>> ---
>>   drivers/watchdog/Kconfig     |   13 +++
>>   drivers/watchdog/Makefile    |    1 +
>>   drivers/watchdog/pic32-wdt.c |  264 ++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 278 insertions(+)
>>   create mode 100644 drivers/watchdog/pic32-wdt.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 0f6d851..543fa81 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1414,6 +1414,19 @@ config MT7621_WDT
>>       help
>>         Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
>>
>> +config PIC32_WDT
>> +    tristate "Microchip PIC32 hardware watchdog"
>> +    select WATCHDOG_CORE
>> +    depends on MACH_PIC32
>> +    help
>> +      Watchdog driver for the built in watchdog hardware in a PIC32.
>> +
>> +      Configuration bits must be set appropriately for the watchdog to be
>> +      controlled by this driver.
>> +
>> +      To compile this driver as a loadable module, choose M here.
>> +      The module will be called pic32-wdt.
>> +
>>   # PARISC Architecture
>>
>>   # POWERPC Architecture
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index f566753..244ed80 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -153,6 +153,7 @@ obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
>>   obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
>>   obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
>>   obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
>> +obj-$(CONFIG_PIC32_WDT) += pic32-wdt.o
>>
>>   # PARISC Architecture
>>
>> diff --git a/drivers/watchdog/pic32-wdt.c b/drivers/watchdog/pic32-wdt.c
>> new file mode 100644
>> index 0000000..caec459
>> --- /dev/null
>> +++ b/drivers/watchdog/pic32-wdt.c
>> @@ -0,0 +1,264 @@
>> +/*
>> + * PIC32 watchdog driver
>> + *
>> + * Joshua Henderson <joshua.henderson@microchip.com>
>> + * Copyright (c) 2016, Microchip Technology Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm.h>
>> +#include <linux/watchdog.h>
>> +
>> +#include <asm/mach-pic32/pic32.h>
>> +
>> +/* Watchdog Timer Registers */
>> +#define WDTCON_REG        0x00
>> +
>> +/* Watchdog Timer Control Register fields */
>> +#define WDTCON_WIN_EN        BIT(0)
>> +#define WDTCON_RMCS_MASK    0x0003
>> +#define WDTCON_RMCS_SHIFT    0x0006
>> +#define WDTCON_RMPS_MASK    0x001F
>> +#define WDTCON_RMPS_SHIFT    0x0008
>> +#define WDTCON_ON        BIT(15)
>> +#define WDTCON_CLR_KEY        0x5743
>> +
>> +/* Reset Control Register fields for watchdog */
>> +#define RESETCON_TIMEOUT_IDLE    BIT(2)
>> +#define RESETCON_TIMEOUT_SLEEP    BIT(3)
>> +#define RESETCON_WDT_TIMEOUT    BIT(4)
>> +
>> +struct pic32_wdt {
>> +    void __iomem    *regs;
>> +    void __iomem    *rst_base;
>> +    struct clk    *clk;
>> +};
>> +
>> +static inline bool pic32_wdt_is_win_enabled(struct pic32_wdt *wdt)
>> +{
>> +    return !!(readl(wdt->regs + WDTCON_REG) & WDTCON_WIN_EN);
>> +}
>> +
>> +static inline u32 pic32_wdt_get_post_scaler(struct pic32_wdt *wdt)
>> +{
>> +    u32 v = readl(wdt->regs + WDTCON_REG);
>> +
>> +    return (v >> WDTCON_RMPS_SHIFT) & WDTCON_RMPS_MASK;
>> +}
>> +
>> +static inline u32 pic32_wdt_get_clk_id(struct pic32_wdt *wdt)
>> +{
>> +    u32 v = readl(wdt->regs + WDTCON_REG);
>> +
>> +    return (v >> WDTCON_RMCS_SHIFT) & WDTCON_RMCS_MASK;
>> +}
>> +
>> +static int pic32_wdt_bootstatus(struct pic32_wdt *wdt)
>> +{
>> +    u32 v = readl(wdt->rst_base);
>> +
>> +    writel(RESETCON_WDT_TIMEOUT, PIC32_CLR(wdt->rst_base));
>> +
>> +    return v & RESETCON_WDT_TIMEOUT;
>> +}
>> +
>> +static int pic32_wdt_get_timeout_secs(struct pic32_wdt *wdt)
>> +{
>> +    unsigned long rate;
>> +    u32 period, ps, terminal;
>> +
>> +    rate = clk_get_rate(wdt->clk);
>> +    if (!rate)
>> +        return 0;
>> +
>> +    pr_debug("wdt: clk_id %d, clk_rate %lu (prescale)\n",
>> +         pic32_wdt_get_clk_id(wdt), rate);
>> +
> 
> Please pass 'dev' as argument and use dev_dbg().
> Then you can also remove the #define pr_fmt above.

Ack.

> 
>> +    /* default, prescaler of 32 (i.e. div-by-32) is implicit. */
>> +    rate >>= 5;
> 
> Instead of checking rate for 0 above, it might make more sense
> to check if it is 0 here.

Ack.

> 
>> +
>> +    /* calculate terminal count from postscaler. */
>> +    ps = pic32_wdt_get_post_scaler(wdt);
>> +    terminal = BIT(ps);
>> +
>> +    /* find time taken (in secs) to reach terminal count */
>> +    period = terminal / rate;
> 
> With ps == 31, and rate == 1, the period would end up being 0x80000000,
> or negative. Not that it matters (it is assigned to an unsigned on return),
> but for consistency it might be better to return an unsigned int.

Makes sense.

> 
>> +    pr_debug("wdt: clk_rate %lu (postscale) / terminal %d, timeout %dsec\n",
>> +         rate, terminal, period);
>> +
>> +    return period;
>> +}
>> +
>> +static void pic32_wdt_keepalive(struct pic32_wdt *wdt)
>> +{
>> +    /* write key through single half-word */
>> +    writew(WDTCON_CLR_KEY, wdt->regs + WDTCON_REG + 2);
>> +}
>> +
>> +static int pic32_wdt_start(struct watchdog_device *wdd)
>> +{
>> +    struct pic32_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +    writel(WDTCON_ON, PIC32_SET(wdt->regs + WDTCON_REG));
>> +    pic32_wdt_keepalive(wdt);
>> +
>> +    return 0;
>> +}
>> +
>> +static int pic32_wdt_stop(struct watchdog_device *wdd)
>> +{
>> +    struct pic32_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +    writel(WDTCON_ON, PIC32_CLR(wdt->regs + WDTCON_REG));
>> +    /*
>> +     * Cannot touch registers in the CPU cycle following clearing the
>> +     * ON bit.
>> +     */
>> +    nop();
>> +
>> +    return 0;
>> +}
>> +
>> +static int pic32_wdt_ping(struct watchdog_device *wdd)
>> +{
>> +    struct pic32_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +    pic32_wdt_keepalive(wdt);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct watchdog_ops pic32_wdt_fops = {
>> +    .owner        = THIS_MODULE,
>> +    .start        = pic32_wdt_start,
>> +    .stop        = pic32_wdt_stop,
>> +    .ping        = pic32_wdt_ping,
>> +};
>> +
>> +static const struct watchdog_info pic32_wdt_ident = {
>> +    .options = WDIOF_KEEPALIVEPING |
>> +            WDIOF_MAGICCLOSE | WDIOF_CARDRESET,
>> +    .identity = "PIC32 Watchdog",
>> +};
>> +
>> +static struct watchdog_device pic32_wdd = {
>> +    .info        = &pic32_wdt_ident,
>> +    .ops        = &pic32_wdt_fops,
>> +};
>> +
>> +static const struct of_device_id pic32_wdt_dt_ids[] = {
>> +    { .compatible = "microchip,pic32mzda-wdt", },
>> +    { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, pic32_wdt_dt_ids);
>> +
>> +static int pic32_wdt_drv_probe(struct platform_device *pdev)
>> +{
>> +    int ret;
>> +    struct watchdog_device *wdd = &pic32_wdd;
>> +    struct pic32_wdt *wdt;
>> +    struct resource *mem;
>> +
>> +    wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>> +    if (IS_ERR(wdt))
>> +        return PTR_ERR(wdt);
>> +
>> +    mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    wdt->regs = devm_ioremap_resource(&pdev->dev, mem);
>> +    if (IS_ERR(wdt->regs))
>> +        return PTR_ERR(wdt->regs);
>> +
>> +    wdt->rst_base = devm_ioremap(&pdev->dev, PIC32_BASE_RESET, 0x10);
>> +    if (IS_ERR(wdt->rst_base))
>> +        return PTR_ERR(wdt->rst_base);
>> +
>> +    wdt->clk = devm_clk_get(&pdev->dev, NULL);
>> +    if (IS_ERR(wdt->clk)) {
>> +        dev_err(&pdev->dev, "clk not found\n");
>> +        return PTR_ERR(wdt->clk);
>> +    }
>> +
>> +    ret = clk_prepare_enable(wdt->clk);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "clk enable failed\n");
>> +        return ret;
>> +    }
>> +
>> +    if (pic32_wdt_is_win_enabled(wdt)) {
>> +        dev_err(&pdev->dev, "windowed-clear mode is not supported.\n");
>> +        ret = -EOPNOTSUPP;
> 
> -ENODEV, please.

Ack.

> 
>> +        goto out_disable_clk;
>> +    }
>> +
>> +    wdd->timeout = pic32_wdt_get_timeout_secs(wdt);
>> +    if (!wdd->timeout) {
>> +        dev_err(&pdev->dev,
>> +            "failed to read watchdog register timeout\n");
>> +        ret = -EINVAL;
>> +        goto out_disable_clk;
>> +    }
>> +
>> +    dev_info(&pdev->dev, "timeout %d\n", wdd->timeout);
>> +
>> +    wdd->bootstatus = pic32_wdt_bootstatus(wdt) ? WDIOF_CARDRESET : 0;
>> +
>> +    watchdog_set_nowayout(wdd, WATCHDOG_NOWAYOUT);
>> +    watchdog_set_drvdata(wdd, wdt);
>> +
>> +    ret = watchdog_register_device(wdd);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "watchdog register failed, err %d\n", ret);
>> +        goto out_disable_clk;
>> +    }
>> +
>> +    platform_set_drvdata(pdev, wdd);
>> +
>> +    return 0;
>> +
>> +out_disable_clk:
>> +    clk_disable_unprepare(wdt->clk);
>> +
>> +    return ret;
>> +}
>> +
>> +static int pic32_wdt_drv_remove(struct platform_device *pdev)
>> +{
>> +    struct watchdog_device *wdd = platform_get_drvdata(pdev);
>> +    struct pic32_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +    watchdog_unregister_device(wdd);
>> +    clk_disable_unprepare(wdt->clk);
>> +
>> +    return 0;
>> +}
>> +
>> +static struct platform_driver pic32_wdt_driver = {
>> +    .probe        = pic32_wdt_drv_probe,
>> +    .remove        = pic32_wdt_drv_remove,
>> +    .driver        = {
>> +        .name        = "pic32-wdt",
>> +        .owner        = THIS_MODULE,
>> +        .of_match_table = of_match_ptr(pic32_wdt_dt_ids),
>> +    }
>> +};
>> +
>> +module_platform_driver(pic32_wdt_driver);
>> +
>> +MODULE_AUTHOR("Joshua Henderson <joshua.henderson@microchip.com>");
>> +MODULE_DESCRIPTION("Microchip PIC32 Watchdog Timer");
>> +MODULE_LICENSE("GPL");
>>
> 

Thanks,
Josh
