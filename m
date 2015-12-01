Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35990 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209AbbLAKLs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Dec 2015 05:11:48 -0500
Received: by lfs39 with SMTP id 39so1447728lfs.3
        for <linux-watchdog@vger.kernel.org>; Tue, 01 Dec 2015 02:11:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <565D6BAD.6070609@roeck-us.net>
References: <1448955825-17115-1-git-send-email-21cnbao@gmail.com> <565D6BAD.6070609@roeck-us.net>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 1 Dec 2015 18:11:27 +0800
Message-ID: <CAGsJ_4xVvx=biuJYr__Gf7U1-faYTKtDTrZrmqeRPurB+ecGUw@mail.gmail.com>
Subject: Re: [PATCH v3] watchdog: atlas7: add watchdog driver of CSRatlas7
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>,
	Guo Zeng <Guo.Zeng@csr.com>,
	William Wang <William.Wang@csr.com>,
	Barry Song <Baohua.Song@csr.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

2015-12-01 17:43 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On 11/30/2015 11:43 PM, Barry Song wrote:
>>
>> From: Guo Zeng <Guo.Zeng@csr.com>
>>
>> This patch adds watchdog driver for CSRatlas7 platform.
>> On CSRatlas7, the 6th timer can act as a watchdog timer
>> when the Watchdog mode is enabled.
>>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
>> Signed-off-by: William Wang <William.Wang@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
>
> Are those people all in the sign-off path, or just somehow involved
> in writing the code ?

involved in writing the code.

