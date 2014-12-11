Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35926 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933460AbaLKEEa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Dec 2014 23:04:30 -0500
Date: Wed, 10 Dec 2014 20:04:05 -0800
From: Darren Hart <dvhart@infradead.org>
To: "Muller, Francois-nicolas" <francois-nicolas.muller@intel.com>
Cc: "'platform-driver-x86@vger.kernel.org'"
	<platform-driver-x86@vger.kernel.org>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] TCO Watchdog warning interrupt driver creation
Message-ID: <20141211040404.GA28797@vmdeb7>
References: <B9C02DB17496AC4197F41A146D371B9B075AF9DE@hasmsx107.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B9C02DB17496AC4197F41A146D371B9B075AF9DE@hasmsx107.ger.corp.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Dec 05, 2014 at 10:08:45AM +0000, Muller, Francois-nicolas wrote:
> This driver provides support for TCO watchdog warning interrupt.
> 

Hi Francois,

Cc: Rafael and linux-acpi per his request on ACPI drivers (even if they are for
platform/drivers/x86).

> This feature is useful to root cause watchdog expiration.

Would this not be better suited as a debug option to the iTCO_wdt.c driver under
drivers/watchdog?

Cc: Wim Van Sebroeck and linux-watchdog

> Upon first expiration of the TCO watchdog, a warning interrupt is fired
> to this driver, which calls panic() function and dumps debug information
> (registers and call stacks).

Nit: Newlines between paragraphs for legibility here and in comments please.

> This implies TCO watchdog driver has enabled the interrupt (SCI) and ACPI
> tables contain GPE mapping information.
> After the interrupt has been fired, TCO watchdog reloads automatically and
> upon second expiration it trigs a reset of the platform.

triggers

> 
> Change-Id: I39b615b59dd4336bf208454f08b3e9eac9eb2880

Please run through checkpatch.pl (Gerrit change-id's should be removed).

> Signed-off-by: Francois-Nicolas Muller <francois-nicolas.muller@intel.com>
> ---
> drivers/platform/x86/Kconfig          |   13 +++++
> drivers/platform/x86/Makefile         |    1 +
> drivers/platform/x86/intel_warn_int.c |   98 +++++++++++++++++++++++++++++++++
> 3 files changed, 112 insertions(+)
> create mode 100644 drivers/platform/x86/intel_warn_int.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 5ae65c1..79cba16 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -827,4 +827,17 @@ config INTEL_BAYTRAIL_MBI
>                  Interface. This is a requirement for systems that need to configure
>                  the PUNIT for power management features such as RAPL.
> +config INTEL_WARN_INT
> +             tristate "TCO Watchdog warning interrupt"
> +             depends on ITCO_WDT
> +             ---help---
> +               This driver provides support for TCO watchdog warning interrupt.
> +               Upon first expiration of the TCO watchdog, a warning interrupt is
> +               fired and the driver calls panic() function to dump debug information

s/function//

> +               (registers and call stacks).

newline

> +               At the same time, the TCO watchdog reloads with 2.4 seconds timeout
> +               value and runs till the second expiration. At the second expiration of

s/till/until/

> +               the TCO watchdog, the platform resets (the dump is supposed to last less
> +               than 2.4 seconds).
> +
> endif # X86_PLATFORM_DEVICES
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 32caae3..2d47b4d 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -58,3 +58,4 @@ obj-$(CONFIG_PVPANIC)                               += pvpanic.o
> obj-$(CONFIG_INTEL_BAYTRAIL_MBI)                += intel_baytrail.o
> obj-$(CONFIG_INTEL_SOC_PMIC)        += dc_ti_cc.o
> obj-$(CONFIG_ACPI)                   += intel_em_config.o
> +obj-$(CONFIG_INTEL_WARN_INT)      += intel_warn_int.o
> diff --git a/drivers/platform/x86/intel_warn_int.c b/drivers/platform/x86/intel_warn_int.c
> new file mode 100644
> index 0000000..7ec8b73
> --- /dev/null
> +++ b/drivers/platform/x86/intel_warn_int.c
> @@ -0,0 +1,98 @@
> +/*
> + * intel_warn_int.c - This driver provides support for TCO watchdog warning
> + * interrupt.

Newlines between paragraphs in this section too.

> + * This feature is useful to root cause watchdog expiration.
> + * Upon first expiration of the TCO watchdog, a warning interrupt is fired
> + * to this driver, which calls panic() function and dumps debug information

s/function//

> + * (registers and call stacks).
> + * This implies TCO watchdog driver has enabled the interrupt (SCI) and ACPI

the ACPI...

> + * tables contain GPE mapping information.

the GPE...

> + * After the interrupt has been fired, TCO watchdog reloads automatically and
> + * upon second expiration it trigs a reset of the platform.

triggers

> + * Copyright (c) 2014, Intel Corporation.

All rights reserved.

> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *

extra * line, can remove.

> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/acpi.h>
> +#include <linux/nmi.h>
> +#include <acpi/actypes.h>
> +
> +#define DRV_NAME "warn_int"
> +#define TCO_CLASS DRV_NAME
> +
> +static const struct acpi_device_id tco_device_ids[] = {
> +             {"8086229C", 0},

What is this device ID? Is it specific to a debug ID for the WDT? If not, will
this eventually conflict with a non-debug driver for this WDT?

> +             {"", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, tco_device_ids);
> +
> +static u32 warn_irq_handler(acpi_handle gpe_device, u32 gpe, void *context)
> +{
> +             pr_warn("[SHTDWN] %s, WATCHDOG TIMEOUT HANDLER!\n", __func__);

Indenting with 13 spaces? Please review Documentation/CodingStyle and update the
patch. Rather than point out all these sorts of errors, I'm goign to stop here -
please read the doc and correct throughout.

> +
> +             trigger_all_cpu_backtrace();
> +             panic("Kernel Watchdog");
> +
> +             /* This code should not be reached */
> +             return IRQ_HANDLED;
> +}
> +
> +static int acpi_tco_add(struct acpi_device *device)
> +{
> +             acpi_status status;
> +             unsigned long long tco_gpe;

Declare variables in decreasing line length order.

> +
> +             status = acpi_evaluate_integer(device->handle, "_GPE", NULL, &tco_gpe);
> +             if (ACPI_FAILURE(status))
> +                             return -EINVAL;
> +
> +             status = acpi_install_gpe_handler(NULL, tco_gpe,
> +                                                                              ACPI_GPE_EDGE_TRIGGERED,
> +                                                                              warn_irq_handler, NULL);
> +             if (ACPI_FAILURE(status))
> +                             return -ENODEV;
> +
> +             acpi_enable_gpe(NULL, tco_gpe);
> +
> +             pr_info("initialized. Interrupt=SCI GPE 0x%02llx", tco_gpe);
> +             return 0;
> +}
> +
> +static struct acpi_driver tco_driver = {
> +             .name = "warn_int",
> +             .class = TCO_CLASS,
> +             .ids = tco_device_ids,
> +             .ops = {
> +                             .add = acpi_tco_add,
> +             },
> +};
> +
> +static int __init warn_int_init(void)
> +{
> +             return acpi_bus_register_driver(&tco_driver);
> +}
> +
> +module_init(warn_int_init);
> +/* no module_exit, this driver shouldn't be unloaded */
> +
> +MODULE_AUTHOR("Francois-Nicolas Muller <francois-nicolas.muller@intel.com>");
> +MODULE_DESCRIPTION("Intel TCO WatchDog Warning Interrupt");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" DRV_NAME);
> --
> 1.7.9.5
> 

-- 
Darren Hart
Intel Open Source Technology Center
