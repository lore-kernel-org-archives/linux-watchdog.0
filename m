Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <D18BEA07.26058%charles.garcia-tobin@arm.com>
References: <1432335137-1023-1-git-send-email-timur@codeaurora.org>
	<5564A92F.4090403@linaro.org>
	<D18BEA07.26058%charles.garcia-tobin@arm.com>
Date: Wed, 10 Jun 2015 22:55:00 +0800
Message-ID: <CADyBb7tLdHp91EZfN3=Aw9bLUwP+QsL99CO9g9k7-diTvtnG7g@mail.gmail.com>
Subject: Re: [Linaro-acpi] [PATCH] [v4] watchdog: introduce the ARM64 SBSA
 watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: administrator <charles.garcia-tobin@arm.com>
Cc: Al Stone <al.stone@linaro.org>, Timur Tabi <timur@codeaurora.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>, Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	"graeme.gregory@linaro.org" <graeme.gregory@linaro.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Charles,

Great thanks for your info.
Sorry, I just see this message.

Would you please provide some info about How to use the WS0/1.
What is the original thought of this two stage timeout?

Those info is very important for implementing this driver. :-)

Thanks again!


On 28 May 2015 at 05:47, administrator <charles.garcia-tobin@arm.com> wrote:
> Hi
>
> On 5/26/15, 6:11 PM, "Al Stone" <al.stone@linaro.org> wrote:
>
>>On 05/22/2015 04:52 PM, Timur Tabi wrote:
>>> The ARM Server Base System Architecture is a specification for ARM-based
>>> server systems.  Among other things, it defines the behavior and
>>>register
>>> interface for a watchdog timer.
>>>
>>> Signed-off-by: Timur Tabi <timur@codeaurora.org>
>>> ---
>>
>>My apologies for not getting a chance to think through earlier versions
>>before now.
>>
>>So, this is meant to be SBSA compliant; is it also meant to be SBBR
>>compliant?
>>I suspect not, since there is no ACPI initialization and SBBR requires
>>both
>>UEFI and ACPI.  Is there any reason for not being SBBR compliant?  I'm not
>>saying this is good or bad; I'm only trying to understand the reasoning.
>>
>>I'll also admit that I'm not an expert in ARM timers.  Could I ask a
>>really big
>>favor, please?  When I read the SBSA (section 5.2, specifically), that
>>implies
>>to me that there are two interrupts: a first interrupt for the timer
>>itself set
>>to go off after the timeout expires, and a second interrupt that is
>>required
>>when the timeout expires to force some "executive action".  I only see
>>one IRQ
>>in the patch; what am I missing?
>
> The sbsa watchdog has two signals, WS0 and WS1, or as some have now
> renamed them,
> the bark and bite. At a kernel level the first is going to come in as an
> interrupt,
> and second will be a essentially a reset.This gives you two chances at
> recovery. One
> reason for having this second chance is to allow a debug agent to step in
> an gather
> crash information.
>
> HTH
>
> Charles
>
>>
>>Thanks.
>>
>>> [v4]
>>> Removed COMPILE_TEST
>>> pm_status is now bool
>>> removed some #includes
>>> use do_div instead
>>> display arch version if unsupported
>>> remove watchdog_set_drvdata
>>>
>>>  drivers/watchdog/Kconfig        |   9 ++
>>>  drivers/watchdog/Makefile       |   1 +
>>>  drivers/watchdog/arm_sbsa_wdt.c | 295
>>>++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 305 insertions(+)
>>>  create mode 100644 drivers/watchdog/arm_sbsa_wdt.c
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index e5e7c55..7720190 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -514,6 +514,15 @@ config MEDIATEK_WATCHDOG
>>>        To compile this driver as a module, choose M here: the
>>>        module will be called mtk_wdt.
>>>
>>> +config ARM_SBSA_WDT
>>> +    tristate "ARM Server Base System Architecture watchdog"
>>> +    depends on ARM64
>>> +    depends on ARM_ARCH_TIMER
>>> +    select WATCHDOG_CORE
>>> +    help
>>> +      Say Y here to include watchdog timer support for ARM Server Base
>>> +      System Architecture (SBSA) systems.
>>> +
>>>  # AVR32 Architecture
>>>
>>>  config AT32AP700X_WDT
>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>> index 5c19294..063ab8c 100644
>>> --- a/drivers/watchdog/Makefile
>>> +++ b/drivers/watchdog/Makefile
>>> @@ -64,6 +64,7 @@ obj-$(CONFIG_BCM_KONA_WDT) += bcm_kona_wdt.o
>>>  obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
>>>  obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
>>>  obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
>>> +obj-$(CONFIG_ARM_SBSA_WDT) += arm_sbsa_wdt.o
>>>
>>>  # AVR32 Architecture
>>>  obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
>>> diff --git a/drivers/watchdog/arm_sbsa_wdt.c
>>>b/drivers/watchdog/arm_sbsa_wdt.c
>>> new file mode 100644
>>> index 0000000..12ed520e
>>> --- /dev/null
>>> +++ b/drivers/watchdog/arm_sbsa_wdt.c
>>> @@ -0,0 +1,295 @@
>>> +/*
>>> + * Watchdog driver for SBSA-compliant watchdog timers
>>> + *
>>> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 and
>>> + * only version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * ARM Server Base System Architecture watchdog driver.
>>> + *
>>> + * Register descriptions are taken from the ARM Server Base System
>>> + * Architecture document (ARM-DEN-0029)
>>> + */
>>> +
>>> +#define pr_fmt(fmt) "sbsa-gwdt: " fmt
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/watchdog.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/of.h>
>>> +#include <linux/device.h>
>>> +#include <linux/io.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/reboot.h>
>>> +
>>> +#include <asm/arch_timer.h>
>>> +
>>> +/* Watchdog Interface Identification Registers */
>>> +struct arm_sbsa_watchdog_ident {
>>> +    __le32 w_iidr;  /* Watchdog Interface Identification Register */
>>> +    uint8_t res2[0xFE8 - 0xFD0];
>>> +    __le32 w_pidr2; /* Peripheral ID2 Register */
>>> +};
>>> +
>>> +/* Watchdog Refresh Frame */
>>> +struct arm_sbsa_watchdog_refresh {
>>> +    __le32 wrr;             /* Watchdog Refresh Register */
>>> +    uint8_t res1[0xFCC - 0x004];
>>> +    struct arm_sbsa_watchdog_ident ident;
>>> +};
>>> +
>>> +/* Watchdog Control Frame */
>>> +struct arm_sbsa_watchdog_control {
>>> +    __le32 wcs;
>>> +    __le32 res1;
>>> +    __le32 wor;
>>> +    __le32 res2;
>>> +    __le64 wcv;
>>> +    uint8_t res3[0xFCC - 0x018];
>>> +    struct arm_sbsa_watchdog_ident ident;
>>> +};
>>> +
>>> +struct arm_sbsa_watchdog_data {
>>> +    struct watchdog_device wdev;
>>> +    bool pm_status;
>>> +    struct arm_sbsa_watchdog_refresh __iomem *refresh;
>>> +    struct arm_sbsa_watchdog_control __iomem *control;
>>> +};
>>> +
>>> +static int arm_sbsa_wdt_start(struct watchdog_device *wdev)
>>> +{
>>> +    struct arm_sbsa_watchdog_data *data =
>>> +            container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
>>> +
>>> +    /* Writing to the control register will also reset the counter */
>>> +    writel(1, &data->control->wcs);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int arm_sbsa_wdt_stop(struct watchdog_device *wdev)
>>> +{
>>> +    struct arm_sbsa_watchdog_data *data =
>>> +            container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
>>> +
>>> +    writel(0, &data->control->wcs);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int arm_sbsa_wdt_set_timeout(struct watchdog_device *wdev,
>>> +    unsigned int timeout)
>>> +{
>>> +    struct arm_sbsa_watchdog_data *data =
>>> +            container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
>>> +
>>> +    wdev->timeout = timeout;
>>> +    writel(arch_timer_get_cntfrq() * wdev->timeout, &data->control->wor);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int arm_sbsa_wdt_ping(struct watchdog_device *wdev)
>>> +{
>>> +    struct arm_sbsa_watchdog_data *data =
>>> +            container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
>>> +
>>> +    writel(1, &data->refresh->wrr);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static unsigned int arm_sbsa_wdt_status(struct watchdog_device *wdev)
>>> +{
>>> +    struct arm_sbsa_watchdog_data *data =
>>> +            container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
>>> +
>>> +    return (readl(&data->control->wcs) & 1) << WDOG_ACTIVE;
>>> +}
>>> +
>>> +static unsigned int arm_sbsa_wdt_timeleft(struct watchdog_device *wdev)
>>> +{
>>> +    struct arm_sbsa_watchdog_data *data =
>>> +            container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
>>> +    uint64_t diff = readq(&data->control->wcv) -
>>>arch_counter_get_cntvct();
>>> +
>>> +    do_div(diff, arch_timer_get_cntfrq());
>>> +
>>> +    return diff;
>>> +}
>>> +
>>> +static irqreturn_t arm_sbsa_wdt_interrupt(int irq, void *p)
>>> +{
>>> +    /*
>>> +     * The WS0 interrupt occurs after the first timeout, so we attempt
>>> +     * a manual reboot.  If this doesn't work, the WS1 timeout will
>>> +     * cause a hardware reset.
>>> +     */
>>> +    pr_crit("Initiating system reboot\n");
>>> +    emergency_restart();
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>> +/*
>>> + * Disable watchdog if it is active during suspend
>>> + */
>>> +static int __maybe_unused arm_sbsa_wdt_suspend(struct device *dev)
>>> +{
>>> +    struct arm_sbsa_watchdog_data *data = dev_get_drvdata(dev);
>>> +
>>> +    data->pm_status = !!(readl(&data->control->wcs) & 1);
>>> +
>>> +    if (data->pm_status)
>>> +            writel(0, &data->control->wcs);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/*
>>> + * Enable watchdog and configure it if necessary
>>> + */
>>> +static int __maybe_unused arm_sbsa_wdt_resume(struct device *dev)
>>> +{
>>> +    struct arm_sbsa_watchdog_data *data = dev_get_drvdata(dev);
>>> +
>>> +    if (data->pm_status)
>>> +            writel(1, &data->control->wcs);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct dev_pm_ops arm_sbsa_wdt_pm_ops = {
>>> +    SET_SYSTEM_SLEEP_PM_OPS(arm_sbsa_wdt_suspend, arm_sbsa_wdt_resume)
>>> +};
>>> +
>>> +static struct watchdog_info arm_sbsa_wdt_info = {
>>> +    .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>>> +    .identity = "ARM SBSA watchdog",
>>> +};
>>> +
>>> +static struct watchdog_ops arm_sbsa_wdt_ops = {
>>> +    .owner = THIS_MODULE,
>>> +    .start = arm_sbsa_wdt_start,
>>> +    .stop = arm_sbsa_wdt_stop,
>>> +    .ping = arm_sbsa_wdt_ping,
>>> +    .set_timeout = arm_sbsa_wdt_set_timeout,
>>> +    .status = arm_sbsa_wdt_status,
>>> +    .get_timeleft = arm_sbsa_wdt_timeleft,
>>> +};
>>> +
>>> +static int __init arm_sbsa_wdt_probe(struct platform_device *pdev)
>>> +{
>>> +    struct arm_sbsa_watchdog_data *data;
>>> +    struct resource *res;
>>> +    uint32_t iidr;
>>> +    unsigned int arch;
>>> +    int irq, ret;
>>> +
>>> +    data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>>> +    if (!data)
>>> +            return -ENOMEM;
>>> +
>>> +    res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "control");
>>> +    data->control = devm_ioremap_resource(&pdev->dev, res);
>>> +    if (IS_ERR(data->control))
>>> +            return PTR_ERR(data->control);
>>> +
>>> +    res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "refresh");
>>> +    data->refresh = devm_ioremap_resource(&pdev->dev, res);
>>> +    if (IS_ERR(data->refresh))
>>> +            return PTR_ERR(data->refresh);
>>> +
>>> +    /* We only support architecture version 0 */
>>> +    iidr = readl(&data->control->ident.w_iidr);
>>> +    arch = (iidr >> 16) & 0xf;
>>> +    if (arch != 0) {
>>> +            dev_err(&pdev->dev,
>>> +                     "architecture version %u is not supported\n", arch);
>>> +            return -ENODEV;
>>> +    }
>>> +
>>> +    irq = platform_get_irq_byname(pdev, "ws0");
>>> +    if (irq < 0) {
>>> +            dev_err(&pdev->dev, "could not get interrupt\n");
>>> +            return irq;
>>> +    }
>>> +
>>> +    ret = devm_request_irq(&pdev->dev, irq, arm_sbsa_wdt_interrupt,
>>> +                           0, pdev->name, NULL);
>>> +    if (ret < 0) {
>>> +            dev_err(&pdev->dev, "could not request irq %i (ret=%i)\n",
>>> +                    irq, ret);
>>> +            return ret;
>>> +    }
>>> +
>>> +    data->wdev.info = &arm_sbsa_wdt_info;
>>> +    data->wdev.ops = &arm_sbsa_wdt_ops;
>>> +    data->wdev.min_timeout = 1;
>>> +    data->wdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
>>> +
>>> +    /* Calculate the maximum timeout in seconds that we can support */
>>> +    data->wdev.max_timeout = U32_MAX / arch_timer_get_cntfrq();
>>> +
>>> +    /*
>>> +     * Bits [15:12] are an implementation-defined revision number
>>> +     * for the component.
>>> +     */
>>> +    arm_sbsa_wdt_info.firmware_version = (iidr >> 12) & 0xf;
>>> +
>>> +    ret = watchdog_register_device(&data->wdev);
>>> +    if (ret < 0) {
>>> +            dev_err(&pdev->dev,
>>> +                    "could not register watchdog device (ret=%i)\n", ret);
>>> +            return ret;
>>> +    }
>>> +
>>> +    dev_dbg(&pdev->dev, "implementer code is %03x\n",
>>> +             (iidr & 0xf00) >> 1 | (iidr & 0x7f));
>>> +    dev_info(&pdev->dev, "maximum timeout is %u seconds\n",
>>> +             data->wdev.max_timeout);
>>> +
>>> +    platform_set_drvdata(pdev, data);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int __exit arm_sbsa_wdt_remove(struct platform_device *pdev)
>>> +{
>>> +    struct arm_sbsa_watchdog_data *data = platform_get_drvdata(pdev);
>>> +
>>> +    watchdog_unregister_device(&data->wdev);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +#if IS_ENABLED(CONFIG_OF)
>>> +static const struct of_device_id arm_sbsa_wdt_of_match[] = {
>>> +    { .compatible = "arm,sbsa-gwdt" },
>>> +    {},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, arm_sbsa_wdt_of_match);
>>> +#endif
>>> +
>>> +static struct platform_driver arm_sbsa_wdt_driver = {
>>> +    .driver = {
>>> +            .name = "sbsa-gwdt",
>>> +            .owner = THIS_MODULE,
>>> +            .pm = &arm_sbsa_wdt_pm_ops,
>>> +            .of_match_table = of_match_ptr(arm_sbsa_wdt_of_match),
>>> +    },
>>> +    .probe = arm_sbsa_wdt_probe,
>>> +    .remove = __exit_p(arm_sbsa_wdt_remove),
>>> +};
>>> +
>>> +module_platform_driver(arm_sbsa_wdt_driver);
>>> +
>>> +MODULE_DESCRIPTION("ARM Server Base System Architecture Watchdog
>>>Driver");
>>> +MODULE_LICENSE("GPL v2");
>>>
>>
>>
>>--
>>ciao,
>>al
>>-----------------------------------
>>Al Stone
>>Software Engineer
>>Linaro Enterprise Group
>>al.stone@linaro.org
>>-----------------------------------
>>_______________________________________________
>>Linaro-acpi mailing list
>>Linaro-acpi@lists.linaro.org
>>https://lists.linaro.org/mailman/listinfo/linaro-acpi
>
>



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
