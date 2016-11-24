Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34196 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933643AbcKXUsl (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 24 Nov 2016 15:48:41 -0500
Subject: Re: [PATCH v2] watchdog: nic7018_wdt: Add NIC7018 watchdog driver
To: Hui Chun Ong <hui.chun.ong@ni.com>, wim@iguana.be, corbet@lwn.net
References: <1479266515-9205-1-git-send-email-hui.chun.ong@ni.com>
 <ba6df233-af61-2553-27ab-72d5153c4f19@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
        jonathan.hearn@ni.com, julia.cartwright@ni.com, rjw@rjwysocki.net,
        mika.westerberg@linux.intel.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <253d9320-cf39-22b3-7698-b7e3e77cedce@roeck-us.net>
Date: Thu, 24 Nov 2016 12:48:35 -0800
MIME-Version: 1.0
In-Reply-To: <ba6df233-af61-2553-27ab-72d5153c4f19@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/24/2016 11:56 AM, Guenter Roeck wrote:
> On 11/15/2016 07:21 PM, Hui Chun Ong wrote:
>> Add support for the watchdog timer on PXI Embedded Controller.
>>
>> Signed-off-by: Hui Chun Ong <hui.chun.ong@ni.com>
>> ---
>> v1: Remove non-standard attributes.
>>     Change from acpi_driver to platform_driver.
>>     Rename driver from ni7018_wdt to nic7018_wdt.
>> ---
>>  Documentation/watchdog/watchdog-parameters.txt |   5 +
>>  drivers/watchdog/Kconfig                       |  10 +
>>  drivers/watchdog/Makefile                      |   1 +
>>  drivers/watchdog/nic7018_wdt.c                 | 303 +++++++++++++++++++++++++
>>  4 files changed, 319 insertions(+)
>>  create mode 100644 drivers/watchdog/nic7018_wdt.c
>>
>> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
>> index a8d3642..bd142fa 100644
>> --- a/Documentation/watchdog/watchdog-parameters.txt
>> +++ b/Documentation/watchdog/watchdog-parameters.txt
>> @@ -209,6 +209,11 @@ timeout: Initial watchdog timeout in seconds (0<timeout<516, default=60)
>>  nowayout: Watchdog cannot be stopped once started
>>      (default=kernel config parameter)
>>  -------------------------------------------------
>> +nic7018_wdt:
>> +timeout: Initial watchdog timeout in seconds (0<timeout<464, default=80)
>> +nowayout: Watchdog cannot be stopped once started
>> +    (default=kernel config parameter)
>> +-------------------------------------------------
>>  nuc900_wdt:
>>  heartbeat: Watchdog heartbeats in seconds.
>>      (default = 15)
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index fdd3228..79fb224 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1325,6 +1325,16 @@ config NI903X_WDT
>>        To compile this driver as a module, choose M here: the module will be
>>        called ni903x_wdt.
>>
>> +config NIC7018_WDT
>> +    tristate "NIC7018 Watchdog"
>> +    depends on X86 && ACPI
>> +    select WATCHDOG_CORE
>> +    ---help---
>> +      This is the device driver for National Instruments NIC7018 Watchdog.
>> +
> This should describe what the watchdog is for.
>
> "Support for National Instruments NIC7018 Watchdog".
>
>> +      To compile this driver as a module, choose M here: the module will be
>> +      called nic7018_wdt.
>> +
>>  # M32R Architecture
>>
>>  # M68K Architecture
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index caa9f4a..bd88e2e 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -139,6 +139,7 @@ obj-$(CONFIG_INTEL_SCU_WATCHDOG) += intel_scu_watchdog.o
>>  obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
>>  obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
>>  obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
>> +obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
>>
>>  # M32R Architecture
>>
>> diff --git a/drivers/watchdog/nic7018_wdt.c b/drivers/watchdog/nic7018_wdt.c
>> new file mode 100644
>> index 0000000..780edc6
>> --- /dev/null
>> +++ b/drivers/watchdog/nic7018_wdt.c
>> @@ -0,0 +1,303 @@
>> +/*
>> + * Copyright (C) 2016 National Instruments Corp.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/watchdog.h>
>> +
>> +#define LOCK            0xA5
>> +#define UNLOCK            0x5A
>> +
>> +#define WDT_CTRL_RESET_EN    BIT(7)
>> +#define WDT_RELOAD_PORT_EN    BIT(7)
>> +
>
> Should include linux/bitops.h
>
>> +#define WDT_CTRL        1
>> +#define WDT_RELOAD_CTRL        2
>> +#define WDT_PRESET_PRESCALE    4
>> +#define WDT_REG_LOCK        5
>> +#define WDT_COUNT        6
>> +#define WDT_RELOAD_PORT        7
>> +
>> +#define WDT_MIN_TIMEOUT        1
>> +#define WDT_MAX_TIMEOUT        464
>
> 32 * 15 would be 480 ? I assume the limit above is because of the rounding down
> by 16 in the driver, but that only shows that this rounding is maybe not the best
> idea. After all, the maximum timeout _is_ 480 seconds, if I understand the code
> correctly.
>
>> +#define WDT_DEFAULT_TIMEOUT    80
>> +
>
> Kind of an odd number, as it can not really be expressed by the hardware.
> The real timeout, if I understand the code correctly, would be 96 (32 * 3)
> seconds. Another data point that the rounding as implemented isn't necessarily
> the best possible implementation.
>
>> +#define WDT_IO_SIZE        8
>> +#define WDT_MAX_COUNTER        15
>> +
>> +static unsigned int timeout;
>> +module_param(timeout, uint, 0);
>> +MODULE_PARM_DESC(timeout,
>> +         "Watchdog timeout in seconds. (default="
>> +         __MODULE_STRING(WDT_DEFAULT_TIMEOUT) ")");
>> +
>> +static int nowayout = WATCHDOG_NOWAYOUT;
>> +module_param(nowayout, int, S_IRUGO);
>
> S_IRUGO is out of favor nowadays. Just use 0444.
> Sure you want this readable, though ? That is quite unusual.
>
>> +MODULE_PARM_DESC(nowayout,
>> +         "Watchdog cannot be stopped once started. (default="
>> +         __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>> +
>> +struct nic7018_wdt {
>> +    u16 io_base;
>> +    u32 period_ms;
>> +    struct mutex lock;
>
> This lock is not necessary. The watchdog core already provides locking.
>
>> +    struct watchdog_device wdd;
>> +    struct platform_device *pdev;
>
> pdev isn't used anywhere.
>
>> +};
>> +
>> +struct nic7018_config {
>> +    u32 period_ms;
>> +    u8 divider;
>> +};
>> +
>> +static const struct nic7018_config nic7018_configs[] = {
>> +    {   125, 3 },
>> +    {  2000, 4 },
>> +    { 32000, 5 },
>> +};
>> +
>> +static inline u32 nic7018_timeout_ms(u32 period_ms, u8 counter)
>> +{
>> +    return period_ms * counter - period_ms / 2;
>> +}
>> +
>> +static const struct nic7018_config *nic7018_get_config(u32 timeout_ms,
>> +                               u8 *counter)
>> +{
>> +    u32 delta, i, best_delta = U32_MAX;
>> +    const struct nic7018_config *config, *best_config = NULL;
>> +    u8 count;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(nic7018_configs); i++) {
>> +        config = &nic7018_configs[i];
>> +
>> +        count = DIV_ROUND_UP(timeout_ms + config->period_ms / 2,
>> +                     config->period_ms);
>> +
>> +        if (count > WDT_MAX_COUNTER)
>> +            continue;
>> +
>> +        delta = nic7018_timeout_ms(config->period_ms, count) -
>> +            timeout_ms;
>> +
>> +        if (delta < best_delta) {
>> +            best_delta = delta;
>> +            best_config = config;
>> +            *counter = count;
>> +        }
>> +    }
>> +    return best_config;
>> +}
>> +
> This appears overly complex. Ultimately it boils down to something like
>
>     if (timeout_ms <= 125 * (WDT_MAX_COUNTER + 8) {
>         *counter = min(WDT_MAX_COUNTER, DIV_ROUND_UP(timeout_ms, 125));
>         return  &config[0];
>     } else if (timeout_ms <= 2000 * (WDT_MAX_COUNTER + 8) {
>         *counter = min(WDT_MAX_COUNTER, DIV_ROUND_UP(timeout_ms, 2000));
>         return &config[1];
>     }
>     *counter = min(WDT_MAX_COUNTER, DIV_ROUND_UP(timeout_ms, 32000));
>     return &config[2];
>
> or, if you want to be fancy,
>
>     for (i = 0; i < ARRAY_SIZE(nic7018_configs); i++) {
>         config = &nic7018_configs[i];
>         if (timeout_ms <= config->period_ms * (WDT_MAX_COUNTER + 8))

Correction:
	if (timeout_ms <= config->period_ms * (WDT_MAX_COUNTER * 2 + 1) / 2)

>             break;
>     }
>     *counter = min(WDT_MAX_COUNTER, DIV_ROUND_UP(timeout_ms, config->period_ms));
>     return config;
>
>> +static int nic7018_set_timeout(struct watchdog_device *wdd,
>> +                   unsigned int timeout)
>> +{
>> +    struct nic7018_wdt *wdt = watchdog_get_drvdata(wdd);
>> +    const struct nic7018_config *config;
>> +    u8 counter;
>> +
>> +    config = nic7018_get_config(timeout * 1000, &counter);
>> +    if (!config)
>> +        return -EINVAL;
>
> This is not necessary. The maximum timeout guarantees that the core will not request
> a larger timeout than supported. Just have nic7018_get_config() never return an error
> (as suggested above).
>
>> +
>> +    mutex_lock(&wdt->lock);
>> +    outb(counter << 4 | config->divider,
>> +         wdt->io_base + WDT_PRESET_PRESCALE);
>> +
>> +    wdd->timeout = nic7018_timeout_ms(config->period_ms, counter) / 1000;
>> +    wdt->period_ms = config->period_ms;
>> +    mutex_unlock(&wdt->lock);
>> +
>> +    return 0;
>> +}
>> +
>> +static int nic7018_start(struct watchdog_device *wdd)
>> +{
>> +    struct nic7018_wdt *wdt = watchdog_get_drvdata(wdd);
>> +    u8 control;
>> +
>> +    nic7018_set_timeout(wdd, wdd->timeout);
>> +
> Side note: As currently written, the above function can return an error
> (in theory). If that was the case, the code below would have more or less random
> results.
>
>> +    mutex_lock(&wdt->lock);
>> +    control = inb(wdt->io_base + WDT_RELOAD_CTRL);
>> +    outb(control | WDT_RELOAD_PORT_EN, wdt->io_base + WDT_RELOAD_CTRL);
>> +
>> +    outb(1, wdt->io_base + WDT_RELOAD_PORT);
>> +
>> +    control = inb(wdt->io_base + WDT_CTRL);
>> +    outb(control | WDT_CTRL_RESET_EN, wdt->io_base + WDT_CTRL);
>> +    mutex_unlock(&wdt->lock);
>> +
>> +    return 0;
>> +}
>> +
>> +static int nic7018_stop(struct watchdog_device *wdd)
>> +{
>> +    struct nic7018_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +    mutex_lock(&wdt->lock);
>> +    outb(0, wdt->io_base + WDT_CTRL);
>> +    outb(0, wdt->io_base + WDT_RELOAD_CTRL);
>> +    outb(0xF0, wdt->io_base + WDT_PRESET_PRESCALE);
>> +    mutex_unlock(&wdt->lock);
>> +
>> +    return 0;
>> +}
>> +
>> +static int nic7018_ping(struct watchdog_device *wdd)
>> +{
>> +    struct nic7018_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +    mutex_lock(&wdt->lock);
>> +    outb(1, wdt->io_base + WDT_RELOAD_PORT);
>> +    mutex_unlock(&wdt->lock);
>> +
>> +    return 0;
>> +}
>> +
>> +static unsigned int nic7018_get_timeleft(struct watchdog_device *wdd)
>> +{
>> +    struct nic7018_wdt *wdt = watchdog_get_drvdata(wdd);
>> +    u8 count;
>> +
>> +    mutex_lock(&wdt->lock);
>> +    count = inb(wdt->io_base + WDT_COUNT) & 0xF;
>> +    mutex_unlock(&wdt->lock);
>> +
>> +    if (!count)
>> +        return 0;
>> +
> This is only needed because of the rounding down in nic7018_timeout_ms().
> I am not really sure if that rounding adds any real value, especially
> since the result is then divided by 1000 without rounding. From my
> perspective, all it does is to add complexity. I would suggest to just return
> wdt->period_ms * count / 1000, or, if you want to be fancy,
> DIV_ROUND_CLOSEST(wdt->period_ms * count, 1000).
>
>> +    return nic7018_timeout_ms(wdt->period_ms, count) / 1000;
>> +}
>> +
>> +static const struct watchdog_info nic7018_wdd_info = {
>> +    .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>> +    .identity = "NIC7018 Watchdog",
>> +};
>> +
>> +static const struct watchdog_ops nic7018_wdd_ops = {
>> +    .owner = THIS_MODULE,
>> +    .start = nic7018_start,
>> +    .stop = nic7018_stop,
>> +    .ping = nic7018_ping,
>> +    .set_timeout = nic7018_set_timeout,
>> +    .get_timeleft = nic7018_get_timeleft,
>> +};
>> +
>> +static int nic7018_probe(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    struct watchdog_device *wdd;
>> +    struct nic7018_wdt *wdt;
>> +    struct resource *io_rc;
>> +    int ret;
>> +
>> +    wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>> +    if (!wdt)
>> +        return -ENOMEM;
>> +
>> +    wdt->pdev = pdev;
>> +    platform_set_drvdata(pdev, wdt);
>> +
>> +    io_rc = platform_get_resource(pdev, IORESOURCE_IO, 0);
>> +    if (!io_rc) {
>> +        dev_err(dev, "missing IO resources\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (resource_size(io_rc) < WDT_IO_SIZE) {
>> +        dev_err(dev, "IO region too small\n");
>> +        return -EINVAL;
>> +    }
>> +
>
> It is highly unusual to check the resource size. I would suggest to drop it.
> Also, please use devm_ioremap_resource(), which returns an error code.
> With that, you don't have to check the error code from platform_get_resource();
> devm_ioremap_resource() does it for you.
>     io_rc = platform_get_resource(pdev, IORESOURCE_IO, 0);
>     wdt->io_base = devm_ioremap_resource(dev, res);
>     if (IS_ERR(wdt->io_base))
>         return PTR_ERR(wdt->io_base);
>
>> +    if (!devm_request_region(dev, io_rc->start, resource_size(io_rc),
>> +                 KBUILD_MODNAME)) {
>> +        dev_err(dev, "failed to get IO region\n");
>> +        return -EBUSY;
>> +    }
>> +
>> +    wdt->io_base = io_rc->start;
>> +    mutex_init(&wdt->lock);
>> +
>> +    wdd = &wdt->wdd;
>> +    wdd->info = &nic7018_wdd_info;
>> +    wdd->ops = &nic7018_wdd_ops;
>> +    wdd->min_timeout = WDT_MIN_TIMEOUT;
>> +    wdd->max_timeout = WDT_MAX_TIMEOUT;
>> +    wdd->timeout = WDT_DEFAULT_TIMEOUT;
>> +    wdd->parent = dev;
>> +
>> +    watchdog_set_drvdata(wdd, wdt);
>> +    watchdog_set_nowayout(wdd, nowayout);
>> +
>> +    ret = watchdog_init_timeout(wdd, timeout, dev);
>> +    if (ret)
>> +        dev_err(dev, "unable to set timeout value, using default\n");
>
> If this is an error, the code whould abort. Either make it a warning, or abort.
>
>> +
>> +    /* Unlock WDT register */
>> +    outb(UNLOCK, wdt->io_base + WDT_REG_LOCK);
>> +
>> +    ret = watchdog_register_device(wdd);
>> +    if (ret) {
>> +        dev_err(dev, "failed to register watchdog\n");
>> +        goto err_out;
>
> No output to WDT_REG_LOCK needed here ?
>
>> +    }
>> +
>> +    dev_dbg(dev, "io_base=0x%04X, timeout=%d, nowayout=%d\n",
>> +        wdt->io_base, timeout, nowayout);
>> +    return 0;
>> +
>> +err_out:
>> +    mutex_destroy(&wdt->lock);
>> +    return ret;
>> +}
>> +
>> +static int nic7018_remove(struct platform_device *pdev)
>> +{
>> +    struct nic7018_wdt *wdt = platform_get_drvdata(pdev);
>> +
>> +    nic7018_stop(&wdt->wdd);
>> +    watchdog_unregister_device(&wdt->wdd);
>> +
>> +    /* Lock WDT register */
>> +    outb(LOCK, wdt->io_base + WDT_REG_LOCK);
>> +
>> +    mutex_destroy(&wdt->lock);
>> +    return 0;
>> +}
>> +
>> +static const struct acpi_device_id nic7018_device_ids[] = {
>> +    {"NIC7018", 0},
>> +    {"", 0},
>> +};
>> +MODULE_DEVICE_TABLE(acpi, nic7018_device_ids);
>> +
>> +static struct platform_driver watchdog_driver = {
>> +    .probe = nic7018_probe,
>> +    .remove = nic7018_remove,
>> +    .driver = {
>> +        .name = KBUILD_MODNAME,
>> +        .acpi_match_table = ACPI_PTR(nic7018_device_ids),
>> +    },
>> +};
>> +
>> +module_platform_driver(watchdog_driver);
>> +
>> +MODULE_DESCRIPTION("National Instruments NIC7018 Watchdog driver");
>> +MODULE_AUTHOR("Hui Chun Ong <hui.chun.ong@ni.com>");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

