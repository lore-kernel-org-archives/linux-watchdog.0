Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58997 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756326AbcGZMVe (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jul 2016 08:21:34 -0400
From: fu.wei@linaro.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, marc.zyngier@arm.com,
	lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
	hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, graeme.gregory@linaro.org,
	al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
	wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com, leo.duran@amd.com,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v10 6/8] acpi/arm64: Add memory-mapped timer support in GTDT driver
Date: Tue, 26 Jul 2016 20:19:23 +0800
Message-Id: <1469535565-20924-7-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
References: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

On platforms booting with ACPI, architected memory-mapped timers'
configuration data is provided by firmware through the ACPI GTDT
static table.

The clocksource architected timer kernel driver requires a firmware
interface to collect timer configuration and configure its driver.
this infrastructure is present for device tree systems, but it is
missing on systems booting with ACPI.

Implement the kernel infrastructure required to parse the static
ACPI GTDT table so that the architected timer clocksource driver can
make use of it on systems booting with ACPI, therefore enabling
the corresponding timers configuration.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/acpi_gtdt.c       | 70 ++++++++++++++++++++++++++++++++++++
 include/clocksource/arm_arch_timer.h | 15 ++++++++
 include/linux/acpi.h                 |  1 +
 3 files changed, 86 insertions(+)

diff --git a/drivers/acpi/arm64/acpi_gtdt.c b/drivers/acpi/arm64/acpi_gtdt.c
index cdb2fb1..0159175 100644
--- a/drivers/acpi/arm64/acpi_gtdt.c
+++ b/drivers/acpi/arm64/acpi_gtdt.c
@@ -150,3 +150,73 @@ int __init acpi_gtdt_init(struct acpi_table_header *table)
 
 	return gtdt->platform_timer_count;
 }
+
+static int __init gtdt_parse_gt_block(struct acpi_gtdt_timer_block *block,
+				      struct gt_block_data *data)
+{
+	struct acpi_gtdt_timer_entry *frame;
+	int i;
+
+	if (!block || !data)
+		return -EINVAL;
+
+	if (!block->block_address || !block->timer_count)
+		return -EINVAL;
+
+	data->cntctlbase_phy = (phys_addr_t)block->block_address;
+	data->timer_count = block->timer_count;
+
+	frame = (void *)block + block->timer_offset;
+	if (frame + block->timer_count != (void *)block + block->header.length)
+		return -EINVAL;
+
+	/*
+	 * Get the GT timer Frame data for every GT Block Timer
+	 */
+	for (i = 0; i < block->timer_count; i++, frame++) {
+		if (!frame->base_address || !frame->timer_interrupt)
+			return -EINVAL;
+
+		data->timer[i].irq = map_gt_gsi(frame->timer_interrupt,
+						frame->timer_flags);
+		if (data->timer[i].irq <= 0)
+			return -EINVAL;
+
+		if (frame->virtual_timer_interrupt) {
+			data->timer[i].virtual_irq =
+				map_gt_gsi(frame->virtual_timer_interrupt,
+					   frame->virtual_timer_flags);
+			if (data->timer[i].virtual_irq <= 0)
+				return -EINVAL;
+		}
+
+		data->timer[i].frame_nr = frame->frame_number;
+		data->timer[i].cntbase_phy = frame->base_address;
+	}
+
+	return 0;
+}
+
+/*
+ * Get the GT block info for memory-mapped timer from GTDT table.
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
index 16dcd10..94a5d14 100644
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
+	int virtual_irq;
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

