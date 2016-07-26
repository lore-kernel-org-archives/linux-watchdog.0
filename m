Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37618 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbcGZMkv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jul 2016 08:40:51 -0400
Received: by mail-it0-f46.google.com with SMTP id f6so8612499ith.0
        for <linux-watchdog@vger.kernel.org>; Tue, 26 Jul 2016 05:40:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1754781.CC9jSrYt2s@vostro.rjw.lan>
References: <1469460427-8643-1-git-send-email-fu.wei@linaro.org>
 <1469460427-8643-6-git-send-email-fu.wei@linaro.org> <1754781.CC9jSrYt2s@vostro.rjw.lan>
From: Fu Wei <fu.wei@linaro.org>
Date: Tue, 26 Jul 2016 20:40:49 +0800
Message-ID: <CADyBb7ukk7n8yX1+mRoWRoqjM2wE_1bWbuWNhbv+dtiuJK0ZSQ@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] acpi/arm64: Add GTDT table parse driver
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	rruigrok@codeaurora.org, harba@codeaurora.org,
	Christopher Covington <cov@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>,
	wei@redhat.com, Arnd Bergmann <arnd@arndb.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Leo Duran <leo.duran@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Rafael,

On 26 July 2016 at 19:50, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, July 25, 2016 11:27:03 PM fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patch adds support for parsing arch timer in GTDT,
>> provides some kernel APIs to parse all the PPIs and
>> always-on info in GTDT and export them.
>>
>> By this driver, we can simplify arm_arch_timer drivers, and
>> separate the ACPI GTDT knowledge from it.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>
> From the ACPI perspective:
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Great thanks for your help, I just posted v10, then got your ACK :-)
But there is not change in the patch, I 'm assuming that your ACK
still works for my v10 :-)

>
> and I'm assuming that the patches will go in via some other (non-ACPI) tree.

I think so, I guess the clocksource maintainer will take care of it.

Daniel, is this patch will go into clocksource tree?

Thanks for your help! :-)


