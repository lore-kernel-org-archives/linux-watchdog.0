Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34845 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbcI1SSo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Sep 2016 14:18:44 -0400
Received: by mail-pf0-f176.google.com with SMTP id s13so19891978pfd.2
        for <linux-watchdog@vger.kernel.org>; Wed, 28 Sep 2016 11:18:44 -0700 (PDT)
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
Subject: [PATCH v14 7/9] clocksource/drivers/arm_arch_timer: Refactor the timer init code to prepare for GTDT
Date: Thu, 29 Sep 2016 02:17:15 +0800
Message-Id: <1475086637-1914-8-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

The patch refactor original memory-mapped timer init code:
(1) extract some subfunction for reusing some common code
    a. get_cnttidr
    b. is_best_frame
(2) move base address and irq code for arch_timer_mem to
arch_timer_mem_register

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 159 +++++++++++++++++++++--------------
 1 file changed, 96 insertions(+), 63 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index c7b0040..e78095f 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -57,6 +57,7 @@
 static unsigned arch_timers_present __initdata;
 
 static void __iomem *arch_counter_base;
+static void __iomem *cntctlbase __initdata;
 
 struct arch_timer {
 	void __iomem *base;
@@ -656,15 +657,49 @@ out:
 	return err;
 }
 
-static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
+static int __init arch_timer_mem_register(struct device_node *np, void *frame)
 {
-	int ret;
-	irq_handler_t func;
+	struct device_node *frame_node = NULL;
 	struct arch_timer *t;
+	void __iomem *base;
+	irq_handler_t func;
+	unsigned int irq;
+	int ret;
+
+	if (!frame)
+		return -EINVAL;
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
+		pr_err("Device node is missing.\n");
+		return -EINVAL;
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
-		return -ENOMEM;
+	if (!t) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	t->base = base;
 	t->evt.irq = irq;
@@ -676,11 +711,13 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
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
 
@@ -803,21 +840,54 @@ static int __init arch_timer_of_init(struct device_node *np)
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
 CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
 
-static int __init arch_timer_mem_init(struct device_node *np)
+static int __init get_cnttidr(struct device_node *np, u32 *cnttidr)
 {
-	struct device_node *frame, *best_frame = NULL;
-	void __iomem *cntctlbase, *base;
-	unsigned int irq, ret = -EINVAL;
-	u32 cnttidr;
+	if (!cnttidr)
+		return -EINVAL;
+
+	if (np)
+		cntctlbase = of_iomap(np, 0);
+	else
+		return -EINVAL;
 
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
+	unsigned int ret;
+	u32 cnttidr;
+
+	arch_timers_present |= ARCH_MEM_TIMER;
+
+	ret = get_cnttidr(np, &cnttidr);
+	if (ret)
+		return ret;
 
 	/*
 	 * Try to find a virtual capable frame. Otherwise fall back to a
@@ -825,60 +895,23 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	 */
 	for_each_available_child_of_node(np, frame) {
 		int n;
-		u32 cntacr;
-
 		if (of_property_read_u32(frame, "frame-number", &n)) {
-			pr_err("Missing frame-number\n");
+			pr_err("Missing frame-number.\n");
 			of_node_put(frame);
+			ret = -EINVAL;
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
 	}
 
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
-	}
-
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
-- 
2.7.4

