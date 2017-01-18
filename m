Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751625AbdARNel (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 18 Jan 2017 08:34:41 -0500
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
Subject: [PATCH v20 12/17] clocksource/drivers/arm_arch_timer: Refactor MMIO timer probing.
Date: Wed, 18 Jan 2017 21:25:36 +0800
Message-Id: <20170118132541.8989-13-fu.wei@linaro.org>
In-Reply-To: <20170118132541.8989-1-fu.wei@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
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
---
 drivers/clocksource/arm_arch_timer.c | 142 ++++++++++++++++++++++++-----------
 1 file changed, 99 insertions(+), 43 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9db5fb9..6e8a20c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -927,17 +927,17 @@ static int __init arch_timer_of_init(struct device_node *np)
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
 CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
 
-static int __init arch_timer_mem_init(struct device_node *np)
+static int __init arch_timer_mem_init(struct arch_timer_mem *timer_mem)
 {
-	struct device_node *frame, *best_frame = NULL;
 	void __iomem *cntctlbase, *base;
-	unsigned int irq, ret = -EINVAL;
+	struct arch_timer_mem_frame *best_frame = NULL;
+	unsigned int irq;
 	u32 cnttidr;
+	int i, ret;
 
-	arch_timers_present |= ARCH_TIMER_TYPE_MEM;
-	cntctlbase = of_iomap(np, 0);
+	cntctlbase = ioremap(timer_mem->cntctlbase, timer_mem->size);
 	if (!cntctlbase) {
-		pr_err("Can't find CNTCTLBase\n");
+		pr_err("Can't map CNTCTLBase.\n");
 		return -ENXIO;
 	}
 
@@ -947,26 +947,18 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	 * Try to find a virtual capable frame. Otherwise fall back to a
 	 * physical capable frame.
 	 */
-	for_each_available_child_of_node(np, frame) {
-		int n;
-		u32 cntacr;
-
-		if (of_property_read_u32(frame, "frame-number", &n)) {
-			pr_err("Missing frame-number\n");
-			of_node_put(frame);
-			goto out;
-		}
+	for (i = 0; i < timer_mem->num_frames; i++) {
+		u32 cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
+			     CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
+		int n = timer_mem->frame[i].frame_nr;
 
 		/* Try enabling everything, and see what sticks */
-		cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
-			 CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
 		writel_relaxed(cntacr, cntctlbase + CNTACR(n));
 		cntacr = readl_relaxed(cntctlbase + CNTACR(n));
 
 		if ((cnttidr & CNTTIDR_VIRT(n)) &&
 		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
-			of_node_put(best_frame);
-			best_frame = frame;
+			best_frame = &timer_mem->frame[i];
 			arch_timer_mem_use_virtual = true;
 			break;
 		}
@@ -974,51 +966,115 @@ static int __init arch_timer_mem_init(struct device_node *np)
 		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
 			continue;
 
-		of_node_put(best_frame);
-		best_frame = of_node_get(frame);
+		best_frame = &timer_mem->frame[i];
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
-		goto out;
+		return -EINVAL;
 	}
 
-	/*
-	 * Try to determine the frequency from the device tree,
-	 * if fail, get the frequency from the CNTFRQ reg of MMIO timer.
-	 */
-	if (!arch_timer_rate &&
-	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
-		arch_timer_mem_detect_rate(base);
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
+	arch_timer_mem_detect_rate(base);
 
 	ret = arch_timer_mem_register(base, irq);
-	if (ret)
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
+	int i, ret = -EINVAL;
+
+	timer_mem = kzalloc(sizeof(*timer_mem), GFP_KERNEL);
+	if (!timer_mem)
+		return -ENOMEM;
+
+	if (of_address_to_resource(np, 0, &res))
 		goto out;
+	timer_mem->cntctlbase = res.start;
+	timer_mem->size = resource_size(&res);
+
+	i = 0;
+	for_each_available_child_of_node(np, frame_node) {
+		int n;
+		struct arch_timer_mem_frame *frame;
+
+		if (i >= ARCH_TIMER_MEM_MAX_FRAMES) {
+			pr_err(FW_BUG "too many frames, only %u are permitted.\n",
+			       ARCH_TIMER_MEM_MAX_FRAMES);
+			goto out;
+		}
+
+		frame = &timer_mem->frame[i];
 
-	if (!arch_timer_needs_of_probing())
+		if (of_property_read_u32(frame_node, "frame-number", &n)) {
+			pr_err(FW_BUG "Missing frame-number\n");
+			of_node_put(frame_node);
+			goto out;
+		}
+		frame->frame_nr = n;
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
+		i++;
+	}
+	timer_mem->num_frames = i;
+
+	/* Try to determine the frequency from the device tree */
+	if (!arch_timer_rate)
+		of_property_read_u32(np, "clock-frequency", &arch_timer_rate);
+
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

