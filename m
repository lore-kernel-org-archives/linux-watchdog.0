Return-path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <CAJZ5v0i-1NysCiDFX4ST_uBBeYF2YNzWztgDP=u9a4S1OdpWuw@mail.gmail.com>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
 <1468432402-4872-5-git-send-email-fu.wei@linaro.org> <CAJZ5v0i-1NysCiDFX4ST_uBBeYF2YNzWztgDP=u9a4S1OdpWuw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Jul 2016 22:39:36 +0200
Message-ID: <CAJZ5v0hm1xkgiyPp4voUygHy_GTKqoGiA99w6EnbVQLkhF_ELA@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] acpi/arm64: Add GTDT table parse driver
To: Fu Wei <fu.wei@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org,
	Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>,
	Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>,
	Leo Duran <leo.duran@amd.com>, Guenter Roeck <linux@roeck-us.net>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, David Miller <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kvalo@codeaurora.org, mchehab@kernel.org, Jiri Slaby <jslaby@suse.cz>,
	christoffer.dall@linaro.org, julien.grall@arm.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Jul 13, 2016 at 10:30 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Jul 13, 2016 at 7:53 PM,  <fu.wei@linaro.org> wrote:
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
>> ---
>>  drivers/acpi/Kconfig           |   5 ++
>>  drivers/acpi/Makefile          |   1 +
>>  drivers/acpi/arm64/Kconfig     |  15 ++++
>>  drivers/acpi/arm64/Makefile    |   1 +
>>  drivers/acpi/arm64/acpi_gtdt.c | 170 +++++++++++++++++++++++++++++++++++++++++
>>  include/linux/acpi.h           |   6 ++
>>  6 files changed, 198 insertions(+)
>>
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
>>  endif  # ACPI
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 251ce85..1a94ff7 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -99,5 +99,6 @@ obj-$(CONFIG_ACPI_EXTLOG)     += acpi_extlog.o
>>  obj-$(CONFIG_PMIC_OPREGION)    += pmic/intel_pmic.o
>>  obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
>>  obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
>> +obj-$(CONFIG_ARM64)    += arm64/
>>
>>  video-objs                     += acpi_video.o video_detect.o
>> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
>> new file mode 100644
>> index 0000000..ff5c253
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/Kconfig
>> @@ -0,0 +1,15 @@
>> +#
>> +# ACPI Configuration for ARM64
>> +#
>> +
>> +menu "The ARM64-specific ACPI Support"
>> +
>> +config ACPI_GTDT
>> +       bool "ACPI GTDT table Support"
>
> This should depend on ARM64.
>
> Also I wonder if it needs to be user-selectable?  Wouldn't it be
> better to enable it by default when building for ARM64 with ACPI?
>
>> +       help
>> +         GTDT (Generic Timer Description Table) provides information
>> +         for per-processor timers and Platform (memory-mapped) timers
>> +         for ARM platforms. Select this option to provide information
>> +         needed for the timers init.
>> +
>> +endmenu
>> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
>> new file mode 100644
>> index 0000000..466de6b
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_ACPI_GTDT)                += acpi_gtdt.o
>> diff --git a/drivers/acpi/arm64/acpi_gtdt.c b/drivers/acpi/arm64/acpi_gtdt.c
>> new file mode 100644
>> index 0000000..9ee977d
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/acpi_gtdt.c
>> @@ -0,0 +1,170 @@
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
>> +#include <linux/module.h>
>> +
>> +#include <clocksource/arm_arch_timer.h>
>> +
>> +#undef pr_fmt
>> +#define pr_fmt(fmt) "GTDT: " fmt
>
> I would add "ACPI" to the prefix too if I were you, but that's me.
>
>> +
>> +typedef struct {
>> +       struct acpi_table_gtdt *gtdt;
>> +       void *platform_timer_start;
>> +       void *gtdt_end;
>> +} acpi_gtdt_desc_t;
>> +
>> +static acpi_gtdt_desc_t acpi_gtdt_desc __initdata;
>> +
>> +static inline void *next_platform_timer(void *platform_timer)
>> +{
>> +       struct acpi_gtdt_header *gh = platform_timer;
>> +
>> +       platform_timer += gh->length;
>> +       if (platform_timer < acpi_gtdt_desc.gtdt_end)
>> +               return platform_timer;
>> +
>> +       return NULL;
>> +}
>> +
>> +#define for_each_platform_timer(_g)                            \
>> +       for (_g = acpi_gtdt_desc.platform_timer_start; _g;      \
>> +            _g = next_platform_timer(_g))
>> +
>> +static inline bool is_timer_block(void *platform_timer)
>> +{
>> +       struct acpi_gtdt_header *gh = platform_timer;
>> +
>> +       if (gh->type == ACPI_GTDT_TYPE_TIMER_BLOCK)
>> +               return true;
>> +
>> +       return false;
>
> This is just too much code.  It would suffice to do
>
>     return gh->type == ACPI_GTDT_TYPE_TIMER_BLOCK;
>
>> +}
>> +
>> +static inline bool is_watchdog(void *platform_timer)
>> +{
>> +       struct acpi_gtdt_header *gh = platform_timer;
>> +
>> +       if (gh->type == ACPI_GTDT_TYPE_WATCHDOG)
>> +               return true;
>> +
>> +       return false;
>
> Just like above.
>
>> +}
>> +
>> +/*
>> + * Get some basic info from GTDT table, and init the global variables above
>> + * for all timers initialization of Generic Timer.
>> + * This function does some validation on GTDT table.
>> + */
>> +static int __init acpi_gtdt_desc_init(struct acpi_table_header *table)
>> +{
>> +       struct acpi_table_gtdt *gtdt = container_of(table,
>> +                                                   struct acpi_table_gtdt,
>> +                                                   header);
>> +
>> +       acpi_gtdt_desc.gtdt = gtdt;
>> +       acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
>> +
>> +       if (table->revision < 2) {
>> +               pr_info("Revision:%d doesn't support Platform Timers.\n",
>> +                       table->revision);
>
> Is it really useful to print this message (and the one below) at the
> "info" level?  What about changing them to pr_debug()?
>
>> +               return 0;
>> +       }
>> +
>> +       if (!gtdt->platform_timer_count) {
>> +               pr_info("No Platform Timer.\n");
>> +               return 0;
>> +       }
>> +
>> +       acpi_gtdt_desc.platform_timer_start = (void *)gtdt +
>> +                                             gtdt->platform_timer_offset;

BTW, breaking lines this way doesn't make the code particularly more readable.

>> +       if (acpi_gtdt_desc.platform_timer_start <
>> +           (void *)table + sizeof(struct acpi_table_gtdt)) {

Same here.

It might be avoided by using a local (void *) variable "start", ie.

    start = (void *)gtdt + gtdt->platform_timer_offset;
    if (start < (void *)table + sizeof(struct acpi_table_gtdt))) {
        print message;
        return -EINVAL;
    }
    acpi_gtdt_desc.platform_timer_start = start;

Thanks,
Rafael
