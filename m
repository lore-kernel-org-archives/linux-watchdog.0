Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40828 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbbLBFnx (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Dec 2015 00:43:53 -0500
From: fu.wei@linaro.org
To: linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
	lenb@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
	hanjun.guo@linaro.org, davem@davemloft.net,
	jeffrey.t.kirsher@intel.com, richardcochran@gmail.com
Cc: arnd@arndb.de, wim@iguana.be, jcm@redhat.com, leo.duran@amd.com,
	mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com, robherring2@gmail.com,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v2 1/3] ACPI: add GTDT table parse driver into ACPI driver
Date: Wed,  2 Dec 2015 13:43:02 +0800
Message-Id: <1449034984-12075-2-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1449034984-12075-1-git-send-email-fu.wei@linaro.org>
References: <1449034984-12075-1-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This driver adds support for parsing all kinds of timer in GTDT:
(1)arch timer: provide a kernel API to parse all the PPIs and
always-on info in GTDT and export them by arch_timer_data struct.

(2)memory-mapped timer: provide several kernel APIs to parse
GT Block Structure in GTDT, export those info by return value
and arch_timer_mem_data struct.

(3)SBSA Generic Watchdog: parse all info in SBSA Generic Watchdog
Structure in GTDT, and creating a platform device with that
information. This allows the operating system to obtain device
data from the resource of platform device.
The platform device named "sbsa-gwdt" can be used by the ARM SBSA
Generic Watchdog driver.

By this driver, we can simplify all the relevant drivers, and
separate all the ACPI GTDT knowledge from them.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Kconfig                 |   9 +
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/gtdt.c                  | 367 +++++++++++++++++++++++++++++++++++
 drivers/clocksource/arm_arch_timer.c |   2 -
 include/clocksource/arm_arch_timer.h |  19 ++
 include/linux/acpi.h                 |  17 ++
 6 files changed, 413 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 25dbb76..9b23596 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -510,4 +510,13 @@ config XPOWER_PMIC_OPREGION
 
 endif
 
+config ACPI_GTDT
+	bool "ACPI GTDT Support"
+	depends on ARM64
+	help
+	  GTDT (Generic Timer Description Table) provides information
+	  for per-processor timers and Platform (memory-mapped) timers
+	  for ARM platforms. Select this option to provide information
+	  needed for the timers init.
+
 endif	# ACPI
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 675eaf3..ac42e31 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -96,5 +96,6 @@ obj-$(CONFIG_ACPI_EXTLOG)	+= acpi_extlog.o
 obj-$(CONFIG_PMIC_OPREGION)	+= pmic/intel_pmic.o
 obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
 obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
+obj-$(CONFIG_ACPI_GTDT)		+= gtdt.o
 
 video-objs			+= acpi_video.o video_detect.o
