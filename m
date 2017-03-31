Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933727AbdCaRx2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 31 Mar 2017 13:53:28 -0400
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
Subject: [PATCH v23 09/11] acpi/arm64: Add memory-mapped timer support in GTDT driver
Date: Sat,  1 Apr 2017 01:51:03 +0800
Message-Id: <20170331175105.8370-10-fu.wei@linaro.org>
In-Reply-To: <20170331175105.8370-1-fu.wei@linaro.org>
References: <20170331175105.8370-1-fu.wei@linaro.org>
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
 drivers/acpi/arm64/gtdt.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h      |   1 +
 2 files changed, 147 insertions(+)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 3d95af8..3dd33f3 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -13,6 +13,7 @@
 
 #include <linux/acpi.h>
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -37,6 +38,28 @@ struct acpi_gtdt_descriptor {
 
 static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
 
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
+	for (_g = acpi_gtdt_desc.platform_timer; _g;	\
+	     _g = next_platform_timer(_g))
+
+static inline bool is_timer_block(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh = platform_timer;
+
+	return gh->type == ACPI_GTDT_TYPE_TIMER_BLOCK;
+}
+
 static int __init map_gt_gsi(u32 interrupt, u32 flags)
 {
 	int trigger, polarity;
@@ -155,3 +178,126 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
 
 	return 0;
 }
+
+static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
+					 struct arch_timer_mem *timer_mem)
+{
+	int i;
+	struct arch_timer_mem_frame *frame;
+	struct acpi_gtdt_timer_entry *gtdt_frame;
+
+	if (!block->timer_count) {
+		pr_err(FW_BUG "GT block present, but frame count is zero.");
+		return -ENODEV;
+	}
+
+	if (block->timer_count > ARCH_TIMER_MEM_MAX_FRAMES) {
+		pr_err(FW_BUG "GT block lists %d frames, ACPI spec only allows 8\n",
+		       block->timer_count);
+		return -EINVAL;
+	}
+
+	timer_mem->cntctlbase = (phys_addr_t)block->block_address;
+	/*
+	 * The CNTCTLBase frame is 4KB (register offsets 0x000 - 0xFFC).
+	 * See ARM DDI 0487A.k_iss10775, page I1-5129, Table I1-3
+	 * "CNTCTLBase memory map".
+	 */
+	timer_mem->size = SZ_4K;
+
+	gtdt_frame = (void *)block + block->timer_offset;
+	if (gtdt_frame + block->timer_count != (void *)block + block->header.length)
+		return -EINVAL;
+
+	/*
+	 * Get the GT timer Frame data for every GT Block Timer
+	 */
+	for (i = 0; i < block->timer_count; i++, gtdt_frame++) {
+		if (gtdt_frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER)
+			continue;
+
+		if (!gtdt_frame->base_address || !gtdt_frame->timer_interrupt)
+			goto error;
+
+		frame = &timer_mem->frame[gtdt_frame->frame_number];
+		frame->phys_irq = map_gt_gsi(gtdt_frame->timer_interrupt,
+					     gtdt_frame->timer_flags);
+		if (frame->phys_irq <= 0) {
+			pr_warn("failed to map physical timer irq in frame %d.\n",
+				gtdt_frame->frame_number);
+			goto error;
+		}
+
+		if (gtdt_frame->virtual_timer_interrupt) {
+			frame->virt_irq =
+				map_gt_gsi(gtdt_frame->virtual_timer_interrupt,
+					   gtdt_frame->virtual_timer_flags);
+			if (frame->virt_irq <= 0) {
+				pr_warn("failed to map virtual timer irq in frame %d.\n",
+					gtdt_frame->frame_number);
+				acpi_unregister_gsi(gtdt_frame->timer_interrupt);
+				goto error;
+			}
+		} else {
+			frame->virt_irq = 0;
+			pr_debug("virtual timer in frame %d not implemented.\n",
+				 gtdt_frame->frame_number);
+		}
+
+		frame->cntbase = gtdt_frame->base_address;
+		/*
+		 * The CNTBaseN frame is 4KB (register offsets 0x000 - 0xFFC).
+		 * See ARM DDI 0487A.k_iss10775, page I1-5130, Table I1-4
+		 * "CNTBaseN memory map".
+		 */
+		frame->size = SZ_4K;
+		frame->valid = true;
+	}
+
+	return 0;
+
+error:
+	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
+		frame = &timer_mem->frame[i];
+		if (!frame->valid)
+			continue;
+		irq_dispose_mapping(frame->phys_irq);
+		if (frame->virt_irq)
+			irq_dispose_mapping(frame->virt_irq);
+	}
+	return -EINVAL;
+}
+
+/**
+ * acpi_arch_timer_mem_init() - Get the info of all GT blocks in GTDT table.
+ * @timer_mem:	The pointer to the array of struct arch_timer_mem for returning
+ *		the result of parsing. The element number of this array should
+ *		be platform_timer_count(the total number of platform timers).
+ * @timer_count: It points to a integer variable which is used for storing the
+ *		number of GT blocks we have parsed.
+ *
+ * Return: 0 if success, -EINVAL/-ENODEV if error.
+ */
+int __init acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem,
+				    int *timer_count)
+{
+	int ret;
+	void *platform_timer;
+
+	*timer_count = 0;
+	for_each_platform_timer(platform_timer) {
+		if (is_timer_block(platform_timer)) {
+			ret = gtdt_parse_timer_block(platform_timer, timer_mem);
+			if (ret)
+				return ret;
+			timer_mem++;
+			(*timer_count)++;
+		}
+	}
+
+	if (*timer_count)
+		pr_info("found %d memory-mapped timer block(s).\n",
+			*timer_count);
+
+	return 0;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4b5c146..3193724 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -599,6 +599,7 @@ int acpi_reconfig_notifier_unregister(struct notifier_block *nb);
 int acpi_gtdt_init(struct acpi_table_header *table, int *platform_timer_count);
 int acpi_gtdt_map_ppi(int type);
 bool acpi_gtdt_c3stop(int type);
+int acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem, int *timer_count);
 #endif
 
 #else	/* !CONFIG_ACPI */
-- 
2.9.3

