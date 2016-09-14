Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37845 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765144AbcINUMy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 14 Sep 2016 16:12:54 -0400
Received: by mail-wm0-f51.google.com with SMTP id k186so28903203wmd.0
        for <linux-watchdog@vger.kernel.org>; Wed, 14 Sep 2016 13:12:23 -0700 (PDT)
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
Subject: [PATCH v13 7/8] clocksource/drivers/arm_arch_timer: Add GTDT support for memory-mapped timer
Date: Thu, 15 Sep 2016 04:09:40 +0800
Message-Id: <1473883781-9571-8-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1473883781-9571-1-git-send-email-fu.wei@linaro.org>
References: <1473883781-9571-1-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

The patch add memory-mapped timer register support by using the information
provided by the new GTDT driver of ACPI.
Also refactor original memory-mapped timer dt support for reusing some common
code.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 238 +++++++++++++++++++++++++----------
 1 file changed, 172 insertions(+), 66 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 0197ef9..ddca6e3 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -57,6 +57,7 @@
 static unsigned arch_timers_present __initdata;
 
 static void __iomem *arch_counter_base;
+static void __iomem *cntctlbase __initdata;
 
 struct arch_timer {
 	void __iomem *base;
@@ -656,15 +657,56 @@ out:
 	return err;
 }
 
-static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
+static int __init arch_timer_mem_register(struct device_node *np, void *frame)
 {
-	int ret;
-	irq_handler_t func;
+	struct device_node *frame_node = NULL;
+	struct gt_timer_data *frame_data = NULL;
 	struct arch_timer *t;
+	void __iomem *base;
+	irq_handler_t func;
+	unsigned int irq;
+	int ret;
+
+	if (np) {
+		frame_node = (struct device_node *)frame;
+		base = of_iomap(frame_node, 0);
+		arch_timer_detect_rate(base, np);
+		if (arch_timer_mem_use_virtual)
+			irq = irq_of_parse_and_map(frame_node, VIRT_SPI);
+		else
+			irq = irq_of_parse_and_map(frame_node, PHYS_SPI);
+	} else {
+		frame_data = (struct gt_timer_data *)frame;
+		/*
+		 * According to ARMv8 Architecture Reference Manual(ARM),
+		 * the size of CNTBaseN frames of memory-mapped timer
+		 * is SZ_4K(Offset 0x000 – 0xFFF).
+		 */
+		base = ioremap(frame_data->cntbase_phy, SZ_4K);
+		if (arch_timer_mem_use_virtual)
+			irq = frame_data->virtual_irq;
+		else
+			irq = frame_data->irq;
+	}
+
+	if (!base) {
+		pr_err("Can't map frame's registers\n");
+		return -ENXIO;
+	}
+	if (!irq) {
+		pr_err("Frame missing %s irq",
+		       arch_timer_mem_use_virtual ? "virt" : "phys");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	arch_counter_base = base;
 
 	t = kzalloc(sizeof(*t), GFP_KERNEL);
-	if (!t)
+	if (!t) {
 		return -ENOMEM;
+		goto out;
+	}
 
 	t->base = base;
 	t->evt.irq = irq;
@@ -676,11 +718,13 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
 		func = arch_timer_handler_phys_mem;
 
 	ret = request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &t->evt);
-	if (ret) {
-		pr_err("Failed to request mem timer irq\n");
-		kfree(t);
-	}
+	if (!ret)
+		return 0;
 
+	pr_err("Failed to request mem timer irq\n");
+	kfree(t);
+out:
+	iounmap(base);
 	return ret;
 }
 
@@ -769,7 +813,7 @@ static int __init arch_timer_init(void)
 		return ret;
 
 	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[VIRT_PPI];
-	
+
 	return 0;
 }
 
@@ -803,21 +847,56 @@ static int __init arch_timer_of_init(struct device_node *np)
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
 CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
 
