Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753532AbcKYIso (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 25 Nov 2016 03:48:44 -0500
From: fu.wei@linaro.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org,
        al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com,
        Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v17 11/15] acpi/arm64: Add GTDT table parse driver
Date: Fri, 25 Nov 2016 16:46:19 +0800
Message-Id: <20161125084623.22515-12-fu.wei@linaro.org>
In-Reply-To: <20161125084623.22515-1-fu.wei@linaro.org>
References: <20161125084623.22515-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patch adds support for parsing arch timer info in GTDT,
provides some kernel APIs to parse all the PPIs and
always-on info in GTDT and export them.

By this driver, we can simplify arm_arch_timer drivers, and
separate the ACPI GTDT knowledge from it.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/arm64/Kconfig          |   1 +
 drivers/acpi/arm64/Kconfig  |   3 +
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/gtdt.c   | 157 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h        |   6 ++
 5 files changed, 168 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 969ef88..4277a21 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@ config ARM64
 	def_bool y
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_GTDT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
 	select ACPI_SPCR_TABLE if ACPI
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index 4616da4..5a6f80f 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -4,3 +4,6 @@
 
 config ACPI_IORT
 	bool
+
+config ACPI_GTDT
+	bool
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 72331f2..1017def 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
+obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
new file mode 100644
index 0000000..d93a790
--- /dev/null
+++ b/drivers/acpi/arm64/gtdt.c
@@ -0,0 +1,157 @@
+/*
+ * ARM Specific GTDT table Support
+ *
+ * Copyright (C) 2016, Linaro Ltd.
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *         Fu Wei <fu.wei@linaro.org>
+ *         Hanjun Guo <hanjun.guo@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <clocksource/arm_arch_timer.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "ACPI GTDT: " fmt
+
+/**
+ * struct acpi_gtdt_descriptor - Store the key info of GTDT for all functions
+ * @gtdt:	The pointer to the struct acpi_table_gtdt of GTDT table.
+ * @gtdt_end:	The pointer to the end of GTDT table.
+ * @platform_timer:	The pointer to the start of Platform Timer Structure
+ *
+ * The struct store the key info of GTDT table, it should be initialized by
+ * acpi_gtdt_init.
+ */
+struct acpi_gtdt_descriptor {
+	struct acpi_table_gtdt *gtdt;
+	void *gtdt_end;
+	void *platform_timer;
+};
+
+static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
+
+static int __init map_gt_gsi(u32 interrupt, u32 flags)
+{
+	int trigger, polarity;
+
+	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
+			: ACPI_LEVEL_SENSITIVE;
+
+	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
+			: ACPI_ACTIVE_HIGH;
+
+	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
+}
+
+/**
+ * acpi_gtdt_map_ppi() - Map the PPIs of per-cpu arch_timer.
+ * @type:	the type of PPI.
+ *
+ * Note: Linux on arm64 isn't supported on the secure side.
+ * So we only handle the non-secure timer PPIs,
+ * ARCH_TIMER_PHYS_SECURE_PPI is treated as invalid type.
+ *
+ * Return: the mapped PPI value, 0 if error.
+ */
+int __init acpi_gtdt_map_ppi(int type)
+{
+	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+
+	switch (type) {
+	case ARCH_TIMER_PHYS_NONSECURE_PPI:
+		return map_gt_gsi(gtdt->non_secure_el1_interrupt,
+				  gtdt->non_secure_el1_flags);
+	case ARCH_TIMER_VIRT_PPI:
+		return map_gt_gsi(gtdt->virtual_timer_interrupt,
+				  gtdt->virtual_timer_flags);
+
+	case ARCH_TIMER_HYP_PPI:
+		return map_gt_gsi(gtdt->non_secure_el2_interrupt,
+				  gtdt->non_secure_el2_flags);
+	default:
+		pr_err("Failed to map timer interrupt: invalid type.\n");
+	}
+
+	return 0;
+}
+
+/**
+ * acpi_gtdt_c3stop() - Got c3stop info from GTDT according to the type of PPI.
+ * @type:	the type of PPI.
+ *
+ * Return: 1 if the timer can be in deep idle state, 0 otherwise.
+ */
+bool __init acpi_gtdt_c3stop(int type)
+{
+	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+
+	switch (type) {
+	case ARCH_TIMER_PHYS_NONSECURE_PPI:
+		return !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
+
+	case ARCH_TIMER_VIRT_PPI:
+		return !(gtdt->virtual_timer_flags & ACPI_GTDT_ALWAYS_ON);
+
+	case ARCH_TIMER_HYP_PPI:
+		return !(gtdt->non_secure_el2_flags & ACPI_GTDT_ALWAYS_ON);
+
+	default:
+		pr_err("Failed to get c3stop info: invalid type.\n");
+	}
+
+	return 0;
+}
+
+/**
+ * acpi_gtdt_init() - Get the info of GTDT table to prepare for further init.
+ * @table:	The pointer to GTDT table.
+ * @platform_timer_count:	The pointer of int variate for returning the
+ *				number of platform timers. It can be NULL, if
+ *				driver don't need this info.
+ *
+ * Return: 0 if success, -EINVAL if error.
+ */
+int __init acpi_gtdt_init(struct acpi_table_header *table,
+			  int *platform_timer_count)
+{
+	int ret = 0;
+	int timer_count = 0;
+	void *platform_timer = NULL;
+	struct acpi_table_gtdt *gtdt;
+
+	gtdt = container_of(table, struct acpi_table_gtdt, header);
+	acpi_gtdt_desc.gtdt = gtdt;
+	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
+
+	if (table->revision < 2)
+		pr_debug("Revision:%d doesn't support Platform Timers.\n",
+			 table->revision);
+	else if (!gtdt->platform_timer_count)
+		pr_debug("No Platform Timer.\n");
+	else
+		timer_count = gtdt->platform_timer_count;
+
+	if (timer_count) {
+		platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
+		if (platform_timer < (void *)table +
+				     sizeof(struct acpi_table_gtdt)) {
+			pr_err(FW_BUG "invalid timer data.\n");
+			timer_count = 0;
+			platform_timer = NULL;
+			ret = -EINVAL;
+		}
+	}
+
+	acpi_gtdt_desc.platform_timer = platform_timer;
+	if (platform_timer_count)
+		*platform_timer_count = timer_count;
+
+	return ret;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 61a3d90..d201ce4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -577,6 +577,12 @@ enum acpi_reconfig_event  {
 int acpi_reconfig_notifier_register(struct notifier_block *nb);
 int acpi_reconfig_notifier_unregister(struct notifier_block *nb);
 
+#ifdef CONFIG_ACPI_GTDT
+int acpi_gtdt_init(struct acpi_table_header *table, int *platform_timer_count);
+int acpi_gtdt_map_ppi(int type);
+bool acpi_gtdt_c3stop(int type);
+#endif
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
-- 
2.9.3

