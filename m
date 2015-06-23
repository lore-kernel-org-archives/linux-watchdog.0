Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20150611162810.GA22711@roeck-us.net>
References: <1433958452-23721-5-git-send-email-fu.wei@linaro.org>
	<20150611162810.GA22711@roeck-us.net>
Date: Tue, 23 Jun 2015 21:26:35 +0800
Message-ID: <CADyBb7uGT9bTNiG7524wrd14xiFfgwoDNMq1_J2HDxiK-ogc8Q@mail.gmail.com>
Subject: Re: [non-pretimeout,4/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Vipul Gandhi <vgandhi@codeaurora.org>, Wim Van Sebroeck <wim@iguana.be>, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On 12 June 2015 at 00:28, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Jun 11, 2015 at 01:47:29AM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This driver bases on linux kernel watchdog framework.
>> It supports getting timeout from parameter and FDT
>> at the driver init stage.
>> The first timeout period expires, the interrupt routine
>> got another timeout period to run panic for saving
>> system context.
>>
> Comments inline.
>
> Thanks,
> Guenter
>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  drivers/watchdog/Kconfig     |  11 ++
>>  drivers/watchdog/Makefile    |   1 +
>>  drivers/watchdog/sbsa_gwdt.c | 383 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 395 insertions(+)
>>  create mode 100644 drivers/watchdog/sbsa_gwdt.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index e5e7c55..554f18a 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -152,6 +152,17 @@ config ARM_SP805_WATCHDOG
>>         ARM Primecell SP805 Watchdog timer. This will reboot your system when
>>         the timeout is reached.
>>
>> +config ARM_SBSA_WATCHDOG
>> +     tristate "ARM SBSA Generic Watchdog"
>> +     depends on ARM64
>> +     depends on ARM_ARCH_TIMER
>> +     select WATCHDOG_CORE
>> +     help
>> +       ARM SBSA Generic Watchdog. This watchdog has two Watchdog timeouts.
>> +       The first timeout will trigger a panic; the second timeout will
>> +       trigger a system reset.
>> +       More details: ARM DEN0029B - Server Base System Architecture (SBSA)
>> +
>           To compile this driver as module, choose M here: The module
>           will be called sbsa_gwdt.

Thanks! added it.

>
>>  config AT91RM9200_WATCHDOG
>>       tristate "AT91RM9200 watchdog"
>>       depends on SOC_AT91RM9200 && MFD_SYSCON
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index 5c19294..471f1b7c 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -30,6 +30,7 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
>>
>>  # ARM Architecture
>>  obj-$(CONFIG_ARM_SP805_WATCHDOG) += sp805_wdt.o
>> +obj-$(CONFIG_ARM_SBSA_WATCHDOG) += sbsa_gwdt.o
>>  obj-$(CONFIG_AT91RM9200_WATCHDOG) += at91rm9200_wdt.o
>>  obj-$(CONFIG_AT91SAM9X_WATCHDOG) += at91sam9_wdt.o
>>  obj-$(CONFIG_CADENCE_WATCHDOG) += cadence_wdt.o
>> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
>> new file mode 100644
>> index 0000000..1ddc10f
>> --- /dev/null
>> +++ b/drivers/watchdog/sbsa_gwdt.c
>> @@ -0,0 +1,383 @@
>> +/*
>> + * SBSA(Server Base System Architecture) Generic Watchdog driver
>> + *
>> + * Copyright (c) 2015, Linaro Ltd.
>> + * Author: Fu Wei <fu.wei@linaro.org>
>> + *         Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License 2 as published
>> + * by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * Note: This SBSA Generic watchdog has two stage timeouts,
>
> s/This/The/
>
> "has two stages".
>
> I would suggest to drop "Note:", but that is up to you.

Thanks :-)  fixed it

>
>> + *       When the first timeout occurs, WS0(SPI or LPI) is triggered,
>> + *       the second timeout period(as long as the first timeout period) starts.
>
> no longer accurate if WOR is used for the second period.
>
>> + *       In WS0 interrupt routine, panic() will be called for collecting
>> + *       crashdown info.
>> + *       If system can not recover from WS0 interrupt routine, then second
>> + *       timeout occurs, WS1(reset or higher level interrupt) is triggered.
>> + *       The two timeout period can be set by WOR(32bit).
>
> The second timeout period is determined by ...
>
>> + *       WOR gives a maximum watch period of around 10s at the maximum
>> + *       system counter frequency.
>> + *       The System Counter shall run at maximum of 400MHz.
>
> "... at the maximum system counter frequency of 400 MHz.", and drop the
> last sentence.

For the second timeout period,  I have discussed with a kdump developers,
(1)10s maybe not good enough for all the case of panic + kdump, so
maybe we still need to use WCV in the second timeout period
(2)in the second timeout period, maybe we need to programme WCV for
two reason: a, trigger WS1 to reboot system ASAP; b, feed the watchdog
without cleanning WS0 flag.

WHY we want to feed the watchdog (keepalive) without cleanning WS0 flag??
REASON:
(1)if the system context is large, we may need to feed the dog until
we get all the things backed up.
(2)if system goes wrong,  WS0 triggered, then panic--> kdump. if we
feed the dog by WRR or programming WOR, WS0 flag will be cleaned. Once
system goes wrong again, then panic again.....
So this system will be in a panic--kdump--panic--kdump loop, have not
chance to reset.

So if we are in the second timeout period, we may need to always programme WCV.

>
> Please uses spaces before '('.
>
>> + *
>> + *       But If we need a larger timeout period, this driver will programme WCV
>
> s/But //
> s/this/the/
> s/programme/program/
>
>> + *       directly. That can support more than 10s timeout at the maximum
>> + *       system counter frequency.
>
> Drop the last sentence.

Thanks , fixed it

>
>> + *       More details: ARM DEN0029B - Server Base System Architecture (SBSA)
>> + *
>> + * SBSA GWDT:    |---WOR(or WCV)---WS0---WOR(or WCV)---WS1
>> + *               |-----timeout-----WS0-----timeout-----WS1
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/watchdog.h>
>> +#include <asm/arch_timer.h>
>> +
>> +/* SBSA Generic Watchdog register definitions */
>> +/* refresh frame */
>> +#define SBSA_GWDT_WRR                                0x000
>> +
>> +/* control frame */
>> +#define SBSA_GWDT_WCS                                0x000
>> +#define SBSA_GWDT_WOR                                0x008
>> +#define SBSA_GWDT_WCV_LO                     0x010
>> +#define SBSA_GWDT_WCV_HI                     0x014
>> +
>> +/* refresh/control frame */
>> +#define SBSA_GWDT_W_IIDR                     0xfcc
>> +#define SBSA_GWDT_IDR                                0xfd0
>> +
>> +/* Watchdog Control and Status Register */
>> +#define SBSA_GWDT_WCS_EN                     BIT(0)
>> +#define SBSA_GWDT_WCS_WS0                    BIT(1)
>> +#define SBSA_GWDT_WCS_WS1                    BIT(2)
>> +
>> +/**
>> + * struct sbsa_gwdt - Internal representation of the SBSA GWDT
>> + * @wdd:             kernel watchdog_device structure
>> + * @clk:             store the System Counter clock frequency, in Hz.
>> + * @max_wor_timeout: the maximum timeout value for WOR (in seconds).
>> + * @refresh_base:    Virtual address of the watchdog refresh frame
>> + * @control_base:    Virtual address of the watchdog control frame
>> + */
>> +struct sbsa_gwdt {
>> +     struct watchdog_device  wdd;
>> +     u32                     clk;
>> +     int                     max_wor_timeout;
>> +     void __iomem            *refresh_base;
>> +     void __iomem            *control_base;
>> +};
>> +
>> +#define to_sbsa_gwdt(e) container_of(e, struct sbsa_gwdt, wdd)
>> +
>> +#define DEFAULT_TIMEOUT              30 /* seconds */
>> +
>> +static unsigned int timeout;
>> +module_param(timeout, uint, 0);
>> +MODULE_PARM_DESC(timeout,
>> +              "Watchdog timeout in seconds. (>=0, default="
>> +              __MODULE_STRING(DEFAULT_TIMEOUT) ")");
>> +
>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>> +module_param(nowayout, bool, S_IRUGO);
>> +MODULE_PARM_DESC(nowayout,
>> +              "Watchdog cannot be stopped once started (default="
>> +              __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>> +
>> +/*
>> + * help functions for accessing 64bit WCV register
>> + */
>> +static u64 sbsa_gwdt_get_wcv(struct watchdog_device *wdd)
>> +{
>> +     u32 wcv_lo, wcv_hi;
>> +     struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +
>> +     do {
>> +             wcv_hi = readl_relaxed(gwdt->control_base + SBSA_GWDT_WCV_HI);
>> +             wcv_lo = readl_relaxed(gwdt->control_base + SBSA_GWDT_WCV_LO);
>> +     } while (wcv_hi != readl_relaxed(gwdt->control_base +
>> +                                      SBSA_GWDT_WCV_HI));
>> +
>> +     return (((u64)wcv_hi << 32) | wcv_lo);
>> +}
>> +
>> +static void reload_timeout_to_wcv(struct watchdog_device *wdd)
>> +{
>> +     struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +     u64 wcv;
>> +
>> +     wcv = arch_counter_get_cntvct() + (u64)wdd->timeout * gwdt->clk;
>> +
>> +     writel_relaxed(upper_32_bits(wcv),
>> +                    gwdt->control_base + SBSA_GWDT_WCV_HI);
>> +     writel_relaxed(lower_32_bits(wcv),
>> +                    gwdt->control_base + SBSA_GWDT_WCV_LO);
>> +}
>> +
>> +static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
>> +                              unsigned int timeout)
>> +{
>> +     struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +
>> +     wdd->timeout = timeout;
>> +
>> +     if (timeout <= gwdt->max_wor_timeout)
>> +             writel_relaxed(timeout * gwdt->clk,
>> +                            gwdt->control_base + SBSA_GWDT_WOR);
>> +     else
>> +             writel_relaxed(gwdt->max_wor_timeout * gwdt->clk,
>> +                            gwdt->control_base + SBSA_GWDT_WOR);
>> +
>
> This can be simplified a bit to
>         if (timeout > gwdt->max_wor_timeout)
>                 timeout = gwdt->max_wor_timeout;
>         writel_relaxed(timeout * gwdt->clk,
>                        gwdt->control_base + SBSA_GWDT_WOR);

yes, good idea, thanks , fixed

>
>> +     return 0;
>> +}
>> +
>> +static unsigned int sbsa_gwdt_get_timeleft(struct watchdog_device *wdd)
>> +{
>> +     struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +     u64 timeleft = sbsa_gwdt_get_wcv(wdd) - arch_counter_get_cntvct();
>> +
>> +     do_div(timeleft, gwdt->clk);
>> +
>> +     return timeleft;
>> +}
>> +
>> +static int sbsa_gwdt_keepalive(struct watchdog_device *wdd)
>> +{
>> +     struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +
>> +     if (wdd->timeout <= gwdt->max_wor_timeout)
>> +             /*
>> +              * Writing WRR for an explicit watchdog refresh.
>> +              * You can write anyting(like 0xc0ffee).
>> +              */
>> +             writel_relaxed(0xc0ffee, gwdt->refresh_base + SBSA_GWDT_WRR);
>> +     else
>> +             reload_timeout_to_wcv(wdd);
>> +
>> +     return 0;
>> +}
>> +
>> +static int sbsa_gwdt_start(struct watchdog_device *wdd)
>> +{
>> +     struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +     /* Force refresh due to hardware bug found in certain Soc. */
>
> Can you specify which SOC(s) are known to need this, and explain the bug
> a bit better ?

please ignore this, I have deleted it after discussing this with the
engineer of that chip vendor.
we don't need it now.

>
>> +     writel_relaxed(0xc0ffee, gwdt->refresh_base + SBSA_GWDT_WRR);
>> +     /* writing WCS will cause an explicit watchdog refresh */
>> +     writel_relaxed(SBSA_GWDT_WCS_EN, gwdt->control_base + SBSA_GWDT_WCS);
>> +
>> +     return sbsa_gwdt_keepalive(wdd);
>> +}
>> +
>> +static int sbsa_gwdt_stop(struct watchdog_device *wdd)
>> +{
>> +     struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +
>> +     writel_relaxed(0, gwdt->control_base + SBSA_GWDT_WCS);
>> +
>> +     return 0;
>> +}
>> +
>> +static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
>> +{
>> +     struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
>> +     struct watchdog_device *wdd = &gwdt->wdd;
>> +
>> +     if (wdd->timeout > gwdt->max_wor_timeout)
>> +             reload_timeout_to_wcv(wdd);
>> +
> Please drop the above.

as I mentioned above, I thinks we can keep this.
But please check my new patchset for this support

>
>> +     panic("SBSA Watchdog pre-timeout");
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static struct watchdog_info sbsa_gwdt_info = {
>> +     .identity       = "SBSA Generic Watchdog",
>> +     .options        = WDIOF_SETTIMEOUT |
>> +                       WDIOF_KEEPALIVEPING |
>> +                       WDIOF_MAGICCLOSE |
>> +                       WDIOF_CARDRESET,
>> +};
>> +
>> +static struct watchdog_ops sbsa_gwdt_ops = {
>> +     .owner          = THIS_MODULE,
>> +     .start          = sbsa_gwdt_start,
>> +     .stop           = sbsa_gwdt_stop,
>> +     .ping           = sbsa_gwdt_keepalive,
>> +     .set_timeout    = sbsa_gwdt_set_timeout,
>> +     .get_timeleft   = sbsa_gwdt_get_timeleft,
>> +};
>> +
>> +static int sbsa_gwdt_probe(struct platform_device *pdev)
>> +{
>> +     u64 first_period_max = U64_MAX;
>> +     struct device *dev = &pdev->dev;
>> +     struct watchdog_device *wdd;
>> +     struct sbsa_gwdt *gwdt;
>> +     struct resource *res;
>> +     void *rf_base, *cf_base;
>> +     int ret, irq;
>> +     u32 status;
>> +
>> +     gwdt = devm_kzalloc(dev, sizeof(*gwdt), GFP_KERNEL);
>> +     if (!gwdt)
>> +             return -ENOMEM;
>> +     platform_set_drvdata(pdev, gwdt);
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "refresh");
>> +     rf_base = devm_ioremap_resource(dev, res);
>> +     if (IS_ERR(rf_base))
>> +             return PTR_ERR(rf_base);
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "control");
>> +     cf_base = devm_ioremap_resource(dev, res);
>> +     if (IS_ERR(cf_base))
>> +             return PTR_ERR(cf_base);
>> +
>> +     irq = platform_get_irq_byname(pdev, "ws0");
>> +     if (irq < 0) {
>> +             dev_err(dev, "unable to get ws0 interrupt.\n");
>> +             return irq;
>> +     }
>> +
>> +     /*
>> +      * Get the frequency of system counter from the cp15 interface of ARM
>> +      * Generic timer. We don't need to check it, because if it returns "0",
>> +      * system would panic in very early stage.
>> +      */
>> +     gwdt->clk = arch_timer_get_cntfrq();
>> +     gwdt->refresh_base = rf_base;
>> +     gwdt->control_base = cf_base;
>> +     gwdt->max_wor_timeout = U32_MAX / gwdt->clk;
>> +
>> +     wdd = &gwdt->wdd;
>> +     wdd->parent = dev;
>> +     wdd->info = &sbsa_gwdt_info;
>> +     wdd->ops = &sbsa_gwdt_ops;
>> +     watchdog_set_drvdata(wdd, gwdt);
>> +     watchdog_set_nowayout(wdd, nowayout);
>> +
>> +     wdd->min_timeout = 1;
>> +     do_div(first_period_max, gwdt->clk);
>> +     wdd->max_timeout = first_period_max;
>> +
>> +     wdd->timeout = DEFAULT_TIMEOUT;
>> +     watchdog_init_timeout(wdd, timeout, dev);
>> +
>> +     status = readl_relaxed(gwdt->control_base + SBSA_GWDT_WCS);
>> +     if (status & SBSA_GWDT_WCS_WS1) {
>> +             dev_warn(dev, "System reset by WDT(WCV: %llx)\n",
>> +                      sbsa_gwdt_get_wcv(wdd));
>
> WCV here only tells us how many clock cycles were executed since the
> system started (or something like that). So I still don't understand
> why it is valuable to print that number.

this number provides the time of system reset, I thinks that may help
admin to analyse the system failure.

>
>> +             wdd->bootstatus |= WDIOF_CARDRESET;
>> +     }
>> +     /* Check if watchdog is already enabled */
>> +     if (status & SBSA_GWDT_WCS_EN) {
>> +             dev_warn(dev, "already enabled\n");
>> +             sbsa_gwdt_keepalive(wdd);
>> +     }
>
> Can you merge the message with the info message below ?
> Something like
>         dev_info(dev, "Initialized with %ds timeout @ %u Hz%s\n", wdd->timeout,
>                  gwdt->clk, status & SBSA_GWDT_WCS_EN ? " [enabled]" : "");
>
> I don't think that should be a warning.

yes, good idea, will do

>
>> +
>> +     /* update timeout to WOR */
>> +     sbsa_gwdt_set_timeout(wdd, wdd->timeout);
>> +
>
> That will trigger a refresh if the watchdog is active, meaning the timeout
> will occur at time + WOR, not at time + timeout. I think keepalive has to be
> called later, preferrably after calling watchdog_register_device().

yes, you are right, will fix it

>
>> +     ret = devm_request_irq(dev, irq, sbsa_gwdt_interrupt, 0,
>> +                            pdev->name, gwdt);
>> +     if (ret) {
>> +             dev_err(dev, "unable to request IRQ %d\n", irq);
>> +             return ret;
>> +     }
>> +
>> +     ret = watchdog_register_device(wdd);
>> +     if (ret)
>> +             return ret;
>> +
>> +     dev_info(dev, "Initialized with %ds timeout @ %u Hz\n", wdd->timeout,
>> +              gwdt->clk);
>> +
>> +     return 0;
>> +}
>> +
>> +static void sbsa_gwdt_shutdown(struct platform_device *pdev)
>> +{
>> +     struct sbsa_gwdt *gwdt = platform_get_drvdata(pdev);
>> +
>> +     sbsa_gwdt_stop(&gwdt->wdd);
>> +}
>> +
>> +static int sbsa_gwdt_remove(struct platform_device *pdev)
>> +{
>> +     struct sbsa_gwdt *gwdt = platform_get_drvdata(pdev);
>> +
>> +     watchdog_unregister_device(&gwdt->wdd);
>> +
>> +     return 0;
>> +}
>> +
>> +/* Disable watchdog if it is active during suspend */
>> +static int __maybe_unused sbsa_gwdt_suspend(struct device *dev)
>> +{
>> +     struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
>> +
>> +     if (watchdog_active(&gwdt->wdd))
>> +             sbsa_gwdt_stop(&gwdt->wdd);
>> +
>> +     return 0;
>> +}
>> +
>> +/* Enable watchdog and configure it if necessary */
>> +static int __maybe_unused sbsa_gwdt_resume(struct device *dev)
>> +{
>> +     struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
>> +
>> +     if (watchdog_active(&gwdt->wdd))
>> +             sbsa_gwdt_start(&gwdt->wdd);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct dev_pm_ops sbsa_gwdt_pm_ops = {
>> +     SET_SYSTEM_SLEEP_PM_OPS(sbsa_gwdt_suspend, sbsa_gwdt_resume)
>> +};
>> +
>> +static const struct of_device_id sbsa_gwdt_of_match[] = {
>> +     { .compatible = "arm,sbsa-gwdt", },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, sbsa_gwdt_of_match);
>> +
>> +static const struct platform_device_id sbsa_gwdt_pdev_match[] = {
>> +     { .name = "sbsa-gwdt", },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(platform, sbsa_gwdt_pdev_match);
>> +
>> +static struct platform_driver sbsa_gwdt_driver = {
>> +     .driver = {
>> +             .name = "sbsa-gwdt",
>> +             .pm = &sbsa_gwdt_pm_ops,
>> +             .of_match_table = sbsa_gwdt_of_match,
>> +     },
>> +     .probe = sbsa_gwdt_probe,
>> +     .remove = sbsa_gwdt_remove,
>> +     .shutdown = sbsa_gwdt_shutdown,
>> +     .id_table = sbsa_gwdt_pdev_match,
>> +};
>> +
>> +module_platform_driver(sbsa_gwdt_driver);
>> +
>> +MODULE_DESCRIPTION("SBSA Generic Watchdog Driver");
>> +MODULE_VERSION("v1.0");
>
> Version numbers tend to be out of date constantly, and there is no well
> defined mechanism or protocol when increase them. I would suggest to drop it.

Ok, will drop it

>
>> +MODULE_AUTHOR("Fu Wei <fu.wei@linaro.org>");
>> +MODULE_AUTHOR("Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>");
>> +MODULE_LICENSE("GPL v2");



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
