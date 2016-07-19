Return-path: <fu.wei@linaro.org>
From: fu.wei@linaro.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org,
        jcm@redhat.com, wei@redhat.com, arnd@arndb.de, wim@iguana.be,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v8 7/9] acpi/arm64: Add memory-mapped timer support in GTDT driver
Date: Wed, 20 Jul 2016 02:18:02 +0800
Message-Id: <1468952284-28942-8-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1468952284-28942-1-git-send-email-fu.wei@linaro.org>
References: <1468952284-28942-1-git-send-email-fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Fu Wei <fu.wei@linaro.org>

This driver adds support for parsing memory-mapped timer in GTDT:
provide a kernel APIs to parse GT Block Structure in GTDT,
export all the info by filling the struct which provided
by parameter(pointer of the struct).

By this driver, we can add ACPI support for memory-mapped timer in
arm_arch_timer drivers, and separate the ACPI GTDT knowledge from it.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/acpi_gtdt.c       | 72 ++++++++++++++++++++++++++++++++++++
 include/clocksource/arm_arch_timer.h | 15 ++++++++
 include/linux/acpi.h                 |  1 +
 3 files changed, 88 insertions(+)

diff --git a/drivers/acpi/arm64/acpi_gtdt.c b/drivers/acpi/arm64/acpi_gtdt.c
index e1cfc9e..b48e443 100644
--- a/drivers/acpi/arm64/acpi_gtdt.c
+++ b/drivers/acpi/arm64/acpi_gtdt.c
@@ -150,3 +150,75 @@ int __init acpi_gtdt_init(struct acpi_table_header *table)
 
 	return gtdt->platform_timer_count;
 }
+
+static int __init gtdt_parse_gt_block(void *platform_timer,
+				      struct gt_block_data *data)
+{
+	struct acpi_gtdt_timer_block *block = platform_timer;
+	struct acpi_gtdt_timer_entry *frame;
+	int i;
+
+	if (!block || !data)
+		return -EINVAL;
+
+	if (!block->block_address || !block->timer_count)
+		goto error;
+
+	data->cntctlbase_phy = (phys_addr_t)block->block_address;
+	data->timer_count = block->timer_count;
+
+	frame = (void *)block + block->timer_offset;
+	if (frame + block->timer_count != (void *)block + block->header.length)
+		goto error;
+
+	/*
+	 * Get the GT timer Frame data for every GT Block Timer
+	 */
+	for (i = 0; i < block->timer_count; i++) {
+		frame += i;
+		if (!frame->base_address || !frame->timer_interrupt)
+			goto error;
+
+		data->timer[i].frame_nr = frame->frame_number;
+		data->timer[i].cntbase_phy = frame->base_address;
+		data->timer[i].irq =
+			map_generic_timer_interrupt(frame->timer_interrupt,
+						    frame->timer_flags);
+		if (frame->virtual_timer_interrupt)
+			data->timer[i].virt_irq =
+				map_generic_timer_interrupt(
+					frame->virtual_timer_interrupt,
+					frame->virtual_timer_flags);
+	}
+	return 0;
+
+error:
+	pr_err(FW_BUG "invalid GT Block data.\n");
+	return -EINVAL;
+}
+
+/*
+ * Get the GT block info for memory-mapped timer from GTDT table.
+ * Please make sure we have called acpi_gtdt_init, because it helps to
+ * init the global variables.
+ */
+int __init gtdt_arch_timer_mem_init(struct gt_block_data *data)
+{
+	void *platform_timer;
+	int index = 0;
+	int ret;
+
+	for_each_platform_timer(platform_timer) {
+		if (!is_timer_block(platform_timer))
+			continue;
+		ret = gtdt_parse_gt_block(platform_timer, data + index);
+		if (ret)
+			return ret;
+		index++;
+	}
+
+	if (index)
+		pr_info("found %d memory-mapped timer block(s).\n", index);
+
+	return index;
+}
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 16dcd10..ece6b3b 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -56,6 +56,8 @@ enum spi_nr {
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
 #define ARCH_TIMER_MEM_VIRT_ACCESS	3
 
+#define ARCH_TIMER_MEM_MAX_FRAME	8
+
 #define ARCH_TIMER_USR_PCT_ACCESS_EN	(1 << 0) /* physical counter */
 #define ARCH_TIMER_USR_VCT_ACCESS_EN	(1 << 1) /* virtual counter */
 #define ARCH_TIMER_VIRT_EVT_EN		(1 << 2)
@@ -71,6 +73,19 @@ struct arch_timer_kvm_info {
 	int virtual_irq;
 };
 
+struct gt_timer_data {
+	int frame_nr;
+	phys_addr_t cntbase_phy;
+	int irq;
+	int virt_irq;
+};
+
+struct gt_block_data {
+	phys_addr_t cntctlbase_phy;
+	int timer_count;
+	struct gt_timer_data timer[ARCH_TIMER_MEM_MAX_FRAME];
+};
+
 #ifdef CONFIG_ARM_ARCH_TIMER
 
 extern u32 arch_timer_get_rate(void);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index fb8b689..24b1750 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -536,6 +536,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *);
 int acpi_gtdt_init(struct acpi_table_header *table);
 int acpi_gtdt_map_ppi(int type);
 bool acpi_gtdt_c3stop(void);
+int gtdt_arch_timer_mem_init(struct gt_block_data *data);
 #endif
 
 #else	/* !CONFIG_ACPI */
-- 
2.5.5
