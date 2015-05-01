Return-path: <timur@codeaurora.org>
Message-ID: <5543A6E9.1090203@codeaurora.org>
Date: Fri, 01 May 2015 11:16:41 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Vipul Gandhi <vgandhi@codeaurora.org>, Fu Wei <fu.wei@linaro.org>,
 Al Stone <al.stone@linaro.org>,
 Wim Van Sebroeck <wim@iguana.be>, Hanjun Guo <hanjun.guo@linaro.org>,
 linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org> <5542F33D.2020206@roeck-us.net>
In-Reply-To: <5542F33D.2020206@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 04/30/2015 10:30 PM, Guenter Roeck wrote:

>> +/* Watchdog Refresh Frame */
>> +struct arm_sbsa_watchdog_refresh {
>> +    uint32_t wrr;        /* Watchdog Refresh Register */
>> +    uint8_t res1[0xFCC - 0x004];
>> +    struct arm_sbsa_watchdog_ident ident;
>> +};
>> +
>> +/* Watchdog Control Frame */
>> +struct arm_sbsa_watchdog_control {
>> +    uint32_t wcs;
>> +    uint32_t res1;
>> +    uint32_t wor;
>> +    uint32_t res2;
>> +    uint64_t wcv;
>> +    uint8_t res3[0xFCC - 0x018];
>> +    struct arm_sbsa_watchdog_ident ident;
>> +};
>> +
>
> Why not just use defines instead of all those structures ?

I like structures.  I think hardware register blocks should be defined 
with structures that provide type checking.

