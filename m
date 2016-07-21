Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50460 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752098AbcGUNXc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Jul 2016 09:23:32 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: fu.wei@linaro.org
Cc: lenb@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
	marc.zyngier@arm.com, lorenzo.pieralisi@arm.com,
	sudeep.holla@arm.com, hanjun.guo@linaro.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, graeme.gregory@linaro.org,
	al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
	wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com, leo.duran@amd.com,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v8 5/9] acpi/arm64: Add GTDT table parse driver
Date: Thu, 21 Jul 2016 15:28:27 +0200
Message-ID: <2091912.arUKSr7MLh@vostro.rjw.lan>
In-Reply-To: <1468952284-28942-6-git-send-email-fu.wei@linaro.org>
References: <1468952284-28942-1-git-send-email-fu.wei@linaro.org> <1468952284-28942-6-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wednesday, July 20, 2016 02:18:00 AM fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> This patch adds support for parsing arch timer in GTDT,
> provides some kernel APIs to parse all the PPIs and
> always-on info in GTDT and export them.
> 
> By this driver, we can simplify arm_arch_timer drivers, and
> separate the ACPI GTDT knowledge from it.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/Kconfig             |   1 +
>  drivers/acpi/Kconfig           |   5 ++
>  drivers/acpi/Makefile          |   1 +
>  drivers/acpi/arm64/Kconfig     |   5 ++
>  drivers/acpi/arm64/Makefile    |   1 +
>  drivers/acpi/arm64/acpi_gtdt.c | 152 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clocksource/Kconfig    |   1 -
>  include/linux/acpi.h           |   6 ++
>  8 files changed, 171 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5a0a691..0b9fba7 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2,6 +2,7 @@ config ARM64
>  	def_bool y
>  	select ACPI_CCA_REQUIRED if ACPI
>  	select ACPI_GENERIC_GSI if ACPI
> +	select ACPI_GTDT if ACPI
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index b7e2e77..1cdc7d2 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -521,4 +521,9 @@ config XPOWER_PMIC_OPREGION
>  
>  endif
>  
> +if ARM64
> +source "drivers/acpi/arm64/Kconfig"
> +
> +endif
> +
>  endif	# ACPI
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 251ce85..1a94ff7 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -99,5 +99,6 @@ obj-$(CONFIG_ACPI_EXTLOG)	+= acpi_extlog.o
>  obj-$(CONFIG_PMIC_OPREGION)	+= pmic/intel_pmic.o
>  obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
>  obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
> +obj-$(CONFIG_ARM64)	+= arm64/
>  
>  video-objs			+= acpi_video.o video_detect.o
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> new file mode 100644
> index 0000000..80201be
> --- /dev/null
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -0,0 +1,5 @@
> +#
> +# ACPI Configuration for ARM64
> +#
> +config ACPI_GTDT
> +	bool
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> new file mode 100644
> index 0000000..466de6b
> --- /dev/null
> +++ b/drivers/acpi/arm64/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_ACPI_GTDT)		+= acpi_gtdt.o
> diff --git a/drivers/acpi/arm64/acpi_gtdt.c b/drivers/acpi/arm64/acpi_gtdt.c
> new file mode 100644
> index 0000000..e1cfc9e
> --- /dev/null
> +++ b/drivers/acpi/arm64/acpi_gtdt.c
> @@ -0,0 +1,152 @@
> +/*
> + * ARM Specific GTDT table Support
> + *
> + * Copyright (C) 2016, Linaro Ltd.
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *         Fu Wei <fu.wei@linaro.org>
> + *         Hanjun Guo <hanjun.guo@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +
> +#include <clocksource/arm_arch_timer.h>
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "ACPI GTDT: " fmt
> +
> +typedef struct {
> +	struct acpi_table_gtdt *gtdt;
> +	void *platform_timer_start;
> +	void *gtdt_end;
> +} acpi_gtdt_desc_t;
> +
> +static acpi_gtdt_desc_t acpi_gtdt_desc __initdata;
> +
> +static inline void *next_platform_timer(void *platform_timer)
> +{
> +	struct acpi_gtdt_header *gh = platform_timer;
> +
> +	platform_timer += gh->length;
> +	if (platform_timer < acpi_gtdt_desc.gtdt_end)
> +		return platform_timer;
> +
> +	return NULL;
> +}
> +
> +#define for_each_platform_timer(_g)				\
> +	for (_g = acpi_gtdt_desc.platform_timer_start; _g;	\
> +	     _g = next_platform_timer(_g))
> +
> +static inline bool is_timer_block(void *platform_timer)
> +{
> +	struct acpi_gtdt_header *gh = platform_timer;
> +
> +	return gh->type == ACPI_GTDT_TYPE_TIMER_BLOCK;
> +}
> +
> +static inline bool is_watchdog(void *platform_timer)
> +{
> +	struct acpi_gtdt_header *gh = platform_timer;
> +
> +	return gh->type == ACPI_GTDT_TYPE_WATCHDOG;
> +}
> +
> +static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
> +{
> +	int trigger, polarity;
> +
> +	if (!interrupt)
> +		return 0;
> +
> +	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
> +			: ACPI_LEVEL_SENSITIVE;
> +
> +	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
> +			: ACPI_ACTIVE_HIGH;
> +
> +	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
> +}
> +
> +/*
> + * Map the PPIs of per-cpu arch_timer.
> + * @type: the type of PPI
> + * Returns 0 if error.
> + */
> +int __init acpi_gtdt_map_ppi(int type)
> +{
> +	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
> +
> +	switch (type) {
> +	case PHYS_SECURE_PPI:
> +		return map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
> +						   gtdt->secure_el1_flags);
> +	case PHYS_NONSECURE_PPI:
> +		return map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
> +						   gtdt->non_secure_el1_flags);
> +	case VIRT_PPI:
> +		return map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
> +						   gtdt->virtual_timer_flags);
> +
> +	case HYP_PPI:
> +		return map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
> +						   gtdt->non_secure_el2_flags);
> +	default:
> +		pr_err("Map PPI failed: invalid type.\n");
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * acpi_gtdt_c3stop - got c3stop info from GTDT
> + *
> + * Returns 1 if the timer is powered in deep idle state, 0 otherwise.
> + */
> +bool __init acpi_gtdt_c3stop(void)
> +{
> +	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
> +
> +	return !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
> +}
> +
> +/*
> + * Get some basic info from GTDT table, and init the global variables above
> + * for all timers initialization of Generic Timer.
> + * This function does some validation on GTDT table.
> + */
> +int __init acpi_gtdt_init(struct acpi_table_header *table)
> +{
> +	void *start;
> +	struct acpi_table_gtdt *gtdt;
> +
> +	gtdt = container_of(table, struct acpi_table_gtdt, header);
> +
> +	acpi_gtdt_desc.gtdt = gtdt;
> +	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
> +
> +	if (table->revision < 2) {
> +		pr_debug("Revision:%d doesn't support Platform Timers.\n",
> +			 table->revision);
> +		return 0;
> +	}
> +
> +	if (!gtdt->platform_timer_count) {
> +		pr_debug("No Platform Timer.\n");
> +		return 0;
> +	}
> +
> +	start = (void *)gtdt + gtdt->platform_timer_offset;
> +	if (start < (void *)table + sizeof(struct acpi_table_gtdt)) {
> +		pr_err(FW_BUG "Failed to init table: ACPI/GTDT is buggy.\n");

I would prefer something like

		pr_err(FW_BUG "Failed to retrieve timer information from firmware (invalid data)\n");

which is clear enough IMO and doesn't require whoever reads this message
to know anything about ACPI/GTDT etc.

Thanks,
Rafael