-static int __init arch_timer_mem_init(struct device_node *np)
+static int __init get_cnttidr(struct device_node *np,
+			      struct gt_block_data *gt_block, u32 *cnttidr)
 {
-	struct device_node *frame, *best_frame = NULL;
-	void __iomem *cntctlbase, *base;
-	unsigned int irq, ret = -EINVAL;
-	u32 cnttidr;
+	if (np)
+		cntctlbase = of_iomap(np, 0);
+	else
+		cntctlbase = ioremap(gt_block->cntctlbase_phy, SZ_4K);
+		/*
+		 * According to ARMv8 Architecture Reference Manual(ARM),
+		 * the size of CNTCTLBase frame of memory-mapped timer
+		 * is SZ_4K(Offset 0x000 – 0xFFF).
+		 */
 
-	arch_timers_present |= ARCH_MEM_TIMER;
-	cntctlbase = of_iomap(np, 0);
 	if (!cntctlbase) {
 		pr_err("Can't find CNTCTLBase\n");
 		return -ENXIO;
 	}
 
-	cnttidr = readl_relaxed(cntctlbase + CNTTIDR);
+	*cnttidr = readl_relaxed(cntctlbase + CNTTIDR);
+	return 0;
+}
+
+static bool __init is_best_frame(u32 cnttidr, int n)
+{
+	u32 cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT | CNTACR_RWVT |
+		     CNTACR_RVOFF | CNTACR_RVCT;
+
+	/* Try enabling everything, and see what sticks */
+	writel_relaxed(cntacr, cntctlbase + CNTACR(n));
+	cntacr = readl_relaxed(cntctlbase + CNTACR(n));
+
+	if ((cnttidr & CNTTIDR_VIRT(n)) &&
+	    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT)))
+		arch_timer_mem_use_virtual = true;
+	else if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
+		return false;
+
+	return true;
+}
+
+static int __init arch_timer_mem_init(struct device_node *np)
+{
+	struct device_node *frame, *best_frame = NULL;
+	unsigned int ret = -EINVAL;
+	u32 cnttidr;
+
+	arch_timers_present |= ARCH_MEM_TIMER;
+
+	if (get_cnttidr(np, NULL, &cnttidr))
+		return -ENXIO;
 
 	/*
 	 * Try to find a virtual capable frame. Otherwise fall back to a
@@ -825,60 +904,22 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	 */
 	for_each_available_child_of_node(np, frame) {
 		int n;
-		u32 cntacr;
-
 		if (of_property_read_u32(frame, "frame-number", &n)) {
-			pr_err("Missing frame-number\n");
+			pr_err("Missing frame-number.\n");
 			of_node_put(frame);
 			goto out;
 		}
-
-		/* Try enabling everything, and see what sticks */
-		cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
-			 CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
-		writel_relaxed(cntacr, cntctlbase + CNTACR(n));
-		cntacr = readl_relaxed(cntctlbase + CNTACR(n));
-
-		if ((cnttidr & CNTTIDR_VIRT(n)) &&
-		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
+		if (is_best_frame(cnttidr, n)) {
 			of_node_put(best_frame);
-			best_frame = frame;
-			arch_timer_mem_use_virtual = true;
-			break;
+			best_frame = of_node_get(frame);
+			if (arch_timer_mem_use_virtual)
+				break;
 		}
-
-		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
-			continue;
-
-		of_node_put(best_frame);
-		best_frame = of_node_get(frame);
-	}
-
-	ret= -ENXIO;
-	base = arch_counter_base = of_iomap(best_frame, 0);
-	if (!base) {
-		pr_err("Can't map frame's registers\n");
-		goto out;
-	}
-
-	if (arch_timer_mem_use_virtual)
-		irq = irq_of_parse_and_map(best_frame, VIRT_SPI);
-	else
-		irq = irq_of_parse_and_map(best_frame, PHYS_SPI);
-
-	ret = -EINVAL;
-	if (!irq) {
-		pr_err("Frame missing %s irq",
-		       arch_timer_mem_use_virtual ? "virt" : "phys");
-		goto out;
 	}
 
-	arch_timer_detect_rate(base, np);
-	ret = arch_timer_mem_register(base, irq);
-	if (ret)
-		goto out;
-
-	return arch_timer_common_init();
+	ret = arch_timer_mem_register(np, best_frame);
+	if (!ret)
+		ret = arch_timer_common_init();
 out:
 	iounmap(cntctlbase);
 	of_node_put(best_frame);
@@ -888,7 +929,72 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
 		       arch_timer_mem_init);
 
 #ifdef CONFIG_ACPI_GTDT
-/* Initialize per-processor generic timer */
+static struct gt_timer_data __init *arch_timer_mem_get_timer(
+						struct gt_block_data *gt_blocks)
+{
+	struct gt_block_data *gt_block = gt_blocks;
+	struct gt_timer_data *best_frame = NULL;
+	u32 cnttidr;
+	int i;
+
+	if (get_cnttidr(NULL, gt_block, &cnttidr))
+		return NULL;
+	/*
+	 * Try to find a virtual capable frame. Otherwise fall back to a
+	 * physical capable frame.
+	 */
+	for (i = 0; i < gt_block->timer_count; i++) {
+		if (is_best_frame(cnttidr, gt_block->timer[i].frame_nr)) {
+			best_frame = &gt_block->timer[i];
+			if (arch_timer_mem_use_virtual)
+				break;
+		}
+	}
+	iounmap(cntctlbase);
+
+	return best_frame;
+}
+
+static int __init arch_timer_mem_acpi_init(size_t timer_count)
+{
+	struct gt_block_data *gt_blocks;
+	struct gt_timer_data *gt_timer;
+	int ret = -EINVAL;
+
+	/*
+	 * If we don't have any Platform Timer Structures, just return.
+	 */
+	if (!timer_count)
+		return 0;
+
+	/*
+	 * before really check all the Platform Timer Structures,
+	 * we assume they are GT block, and allocate memory for them.
+	 * We will free these memory once we finish the initialization.
+	 */
+	gt_blocks = kcalloc(timer_count, sizeof(*gt_blocks), GFP_KERNEL);
+	if (!gt_blocks)
+		return -ENOMEM;
+
+	if (gtdt_arch_timer_mem_init(gt_blocks) > 0) {
+		gt_timer = arch_timer_mem_get_timer(gt_blocks);
+		if (!gt_timer) {
+			pr_err("Failed to get mem timer info.\n");
+			goto error;
+		}
+		ret = arch_timer_mem_register(NULL, gt_timer);
+		if (ret) {
+			pr_err("Failed to register mem timer.\n");
+			goto error;
+		}
+	}
+	arch_timers_present |= ARCH_MEM_TIMER;
+error:
+	kfree(gt_blocks);
+	return ret;
+}
+
+/* Initialize per-processor generic timer and memory-mapped timer(if present) */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
 	int timer_count;
@@ -912,8 +1018,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate(NULL, NULL);
 
-	if (timer_count < 0)
-		pr_err("Failed to get platform timer info.\n");
+	if (timer_count < 0 || arch_timer_mem_acpi_init((size_t)timer_count))
+		pr_err("Failed to initialize memory-mapped timer.\n");
 
 	return arch_timer_init();
 }
-- 
2.7.4

