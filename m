Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45162 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbcGMVJe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Jul 2016 17:09:34 -0400
Date: Wed, 13 Jul 2016 14:08:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Fu Wei <fu.wei@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
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
	Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>,
	Leo Duran <leo.duran@amd.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kvalo@codeaurora.org, mchehab@kernel.org,
	Jiri Slaby <jslaby@suse.cz>, christoffer.dall@linaro.org,
	julien.grall@arm.com
Subject: Re: [PATCH v7 4/9] acpi/arm64: Add GTDT table parse driver
Message-ID: <20160713210857.GA9500@roeck-us.net>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
 <1468432402-4872-5-git-send-email-fu.wei@linaro.org>
 <CAJZ5v0i-1NysCiDFX4ST_uBBeYF2YNzWztgDP=u9a4S1OdpWuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i-1NysCiDFX4ST_uBBeYF2YNzWztgDP=u9a4S1OdpWuw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jul 13, 2016 at 10:30:37PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 13, 2016 at 7:53 PM,  <fu.wei@linaro.org> wrote:
> > From: Fu Wei <fu.wei@linaro.org>
> >
> > This patch adds support for parsing arch timer in GTDT,
> > provides some kernel APIs to parse all the PPIs and
> > always-on info in GTDT and export them.
> >
> > By this driver, we can simplify arm_arch_timer drivers, and
> > separate the ACPI GTDT knowledge from it.
> >
> > Signed-off-by: Fu Wei <fu.wei@linaro.org>
> > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > ---
> >  drivers/acpi/Kconfig           |   5 ++
> >  drivers/acpi/Makefile          |   1 +
> >  drivers/acpi/arm64/Kconfig     |  15 ++++
> >  drivers/acpi/arm64/Makefile    |   1 +
> >  drivers/acpi/arm64/acpi_gtdt.c | 170 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/acpi.h           |   6 ++
> >  6 files changed, 198 insertions(+)
> >
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index b7e2e77..1cdc7d2 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -521,4 +521,9 @@ config XPOWER_PMIC_OPREGION
> >
> >  endif
> >
> > +if ARM64
> > +source "drivers/acpi/arm64/Kconfig"
> > +
> > +endif
> > +
> >  endif  # ACPI
> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > index 251ce85..1a94ff7 100644
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -99,5 +99,6 @@ obj-$(CONFIG_ACPI_EXTLOG)     += acpi_extlog.o
> >  obj-$(CONFIG_PMIC_OPREGION)    += pmic/intel_pmic.o
> >  obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
> >  obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
> > +obj-$(CONFIG_ARM64)    += arm64/
> >
> >  video-objs                     += acpi_video.o video_detect.o
> > diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> > new file mode 100644
> > index 0000000..ff5c253
> > --- /dev/null
> > +++ b/drivers/acpi/arm64/Kconfig
> > @@ -0,0 +1,15 @@
> > +#
> > +# ACPI Configuration for ARM64
> > +#
> > +
> > +menu "The ARM64-specific ACPI Support"
> > +
> > +config ACPI_GTDT
> > +       bool "ACPI GTDT table Support"
> 
> This should depend on ARM64.
> 
> Also I wonder if it needs to be user-selectable?  Wouldn't it be
> better to enable it by default when building for ARM64 with ACPI?
> 
It is currently selected in patch 9, in the watchdog driver's Kconfig
entry. Not sure if I like that; maybe the watchdog driver should depend
on it instead ?

Guenter

