Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34269 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbbEANJU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 May 2015 09:09:20 -0400
Received: by obfe9 with SMTP id e9so65103442obf.1
        for <linux-watchdog@vger.kernel.org>; Fri, 01 May 2015 06:09:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1430336034-5275-1-git-send-email-timur@codeaurora.org>
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org>
Date: Fri, 1 May 2015 09:09:19 -0400
Message-ID: <CAJ5Y-eaX6CYV5w5Xq_Sehvk9UyDBi1ZjaRc8=muqx_+5LddMJA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: introduce the ARM64 SBSA watchdog driver
From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: linux-watchdog@vger.kernel.org,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

+ Linaro-acpi

On 29 April 2015 at 15:33, Timur Tabi <timur@codeaurora.org> wrote:
> The ARM Server Base System Architecture is a specification for ARM-based
> server systems.  Among other things, it defines the behavior and register
> interface for a watchdog timer.
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  drivers/watchdog/Kconfig        |  10 ++
>  drivers/watchdog/Makefile       |   1 +
>  drivers/watchdog/arm_sbsa_wdt.c | 368 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 379 insertions(+)
>  create mode 100644 drivers/watchdog/arm_sbsa_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index e5e7c55..a2a133f 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -514,6 +514,16 @@ config MEDIATEK_WATCHDOG
>           To compile this driver as a module, choose M here: the
>           module will be called mtk_wdt.
>
> +config ARM_SBSA_WDT
> +       bool "ARM Server Base System Architecture watchdog"
> +       depends on ACPI
> +       depends on ARM64
> +       depends on ARM_ARCH_TIMER
> +       select WATCHDOG_CORE
> +       help
> +         Say Y here to include watchdog timer support for ARM Server Base
> +         System Architecture (SBSA) systems.
> +
>  # AVR32 Architecture
>
>  config AT32AP700X_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 5c19294..063ab8c 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_BCM_KONA_WDT) += bcm_kona_wdt.o
>  obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
>  obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
>  obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
> +obj-$(CONFIG_ARM_SBSA_WDT) += arm_sbsa_wdt.o
>
>  # AVR32 Architecture
>  obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> diff --git a/drivers/watchdog/arm_sbsa_wdt.c b/drivers/watchdog/arm_sbsa_wdt.c
> new file mode 100644
> index 0000000..2a2be40
> --- /dev/null
> +++ b/drivers/watchdog/arm_sbsa_wdt.c
> @@ -0,0 +1,368 @@
> +/*
> + * Watchdog driver for SBSA-compliant watchdog timers
> + *
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * ARM Server Base System Architecture watchdog driver.
> + *
> + * Register descriptions are taken from the ARM Server Base System
> + * Architecture document (ARM-DEN-0029)
> + */
> +
> +#define DRV_NAME "arm-sbsa-wdt"
> +#define pr_fmt(fmt) DRV_NAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/watchdog.h>
> +#include <linux/platform_device.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +
> +#include <linux/irqdomain.h>
> +#include <linux/interrupt.h>
> +#include <linux/reboot.h>
> +
> +#include <clocksource/arm_arch_timer.h>
> +#include <linux/acpi.h>
> +
> +/* Watchdog Interface Identification Registers */
> +struct arm_sbsa_watchdog_ident {
> +       uint32_t w_iidr;        /* Watchdog Interface Identification Register */
> +       uint8_t res2[0xFE8 - 0xFD0];
> +       uint32_t w_pidr2;       /* Peripheral ID2 Register */
> +};
> +
> +/* Watchdog Refresh Frame */
> +struct arm_sbsa_watchdog_refresh {
> +       uint32_t wrr;           /* Watchdog Refresh Register */
> +       uint8_t res1[0xFCC - 0x004];
> +       struct arm_sbsa_watchdog_ident ident;
> +};
> +
> +/* Watchdog Control Frame */
> +struct arm_sbsa_watchdog_control {
> +       uint32_t wcs;
> +       uint32_t res1;
> +       uint32_t wor;
> +       uint32_t res2;
> +       uint64_t wcv;
> +       uint8_t res3[0xFCC - 0x018];
> +       struct arm_sbsa_watchdog_ident ident;
> +};
> +
> +struct arm_sbsa_watchdog_data {
> +       struct watchdog_device wdev;
> +       struct arm_sbsa_watchdog_refresh __iomem *refresh;
> +       struct arm_sbsa_watchdog_control __iomem *control;
> +};
> +
> +static int arm_sbsa_wdt_start(struct watchdog_device *wdev)
> +{
> +       struct arm_sbsa_watchdog_data *data =
> +               container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
> +
> +       /* Writing to the control register will also reset the counter */
> +       writel(1, &data->control->wcs);
> +
> +       return 0;
> +}
> +
> +static int arm_sbsa_wdt_stop(struct watchdog_device *wdev)
> +{
> +       struct arm_sbsa_watchdog_data *data =
> +               container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
> +
> +       writel(0, &data->control->wcs);
> +
> +       return 0;
> +}
> +
> +static int arm_sbsa_wdt_set_timeout(struct watchdog_device *wdev,
> +       unsigned int timeout)
> +{
> +       struct arm_sbsa_watchdog_data *data =
> +               container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
> +
> +       wdev->timeout = timeout;
> +       writel(arch_timer_get_rate() * wdev->timeout, &data->control->wor);
> +
> +       return 0;
> +}
> +
> +static int arm_sbsa_wdt_ping(struct watchdog_device *wdev)
> +{
> +       struct arm_sbsa_watchdog_data *data =
> +               container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
> +
> +       writel(1, &data->refresh->wrr);
> +
> +       return 0;
> +}
> +
> +static unsigned int arm_sbsa_wdt_status(struct watchdog_device *wdev)
> +{
> +       struct arm_sbsa_watchdog_data *data =
> +               container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
> +
> +       return (readl(&data->control->wcs) & 1) << WDOG_ACTIVE;
> +}
> +
> +static unsigned int arm_sbsa_wdt_timeleft(struct watchdog_device *wdev)
> +{
> +       struct arm_sbsa_watchdog_data *data =
> +               container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
> +
> +       uint64_t diff = readq(&data->control->wcv) - arch_timer_read_counter();
> +
> +       return diff / arch_timer_get_rate();
> +}
> +
> +static struct watchdog_info arm_sbsa_wdt_info = {
> +       .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +       .identity = "ARM SBSA watchdog",
> +};
> +
> +static struct watchdog_ops arm_sbsa_wdt_ops = {
> +       .owner = THIS_MODULE,
> +       .start = arm_sbsa_wdt_start,
> +       .stop = arm_sbsa_wdt_stop,
> +       .ping = arm_sbsa_wdt_ping,
> +       .set_timeout = arm_sbsa_wdt_set_timeout,
> +       .status = arm_sbsa_wdt_status,
> +       .get_timeleft = arm_sbsa_wdt_timeleft,
> +};
> +
> +static irqreturn_t arm_sbsa_wdt_interrupt(int irq, void *p)
> +{
> +       /*
> +        * The WS0 interrupt occurs after the first timeout, so we attempt
> +        * a manual reboot.  If this doesn't work, the WS1 timeout will
> +        * cause a hardware reset.
> +        */
> +       emergency_restart();
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int __init arm_sbsa_wdt_probe(struct platform_device *pdev)
> +{
> +       struct arm_sbsa_watchdog_data *data;
> +       struct resource *res;
> +       uint32_t iidr;
> +       int ret;
> +
> +       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res || !res->start) {
> +               dev_err(&pdev->dev, "could not get control address\n");
> +               return -ENOMEM;
> +       }
> +
> +       data->control = devm_ioremap_resource(&pdev->dev, res);
> +       if (!data->control)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       if (!res || !res->start) {
> +               dev_err(&pdev->dev, "could not get refresh address\n");
> +               return -ENOMEM;
> +       }
> +       data->refresh = devm_ioremap_resource(&pdev->dev, res);
> +       if (!data->refresh)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +       if (!res || !res->start) {
> +               dev_err(&pdev->dev, "could not get interrupt\n");
> +               return -ENOMEM;
> +       }
> +
> +       iidr = readl(&data->control->ident.w_iidr);
> +
> +       /* We only support architecture version 0 */
> +       if (((iidr >> 16) & 0xf) != 0) {
> +               dev_info(&pdev->dev, "only architecture version 0 is supported\n");
> +               return -ENODEV;
> +       }
> +
> +       ret = devm_request_irq(&pdev->dev, res->start, arm_sbsa_wdt_interrupt,
> +               0, DRV_NAME, NULL);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "could not request irq %u (ret=%i)\n",
> +                       (unsigned int)res->start, ret);
> +               return ret;
> +       }
> +
> +       data->wdev.info = &arm_sbsa_wdt_info;
> +       data->wdev.ops = &arm_sbsa_wdt_ops;
> +       data->wdev.min_timeout = 1;
> +       data->wdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
> +
> +       /* Calculate the maximum timeout in seconds that we can support */
> +       data->wdev.max_timeout = U32_MAX / arch_timer_get_rate();
> +
> +       ret = watchdog_register_device(&data->wdev);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev,
> +                       "could not register watchdog device (ret=%i)\n", ret);
> +               return ret;
> +       }
> +
> +       dev_info(&pdev->dev, "implementer code is %03x, max timeout is %u seconds\n",
> +               (iidr & 0xf00) >> 1 | (iidr & 0x7f), data->wdev.max_timeout);
> +
> +       /*
> +        * Bits [15:12] are an implementation-defined revision number
> +        * for the component.
> +        */
> +       arm_sbsa_wdt_info.firmware_version = (iidr >> 12) & 0xf;
> +
> +       platform_set_drvdata(pdev, data);
> +
> +       return 0;
> +}
> +
> +static int __exit arm_sbsa_wdt_remove(struct platform_device *pdev)
> +{
> +       struct arm_sbsa_watchdog_data *data = platform_get_drvdata(pdev);
> +
> +       watchdog_unregister_device(&data->wdev);
> +
> +       return 0;
> +}
> +
> +static struct platform_device *arm_sbsa_wdt_pdev;
> +
> +static int __init arm_sbsa_wdt_parse_gtdt(struct acpi_subtable_header *header,
> +       const unsigned long end)
> +{
> +       struct acpi_gtdt_watchdog *wdg = (struct acpi_gtdt_watchdog *)header;
> +       struct platform_device *arm_sbsa_wdt_pdev;
> +       struct resource res[3] = {};
> +       int trigger, polarity;
> +       int ret;
> +
> +       if (!header ||
> +           (unsigned long)header + sizeof(*wdg) > end ||
> +           header->length < sizeof(*wdg)) {
> +               pr_err("malformed subtable entry\n");
> +               return -EINVAL;
> +       }
> +
> +       if (!wdg->control_frame_address || !wdg->refresh_frame_address) {
> +               pr_err("invalid control or refresh address\n");
> +               return -ENXIO;
> +       }
> +
> +       arm_sbsa_wdt_pdev = platform_device_alloc(DRV_NAME, 0);
> +       if (!arm_sbsa_wdt_pdev)
> +               return -ENOMEM;
> +
> +       res[0].name = "control";
> +       res[0].flags = IORESOURCE_MEM;
> +       res[0].start = wdg->control_frame_address;
> +       res[0].end = res[0].start + sizeof(struct arm_sbsa_watchdog_control);
> +
> +       res[1].name = "refresh";
> +       res[1].flags = IORESOURCE_MEM;
> +       res[1].start = wdg->refresh_frame_address;
> +       res[1].end = res[1].start + sizeof(struct arm_sbsa_watchdog_refresh);
> +
> +       trigger = (wdg->timer_flags & ACPI_GTDT_WATCHDOG_IRQ_MODE) ?
> +               ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
> +
> +       polarity = (wdg->timer_flags & ACPI_GTDT_WATCHDOG_IRQ_POLARITY) ?
> +               ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
> +
> +       /* This should be the WS0 interrupt */
> +       ret = acpi_register_gsi(&arm_sbsa_wdt_pdev->dev, wdg->timer_interrupt,
> +               trigger, polarity);
> +       if (ret <= 0) {
> +               pr_err("could not obtain interrupt\n");
> +               goto error_platform;
> +       }
> +
> +       res[2].name = "irq";
> +       res[2].flags = IORESOURCE_IRQ;
> +       res[2].start = ret;
> +       res[2].end = res[2].start;
> +
> +       ret = platform_device_add_resources(arm_sbsa_wdt_pdev, res,
> +               ARRAY_SIZE(res));
> +       if (ret) {
> +               pr_err("could not add platform resources\n");
> +               goto error_acpi;
> +       }
> +
> +       ret = platform_device_add(arm_sbsa_wdt_pdev);
> +       if (ret) {
> +               pr_err("could not add platform device\n");
> +               goto error_acpi;
> +       }
> +
> +       return 0;
> +
> +error_acpi:
> +       acpi_unregister_gsi(res[2].start);
> +
> +error_platform:
> +       platform_device_put(arm_sbsa_wdt_pdev);
> +
> +       return ret;
> +}
> +
> +static struct platform_driver arm_sbsa_wdt_driver = {
> +       .remove = __exit_p(arm_sbsa_wdt_remove),
> +       .driver = {
> +                  .name = DRV_NAME,
> +                  .owner = THIS_MODULE,
> +       },
> +};
> +
> +static int __init arm_sbsa_wdt_init(void)
> +{
> +       struct acpi_table_header *table;
> +       acpi_size tbl_size;
> +       acpi_status status;
> +       int count;
> +
> +       pr_info("ARM Server Base System Architecture watchdog driver\n");
> +
> +       status = acpi_get_table_with_size(ACPI_SIG_GTDT, 0, &table, &tbl_size);
> +       if (ACPI_FAILURE(status)) {
> +               pr_err("cannot locate GTDT table\n");
> +               return -EINVAL;
> +       }
> +       count = acpi_parse_entries(ACPI_SIG_GTDT, sizeof(struct acpi_table_gtdt),
> +               arm_sbsa_wdt_parse_gtdt, table, ACPI_GTDT_TYPE_WATCHDOG, 0);
> +       if (count <= 0) {
> +               pr_err("no watchdog subtables found\n");
> +               return -EINVAL;
> +       }
> +
> +       return platform_driver_probe(&arm_sbsa_wdt_driver, arm_sbsa_wdt_probe);
> +}
> +
> +static void __exit arm_sbsa_wdt_exit(void)
> +{
> +       platform_device_unregister(arm_sbsa_wdt_pdev);
> +       platform_driver_unregister(&arm_sbsa_wdt_driver);
> +}
> +
> +module_init(arm_sbsa_wdt_init);
> +module_exit(arm_sbsa_wdt_exit);
> +
> +MODULE_DESCRIPTION("ARM Server Base System Architecture Watchdog Driver");
> +MODULE_LICENSE("GPL v2");
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
>