>> +static int arm_sbsa_wdt_set_timeout(struct watchdog_device *wdev,
>> +    unsigned int timeout)
>> +{
>> +    struct arm_sbsa_watchdog_data *data =
>> +        container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
>> +
>> +    wdev->timeout = timeout;
>> +    writel(arch_timer_get_rate() * wdev->timeout, &data->control->wor);
>
> Do you also have to reset the counter ?

No.  Programming a new timeout automatically resets the timer.

>> +static int __init arm_sbsa_wdt_probe(struct platform_device *pdev)
>> +{
>> +    struct arm_sbsa_watchdog_data *data;
>> +    struct resource *res;
>> +    uint32_t iidr;
>> +    int ret;
>> +
>> +    data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +    if (!data)
>> +        return -ENOMEM;
>> +
>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    if (!res || !res->start) {
>> +        dev_err(&pdev->dev, "could not get control address\n");
>> +        return -ENOMEM;
>> +    }
>> +
> devm_ioremap_resource already prints an error message if res is NULL.
> And res->start can not be 0 unless there is a severe infrastructure
> problem.

Will fix.

>> +    data->control = devm_ioremap_resource(&pdev->dev, res);
>> +    if (!data->control)
>> +        return -ENOMEM;
>> +
>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +    if (!res || !res->start) {
>> +        dev_err(&pdev->dev, "could not get refresh address\n");
>> +        return -ENOMEM;
>> +    }
> Same here.
>
>> +    data->refresh = devm_ioremap_resource(&pdev->dev, res);
>> +    if (!data->refresh)
>> +        return -ENOMEM;
>> +
>> +    res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> +    if (!res || !res->start) {
>
> res->start checking is unnecessary. On a side note, irq == 0 might be a
> valid
> interrupt number.

Will fix.

>
>> +        dev_err(&pdev->dev, "could not get interrupt\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    iidr = readl(&data->control->ident.w_iidr);
>> +
>> +    /* We only support architecture version 0 */
>> +    if (((iidr >> 16) & 0xf) != 0) {
>> +        dev_info(&pdev->dev, "only architecture version 0 is
>> supported\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    ret = devm_request_irq(&pdev->dev, res->start,
>> arm_sbsa_wdt_interrupt,
>> +        0, DRV_NAME, NULL);
>
> Please align continuation lines with '('.

Will fix.

>> +    if (ret < 0) {
>> +        dev_err(&pdev->dev, "could not request irq %u (ret=%i)\n",
>> +            (unsigned int)res->start, ret);
>> +        return ret;
>> +    }
>> +
>> +    data->wdev.info = &arm_sbsa_wdt_info;
>> +    data->wdev.ops = &arm_sbsa_wdt_ops;
>> +    data->wdev.min_timeout = 1;
>> +    data->wdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
>> +
>> +    /* Calculate the maximum timeout in seconds that we can support */
>> +    data->wdev.max_timeout = U32_MAX / arch_timer_get_rate();
>> +
>> +    ret = watchdog_register_device(&data->wdev);
>> +    if (ret < 0) {
>> +        dev_err(&pdev->dev,
>> +            "could not register watchdog device (ret=%i)\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    dev_info(&pdev->dev, "implementer code is %03x, max timeout is %u
>> seconds\n",
>> +        (iidr & 0xf00) >> 1 | (iidr & 0x7f), data->wdev.max_timeout);
>
> "Implementer code" sounds very much like a debug message to me.
> It means nothing to me, and it won't mean anything to a user.

Fair enough.  I thought it would be a handy way to know that the driver 
found the hardware, but I'll move it to a pr_debug().

>> +
>> +    /*
>> +     * Bits [15:12] are an implementation-defined revision number
>> +     * for the component.
>> +     */
>> +    arm_sbsa_wdt_info.firmware_version = (iidr >> 12) & 0xf;
>> +
> It might make sense to set that prior to registering the driver.

Ok.

>> +static struct platform_device *arm_sbsa_wdt_pdev;
>> +
>> +static int __init arm_sbsa_wdt_parse_gtdt(struct acpi_subtable_header
>> *header,
>> +    const unsigned long end)
>> +{
>> +    struct acpi_gtdt_watchdog *wdg = (struct acpi_gtdt_watchdog
>> *)header;
>> +    struct platform_device *arm_sbsa_wdt_pdev;
>
> That is an interesting one. Makes me wonder if you ever tried to unload
> this driver.
> Did you ?

The driver can only be compiled in-kernel.

>> +    struct resource res[3] = {};
>> +    int trigger, polarity;
>> +    int ret;
>> +
>> +    if (!header ||
>
> That error check is kind of weird. Sure, 0 is an invalid address, but so
> are many other
> addresses. Is there any reason to believe that acpi_get_table_with_size
> would return
> a NULL pointer (but not some other invalid address) ?

If the table is uninitialized, then all the values are probably zero.  I 
was trying to come up with something.  These are the only tests I could 
come up with I know work.

>> +        (unsigned long)header + sizeof(*wdg) > end ||
>> +        header->length < sizeof(*wdg)) {
>
> So I really wonder how this is supposed to work.
>
> struct acpi_subtable_header {
>          u8 type;
>          u8 length;
> };
>
> struct acpi_gtdt_watchdog {
>          struct acpi_gtdt_header header;
> ...
>
> struct acpi_gtdt_header {
>          u8 type;
>          u16 length;
> };
>
> Either the length is 16 bit or 8 bit. But both ???
> Or is it just luck and the value happens to be stored as little endian
> value and the length is less than 256 bytes ?
>
> I understand this seems to be copied from BAD_MADT_ENTRY or similar code,
> but it is still odd.

It's the best I could come up with.  Sure it seems weird, but it works, 
and since it's copied from BAD_MADT_ENTRY, I figured it was acceptable.

>
>> +        pr_err("malformed subtable entry\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!wdg->control_frame_address || !wdg->refresh_frame_address) {
>> +        pr_err("invalid control or refresh address\n");
>> +        return -ENXIO;
>> +    }
>> +
>> +    arm_sbsa_wdt_pdev = platform_device_alloc(DRV_NAME, 0);
>> +    if (!arm_sbsa_wdt_pdev)
>> +        return -ENOMEM;
>> +
>> +    res[0].name = "control";
>> +    res[0].flags = IORESOURCE_MEM;
>> +    res[0].start = wdg->control_frame_address;
>> +    res[0].end = res[0].start + sizeof(struct
>> arm_sbsa_watchdog_control);
>
> Really ? Or should there be a -1 somewhere ?

You're right.

>> +
>> +    res[1].name = "refresh";
>> +    res[1].flags = IORESOURCE_MEM;
>> +    res[1].start = wdg->refresh_frame_address;
>> +    res[1].end = res[1].start + sizeof(struct
>> arm_sbsa_watchdog_refresh);
>
> Same here.

Ok.

>> +    trigger = (wdg->timer_flags & ACPI_GTDT_WATCHDOG_IRQ_MODE) ?
>> +        ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>> +
>> +    polarity = (wdg->timer_flags & ACPI_GTDT_WATCHDOG_IRQ_POLARITY) ?
>> +        ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +
>> +    /* This should be the WS0 interrupt */
>> +    ret = acpi_register_gsi(&arm_sbsa_wdt_pdev->dev,
>> wdg->timer_interrupt,
>> +        trigger, polarity);
>> +    if (ret <= 0) {
>
> 0 is not an error (the interrupt number could be 0).

Ok.

>> +static int __init arm_sbsa_wdt_init(void)
>> +{
>> +    struct acpi_table_header *table;
>> +    acpi_size tbl_size;
>> +    acpi_status status;
>> +    int count;
>> +
>> +    pr_info("ARM Server Base System Architecture watchdog driver\n");
>> +
> This seems to assume that the watchdog is always supported, which is
> quite unlikely.

I'll make it a pr_debug.

>> +    status = acpi_get_table_with_size(ACPI_SIG_GTDT, 0, &table,
>> &tbl_size);
>> +    if (ACPI_FAILURE(status)) {
>> +        pr_err("cannot locate GTDT table\n");
>> +        return -EINVAL;
>> +    }
>
> I am kind of completely unhappy with the noisiness here and below.
> Is this how acpi detection is supposed to happen ?
> And is it really an _error_ if the device isn't there,
> or does it just mean that the device isn't there ?

I think the GTDT is required.  Most likely, the kernel will fail to boot 
long before we get to this point if the GTDT is missing or corrupt.

However, I'm not an ACPI expert by any means.  I'm hoping that someone 
who knows a lot more than I do will review it.  This driver was reviewed 
and approved by some of our internal ACPI experts, so I presume that it 
is correct.

>> +    count = acpi_parse_entries(ACPI_SIG_GTDT, sizeof(struct
>> acpi_table_gtdt),
>> +        arm_sbsa_wdt_parse_gtdt, table, ACPI_GTDT_TYPE_WATCHDOG, 0);
>> +    if (count <= 0) {
>> +        pr_err("no watchdog subtables found\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    return platform_driver_probe(&arm_sbsa_wdt_driver,
>> arm_sbsa_wdt_probe);
>
> Another oddity. Is this how acpi device instantiation is supposed to
> happen ?
>
> I thought there are functions to register acpi drivers, such as
> acpi_bus_register_driver().
> Why doesn't this work here ?

I can't use acpi_bus_register_driver() because there are no ACPI IDs to 
probe on.  Watchdog information is stored as a subtable of the GTDT 
table, and there's nothing in the ACPI layer that automatically creates 
platforms from subtables.  I have to create the platform from scratch, 
which is why the code looks so messy.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