diff --git a/drivers/acpi/gtdt.c b/drivers/acpi/gtdt.c
new file mode 100644
index 0000000..d15ea91
--- /dev/null
+++ b/drivers/acpi/gtdt.c
@@ -0,0 +1,367 @@
+/*
+ * ARM Specific GTDT table Support
+ *
+ * Copyright (C) 2015, Linaro Ltd.
+ * Author: Fu Wei <fu.wei@linaro.org>
+ *         Hanjun Guo <hanjun.guo@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <clocksource/arm_arch_timer.h>
+
+static u32 platform_timer_count __initdata;
+static int gtdt_timers_existence __initdata;
+
+/*
+ * Get some basic info from GTDT table, and init the global variables above
+ * for all timers initialization of Generic Timer.
+ * This function does some validation on GTDT table, and will be run only once.
+ */
+static void __init *platform_timer_info_init(struct acpi_table_header *table)
+{
+	void *gtdt_end, *platform_timer_struct, *platform_timer;
+	struct acpi_gtdt_header *header;
+	struct acpi_table_gtdt *gtdt;
+	u32 i;
+
+	gtdt = container_of(table, struct acpi_table_gtdt, header);
+	if (!gtdt) {
+		pr_err("GTDT: table pointer error, bad table.\n");
+		return NULL;
+	}
+	gtdt_end = (void *)table + table->length;
+	gtdt_timers_existence |= ARCH_CP15_TIMER;
+
+	if (table->revision < 2) {
+		pr_info("GTDT: Revision:%d doesn't support Platform Timers.\n",
+			table->revision);
+		return NULL;
+	}
+
+	platform_timer_count = gtdt->platform_timer_count;
+	if (!platform_timer_count) {
+		pr_info("GTDT: No Platform Timer structures.\n");
+		return NULL;
+	}
+
+	platform_timer_struct = (void *)gtdt + gtdt->platform_timer_offset;
+	if (platform_timer_struct < (void *)table +
+				    sizeof(struct acpi_table_gtdt)) {
+		pr_err("GTDT: Platform Timer pointer error, bad table.\n");
+		return NULL;
+	}
+
+	platform_timer = platform_timer_struct;
+	for (i = 0; i < platform_timer_count; i++) {
+		if (platform_timer > gtdt_end) {
+			pr_warn("GTDT: subtable pointer overflows, bad table\n");
+			platform_timer_count = i;
+			break;
+		}
+		header = (struct acpi_gtdt_header *)platform_timer;
+		if (header->type == ACPI_GTDT_TYPE_TIMER_BLOCK)
+			gtdt_timers_existence |= ARCH_MEM_TIMER;
+		else if (header->type == ACPI_GTDT_TYPE_WATCHDOG)
+			gtdt_timers_existence |= ARCH_WD_TIMER;
+		platform_timer += header->length;
+	}
+
+	return platform_timer_struct;
+}
+
+static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
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
+ * Get the necessary info of arch_timer from GTDT table.
+ */
+int __init gtdt_arch_timer_data_init(struct acpi_table_header *table,
+				     struct arch_timer_data *data)
+{
+	struct acpi_table_gtdt *gtdt;
+
+	if (acpi_disabled)
+		return -EINVAL;
+
+	if (!gtdt_timers_existence)
+		platform_timer_info_init(table);
+
+	gtdt = container_of(table, struct acpi_table_gtdt, header);
+	if (!gtdt || !data)
+		return -EINVAL;
+
+	data->phys_secure_ppi =
+		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
+					    gtdt->secure_el1_flags);
+
+	data->phys_nonsecure_ppi =
+		map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
+					    gtdt->non_secure_el1_flags);
+
+	data->virt_ppi =
+		map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
+					    gtdt->virtual_timer_flags);
+
+	data->hyp_ppi =
+		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
+					    gtdt->non_secure_el2_flags);
+
+	data->c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
+
+	return 0;
+}
+
+bool __init gtdt_timer_is_available(int type)
+{
+	return gtdt_timers_existence | type;
+}
+
+/*
+ * Helper function for getting the pointer of platform_timer_struct.
+ */
+static void __init *get_platform_timer_struct(struct acpi_table_header *table)
+{
+	struct acpi_table_gtdt *gtdt;
+
+	gtdt = container_of(table, struct acpi_table_gtdt, header);
+	if (gtdt)
+		return (void *)gtdt + gtdt->platform_timer_offset;
+
+	pr_err("GTDT: table pointer error, bad table.\n");
+	return NULL;
+}
+
+ /*
+ * Get the pointer of GT Block Structure in GTDT table
+ */
+void __init *gtdt_gt_block(struct acpi_table_header *table, int index)
+{
+	struct acpi_gtdt_header *header;
+	void *platform_timer;
+	int i, j;
+
+	if (!gtdt_timers_existence)
+		platform_timer = platform_timer_info_init(table);
+	else
+		platform_timer = get_platform_timer_struct(table);
+
+	if (!gtdt_timer_is_available(ARCH_MEM_TIMER))
+		return NULL;
+
+	for (i = 0, j = 0; i < platform_timer_count; i++) {
+		header = (struct acpi_gtdt_header *)platform_timer;
+		if (header->type == ACPI_GTDT_TYPE_TIMER_BLOCK && j++ == index)
+			return platform_timer;
+		platform_timer += header->length;
+	}
+
+	return NULL;
+}
+
+/*
+ * Get the timer_count(the number of timer frame) of a GT Block in GTDT table
+ */
+u32 __init gtdt_gt_timer_count(struct acpi_gtdt_timer_block *gt_block)
+{
+	if (!gt_block) {
+		pr_err("GTDT: invalid GT Block baseaddr.\n");
+		return 0;
+	}
+
+	return gt_block->timer_count;
+}
+
+/*
+ * Get the physical address of GT Block in GTDT table
+ */
+void __init *gtdt_gt_cntctlbase(struct acpi_gtdt_timer_block *gt_block)
+{
+	if (!gt_block) {
+		pr_err("GTDT: invalid GT Block baseaddr.\n");
+		return NULL;
+	}
+
+	return (void *)gt_block->block_address;
+}
+
+/*
+ * Helper function for getting the pointer of a timer frame in GT block.
+ */
+static void __init *gtdt_gt_timer_frame(struct acpi_gtdt_timer_block *gt_block,
+					int index)
+{
+	void *timer_frame;
+
+	if (!(gt_block && gt_block->timer_count))
+		return NULL;
+
+	timer_frame = (void *)gt_block + gt_block->timer_offset +
+		      sizeof(struct acpi_gtdt_timer_entry) * index;
+
+	if (timer_frame <= (void *)gt_block + gt_block->header.length -
+			  sizeof(struct acpi_gtdt_timer_entry))
+		return timer_frame;
+
+	pr_err("GTDT: invalid GT Block timer frame entry addr.\n");
+	return NULL;
+}
+
+/*
+ * Get the GT timer Frame Number(ID) in a GT Block Timer Structure.
+ * The maximum Frame Number(ID) is (ARCH_TIMER_MEM_MAX_FRAME - 1),
+ * so returning ARCH_TIMER_MEM_MAX_FRAME means error.
+ */
+u32 __init gtdt_gt_frame_number(struct acpi_gtdt_timer_block *gt_block,
+				int index)
+{
+	struct acpi_gtdt_timer_entry *frame;
+
+	frame = (struct acpi_gtdt_timer_entry *)gtdt_gt_timer_frame(gt_block,
+								    index);
+	if (frame)
+		return frame->frame_number;
+
+	return ARCH_TIMER_MEM_MAX_FRAME;
+}
+
+/*
+ * Get the GT timer Frame data in a GT Block Timer Structure
+ */
+int __init gtdt_gt_timer_data(struct acpi_gtdt_timer_block *gt_block,
+			      int index, bool virt,
+			      struct arch_timer_mem_data *data)
+{
+	struct acpi_gtdt_timer_entry *frame;
+
+	frame = (struct acpi_gtdt_timer_entry *)gtdt_gt_timer_frame(gt_block,
+								    index);
+	if (!frame)
+		return -EINVAL;
+
+	data->cntbase_phy = (phys_addr_t)frame->base_address;
+	if (virt)
+		data->irq = map_generic_timer_interrupt(
+				frame->virtual_timer_interrupt,
+				frame->virtual_timer_flags);
+	else
+		data->irq = map_generic_timer_interrupt(frame->timer_interrupt,
+							frame->timer_flags);
+
+	return 0;
+}
+
+/*
+ * Initialize a SBSA generic Watchdog platform device info from GTDT
+ */
+static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
+					int index)
+{
+	struct platform_device *pdev;
+	int irq = map_generic_timer_interrupt(wd->timer_interrupt,
+					      wd->timer_flags);
+	/*
+	 * According to SBSA specification the size of refresh and control
+	 * frames of SBSA Generic Watchdog is SZ_4K(Offset 0x000 – 0xFFF).
+	 */
+	struct resource res[] = {
+		DEFINE_RES_IRQ(irq),
+		DEFINE_RES_MEM(wd->control_frame_address, SZ_4K),
+		DEFINE_RES_MEM(wd->refresh_frame_address, SZ_4K),
+	};
+
+	pr_debug("GTDT: a Watchdog GT(0x%llx/0x%llx gsi:%u flags:0x%x)\n",
+		 wd->refresh_frame_address, wd->control_frame_address,
+		 wd->timer_interrupt, wd->timer_flags);
+
+	if (!(wd->refresh_frame_address &&
+	      wd->control_frame_address &&
+	      wd->timer_interrupt)) {
+		pr_err("GTDT: failed geting the device info.\n");
+		return -EINVAL;
+	}
+
+	if (irq < 0) {
+		pr_err("GTDT: failed to register GSI of the Watchdog GT.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Add a platform device named "sbsa-gwdt" to match the platform driver.
+	 * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watchdog
+	 * The platform driver (like drivers/watchdog/sbsa_gwdt.c)can get device
+	 * info below by matching this name.
+	 */
+	pdev = platform_device_register_simple("sbsa-gwdt", index, res,
+					       ARRAY_SIZE(res));
+	if (IS_ERR(pdev)) {
+		acpi_unregister_gsi(wd->timer_interrupt);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+
+static int __init gtdt_sbsa_gwdt_parse(struct acpi_table_header *table)
+{
+	struct acpi_gtdt_header *header;
+	void *platform_timer;
+	int i, gwdt_index;
+	int ret = 0;
+
+	/*
+	 * At this proint, we have got and validate some info about platform
+	 * timer in platform_timer_info_init.
+	 */
+	if (!gtdt_timer_is_available(ARCH_WD_TIMER))
+		return -EINVAL;
+
+	platform_timer = get_platform_timer_struct(table);
+
+	for (i = 0, gwdt_index = 0; i < platform_timer_count; i++) {
+		header = (struct acpi_gtdt_header *)platform_timer;
+		if (header->type == ACPI_GTDT_TYPE_WATCHDOG) {
+			ret = gtdt_import_sbsa_gwdt(platform_timer, gwdt_index);
+			if (ret)
+				pr_err("GTDT: failed to import subtable %d\n",
+				       i);
+			else
+				gwdt_index++;
+		}
+		platform_timer += header->length;
+	}
+
+	return ret;
+}
+
+static int __init gtdt_sbsa_gwdt_init(void)
+{
+	if (acpi_disabled)
+		return 0;
+
+	return acpi_table_parse(ACPI_SIG_GTDT, gtdt_sbsa_gwdt_parse);
+}
+
+device_initcall(gtdt_sbsa_gwdt_init);
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index c64d543..e16fdad 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -40,8 +40,6 @@
 #define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
-#define ARCH_CP15_TIMER	BIT(0)
-#define ARCH_MEM_TIMER	BIT(1)
 static unsigned arch_timers_present __initdata;
 
 static void __iomem *arch_counter_base;
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 9916d0e..7a6d6dc 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -19,6 +19,10 @@
 #include <linux/timecounter.h>
 #include <linux/types.h>
 
+#define ARCH_CP15_TIMER	BIT(0)
+#define ARCH_MEM_TIMER	BIT(1)
+#define ARCH_WD_TIMER	BIT(2)
+
 #define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
 #define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
 #define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
@@ -33,6 +37,8 @@ enum arch_timer_reg {
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
 #define ARCH_TIMER_MEM_VIRT_ACCESS	3
 
+#define ARCH_TIMER_MEM_MAX_FRAME	8
+
 #define ARCH_TIMER_USR_PCT_ACCESS_EN	(1 << 0) /* physical counter */
 #define ARCH_TIMER_USR_VCT_ACCESS_EN	(1 << 1) /* virtual counter */
 #define ARCH_TIMER_VIRT_EVT_EN		(1 << 2)
@@ -43,6 +49,19 @@ enum arch_timer_reg {
 
 #define ARCH_TIMER_EVT_STREAM_FREQ	10000	/* 100us */
 
+struct arch_timer_data {
+	int phys_secure_ppi;
+	int phys_nonsecure_ppi;
+	int virt_ppi;
+	int hyp_ppi;
+	bool c3stop;
+};
+
+struct arch_timer_mem_data {
+	phys_addr_t cntbase_phy;
+	int irq;
+};
+
 #ifdef CONFIG_ARM_ARCH_TIMER
 
 extern u32 arch_timer_get_rate(void);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0548339..8dac186 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -468,6 +468,23 @@ void acpi_walk_dep_device_list(acpi_handle handle);
 struct platform_device *acpi_create_platform_device(struct acpi_device *);
 #define ACPI_PTR(_ptr)	(_ptr)
 
+#ifdef CONFIG_ACPI_GTDT
+bool __init gtdt_timer_is_available(int type);
+
+struct arch_timer_data;
+int __init gtdt_arch_timer_data_init(struct acpi_table_header *table,
+				     struct arch_timer_data *data);
+struct arch_timer_mem_data;
+void __init *gtdt_gt_block(struct acpi_table_header *table, int index);
+u32 __init gtdt_gt_timer_count(struct acpi_gtdt_timer_block *gt_block);
+void __init *gtdt_gt_cntctlbase(struct acpi_gtdt_timer_block *gt_block);
+u32 __init gtdt_gt_frame_number(struct acpi_gtdt_timer_block *gt_block,
+				int index);
+int __init gtdt_gt_timer_data(struct acpi_gtdt_timer_block *gt_block,
+			      int index, bool virt,
+			      struct arch_timer_mem_data *data);
+#endif
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
-- 
2.5.0

