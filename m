Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36197 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765370AbcINULu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 14 Sep 2016 16:11:50 -0400
Received: by mail-wm0-f51.google.com with SMTP id b187so64476220wme.1
        for <linux-watchdog@vger.kernel.org>; Wed, 14 Sep 2016 13:11:49 -0700 (PDT)
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
Subject: [PATCH v13 4/8] acpi/arm64: Add GTDT table parse driver
Date: Thu, 15 Sep 2016 04:09:37 +0800
Message-Id: <1473883781-9571-5-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1473883781-9571-1-git-send-email-fu.wei@linaro.org>
References: <1473883781-9571-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patch adds support for parsing arch timer in GTDT,
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
 drivers/acpi/arm64/gtdt.c   | 152 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/Kconfig |   1 -
 include/linux/acpi.h        |   6 ++
 6 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f..0607728 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@ config ARM64
 	def_bool y
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_GTDT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
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
index 0000000..b24844d
--- /dev/null
+++ b/drivers/acpi/arm64/gtdt.c
@@ -0,0 +1,152 @@
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
+struct acpi_gtdt_descriptor {
+	struct acpi_table_gtdt *gtdt;
+	void *platform_timer_start;
+	void *gtdt_end;
+};
+
+static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
+
+static inline void *next_platform_timer(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh = platform_timer;
+
+	platform_timer += gh->length;
+	if (platform_timer < acpi_gtdt_desc.gtdt_end)
+		return platform_timer;
+
+	return NULL;
+}
+
+#define for_each_platform_timer(_g)				\
+	for (_g = acpi_gtdt_desc.platform_timer_start; _g;	\
+	     _g = next_platform_timer(_g))
+
+static inline bool is_timer_block(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh = platform_timer;
+
+	return gh->type == ACPI_GTDT_TYPE_TIMER_BLOCK;
+}
+
+static inline bool is_watchdog(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh = platform_timer;
+
+	return gh->type == ACPI_GTDT_TYPE_WATCHDOG;
+}
+
+static int __init map_gt_gsi(u32 interrupt, u32 flags)
+{
+	int trigger, polarity;
+
+	if (!interrupt)
+		return 0;
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
+/*
+ * Map the PPIs of per-cpu arch_timer.
+ * @type: the type of PPI
+ * Returns 0 if error.
+ */
+int __init acpi_gtdt_map_ppi(int type)
+{
+	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+
+	switch (type) {
+	case PHYS_SECURE_PPI:
+		return map_gt_gsi(gtdt->secure_el1_interrupt,
+				  gtdt->secure_el1_flags);
+	case PHYS_NONSECURE_PPI:
+		return map_gt_gsi(gtdt->non_secure_el1_interrupt,
+				  gtdt->non_secure_el1_flags);
+	case VIRT_PPI:
+		return map_gt_gsi(gtdt->virtual_timer_interrupt,
+				  gtdt->virtual_timer_flags);
+
+	case HYP_PPI:
+		return map_gt_gsi(gtdt->non_secure_el2_interrupt,
+				  gtdt->non_secure_el2_flags);
+	default:
+		pr_err("Failed to map timer interrupt: invalid type.\n");
+	}
+
+	return 0;
+}
+
+/*
+ * acpi_gtdt_c3stop - got c3stop info from GTDT
+ *
+ * Returns 1 if the timer is powered in deep idle state, 0 otherwise.
+ */
+bool __init acpi_gtdt_c3stop(void)
+{
+	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+
+	return !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
+}
+
+/*
+ * Get some basic info from GTDT table, and init the global variables above
+ * for all timers initialization of Generic Timer.
+ * This function does some validation on GTDT table.
+ */
+int __init acpi_gtdt_init(struct acpi_table_header *table)
+{
+	void *start;
+	struct acpi_table_gtdt *gtdt;
+
+	gtdt = container_of(table, struct acpi_table_gtdt, header);
+
+	acpi_gtdt_desc.gtdt = gtdt;
+	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
+
+	if (table->revision < 2) {
+		pr_debug("Revision:%d doesn't support Platform Timers.\n",
+			 table->revision);
+		return 0;
+	}
+
+	if (!gtdt->platform_timer_count) {
+		pr_debug("No Platform Timer.\n");
+		return 0;
+	}
+
+	start = (void *)gtdt + gtdt->platform_timer_offset;
+	if (start < (void *)table + sizeof(struct acpi_table_gtdt)) {
+		pr_err(FW_BUG "Failed to retrieve timer info from firmware: invalid data.\n");
+		return -EINVAL;
+	}
+	acpi_gtdt_desc.platform_timer_start = start;
+
+	return gtdt->platform_timer_count;
+}
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5677886..b58d259 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -285,7 +285,6 @@ config CLKSRC_MPS2
 config ARM_ARCH_TIMER
 	bool
 	select CLKSRC_OF if OF
-	select CLKSRC_ACPI if ACPI
 
 config ARM_ARCH_TIMER_EVTSTREAM
 	bool "Enable ARM architected timer event stream generation by default"
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c5eaf2f..e2f9841 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -567,6 +567,12 @@ enum acpi_reconfig_event  {
 int acpi_reconfig_notifier_register(struct notifier_block *nb);
 int acpi_reconfig_notifier_unregister(struct notifier_block *nb);
 
+#ifdef CONFIG_ACPI_GTDT
+int acpi_gtdt_init(struct acpi_table_header *table);
+int acpi_gtdt_map_ppi(int type);
+bool acpi_gtdt_c3stop(void);
+#endif
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
-- 
2.7.4

