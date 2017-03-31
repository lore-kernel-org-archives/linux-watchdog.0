Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933696AbdCaRwx (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 31 Mar 2017 13:52:53 -0400
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
Subject: [PATCH v23 06/11] clocksource: arm_arch_timer: refactor MMIO timer probing.
Date: Sat,  1 Apr 2017 01:51:00 +0800
Message-Id: <20170331175105.8370-7-fu.wei@linaro.org>
In-Reply-To: <20170331175105.8370-1-fu.wei@linaro.org>
References: <20170331175105.8370-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

Currently the code to probe MMIO architected timers mixes DT parsing with
actual poking of hardware. This makes the code harder than necessary to
understand, and makes it difficult to add support for probing via ACPI.

This patch factors all the DT-specific logic out of arch_timer_mem_init(),
into a new function arch_timer_mem_of_init().
The former pokes the hardware and determines the suitablility of frames
based on a datastructure populated by the latter.

This cleanly separates the two and will make it possible to add probing
using the ACPI GTDT in subsequent patches.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 170 +++++++++++++++++++++++++----------
 1 file changed, 122 insertions(+), 48 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9433276..4aaebe7 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -977,17 +977,17 @@ static int __init arch_timer_of_init(struct device_node *np)
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
 CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
 
-static int __init arch_timer_mem_init(struct device_node *np)
+static int __init arch_timer_mem_init(struct arch_timer_mem *timer_mem)
 {
-	struct device_node *frame, *best_frame = NULL;
+	struct arch_timer_mem_frame *best_frame = NULL;
+	u32 cnttidr, arch_timer_mem_freq;
 	void __iomem *cntctlbase, *base;
-	unsigned int irq, ret = -EINVAL;
-	u32 cnttidr;
+	unsigned int irq;
+	int i, ret;
 
-	arch_timers_present |= ARCH_TIMER_TYPE_MEM;
-	cntctlbase = of_iomap(np, 0);
+	cntctlbase = ioremap(timer_mem->cntctlbase, timer_mem->size);
 	if (!cntctlbase) {
-		pr_err("Can't find CNTCTLBase\n");
+		pr_err("Can't map CNTCTLBase.\n");
 		return -ENXIO;
 	}
 
@@ -997,25 +997,20 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	 * Try to find a virtual capable frame. Otherwise fall back to a
 	 * physical capable frame.
 	 */
-	for_each_available_child_of_node(np, frame) {
-		int n;
-		u32 cntacr;
+	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
+		u32 cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
+			     CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
+		struct arch_timer_mem_frame *frame = &timer_mem->frame[i];
 
-		if (of_property_read_u32(frame, "frame-number", &n)) {
-			pr_err("Missing frame-number\n");
-			of_node_put(frame);
-			goto out;
-		}
+		if (!frame->valid)
+			continue;
 
 		/* Try enabling everything, and see what sticks */
-		cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
-			 CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
-		writel_relaxed(cntacr, cntctlbase + CNTACR(n));
-		cntacr = readl_relaxed(cntctlbase + CNTACR(n));
+		writel_relaxed(cntacr, cntctlbase + CNTACR(i));
+		cntacr = readl_relaxed(cntctlbase + CNTACR(i));
 
-		if ((cnttidr & CNTTIDR_VIRT(n)) &&
+		if ((cnttidr & CNTTIDR_VIRT(i)) &&
 		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
-			of_node_put(best_frame);
 			best_frame = frame;
 			arch_timer_mem_use_virtual = true;
 			break;
@@ -1024,56 +1019,135 @@ static int __init arch_timer_mem_init(struct device_node *np)
 		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
 			continue;
 
-		of_node_put(best_frame);
-		best_frame = of_node_get(frame);
+		best_frame = frame;
 	}
+	iounmap(cntctlbase);
 
-	ret= -ENXIO;
-	base = arch_counter_base = of_io_request_and_map(best_frame, 0,
-							 "arch_mem_timer");
-	if (IS_ERR(base)) {
-		pr_err("Can't map frame's registers\n");
-		goto out;
+	if (!best_frame) {
+		pr_err("Can't find frame for register\n");
+		return -EINVAL;
 	}
 
 	if (arch_timer_mem_use_virtual)
-		irq = irq_of_parse_and_map(best_frame, ARCH_TIMER_VIRT_SPI);
+		irq = best_frame->virt_irq;
 	else
-		irq = irq_of_parse_and_map(best_frame, ARCH_TIMER_PHYS_SPI);
+		irq = best_frame->phys_irq;
 
-	ret = -EINVAL;
 	if (!irq) {
 		pr_err("Frame missing %s irq.\n",
 		       arch_timer_mem_use_virtual ? "virt" : "phys");
+		return -EINVAL;
+	}
+
+	if (!request_mem_region(best_frame->cntbase, best_frame->size,
+				"arch_mem_timer"))
+		return -EBUSY;
+
+	base = ioremap(best_frame->cntbase, best_frame->size);
+	if (!base) {
+		pr_err("Can't map frame's registers\n");
+		return -ENXIO;
+	}
+
+	arch_timer_mem_freq = arch_timer_mem_get_cntfrq(base);
+	if (!arch_timer_rate && arch_timer_mem_freq) {
+		arch_timer_rate = arch_timer_mem_freq;
+	} else if (!arch_timer_rate || arch_timer_rate != arch_timer_mem_freq) {
+		pr_err(FW_BUG "invalid MMIO frequency.\n");
+		iounmap(base);
+		return -EINVAL;
+	}
+
+	ret = arch_timer_mem_register(base, irq);
+	if (ret) {
+		iounmap(base);
+		return ret;
+	}
+
+	arch_counter_base = base;
+	arch_timers_present |= ARCH_TIMER_TYPE_MEM;
+
+	return 0;
+}
+
+static int __init arch_timer_mem_of_init(struct device_node *np)
+{
+	struct arch_timer_mem *timer_mem;
+	struct device_node *frame_node;
+	struct resource res;
+	int ret = -EINVAL;
+	int i = 0;
+
+	timer_mem = kzalloc(sizeof(*timer_mem), GFP_KERNEL);
+	if (!timer_mem)
+		return -ENOMEM;
+
+	if (of_address_to_resource(np, 0, &res))
+		goto out;
+	timer_mem->cntctlbase = res.start;
+	timer_mem->size = resource_size(&res);
+
+	for_each_available_child_of_node(np, frame_node) {
+		u32 n;
+		struct arch_timer_mem_frame *frame;
+
+		if (of_property_read_u32(frame_node, "frame-number", &n)) {
+			pr_err(FW_BUG "Missing frame-number.\n");
+			of_node_put(frame_node);
+			goto out;
+		}
+		if (n >= ARCH_TIMER_MEM_MAX_FRAMES) {
+			pr_err(FW_BUG "Wrong frame-number, only 0-%u are permitted.\n",
+			       ARCH_TIMER_MEM_MAX_FRAMES - 1);
+			of_node_put(frame_node);
+			goto out;
+		}
+		frame = &timer_mem->frame[n];
+
+		if (frame->valid) {
+			pr_err(FW_BUG "Duplicated frame-number.\n");
+			of_node_put(frame_node);
+			goto out;
+		}
+
+		if (of_address_to_resource(frame_node, 0, &res)) {
+			of_node_put(frame_node);
+			goto out;
+		}
+		frame->cntbase = res.start;
+		frame->size = resource_size(&res);
+
+		frame->virt_irq = irq_of_parse_and_map(frame_node,
+						       ARCH_TIMER_VIRT_SPI);
+		frame->phys_irq = irq_of_parse_and_map(frame_node,
+						       ARCH_TIMER_PHYS_SPI);
+
+		frame->valid = true;
+		i++;
+	}
+	if (!i) {
+		pr_err(FW_BUG "Missing timer frame.\n");
+		ret = -ENODEV;
 		goto out;
 	}
 
 	/*
-	 * Try to determine the frequency from the device tree,
-	 * if fail, get the frequency from the CNTFRQ reg of MMIO timer.
+	 * Try to get the frequency from the device tree,
+	 * if fail, we will try the CNTFRQ register in arch_timer_mem_init.
 	 */
-	if (!arch_timer_rate &&
-	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
-		arch_timer_rate = arch_timer_mem_get_cntfrq(base);
 	if (!arch_timer_rate) {
-		pr_err(FW_BUG "MMIO frequency not available.\n");
-		ret = -EINVAL;
-		goto out;
+		of_property_read_u32(np, "clock-frequency", &arch_timer_rate);
 	}
 
-	ret = arch_timer_mem_register(base, irq);
-	if (ret)
-		goto out;
-
-	if (!arch_timer_needs_of_probing())
+	ret = arch_timer_mem_init(timer_mem);
+	if (!ret && !arch_timer_needs_of_probing())
 		ret = arch_timer_common_init();
 out:
-	iounmap(cntctlbase);
-	of_node_put(best_frame);
+	kfree(timer_mem);
 	return ret;
 }
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
-		       arch_timer_mem_init);
+		       arch_timer_mem_of_init);
 
 #ifdef CONFIG_ACPI
 static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
-- 
2.9.3

