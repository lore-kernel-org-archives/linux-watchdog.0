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
        linux-watchdog@vger.kernel.org, davem@davemloft.net,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        kvalo@codeaurora.org, mchehab@kernel.org, jslaby@suse.cz,
        christoffer.dall@linaro.org, julien.grall@arm.com,
        Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v7 7/9] acpi/arm64: Add memory-mapped timer support in GTDT driver
Date: Thu, 14 Jul 2016 01:53:20 +0800
Message-Id: <1468432402-4872-8-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
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
 drivers/acpi/arm64/acpi_gtdt.c       | 90 ++++++++++++++++++++++++++++++++++++
 include/clocksource/arm_arch_timer.h | 15 ++++++
 include/linux/acpi.h                 |  1 +
 3 files changed, 106 insertions(+)

diff --git a/drivers/acpi/arm64/acpi_gtdt.c b/drivers/acpi/arm64/acpi_gtdt.c
index 9ee977d..ff62953 100644
--- a/drivers/acpi/arm64/acpi_gtdt.c
+++ b/drivers/acpi/arm64/acpi_gtdt.c
@@ -168,3 +168,93 @@ int __init gtdt_arch_timer_init(struct acpi_table_header *table)
 
 	return -EINVAL;
 }
+
+/*
+ * Helper function for getting the pointer of a timer frame in GT block.
+ */
+static void __init *gtdt_gt_timer_frame(struct acpi_gtdt_timer_block *gt_block,
+					int index)
+{
+	void *timer_frame = (void *)gt_block + gt_block->timer_offset +
+			    sizeof(struct acpi_gtdt_timer_entry) * index;
+
+	if (timer_frame <= (void *)gt_block + gt_block->header.length -
+			   sizeof(struct acpi_gtdt_timer_entry))
+		return timer_frame;
+
+	return NULL;
+}
+
+static int __init gtdt_parse_gt_block(void *platform_timer, int index,
+				      void *data)
+{
+	struct acpi_gtdt_timer_block *block;
+	struct acpi_gtdt_timer_entry *frame;
+	struct gt_block_data *block_data;
+	int i, j;
+
+	if (!platform_timer || !data)
+		return -EINVAL;
+
+	block = platform_timer;
+	block_data = data + sizeof(struct gt_block_data) * index;
+
+	if (!block->block_address || !block->timer_count) {
+		pr_err(FW_BUG "invalid GT Block data.\n");
+		return -EINVAL;
+	}
+	block_data->cntctlbase_phy = (phys_addr_t)block->block_address;
+	block_data->timer_count = block->timer_count;
+
+	/*
+	 * Get the GT timer Frame data for every GT Block Timer
+	 */
+	for (i = 0, j = 0; i < block->timer_count; i++) {
+		frame = gtdt_gt_timer_frame(block, i);
+		if (!frame || !frame->base_address || !frame->timer_interrupt) {
+			pr_err(FW_BUG "invalid GT Block Timer data.\n");
+			return -EINVAL;
+		}
+		block_data->timer[j].frame_nr = frame->frame_number;
+		block_data->timer[j].cntbase_phy = frame->base_address;
+		block_data->timer[j].irq = map_generic_timer_interrupt(
+						   frame->timer_interrupt,
+						   frame->timer_flags);
+		if (frame->virtual_timer_interrupt)
+			block_data->timer[j].virt_irq =
+				map_generic_timer_interrupt(
+					frame->virtual_timer_interrupt,
+					frame->virtual_timer_flags);
+		j++;
+	}
+
+	if (j)
+		return 0;
+
+	block_data->cntctlbase_phy = (phys_addr_t)NULL;
+	block_data->timer_count = 0;
+
+	return -EINVAL;
+}
+
+/*
+ * Get the GT block info for memory-mapped timer from GTDT table.
+ * Please make sure we have called gtdt_arch_timer_init, because it helps to
+ * init the global variables.
+ */
+int __init gtdt_arch_timer_mem_init(struct gt_block_data *data)
+{
+	void *platform_timer;
+	int index = 0;
+
+	for_each_platform_timer(platform_timer) {
+		if (is_timer_block(platform_timer) &&
+		    !gtdt_parse_gt_block(platform_timer, index, data))
+			index++;
+	}
+
+	if (index)
+		pr_info("found %d memory-mapped timer block.\n", index);
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
index 8439579..b1cacbc 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -536,6 +536,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *);
 int __init gtdt_arch_timer_init(struct acpi_table_header *table);
 int __init acpi_gtdt_map_ppi(int type);
 int __init acpi_gtdt_c3stop(void);
+int __init gtdt_arch_timer_mem_init(struct gt_block_data *data);
 #endif
 
 #else	/* !CONFIG_ACPI */
-- 
2.5.5