>
>> ---
>>  arch/arm64/Kconfig             |   1 +
>>  drivers/acpi/Kconfig           |   5 ++
>>  drivers/acpi/Makefile          |   1 +
>>  drivers/acpi/arm64/Kconfig     |   5 ++
>>  drivers/acpi/arm64/Makefile    |   1 +
>>  drivers/acpi/arm64/acpi_gtdt.c | 152 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/clocksource/Kconfig    |   1 -
>>  include/linux/acpi.h           |   6 ++
>>  8 files changed, 171 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 5a0a691..0b9fba7 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -2,6 +2,7 @@ config ARM64
>>       def_bool y
>>       select ACPI_CCA_REQUIRED if ACPI
>>       select ACPI_GENERIC_GSI if ACPI
>> +     select ACPI_GTDT if ACPI
>>       select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>>       select ARCH_HAS_DEVMEM_IS_ALLOWED
>>       select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index b7e2e77..1cdc7d2 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -521,4 +521,9 @@ config XPOWER_PMIC_OPREGION
>>
>>  endif
>>
>> +if ARM64
>> +source "drivers/acpi/arm64/Kconfig"
>> +
>> +endif
>> +
>>  endif        # ACPI
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 251ce85..1a94ff7 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -99,5 +99,6 @@ obj-$(CONFIG_ACPI_EXTLOG)   += acpi_extlog.o
>>  obj-$(CONFIG_PMIC_OPREGION)  += pmic/intel_pmic.o
>>  obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
>>  obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
>> +obj-$(CONFIG_ARM64)  += arm64/
>>
>>  video-objs                   += acpi_video.o video_detect.o
>> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
>> new file mode 100644
>> index 0000000..80201be
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/Kconfig
>> @@ -0,0 +1,5 @@
>> +#
>> +# ACPI Configuration for ARM64
>> +#
>> +config ACPI_GTDT
>> +     bool
>> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
>> new file mode 100644
>> index 0000000..466de6b
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_ACPI_GTDT)              += acpi_gtdt.o
>> diff --git a/drivers/acpi/arm64/acpi_gtdt.c b/drivers/acpi/arm64/acpi_gtdt.c
>> new file mode 100644
>> index 0000000..cdb2fb1
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/acpi_gtdt.c
>> @@ -0,0 +1,152 @@
>> +/*
>> + * ARM Specific GTDT table Support
>> + *
>> + * Copyright (C) 2016, Linaro Ltd.
>> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> + *         Fu Wei <fu.wei@linaro.org>
>> + *         Hanjun Guo <hanjun.guo@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +
>> +#include <clocksource/arm_arch_timer.h>
>> +
>> +#undef pr_fmt
>> +#define pr_fmt(fmt) "ACPI GTDT: " fmt
>> +
>> +typedef struct {
>> +     struct acpi_table_gtdt *gtdt;
>> +     void *platform_timer_start;
>> +     void *gtdt_end;
>> +} acpi_gtdt_desc_t;
>> +
>> +static acpi_gtdt_desc_t acpi_gtdt_desc __initdata;
>> +
>> +static inline void *next_platform_timer(void *platform_timer)
>> +{
>> +     struct acpi_gtdt_header *gh = platform_timer;
>> +
>> +     platform_timer += gh->length;
>> +     if (platform_timer < acpi_gtdt_desc.gtdt_end)
>> +             return platform_timer;
>> +
>> +     return NULL;
>> +}
>> +
>> +#define for_each_platform_timer(_g)                          \
>> +     for (_g = acpi_gtdt_desc.platform_timer_start; _g;      \
>> +          _g = next_platform_timer(_g))
>> +
>> +static inline bool is_timer_block(void *platform_timer)
>> +{
>> +     struct acpi_gtdt_header *gh = platform_timer;
>> +
>> +     return gh->type == ACPI_GTDT_TYPE_TIMER_BLOCK;
>> +}
>> +
>> +static inline bool is_watchdog(void *platform_timer)
>> +{
>> +     struct acpi_gtdt_header *gh = platform_timer;
>> +
>> +     return gh->type == ACPI_GTDT_TYPE_WATCHDOG;
>> +}
>> +
>> +static int __init map_gt_gsi(u32 interrupt, u32 flags)
>> +{
>> +     int trigger, polarity;
>> +
>> +     if (!interrupt)
>> +             return 0;
>> +
>> +     trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
>> +                     : ACPI_LEVEL_SENSITIVE;
>> +
>> +     polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
>> +                     : ACPI_ACTIVE_HIGH;
>> +
>> +     return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>> +}
>> +
>> +/*
>> + * Map the PPIs of per-cpu arch_timer.
>> + * @type: the type of PPI
>> + * Returns 0 if error.
>> + */
>> +int __init acpi_gtdt_map_ppi(int type)
>> +{
>> +     struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
>> +
>> +     switch (type) {
>> +     case PHYS_SECURE_PPI:
>> +             return map_gt_gsi(gtdt->secure_el1_interrupt,
>> +                               gtdt->secure_el1_flags);
>> +     case PHYS_NONSECURE_PPI:
>> +             return map_gt_gsi(gtdt->non_secure_el1_interrupt,
>> +                               gtdt->non_secure_el1_flags);
>> +     case VIRT_PPI:
>> +             return map_gt_gsi(gtdt->virtual_timer_interrupt,
>> +                               gtdt->virtual_timer_flags);
>> +
>> +     case HYP_PPI:
>> +             return map_gt_gsi(gtdt->non_secure_el2_interrupt,
>> +                               gtdt->non_secure_el2_flags);
>> +     default:
>> +             pr_err("Failed to map timer interrupt: invalid type.\n");
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +/*
>> + * acpi_gtdt_c3stop - got c3stop info from GTDT
>> + *
>> + * Returns 1 if the timer is powered in deep idle state, 0 otherwise.
>> + */
>> +bool __init acpi_gtdt_c3stop(void)
>> +{
>> +     struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
>> +
>> +     return !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
>> +}
>> +
>> +/*
>> + * Get some basic info from GTDT table, and init the global variables above
>> + * for all timers initialization of Generic Timer.
>> + * This function does some validation on GTDT table.
>> + */
>> +int __init acpi_gtdt_init(struct acpi_table_header *table)
>> +{
>> +     void *start;
>> +     struct acpi_table_gtdt *gtdt;
>> +
>> +     gtdt = container_of(table, struct acpi_table_gtdt, header);
>> +
>> +     acpi_gtdt_desc.gtdt = gtdt;
>> +     acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
>> +
>> +     if (table->revision < 2) {
>> +             pr_debug("Revision:%d doesn't support Platform Timers.\n",
>> +                      table->revision);
>> +             return 0;
>> +     }
>> +
>> +     if (!gtdt->platform_timer_count) {
>> +             pr_debug("No Platform Timer.\n");
>> +             return 0;
>> +     }
>> +
>> +     start = (void *)gtdt + gtdt->platform_timer_offset;
>> +     if (start < (void *)table + sizeof(struct acpi_table_gtdt)) {
>> +             pr_err(FW_BUG "Failed to retrieve timer info from firmware: invalid data.\n");
>> +             return -EINVAL;
>> +     }
>> +     acpi_gtdt_desc.platform_timer_start = start;
>> +
>> +     return gtdt->platform_timer_count;
>> +}
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 47352d2..108dbc3 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -205,7 +205,6 @@ config CLKSRC_MPS2
>>  config ARM_ARCH_TIMER
>>       bool
>>       select CLKSRC_OF if OF
>> -     select CLKSRC_ACPI if ACPI
>>
>>  config ARM_ARCH_TIMER_EVTSTREAM
>>       bool "Support for ARM architected timer event stream generation"
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 288fac5..fb8b689 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -532,6 +532,12 @@ void acpi_walk_dep_device_list(acpi_handle handle);
>>  struct platform_device *acpi_create_platform_device(struct acpi_device *);
>>  #define ACPI_PTR(_ptr)       (_ptr)
>>
>> +#ifdef CONFIG_ACPI_GTDT
>> +int acpi_gtdt_init(struct acpi_table_header *table);
>> +int acpi_gtdt_map_ppi(int type);
>> +bool acpi_gtdt_c3stop(void);
>> +#endif
>> +
>>  #else        /* !CONFIG_ACPI */
>>
>>  #define acpi_disabled 1
>>
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