>
>
>> ---
>>   -v3: fix issues according to Guenter's comments
>>    1. rename updatetimeout to ping
>>    2. drop redundant calling ping in set_timeout
>>    3. fix the error handler in probe
>>    4. move to __maybe_unused for suspend/resume entries
>>    5. fix the min and max timeout
>>    6. clean up clear ugly codes for timeout set
>>
>>   drivers/watchdog/Kconfig      |  10 ++
>>   drivers/watchdog/Makefile     |   1 +
>>   drivers/watchdog/atlas7_wdt.c | 249
>> ++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 260 insertions(+)
>>   create mode 100644 drivers/watchdog/atlas7_wdt.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 1c427be..52b308f 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -578,6 +578,16 @@ config LPC18XX_WATCHDOG
>>           To compile this driver as a module, choose M here: the
>>           module will be called lpc18xx_wdt.
>>
>> +config ATLAS7_WATCHDOG
>> +       tristate "CSRatlas7 watchdog"
>> +       depends on ARCH_ATLAS7
>> +       help
>> +         Say Y here to include Watchdog timer support for the watchdog
>> +         existing on the CSRatlas7 series platforms.
>> +
>> +         To compile this driver as a module, choose M here: the
>> +         module will be called atlas7_wdt.
>> +
>>   # AVR32 Architecture
>>
>>   config AT32AP700X_WDT
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index 53d4827..e2bc52c 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -69,6 +69,7 @@ obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
>>   obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
>>   obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
>>   obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
>> +obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
>>
>>   # AVR32 Architecture
>>   obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
>> diff --git a/drivers/watchdog/atlas7_wdt.c b/drivers/watchdog/atlas7_wdt.c
>> new file mode 100644
>> index 0000000..4f191fe
>> --- /dev/null
>> +++ b/drivers/watchdog/atlas7_wdt.c
>> @@ -0,0 +1,249 @@
>> +/*
>> + * Watchdog driver for CSRatlas7
>> + *
>> + * Copyright (c) 2015 Cambridge Silicon Radio Limited, a CSR plc group
>> company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/watchdog.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/of.h>
>> +#include <linux/io.h>
>> +#include <linux/uaccess.h>
>
>
> Not required.
>
>> +#include <linux/clk.h>
>> +
>
> Please order include files alphabetically.
>
>> +#define ATLAS7_TIMER_WDT_INDEX         5
>> +#define ATLAS7_WDT_DEFAULT_TIMEOUT     20              /* 20 secs */
>> +
>> +#define ATLAS7_WDT_CNT_CTRL    0
>> +#define ATLAS7_WDT_CNT_MATCH   0x18
>> +#define ATLAS7_WDT_CNT         0x48
>
>
> Wondering - below you always add 4 * ATLAS7_TIMER_WDT_INDEX
> to the WDT_CNT_CTRL, WDT_CNT_MATCH, and WDT_CNT registers.
> Wouldn't it be easier to specify the final register offsets directly ?
>
> #define ATLAS7_WDT_CNT_CTRL     (0 + 4 * ATLAS7_TIMER_WDT_INDEX)
>
> or even
>
> #define ATLAS7_WDT_CNT_CTRL     0x14
>
> The long expressions below just make the code more difficult to read.
>
>> +#define ATLAS7_WDT_CNT_EN      (BIT(0) | BIT(1))
>> +#define ATLAS7_WDT_EN          0x64
>> +
>> +static unsigned int timeout = ATLAS7_WDT_DEFAULT_TIMEOUT;
>
>
> This will cause a devicetree based initialization to be ignored.
> It would be better to set this to 0 and initialize .timeout with
> ATLAS7_WDT_DEFAULT_TIMEOUT prior to calling watchdog_init_timeout().
>
>
>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>> +
>> +module_param(timeout, uint, 0);
>> +module_param(nowayout, bool, 0);
>> +
>> +MODULE_PARM_DESC(timeout, "Default watchdog timeout (in seconds)");
>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started
>> (default="
>> +                       __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>> +
>> +struct atlas7_wdog {
>> +       struct device *dev;
>> +       void __iomem *base;
>> +       unsigned long tick_rate;
>> +       struct clk *clk;
>> +};
>> +
>> +static unsigned int atlas7_wdt_gettimeleft(struct watchdog_device *wdd)
>> +{
>> +       struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
>> +       u32 counter, match, delta;
>> +
>> +       counter = readl(wdt->base + ATLAS7_WDT_CNT +
>> +               4 * ATLAS7_TIMER_WDT_INDEX);
>> +       match = readl(wdt->base + ATLAS7_WDT_CNT_MATCH +
>> +                       4 * ATLAS7_TIMER_WDT_INDEX);
>
>
> In general, continuation lines should be aligned with '('.
>
> On the other side, macros such as
>
> #define WDT_CNT_REG(wdt)        ((wdt)->base + ATLAS7_WDT_CNT + 4 *
> ATLAS7_TIMER_WDT_INDEX)
> #define WDT_CNT_MATCH_REG(wdt)  ((wdt)->base + ATLAS7_WDT_CNT_MATCH + 4 *
> ATLAS7_TIMER_WDT_INDEX)
> #define WDT_CNT_CTRL_REG(wdt)   ((wdt)->base + ATLAS7_WDT_CNT_CTRL + 4 *
> ATLAS7_TIMER_WDT_INDEX)
>
> might be quite useful to avoid the repeated use of long expressions.
> Or at least simplify the register definitions as suggested above.
>
>
>> +       delta = match - counter;
>> +
>> +       return  delta / wdt->tick_rate;
>> +}
>> +
>> +static int atlas7_wdt_ping(struct watchdog_device *wdd)
>> +{
>> +       struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
>> +       u32 counter, match, delta;
>> +
>> +       counter = readl(wdt->base + ATLAS7_WDT_CNT +
>> +                       4 * ATLAS7_TIMER_WDT_INDEX);
>> +       delta = wdd->timeout * wdt->tick_rate;
>> +       match = counter + delta;
>> +
>> +       writel(match, wdt->base + ATLAS7_WDT_CNT_MATCH +
>> +               4 * ATLAS7_TIMER_WDT_INDEX);
>> +
>> +       return 0;
>> +}
>> +
>> +static int atlas7_wdt_enable(struct watchdog_device *wdd)
>> +{
>> +       struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
>> +       void __iomem *ctrl_reg = wdt->base + ATLAS7_WDT_CNT_CTRL +
>> +               4 * ATLAS7_TIMER_WDT_INDEX;
>> +
>> +       atlas7_wdt_ping(wdd);
>> +
>> +       writel(readl(ctrl_reg) | ATLAS7_WDT_CNT_EN, ctrl_reg);
>> +       writel(1, wdt->base + ATLAS7_WDT_EN);
>> +
>> +       return 0;
>> +}
>> +
>> +static int atlas7_wdt_disable(struct watchdog_device *wdd)
>> +{
>> +       struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
>> +       void __iomem *ctrl_reg = wdt->base + ATLAS7_WDT_CNT_CTRL +
>> +               4 * ATLAS7_TIMER_WDT_INDEX;
>> +
>> +       writel(0, wdt->base + ATLAS7_WDT_EN);
>> +       writel(readl(ctrl_reg) & ~ATLAS7_WDT_CNT_EN, ctrl_reg);
>> +
>> +       return 0;
>> +}
>> +
>> +static int atlas7_wdt_settimeout(struct watchdog_device *wdd, unsigned
>> int to)
>> +{
>> +       wdd->timeout = to;
>> +
>> +       return 0;
>> +}
>> +
>> +#define OPTIONS (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
>> WDIOF_MAGICCLOSE)
>> +
>> +static const struct watchdog_info atlas7_wdt_ident = {
>> +       .options          =     OPTIONS,
>> +       .firmware_version =     0,
>> +       .identity         =     "atlas7 Watchdog",
>
>
> The tab after '=' is really unnecessary. I would suggest to replace it with
> a space.

ok
>
>
>> +};
>> +
>> +static struct watchdog_ops atlas7_wdt_ops = {
>> +       .owner = THIS_MODULE,
>> +       .start = atlas7_wdt_enable,
>> +       .stop = atlas7_wdt_disable,
>> +       .get_timeleft = atlas7_wdt_gettimeleft,
>> +       .ping = atlas7_wdt_ping,
>> +       .set_timeout = atlas7_wdt_settimeout,
>> +};
>> +
>> +static struct watchdog_device atlas7_wdd = {
>> +       .info = &atlas7_wdt_ident,
>> +       .ops = &atlas7_wdt_ops,
>> +       .timeout = ATLAS7_WDT_DEFAULT_TIMEOUT,
>> +};
>> +
>> +static const struct of_device_id atlas7_wdt_ids[] = {
>> +       { .compatible = "sirf,atlas7-tick"},
>> +       {}
>> +};
>> +
>> +static int atlas7_wdt_probe(struct platform_device *pdev)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +       struct atlas7_wdog *wdt;
>> +       struct resource *res;
>> +       struct clk *clk;
>> +       int ret;
>> +
>> +       wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>> +       if (!wdt)
>> +               return -ENOMEM;
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       wdt->base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(wdt->base))
>> +               return PTR_ERR(wdt->base);
>> +
>> +       clk = of_clk_get(np, 0);
>> +       if (IS_ERR(clk)) {
>> +               ret = PTR_ERR(clk);
>> +               goto err;
>
>
> You can just return PTR_ERR(clk) here.
> The "err:" label, just to return, is unnecessary.
>

ok.

>
>> +       }
>> +       ret = clk_prepare_enable(clk);
>> +       if (ret) {
>> +               pr_err("wdt clk enable failed\n");
>> +               goto err1;
>
>
> wdt->clk is not yet set here, meaning the clk_put() below won't work.
>

right.
>
>> +       }
>> +
>> +       /* disable watchdog hardware */
>> +       writel(0, wdt->base + ATLAS7_WDT_CNT_CTRL +
>> +                       4 * ATLAS7_TIMER_WDT_INDEX);
>> +
>> +       wdt->tick_rate = clk_get_rate(clk);
>> +       wdt->clk = clk;
>> +       atlas7_wdd.min_timeout = 1;
>> +       atlas7_wdd.max_timeout = UINT_MAX / wdt->tick_rate;
>> +
>> +       watchdog_init_timeout(&atlas7_wdd, timeout, &pdev->dev);
>> +       watchdog_set_nowayout(&atlas7_wdd, nowayout);
>> +
>> +       watchdog_set_drvdata(&atlas7_wdd, wdt);
>> +       platform_set_drvdata(pdev, &atlas7_wdd);
>> +
>> +       ret = watchdog_register_device(&atlas7_wdd);
>> +       if (ret)
>> +               goto err2;
>> +
>> +       return 0;
>> +
>> +err2:
>> +       clk_disable_unprepare(wdt->clk);
>> +err1:
>> +       clk_put(wdt->clk);
>> +err:
>> +       return ret;
>> +}
>> +
>> +static void atlas7_wdt_shutdown(struct platform_device *pdev)
>> +{
>> +       struct watchdog_device *wdd = platform_get_drvdata(pdev);
>> +       struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
>> +
>> +       atlas7_wdt_disable(wdd);
>> +       clk_disable_unprepare(wdt->clk);
>> +}
>> +
>> +static int atlas7_wdt_remove(struct platform_device *pdev)
>> +{
>> +       struct watchdog_device *wdd = platform_get_drvdata(pdev);
>> +       struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
>> +
>> +       atlas7_wdt_shutdown(pdev);
>> +       clk_put(wdt->clk);
>> +       return 0;
>> +}
>> +
>> +static int __maybe_unused atlas7_wdt_suspend(struct device *dev)
>> +{
>> +       return 0;
>
>
> Is it not necessary to stop the watchdog ? If the watchdog is disabled
> elsewhere, a similar comment to the one below would help.

it is not disabled. but the power will lose, so that means it is
disabled. and its status is saved in elsewhere.

>
>
>> +}
>> +
>> +static int __maybe_unused atlas7_wdt_resume(struct device *dev)
>> +{
>> +       struct watchdog_device *wdd = dev_get_drvdata(dev);
>> +
>> +       /*
>> +        * NOTE: Since timer controller registers settings are saved
>> +        * and restored back by the timer-atlas7.c, so we need not
>> +        * update WD settings except refreshing timeout.
>> +        */
>> +       atlas7_wdt_ping(wdd);
>> +
>> +       return 0;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(atlas7_wdt_pm_ops,
>> +               atlas7_wdt_suspend, atlas7_wdt_resume);
>> +
>> +MODULE_DEVICE_TABLE(of, atlas7_wdt_ids);
>> +
>> +static struct platform_driver atlas7_wdt_driver = {
>> +       .driver = {
>> +               .name = "atlas7-wdt",
>> +               .pm = &atlas7_wdt_pm_ops,
>> +               .of_match_table = atlas7_wdt_ids,
>> +       },
>> +       .probe = atlas7_wdt_probe,
>> +       .remove = atlas7_wdt_remove,
>> +       .shutdown = atlas7_wdt_shutdown,
>> +};
>> +module_platform_driver(atlas7_wdt_driver);
>> +
>> +MODULE_DESCRIPTION("CSRatlas7 watchdog driver");
>> +MODULE_AUTHOR("Guo Zeng <Guo.Zeng@csr.com>");
>> +MODULE_LICENSE("GPL v2");
>
>
> This contradicts "GPL v2 or later" in the comments at the beginning of the
> file.
will drop "or later".

>
>> +MODULE_ALIAS("platform:atlas7-wdt");
>>
>

-barry