> > +       help
> > +         GTDT (Generic Timer Description Table) provides information
> > +         for per-processor timers and Platform (memory-mapped) timers
> > +         for ARM platforms. Select this option to provide information
> > +         needed for the timers init.
> > +
> > +endmenu
> > diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> > new file mode 100644
> > index 0000000..466de6b
> > --- /dev/null
> > +++ b/drivers/acpi/arm64/Makefile
> > @@ -0,0 +1 @@
> > +obj-$(CONFIG_ACPI_GTDT)                += acpi_gtdt.o
> > diff --git a/drivers/acpi/arm64/acpi_gtdt.c b/drivers/acpi/arm64/acpi_gtdt.c
> > new file mode 100644
> > index 0000000..9ee977d
> > --- /dev/null
> > +++ b/drivers/acpi/arm64/acpi_gtdt.c
> > @@ -0,0 +1,170 @@
> > +/*
> > + * ARM Specific GTDT table Support
> > + *
> > + * Copyright (C) 2016, Linaro Ltd.
> > + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> > + *         Fu Wei <fu.wei@linaro.org>
> > + *         Hanjun Guo <hanjun.guo@linaro.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +
> > +#include <clocksource/arm_arch_timer.h>
> > +
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) "GTDT: " fmt
> 
> I would add "ACPI" to the prefix too if I were you, but that's me.
> 
> > +
> > +typedef struct {
> > +       struct acpi_table_gtdt *gtdt;
> > +       void *platform_timer_start;
> > +       void *gtdt_end;
> > +} acpi_gtdt_desc_t;
> > +
> > +static acpi_gtdt_desc_t acpi_gtdt_desc __initdata;
> > +
> > +static inline void *next_platform_timer(void *platform_timer)
> > +{
> > +       struct acpi_gtdt_header *gh = platform_timer;
> > +
> > +       platform_timer += gh->length;
> > +       if (platform_timer < acpi_gtdt_desc.gtdt_end)
> > +               return platform_timer;
> > +
> > +       return NULL;
> > +}
> > +
> > +#define for_each_platform_timer(_g)                            \
> > +       for (_g = acpi_gtdt_desc.platform_timer_start; _g;      \
> > +            _g = next_platform_timer(_g))
> > +
> > +static inline bool is_timer_block(void *platform_timer)
> > +{
> > +       struct acpi_gtdt_header *gh = platform_timer;
> > +
> > +       if (gh->type == ACPI_GTDT_TYPE_TIMER_BLOCK)
> > +               return true;
> > +
> > +       return false;
> 
> This is just too much code.  It would suffice to do
> 
>     return gh->type == ACPI_GTDT_TYPE_TIMER_BLOCK;
> 
> > +}
> > +
> > +static inline bool is_watchdog(void *platform_timer)
> > +{
> > +       struct acpi_gtdt_header *gh = platform_timer;
> > +
> > +       if (gh->type == ACPI_GTDT_TYPE_WATCHDOG)
> > +               return true;
> > +
> > +       return false;
> 
> Just like above.
> 
> > +}
> > +
> > +/*
> > + * Get some basic info from GTDT table, and init the global variables above
> > + * for all timers initialization of Generic Timer.
> > + * This function does some validation on GTDT table.
> > + */
> > +static int __init acpi_gtdt_desc_init(struct acpi_table_header *table)
> > +{
> > +       struct acpi_table_gtdt *gtdt = container_of(table,
> > +                                                   struct acpi_table_gtdt,
> > +                                                   header);
> > +
> > +       acpi_gtdt_desc.gtdt = gtdt;
> > +       acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
> > +
> > +       if (table->revision < 2) {
> > +               pr_info("Revision:%d doesn't support Platform Timers.\n",
> > +                       table->revision);
> 
> Is it really useful to print this message (and the one below) at the
> "info" level?  What about changing them to pr_debug()?
> 
> > +               return 0;
> > +       }
> > +
> > +       if (!gtdt->platform_timer_count) {
> > +               pr_info("No Platform Timer.\n");
> > +               return 0;
> > +       }
> > +
> > +       acpi_gtdt_desc.platform_timer_start = (void *)gtdt +
> > +                                             gtdt->platform_timer_offset;
> > +       if (acpi_gtdt_desc.platform_timer_start <
> > +           (void *)table + sizeof(struct acpi_table_gtdt)) {
> > +               pr_err(FW_BUG "Platform Timer pointer error.\n");
> 
> Why pr_err()?
> 
> > +               acpi_gtdt_desc.platform_timer_start = NULL;
> > +               return -EINVAL;
> > +       }
> > +
> > +       return gtdt->platform_timer_count;
> > +}
> > +
> > +static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
> > +{
> > +       int trigger, polarity;
> > +
> > +       if (!interrupt)
> > +               return 0;
> > +
> > +       trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
> > +                       : ACPI_LEVEL_SENSITIVE;
> > +
> > +       polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
> > +                       : ACPI_ACTIVE_HIGH;
> > +
> > +       return acpi_register_gsi(NULL, interrupt, trigger, polarity);
> > +}
> > +
> > +/*
> > + * Map the PPIs of per-cpu arch_timer.
> > + * @type: the type of PPI
> > + * Returns 0 if error.
> > + */
> > +int __init acpi_gtdt_map_ppi(int type)
> > +{
> > +       struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
> > +
> > +       switch (type) {
> > +       case PHYS_SECURE_PPI:
> > +               return map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
> > +                                                  gtdt->secure_el1_flags);
> > +       case PHYS_NONSECURE_PPI:
> > +               return map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
> > +                                                  gtdt->non_secure_el1_flags);
> > +       case VIRT_PPI:
> > +               return map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
> > +                                                  gtdt->virtual_timer_flags);
> > +
> > +       case HYP_PPI:
> > +               return map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
> > +                                                  gtdt->non_secure_el2_flags);
> > +       default:
> > +               pr_err("ppi type error.\n");
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * acpi_gtdt_c3stop - got c3stop info from GTDT
> > + *
> > + * Returns 1 if the timer is powered in deep idle state, 0 otherwise.
> > + */
> > +int __init acpi_gtdt_c3stop(void)
> 
> Why not bool?
> 
> > +{
> > +       struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
> > +
> > +       return !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
> > +}
> > +
> > +int __init gtdt_arch_timer_init(struct acpi_table_header *table)
> > +{
> > +       if (table)
> > +               return acpi_gtdt_desc_init(table);
> > +
> > +       pr_err("table pointer error.\n");
> 
> This message is totally unuseful.
> 
> > +
> > +       return -EINVAL;
> > +}
> 
> What is supposed to be calling this function?
> 
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 288fac5..8439579 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -532,6 +532,12 @@ void acpi_walk_dep_device_list(acpi_handle handle);
> >  struct platform_device *acpi_create_platform_device(struct acpi_device *);
> >  #define ACPI_PTR(_ptr) (_ptr)
> >
> > +#ifdef CONFIG_ACPI_GTDT
> > +int __init gtdt_arch_timer_init(struct acpi_table_header *table);
> > +int __init acpi_gtdt_map_ppi(int type);
> > +int __init acpi_gtdt_c3stop(void);
> 
> The __init thing is not necessary here.
> 
> > +#endif
> > +
> >  #else  /* !CONFIG_ACPI */
> >
> >  #define acpi_disabled 1
> > --
> 
> Thanks,
> Rafael
