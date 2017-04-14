Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbdDNSl7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Apr 2017 14:41:59 -0400
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
Subject: [PATCH v24 05/11] clocksource: arm_arch_timer: split MMIO timer probing.
Date: Sat, 15 Apr 2017 02:40:08 +0800
Message-Id: <20170414184014.8524-6-fu.wei@linaro.org>
In-Reply-To: <20170414184014.8524-1-fu.wei@linaro.org>
References: <20170414184014.8524-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

Currently the code to probe MMIO architected timers mixes DT parsing with
actual poking of hardware. This makes the code harder than necessary to
understand, and makes it difficult to add support for probing via ACPI.

This patch splits the DT parsing from HW probing. The DT parsing now
lives in arch_timer_mem_of_init(), which fills in an arch_timer_mem
structure that it hands to probing functions that can be reused for ACPI
support.

Since the rate detection logic will be slight different when using ACPI,
the probing is performed as a number of steps. This results in more code
for the moment, and some arguably redundant work, but simplifies matters
considerably when ACPI support is added.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
[Mark: refactor the probing split]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 186 +++++++++++++++++++++++++++--------
 1 file changed, 143 insertions(+), 43 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index e5e8708..dad0264 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1197,18 +1197,37 @@ static int __init arch_timer_of_init(struct device_node *np)
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
 CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
 
-static int __init arch_timer_mem_init(struct device_node *np)
+static u32 __init
+arch_timer_mem_frame_get_cntfrq(struct arch_timer_mem_frame *frame)
 {
-	struct device_node *frame, *best_frame = NULL;
-	void __iomem *cntctlbase, *base;
-	unsigned int irq, ret = -EINVAL;
-	u32 cnttidr, rate;
+	void __iomem *base;
+	u32 rate;
 
-	arch_timers_present |= ARCH_TIMER_TYPE_MEM;
-	cntctlbase = of_iomap(np, 0);
+	base = ioremap(frame->cntbase, frame->size);
+	if (!base) {
+		pr_err("Unable to map frame @ %pa\n", &frame->cntbase);
+		return 0;
+	}
+
+	rate = readl_relaxed(frame + CNTFRQ);
+
+	iounmap(frame);
+
+	return rate;
+}
+
+static struct arch_timer_mem_frame * __init
+arch_timer_mem_find_best_frame(struct arch_timer_mem *timer_mem)
+{
+	struct arch_timer_mem_frame *frame, *best_frame = NULL;
+	void __iomem *cntctlbase;
+	u32 cnttidr;
+	int i;
+
+	cntctlbase = ioremap(timer_mem->cntctlbase, timer_mem->size);
 	if (!cntctlbase) {
-		pr_err("Can't find CNTCTLBase\n");
-		return -ENXIO;
+		pr_err("Can't map CNTCTLBase @ %pa\n", &timer_mem->cntctlbase);
+		return NULL;
 	}
 
 	cnttidr = readl_relaxed(cntctlbase + CNTTIDR);
@@ -1217,25 +1236,20 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	 * Try to find a virtual capable frame. Otherwise fall back to a
 	 * physical capable frame.
 	 */
-	for_each_available_child_of_node(np, frame) {
-		int n;
-		u32 cntacr;
+	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
+		u32 cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
+			     CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
 
-		if (of_property_read_u32(frame, "frame-number", &n)) {
-			pr_err("Missing frame-number\n");
-			of_node_put(frame);
-			goto out;
-		}
+		frame = &timer_mem->frame[i];
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
@@ -1244,45 +1258,131 @@ static int __init arch_timer_mem_init(struct device_node *np)
 		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
 			continue;
 
-		of_node_put(best_frame);
-		best_frame = of_node_get(frame);
+		best_frame = frame;
 	}
 
-	ret= -ENXIO;
-	base = arch_counter_base = of_io_request_and_map(best_frame, 0,
-							 "arch_mem_timer");
-	if (IS_ERR(base)) {
-		pr_err("Can't map frame's registers\n");
-		goto out;
-	}
+	iounmap(cntctlbase);
+
+	if (!best_frame)
+		pr_err("Unable to find a suitable frame in timer @ %pa\n",
+		       &timer_mem->cntctlbase);
+
+	return frame;
+}
+
+static int __init
+arch_timer_mem_frame_register(struct arch_timer_mem_frame *frame)
+{
+	void __iomem *base;
+	int ret, irq = 0;
 
 	if (arch_timer_mem_use_virtual)
-		irq = irq_of_parse_and_map(best_frame, ARCH_TIMER_VIRT_SPI);
+		irq = frame->virt_irq;
 	else
-		irq = irq_of_parse_and_map(best_frame, ARCH_TIMER_PHYS_SPI);
+		irq = frame->phys_irq;
 
-	ret = -EINVAL;
 	if (!irq) {
 		pr_err("Frame missing %s irq.\n",
 		       arch_timer_mem_use_virtual ? "virt" : "phys");
-		goto out;
+		return -EINVAL;
+	}
+
+	if (!request_mem_region(frame->cntbase, frame->size,
+				"arch_mem_timer"))
+		return -EBUSY;
+
+	base = ioremap(frame->cntbase, frame->size);
+	if (!base) {
+		pr_err("Can't map frame's registers\n");
+		return -ENXIO;
 	}
 
-	rate = readl(base + CNTFRQ);
-	arch_timer_of_configure_rate(rate, np);
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
+	struct arch_timer_mem_frame *frame;
+	struct device_node *frame_node;
+	struct resource res;
+	int ret = -EINVAL;
+	u32 rate;
+
+	timer_mem = kzalloc(sizeof(*timer_mem), GFP_KERNEL);
+	if (!timer_mem)
+		return -ENOMEM;
+
+	if (of_address_to_resource(np, 0, &res))
 		goto out;
+	timer_mem->cntctlbase = res.start;
+	timer_mem->size = resource_size(&res);
 
-	if (!arch_timer_needs_of_probing())
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
+	}
+
+	frame = arch_timer_mem_find_best_frame(timer_mem);
+	if (!frame) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	rate = arch_timer_mem_frame_get_cntfrq(frame);
+	arch_timer_of_configure_rate(rate, np);
+
+	ret = arch_timer_mem_frame_register(frame);
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

